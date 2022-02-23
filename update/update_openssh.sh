#!/bin/bash

version=8.8p1

#查看版本并安装编译工具、下载源码包
yum install -y gcc openssl-devel pam-devel rpm-build make
wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${version}.tar.gz /root

#删除原openssh软件
rm -rf /etc/ssh
rpm -qa |grep openssh
for i in `rpm -qa |grep openssh`;do rpm -e $i --nodeps;done

#安装openssh源码包
tar -zxvf openssh-${version}.tar.gz -C /usr
cd /usr/openssh-${version}
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-md5-passwords --with-pam --with-tcp-wrappers  --without-hardening
make && make install

#配置并重启openssh，查看版本
rm -rf /etc/init.d/sshd
cp /usr/openssh-${version}/contrib/redhat/sshd.init /etc/init.d/sshd
chkconfig --add sshd
chkconfig --list|grep sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl enable sshd
systemctl restart sshd
systemctl status sshd
ssh -V

#清理
rm -rf openssh-${version}.tar.gz
rm -rf /usr/openssh-${version}
yum -y remove wget make rpm-build
