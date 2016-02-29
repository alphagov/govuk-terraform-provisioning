source /etc/lsb-release

PUPPET_DEB=puppetlabs-release-${DISTRIB_CODENAME}.deb
wget https://apt.puppetlabs.com/${PUPPET_DEB}
sudo dpkg -i ${PUPPET_DEB}
rm -f ${PUPPET_DEB}

sudo apt-get update

sudo apt-get -y install build-essential ruby1.9.3 puppet='3.8.5-*' puppet-common='3.8.5-*'
sudo service puppet stop
