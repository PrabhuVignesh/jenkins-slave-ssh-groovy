FROM ubuntu:18.04

LABEL maintainer="Prabhu Vignesh Kumar <prabhu.vignesh1990@gmail.com>"

RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    apt-get install -qy openjdk-8-jdk && \
    apt-get install -qy maven && \
    apt-get -qy autoremove && \
    adduser --quiet jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2

RUN apt-get -y install curl && \
    apt-get -y install unzip && \
    apt-get -y install zip && \
    curl -s get.sdkman.io | bash

COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
