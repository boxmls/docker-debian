#################################################################
## BoxMLS/docker-debian
##
## @author potanin@UD
#################################################################


FROM          debian:9
USER          root

ENV           DEBIAN_FRONTEND noninteractive
ENV           NODE_ENV production
ENV           TERM xterm
ENV           DOCKER_IMAGE boxmls/debian

RUN           \
              apt-get update && \
              apt-get install -y --force-yes apt-transport-https sudo nano apt-utils curl wget python build-essential && \
              apt-get install -y --force-yes htop man unzip vim socat telnet git && \
              apt-get install -y --force-yes libpcre3-dev libcurl3 libcurl3-dev lsyncd monit && \
              apt-get install -y --force-yes openssh-server && \
              apt-get clean all

RUN           \
              gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

RUN           \
              curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
              apt-get install -y nodejs

RUN           \
              groupadd --gid=500 core && \
              useradd --create-home --uid=500 --gid=500 --home-dir=/home/core core && \
              echo core:jxchpwnzaggbyhme | /usr/sbin/chpasswd && \
              usermod -a -G sudo core && \
              yes | cp /root/.bashrc /home/core && \
              chown -R core:core /home/core && \
              echo "core ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
              mkdir -p /root/.ssh && \
              mkdir -p /etc/pki/tls/certs && \
              mkdir -p /etc/pki/tls/private && \
              mkdir -p /home/core/.ssh && \
              mkdir -p /home/core/.config

RUN           \
              echo "127.0.0.1 localhost" >> /etc/hosts

ADD           bin/entrypoint.sh /usr/bin/entrypoint.sh

RUN           \
              chmod +x  /usr/bin/entrypoint.sh

WORKDIR       /home/core

USER          core

ENTRYPOINT    [ "/bin/bash", "/usr/bin/entrypoint.sh" ]

