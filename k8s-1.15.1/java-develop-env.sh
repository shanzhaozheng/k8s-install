#! bin/bash

yum -y install java-1.8.0-openjdk-devel

yum -y install git

yum -y install wget

wget https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -O /opt/apache-maven-3.6.3-bin.tar.gz

mkdir /usr/local/maven

tar -zxvf /opt/apache-maven-3.6.3-bin.tar.gz -C  /usr/local/maven

cat <<EOF >> /etc/profile
MAVEN_HOME=/usr/local/maven/apache-maven-3.6.3
export PATH=\$PATH:\$MAVEN_HOME/bin
EOF

source /etc/profile
