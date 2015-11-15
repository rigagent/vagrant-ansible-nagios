#!/bin/bash

# Package manager checking
if [[ -f /usr/bin/yum ]]; then
    package_manager="yum"
elif [[ -f /usr/bin/apt-get ]]; then
    package_manager="apt-get"
else
    print_error "Unsupported package manager."
    exit 1
fi

# Dependencies installation
case "$package_manager" in
    ### Fedora - just for RHEL 6.x
    yum )
    # EPEL
    cd /etc/yum.repos.d/
    yum install -y wget
    wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    rpm -Uvh epel-release-6*.rpm
    yum update -y
    # Virtual Box
    if [[ ! -f /usr/bin/virtualbox ]]; then
        wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
        yum install -y binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
        yum install -y VirtualBox-5.0
        service vboxdrv setup
    fi
    # Vagrant
    if [[ ! -f /usr/bin/vagrant ]]; then
        wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.rpm
        rpm -Uvh vagrant_1.7.4_x86_64.rpm
    fi
    # Ansible
    if [[ ! -f /usr/bin/ansible ]]; then
        yum install -y ansible
    fi
    # Locust
    if [[ ! -f /usr/local/bin/locust ]]; then
        yum -y install python-setuptools python-devel
        yum -y install libevent libevent-devel
        yum -y -c http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-6/home:fengshuo:zeromq.repo install zeromq zeromq-devel
        easy_install locustio
    fi
    ;;
    ### Debian
    apt-get )
    # Virtual Box
    if [[ ! -f /usr/bin/virtualbox ]]; then
        apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
        wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
        apt-get update
        apt-get install -y virtualbox-5.0
        service vboxdrv setup
    fi
    # Vagrant
    if [[ ! -f /usr/bin/vagrant ]]; then
        wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.deb /tmp
        dpkg -i /tmp/vagrant_1.7.4_x86_64.deb
    fi
    # Ansible
    if [[ ! -f /usr/bin/ansible ]]; then
        apt-get update
        apt-get install -f -y
        apt-get install -y ansible
    fi
    # Locust
    if [[ ! -f /usr/local/bin/locust ]]; then
        apt-get install -y python-dev libxml2-dev libxslt-dev
        apt-get install -y python-pip
        pip install locustio
    fi
    ;;
    * )
    print_error "Sorry, this package manager is not supported."
    exit 1
    ;;
esac

