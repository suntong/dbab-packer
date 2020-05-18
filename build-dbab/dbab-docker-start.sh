cat /etc/resolv.conf.good > /etc/resolv.conf
/etc/init.d/dnsmasq start
sleep 2
/etc/init.d/dbab start
/usr/sbin/squid -NYCd 1
