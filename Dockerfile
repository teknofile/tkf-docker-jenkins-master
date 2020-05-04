FROM jenkins/jenkins

USER root

RUN apt-get update 
RUN apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg > /tmp/dkey
RUN apt-key add /tmp/dkey
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable "
RUN apt-get update && apt-get -y install docker-ce
RUN apt-get install -y docker-ce
RUN usermod -a -G docker jenkins
RUN systemctl enable docker
USER jenkins
