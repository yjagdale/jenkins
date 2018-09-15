from jenkins/jenkins:latest
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY jobs  /var/jenkins_home
RUN /usr/local/bin/install-plugins.sh  < /usr/share/jenkins/ref/plugins.txt

ENV JENKINS_USER admin
ENV JENKINS_PASS admin
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

USER root
# Installing required packages
RUN apt-get update && apt-get install -y maven
RUN apt-get update && apt-get install -y git 
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get update \
 && apt-get install -y --no-install-recommends graphviz nodejs \
 && rm -rf /var/lib/apt/lists/*


USER jenkins

VOLUME /var/jenkins_home

#RUN mkdir -p /var/jenkins_home/users/yjagdale
#COPY user-config.xml /var/jenkins_home/users/yjagdale/config.ixml 
