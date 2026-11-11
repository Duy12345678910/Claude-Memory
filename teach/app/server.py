#!/usr/bin/env python3
"""Trang bài tập đơn giản: hiện câu hỏi, lưu câu trả lời vào answers.json.
Chạy: python3 teach/app/server.py  (mặc định cổng 8765)"""
import json, os, sys, threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HERE = os.path.dirname(os.path.abspath(__file__))
ANS = os.path.join(HERE, "answers.json")
LOCK = threading.Lock()

def load(p, d):
    try:
        with open(p, encoding="utf-8") as f:
            return json.load(f)
    except Exception:
        return d

class H(BaseHTTPRequestHandler):
    def _send(self, code, body, ctype="application/json; charset=utf-8"):
        b = body.encode("utf-8") if isinstance(body, str) else body
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(b)))
        self.end_headers()
        self.wfile.write(b)

    def do_GET(self):
        if self.path in ("/", "/index.html"):
            with open(os.path.join(HERE, "index.html"), "rb") as f:
                self._send(200, f.read(), "text/html; charset=utf-8")
        elif self.path == "/api/state":
            self._send(200, json.dumps({
                "questions": load(os.path.join(HERE, "questions.json"), []),
                "answers": load(ANS, {})}, ensure_ascii=False))
        else:
            self._send(404, "{}")

    def do_POST(self):
        if self.path != "/api/answer":
            return self._send(404, "{}")
        try:
            n = min(int(self.headers.get("Content-Length", 0)), 20000)
            data = json.loads(self.rfile.read(n))
            qid, text = str(data["id"]), str(data["text"])
        except Exception:
            return self._send(400, '{"ok":false}')
        with LOCK:
            a = load(ANS, {})
            a[qid] = text
            with open(ANS, "w", encoding="utf-8") as f:
                json.dump(a, f, ensure_ascii=False, indent=2)
        self._send(200, '{"ok":true}')

    def log_message(self, *a):
        pass

if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8765
    ThreadingHTTPServer(("0.0.0.0", port), H).serve_forever()
