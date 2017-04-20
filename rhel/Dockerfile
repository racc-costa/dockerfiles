FROM registry.access.redhat.com/rhel6.8:6.8
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Copying files
COPY centos68.repo /etc/yum.repos.d/centos.repo
COPY supervisord.conf /etc/supervisord.conf

# Installing packages
RUN yum install -y openssh openssh-server openssh-clients sed vim-enhanced python-setuptools
RUN easy_install supervisor

# SSH configuration
RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config && \
    sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N "" && \
    /usr/bin/ssh-keygen -t dsa -b 1024 -f /etc/ssh/ssh_host_dsa_key -N "" && \
    passwd -d root

USER root
WORKDIR /root

EXPOSE 22

CMD ["/usr/bin/supervisord"]
