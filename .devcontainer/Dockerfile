# Linux 入門 ハンズオン用の Codespaces の環境（AlmaLinux 10）
# WSL の AlmaLinux 10（2026-10-12 に最初から入っている道具を確認）に近い形にします。
#   入っているもの: sudo・vim・nano・man・less・curl・python3・tar・gzip・zip・unzip・ps・ss・ssh（クライアント）など
#   入れていないもの: tree（ハンズオン3で dnf で入れる）・openssh-server（ハンズオン8で入れる）
# 一般ユーザー student が sudo で root の権限を借ります（Codespaces ではパスワードを聞かれません）。
FROM almalinux:10
RUN sed -i '/^tsflags=nodocs/d' /etc/dnf/dnf.conf \
    && dnf install -y \
      sudo passwd shadow-utils vim-enhanced nano man-db man-pages less curl wget python3 \
      tar gzip zip unzip which hostname procps-ng psmisc iproute iputils findutils diffutils file \
      openssh-clients bash-completion \
    && dnf install -y --allowerasing coreutils coreutils-common \
    && dnf reinstall -y bash grep sed gawk findutils tar gzip procps-ng util-linux shadow-utils sudo openssh-clients \
    && (rpm -q vim-minimal >/dev/null && rpm -e --nodeps vim-minimal || true) \
    && dnf clean all \
    && useradd -m -s /bin/bash -G wheel student \
    && echo 'student ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/student \
    && chmod 440 /etc/sudoers.d/student
USER student
WORKDIR /home/student
