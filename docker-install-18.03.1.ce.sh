#! bin/bash

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum update -y && yum install -y docker-ce
systemctl start docker
systemctl enable  docker
docker version
[[ $? -ne 0  ]] && echo "docker 安装失败" || echo "docker 安装成功!"
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://fb1e1fmq.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

yum -y install wget
wget https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m) -O /usr/local/bin/docker-compose
chmod +x  /usr/local/bin/docker-compose
docker-compose -version 

[[ $? -ne 0  ]] && echo "docker-compose 安装失败" || echo "docker-compose 安装成功!"
