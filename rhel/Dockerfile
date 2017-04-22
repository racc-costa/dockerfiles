FROM registry.access.redhat.com/rhel7/rhel:7.3
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Copying files
COPY centos73.repo /etc/yum.repos.d/centos.repo
COPY supervisord.conf /etc/supervisord.conf

# Installing packages
RUN yum install -y openssh openssh-server sed vim-enhanced python-setuptools && \
  yum clean all && \
  easy_install supervisor && \
  sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
  /usr/bin/ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N "" && \
  /usr/bin/ssh-keygen -t dsa -b 1024 -f /etc/ssh/ssh_host_dsa_key -N "" && \
  echo "root:developer" | chpasswd && \
  echo 'cd /opt' >> /root/.bash_profile

EXPOSE 22

CMD ["/usr/bin/supervisord"]
