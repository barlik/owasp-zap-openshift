# This dockerfile builds the zap stable release

FROM registry.access.redhat.com/rhel7

MAINTAINER Dan Hawker <dhawker@redhat.com>

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# Need to enable the RHEL extras subs
RUN yum-config-manager --enable \
    rhel-7-server-rpms \
    rhel-7-server-extras-rpms \
    rhel-7-server-optional-rpms \
    epel \
    > /dev/null

RUN yum install -y \
    --enablerepo=rhel-7-server-rpms \
    --enablerepo=rhel-7-server-extras-rpms \
    --enablerepo=rhel-7-server-optional-rpms \
    --enablerepo=epel \
    redhat-rpm-config \
    make automake autoconf gcc gcc-c++ \
    libstdc++ libstdc++-devel \
    java-1.8.0-openjdk wget curl \
    xmlstarlet git x11vnc gettext \
    xorg-x11-server-Xvfb openbox xterm \
    net-tools python-pip \
    firefox nss_wrapper java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel nss_wrapper && \
    yum clean all


RUN pip install --upgrade pip
RUN pip install zapcli
# Install latest dev version of the python API
RUN pip install python-owasp-zap-v2.4

RUN mkdir -p /zap/wrk && mkdir -p /zap/.ZAP
ADD zap /zap/

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $JAVA_HOME/bin:/zap:$PATH
ENV ZAP_PATH /zap/zap.sh

# Default port for use with zapcli
ENV ZAP_PORT 8080

COPY policies /zap/.ZAP/policies/

WORKDIR /zap
# Download and expand the latest stable release
RUN curl -s https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-dev.xml | xmlstarlet sel -t -v //url |grep -i Linux | wget -q --content-disposition -i - -O - | tar zx --strip-components=1 && \
    curl -s -L https://bitbucket.org/meszarv/webswing/downloads/webswing-2.3-distribution.zip | jar -x && \
    touch AcceptedLicense
ADD webswing.config /zap/webswing-2.3/webswing.config

RUN chown root:root /zap -R && \
    chmod 777 /zap -R

WORKDIR /zap

EXPOSE 8080

ENTRYPOINT ["/zap/zap.sh", "-dir", "/zap/.ZAP", "-daemon", "-host", "0.0.0.0", "-port", "8080", "-config", "api.disablekey=true", "-config", "api.addrs.addr.name=.*", "-config", "api.addrs.addr.regex=true"]
