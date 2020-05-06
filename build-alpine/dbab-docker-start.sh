# cp /etc/resolv.conf.good /etc/resolv.conf
cat /etc/resolv.conf.good > /etc/resolv.conf
dnsmasq
sleep 2
/usr/sbin/dbab-svr &
/usr/sbin/squid -NYCd 1
