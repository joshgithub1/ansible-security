FROM centos:latest
MAINTAINER Tim Kropp @sometheycallme


# setup the Ansible control environment dependencies
# http://docs.ansible.com/ansible/intro_installation.html
RUN yum -y install vim epel-release json-devel libyaml ansible \
    && yum -y update \ 
    && yum clean all \ 
    && wget -q --no-check-certificate https://bootstrap.pypa.io/get-pip.py 
    && python get-pip.py && \
    pip install lxml==3.4.4 && \
    pip install PyYAML==3.11 && \
    pip install paramiko==1.15.3 && \
    pip install jinja2==2.8 && \
    pip install httplib2==0.9.2 && \
    pip install six==1.10.0 && \
    pip install ansible==2.0.0 && \
    pip install xmlrunner==1.7.7 && \
    pip install gitpython==1.0.1 && \
    echo "cd ~/ansible-security/" >> ~/.bashrc
    
ENV ANSIBLE_INVENTORY /root/ansible-security/inventory
ENV ANSIBLE_HOST_KEY_CHECKING False
ENV WORKDIR /root/ansible-security
