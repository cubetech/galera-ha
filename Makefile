default:
	/usr/sbin/useradd -m --system -s /bin/bash galeraha

install:
	/usr/bin/install -o root -g root -m 755 etc/galera-ha.init /etc/init.d/galera-ha
	/usr/bin/install -o root -g root -m 644 etc/logrotate.d/galera-ha.logrotate /etc/logrotate.d/galera-ha
	/usr/bin/install -o root -g root -m 755 bin/galera-ha /usr/local/bin
	/usr/bin/install -o galeraha -g root -m 644 etc/galera-ha.yaml /etc/
	/usr/bin/gem install --no-ri --no-rdoc bundler -v '~>1'
	/usr/bin/mkdir /run/galera-ha
	/usr/bin/chown galeraha /run/galera-ha
	/usr/local/bin/bundle install
	/usr/sbin/chkconfig --add galera-ha
	/usr/sbin/chkconfig galera-ha on

start:
	/etc/init.d/galera-ha start

test:
	/usr/bin/curl --head localhost:3336/galera-state
