#!/usr/bin/env bash
# Static threat scan. Reads files only; never executes anything from the target.
# Usage: scan.sh <dir-or-file>
T="${1:?usage: scan.sh <path>}"
[ -e "$T" ] || { echo "not found: $T"; exit 2; }
HITS=0
sec() { echo; echo "### $1"; }
g() { # severity label regex
  local out
  out=$(grep -rInE --exclude-dir=.git --exclude-dir=node_modules --exclude='*.min.js' --exclude='*.map' --exclude='*.lock' --exclude='package-lock.json' -- "$3" "$T" 2>/dev/null | cut -c1-220 | head -15)
  if [ -n "$out" ]; then HITS=$((HITS+1)); echo "[$1] $2"; echo "$out" | sed 's/^/    /'; fi
}
sec "Install-time execution (runs on install)"
g HIGH "npm lifecycle script" '"(preinstall|install|postinstall|prepare)"[[:space:]]*:'
g HIGH "python setup cmdclass / install hook" 'cmdclass|class [A-Za-z]*\((install|develop|egg_info)\)'
sec "Remote code download + execute"
g HIGH "curl/wget piped to shell" '(curl|wget)[^|#]*\|[[:space:]]*(sudo )?(ba|z|da)?sh'
g HIGH "powershell download-exec" 'IEX|Invoke-Expression|DownloadString|-EncodedCommand'
g HIGH "decode then exec" '(base64 (-d|--decode)|atob\(|b64decode|fromCharCode)[^#]*(eval|exec|sh|bash|Function)'
g MED  "dynamic eval/exec" '(^|[^a-zA-Z_.])(eval|exec)\(|new Function\(|child_process|os\.system\(|subprocess\.(Popen|run|call)\([^)]*shell=True'
sec "Credential / data theft"
g HIGH "reads secrets/keys" '(\.ssh/|id_rsa|\.aws/credentials|\.npmrc|\.pypirc|\.netrc|\.git-credentials|\.kube/config|\.docker/config|\.gnupg|wallet\.dat|keychain|Login Data|Cookies|Local State|\.config/(gcloud|gh))'
g HIGH "env-var harvesting" '(os\.environ\b[^=]*\)|process\.env\)|printenv|env \| |JSON\.stringify\(process\.env|dict\(os\.environ)'
g HIGH "token/key patterns embedded" '(ghp_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|AKIA[0-9A-Z]{16}|sk-[A-Za-z0-9]{32,}|xox[baprs]-[A-Za-z0-9-]{10,})'
sec "Exfiltration endpoints"
g HIGH "webhook/paste/tunnel sinks" '(discord(app)?\.com/api/webhooks|api\.telegram\.org/bot|pastebin\.com|transfer\.sh|ngrok|webhook\.site|requestbin|pipedream\.net|oast\.|interact\.sh|burpcollaborator)'
g MED  "raw-IP URLs" 'https?://[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
sec "Malware behaviour"
g HIGH "reverse shell" '(/dev/tcp/|nc (-e|-c)|bash -i|socat .*exec|mkfifo.*nc|pty\.spawn)'
g HIGH "crypto miner" '(stratum\+tcp|xmrig|coinhive|cryptonight|minerd)'
g MED  "persistence" '(crontab|/etc/cron|systemctl (enable|--user)|\.bashrc|\.zshrc|\.profile|LaunchAgents|authorized_keys|schtasks|HKCU\\\\Software\\\\Microsoft\\\\Windows\\\\CurrentVersion\\\\Run)'
g MED  "destructive" '(rm -rf (/|~|\$HOME)|mkfs\.|dd if=.* of=/dev/|shred )'
sec "Agent / prompt-injection abuse (skills, plugins, CLAUDE.md, hooks)"
g HIGH "injection phrases" '(ignore (all )?(previous|prior|above) instructions|do not (tell|inform|mention).{0,20}user|without (asking|telling|informing).{0,20}(user|permission)|disable (safety|permissions?|sandbox)|dangerously-skip-permissions|bypassPermissions)'
g MED  "hooks / settings tampering" '("hooks"[[:space:]]*:|settings(\.local)?\.json|enableAllProjectMcpServers|"allow"[[:space:]]*:[[:space:]]*\[[^]]*(Bash\(\*|\*\)))'
g MED  "MCP server launching commands" '"mcpServers"|npx -y '
sec "Obfuscation & binaries"
g MED  "long encoded blobs" '[A-Za-z0-9+/=]{300,}'
BIN=$(find "$T" -type f \( -name '*.exe' -o -name '*.dll' -o -name '*.so' -o -name '*.dylib' -o -name '*.node' -o -name '*.bin' -o -name '*.jar' -o -name '*.pyc' \) -not -path '*/.git/*' -not -path '*/node_modules/*' 2>/dev/null | head -15)
[ -n "$BIN" ] && { HITS=$((HITS+1)); echo "[MED] bundled binaries (can't be statically reviewed)"; echo "$BIN" | sed 's/^/    /'; }
echo; echo "=== categories flagged: $HITS ==="
echo "Hits are leads, not verdicts: read each in context (a CLI legitimately reads env vars; a skill reading ~/.ssh does not)."
