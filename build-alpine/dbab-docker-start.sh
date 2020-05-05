printf 'nameserver 127.0.0.1\n' > /etc/resolv.conf
dnsmasq
/usr/sbin/squid -NYCd 1 &
/usr/sbin/dbab-svr
