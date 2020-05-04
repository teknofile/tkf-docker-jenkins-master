FROM jenkins/jenkins:lts
LABEL MAINTAINER "teknofile <teknofile@teknofile.org>"

USER root

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg > /tmp/dkey && \
  apt-key add /tmp/dkey && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable " && \
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install docker-ce 

RUN apt-get clean

RUN groupadd -rg 117 dockerhost && \
  usermod -aG dockerhost jenkins && \
  usermod -aG docker jenkins

USER jenkins
