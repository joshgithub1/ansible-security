FROM centos:latest
MAINTAINER Tim Kropp @sometheycallme


# setup the Ansible control environment dependencies
# http://docs.ansible.com/ansible/intro_installation.html

RUN yum -y install ansible wget python-setuptools python-pip python-wheel && \
    yum -y update && \ 
    yum clean all && \ 
    pip install paramiko PyYAML Jinja2 httplib2 six
    
ENV ANSIBLE_INVENTORY /root/ansible-security/inventory
ENV ANSIBLE_HOST_KEY_CHECKING False
ENV WORKDIR /root/ansible-security
