FROM jenkins/jenkins

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

RUN usermod -a -G docker jenkins
RUN systemctl enable docker
USER jenkins
