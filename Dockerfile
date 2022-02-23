From centos:7

LABEL maintainer="skywin886@139.com"

RUN yum -y install wget
COPY update/* /tmp/
RUN sh /tmp/*.sh

RUN yum -y install openssh-server && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY files/sshd_config /etc/ssh/sshd_config
COPY files/create-sftp-user /usr/local/bin/
COPY files/entrypoint /

EXPOSE 22
WORKDIR /home

ENTRYPOINT ["/entrypoint"]
