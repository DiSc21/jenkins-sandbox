FROM jenkins/jenkins:2.375.1
USER root

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /tmp/jenkins/jenkins_casc.yaml

CMD mkdir /tmp/jenkins

RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y --fix-missing build-essential
RUN apt-get update && apt-get install -y --fix-missing docker-ce-cli

RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "jarjar ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN groupadd -g 971 docker && usermod -a -G docker jenkins

USER jenkins

# some default jenkins plugins
RUN jenkins-plugin-cli --plugins blueocean:1.26.0 docker-workflow:563.vd5d2e5c4007f \
 ant:latest antisamy-markup-formatter:latest build-timeout:latest cloudbees-folder:latest \
 configuration-as-code:latest credentials-binding:latest email-ext:latest git:latest \
 github-branch-source:latest gradle:latest ldap:latest mailer:latest matrix-auth:latest \
 pam-auth:latest pipeline-github-lib:latest pipeline-stage-view:latest ssh-slaves:latest \
 timestamper:latest workflow-aggregator:latest ws-cleanup:latest authorize-project:latest

# basically managing all the code-quality stuff, e.g. static code analysis and gcc/clang warnings
RUN jenkins-plugin-cli --plugins scm-api:631.v9143df5b_e4a_a checks-api:1.8.1 code-coverage-api:3.4.1 warnings-ng:9.22.0 htmlpublisher:1.31

# just for a dirky dark look
RUN jenkins-plugin-cli --plugins theme-manager:1.6 instance-identity:142.v04572ca_5b_265 dark-theme:262.v0202a_4c8fb_6a

CMD mkdir /ws/
WORKDIR /ws/

CMD ["Jenkins server up and running!"]
