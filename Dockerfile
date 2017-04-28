FROM centos:latest
MAINTAINER Ed Kern <ejk@cisco.com>
LABEL Description="VPP centos OS build image" 
LABEL Vendor="cisco.com" 
LABEL Version="1.0"

# Setup the environment

RUN mkdir /workspace && mkdir -p /etc/ssh && mkdir -p /var/ccache

ENV CCACHE_DIR=/var/ccache

#SSH timeout
#RUN touch /etc/ssh/ssh_config
RUN echo "TCPKeepAlive        true" | tee -a /etc/ssh/ssh_config #>/dev/null 2>&1
RUN echo "ServerAliveCountMax 30"   | tee -a /etc/ssh/ssh_config #>/dev/null 2>&1
RUN echo "ServerAliveInterval 10"   | tee -a /etc/ssh/ssh_config #>/dev/null 2>&1


#module
RUN echo uio_pci_generic >> /etc/modules

#ADD files/packagecloud /root/.packagecloud
#Baseline

RUN yum update -y && yum install -y deltarpm && yum clean all
RUN yum update -y && yum install -y @base https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum clean all
RUN yum update -y && yum install -y --enablerepo=epel \
	chrpath \
	git \
	git-review \
	java-*-openjdk-devel \
	jq \
	lcov \
	make \
	nasm \
	perl-XML-XPath \
	puppet \
	sudo \
	unzip \
	xz \
	wget \
	&& yum clean all

#packer install
RUN wget https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip && unzip packer_1.0.0_linux_amd64.zip -d /usr/local/bin/ && mv /usr/local/bin/packer /usr/local/bin/packer.io


RUN yum update -y && yum install -y --enablerepo=epel \
	asciidoc \
	apr-devel \
	cpp \
	c++ \
	cmake \
	dblatex  \
	doxygen \
	epel-rpm-macros \
	gcc \
	graphviz \
	indent \
	java-1.8.0-openjdk-devel \
	kernel-devel \
	libxml2 \
	libffi-devel \
	make \
	openssl-devel \
	python-devel \
	python-virtualenv \
	python-setuptools \
	python-cffi \
    python-pip \
  	python-jinja2 \
  	python-sphinx \
    source-highlight \
    rpm \
	valgrind \
	yum-utils \
	&& yum clean all

RUN yum update -y && yum install -y --enablerepo=epel \
	ganglia-devel \
	libconfuse-devel \
	mock \
	&& yum clean all

#RUN alternatives --set java /usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java
#RUN alternatives --set java_sdk_openjdk /usr/lib/jvm/java-1.7.0-openjdk.x86_64

RUN pip install --upgrade pip
RUN pip install pycap

RUN yum update -y && yum install -y --enablerepo=epel \
	autoconf \
	automake \
	bison \
	ccache \
	cscope \
	curl \
	dkms \
	git \
	git-review \
	libtool \
    libconfuse-dev \
    libpcap-devel \
    libcap-devel \
    scapy \
    && yum clean all

#puppet
RUN yum update -y && yum install -y --enablerepo=epel \
	libxml2-devel \
	libxslt-devel \
	ruby-devel \
	zlib-devel \
	&& yum clean all


RUN gem install package_cloud

RUN yum update -y && yum install -y --enablerepo=epel \
	apr-util \
	byacc \
	diffstat \
	dwz \
	flex \
	gcc-c++ \
	gcc-gfortran \
	gettext-devel \
	glibc-static \
	intltool \
	nasm \
	patchutils \
	rcs \
	redhat-lsb \
	redhat-rpm-config \
	rpm-build \
	rpm-sign \
	subversion \
	swig \
	systemtap \
	&& yum clean all

