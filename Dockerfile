FROM centos:latest
MAINTAINER Tim Kropp @sometheycallme

# install dependencies
RUN yum clean all && \
    yum -y install epel-release && \
    yum -y install PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools git python-pip

# create path to working directory
RUN mkdir /etc/ansible/

# create seed host 
RUN echo "127.0.0.1" > /etc/ansible/inventory

# follow directions here
# for installation http://docs.ansible.com/ansible/intro_installation.html
RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
WORKDIR /opt/ansible/ansible
RUN git submodule update --init

# create environment settings
ENV ANSIBLE_INVENTORY /etc/ansible/inventory
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
   
# ENV ANSIBLE_INVENTORY /root/ansible-security/inventory
# ENV ANSIBLE_HOST_KEY_CHECKING False
# ENV WORKDIR /root/ansible-security
