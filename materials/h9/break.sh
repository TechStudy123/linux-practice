#!/bin/bash
# ハンズオン9 の準備: Web サーバー（httpd）に、わざと3つの不具合を仕込みます。
# 何をするかを読んでから実行してください:  less break.sh
# 実行:  sudo bash break.sh      元に戻す:  sudo bash cleanup.sh
set -e
if [ "$(id -u)" -ne 0 ]; then echo "sudo を付けて実行してください: sudo bash break.sh"; exit 1; fi
if [ "$(ps -p 1 -o comm=)" != "systemd" ]; then
  echo "この環境では systemd が動いていないため、ハンズオン9 は動画を見て進めてください。"; exit 1
fi
# 0) httpd が無ければ入れる（ハンズオン7 をしていない人のため）
rpm -q httpd >/dev/null 2>&1 || dnf install -y -q httpd >/dev/null
systemctl stop httpd 2>/dev/null || true
# 元の設定を控えておく（cleanup.sh で戻す）
[ -f /etc/httpd/conf/httpd.conf.h9orig ] || cp -p /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.h9orig
# トップページ
echo "<h1>Hello from linux-practice</h1>" > /var/www/html/index.html
# 1) 設定の書き間違い: Listen 80 の 0（ゼロ）を O（オー）にする
sed -i 's/^Listen 80$/Listen 8O/' /etc/httpd/conf/httpd.conf
# 2) トップページを、Web サーバーが読めない権限にする
chmod 600 /var/www/html/index.html
# 3) 別のプログラムが 80番を使う（前の担当者が試しに動かした古いサービス、という設定）
mkdir -p /var/tmp/old-web
echo "old page" > /var/tmp/old-web/index.html
cat > /etc/systemd/system/old-web.service <<'UNIT'
[Unit]
Description=Old test web server (practice)
[Service]
ExecStart=/usr/bin/python3 -m http.server 80 --directory /var/tmp/old-web
[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable --now old-web >/dev/null 2>&1
systemctl enable httpd >/dev/null 2>&1
systemctl start httpd 2>/dev/null || true
echo "準備ができました。「Web サーバーにつながらない」という連絡が来た、という場面から始めます。"
