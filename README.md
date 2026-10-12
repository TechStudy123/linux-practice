# linux-practice

「Linux 入門 〜コマンド・権限・SSH・ログ、現場で最初に必要な基本を手を動かして学ぶ〜」のハンズオンで使う教材ファイルと、GitHub Codespaces の練習環境です。

## 教材ファイル（materials）

ハンズオン4 の最初に、WSL の AlmaLinux 10（または Codespaces）のターミナルで取り出します。手順は説明資料のとおりです。

```bash
cd ~/linux-practice
curl -LO https://github.com/TechStudy123/linux-practice/releases/latest/download/materials.tar.gz
tar -tzf materials.tar.gz
tar -xzf materials.tar.gz
```

| ファイル | 使う回 | 中身 |
|---|---|---|
| `materials/h4/sample.conf` | ハンズオン4 | 読んで・控えを取って・直す練習用の設定ファイル |
| `materials/h5/access_log` | ハンズオン5 | 集計の練習用のアクセスログ（架空のデータ。IP は説明用に予約されたアドレス） |
| `materials/h9/break.sh` | ハンズオン9 | Web サーバーにわざと3つの不具合を仕込む（`sudo bash break.sh`） |
| `materials/h9/cleanup.sh` | ハンズオン9 | 元に戻す（`sudo bash cleanup.sh`） |

スクリプトは、実行する前に `less` で中身を読んでください。

## Codespaces（WSL が使えない方）

このリポジトリの「Code」→「Codespaces」→「Create codespace on main」で、AlmaLinux 10 のターミナルが開きます（ユーザーは `student`、`sudo` が使えます）。
Codespaces では systemd が動かないため、`systemctl`・`journalctl` を使う所は動画を見て進めてください。
使い終わったら Codespace を止めてください（無料枠の時間を使い切らないため）。
