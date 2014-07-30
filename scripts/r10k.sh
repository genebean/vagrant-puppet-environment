# r10k setup
if [ ! -d '/etc/puppet/environments' ]; then
  mkdir -p /etc/puppet/environments
fi

puppet module install zack-r10k
