#! bin/bash

yum install -y conntrack ntpdate ntp ipvsadm ipset jq iptables curl sysstat libseccomp wgetvimnet-tools

systemctl  stop firewalld  &&  systemctl  disable firewalld

yum -y install iptables-services  &&  systemctl  start iptables  &&  systemctl  enable iptables &&  iptables -F  &&  service iptables save

swapoff -a && sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

setenforce 0 && sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

# 内核心参数调整兼容k8s
sh ./core-agrs-k8s.sh

# 调整当前系统时区
timedatectl set-timezone Asia/Shanghai

timedatectl set-local-rtc 0

systemctl restart rsyslog

systemctl restart crond

# 关闭系统不需要服务
systemctl stop postfix && systemctl disable postfix

# 设置 rsyslogd 和 systemd journald
mkdir /var/log/journa

mkdir  /etc/systemd/journald.conf.d

cat  > /etc/systemd/journald.conf.d/99-prophet.conf <<EOF
[Journal]
# 持久化保存到磁盘
Storage=persistent
# 压缩历史日志
Compress=yes
SyncIntervalSec=5m
RateLimitInterval=30s
RateLimitBurst=1000
# 最大占用空间 
10GSystemMaxUse=10G
# 单日志文件最大 200M
SystemMaxFileSize=200M
# 日志保存时间 2 周
MaxRetentionSec=2week
# 不将日志转发到 
syslogForwardToSyslog=no
EOF
systemctl restart systemd-journald

# docker 安装
sh ./docker-install-18.03.1.ce.sh

# kube-proxy开启ipvs的前置条件
modprobe br_netfilter

cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4
EOF
chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4

# 阿里云镜像

cat <<EOF > /etc/yum.repos.d/kubernetes.repo

[kubernetes]

name=Kubernetes

baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64

enabled=1

gpgcheck=0

repo_gpgcheck=0

gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg

http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg

EOF

yum -y  install  kubeadm-1.15.1 kubectl-1.15.1 kubelet-1.5.1

systemctl enable kubelet.service

# 下载k8s所需组件，无需翻墙
sh ./kubernetes-1.15.1-downloads.sh
