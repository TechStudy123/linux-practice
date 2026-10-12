#!/bin/bash
# ハンズオン9 の後片付け: break.sh で仕込んだものを元に戻し、httpd を止めます。
# 実行:  sudo bash cleanup.sh
if [ "$(id -u)" -ne 0 ]; then echo "sudo を付けて実行してください: sudo bash cleanup.sh"; exit 1; fi
systemctl disable --now old-web >/dev/null 2>&1
rm -f /etc/systemd/system/old-web.service
rm -rf /var/tmp/old-web
systemctl daemon-reload
if [ -f /etc/httpd/conf/httpd.conf.h9orig ]; then
  mv -f /etc/httpd/conf/httpd.conf.h9orig /etc/httpd/conf/httpd.conf
fi
[ -f /var/www/html/index.html ] && chmod 644 /var/www/html/index.html
systemctl disable --now httpd >/dev/null 2>&1
echo "元に戻しました（httpd は止めて、自動起動もしない状態です）。"
