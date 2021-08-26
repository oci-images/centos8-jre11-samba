FROM centos:centos8
RUN echo '[AdoptOpenJDK]' >> /etc/yum.repos.d/adoptopenjdk.repo && echo 'name=AdoptOpenJDK' >> /etc/yum.repos.d/adoptopenjdk.repo && echo 'baseurl=http://adoptopenjdk.jfrog.io/adoptopenjdk/rpm/centos/$releasever/$basearch' >> /etc/yum.repos.d/adoptopenjdk.repo && echo 'enabled=1' >> /etc/yum.repos.d/adoptopenjdk.repo && echo 'gpgcheck=1' >> /etc/yum.repos.d/adoptopenjdk.repo && echo 'gpgkey=https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public' >> /etc/yum.repos.d/adoptopenjdk.repo
RUN yum -y  install adoptopenjdk-11-hotspot-jre
RUN yum -y  install samba-client
COPY copySamba.sh /opt/app/copySamba.sh
COPY *smb.conf /etc/samba/smb.conf
WORKDIR /opt/app
COPY java_runner.sh /opt/app
RUN chown 1001 /opt/app; \
    chmod "g+rwX" /opt/app; \
    chown 1001:root /opt/app; \
	chown 1001 /opt/app/java_runner.sh;  \
    chmod 540 /opt/app/java_runner.sh;
USER 1001
CMD ["/bin/bash","/opt/app/java_runner.sh","run"]

