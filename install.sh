#!/bin/bash

cd mDNSResponder-1310.80.1

#binaries
cp /usr/bin/dns-sd /usr/bin/dns-sd-bak
cp Clients/build/dns-sd /usr/bin/dns-sd
cp /usr/bin/mdnsd /usr/bin/mdnsd-back
cp mDNSPosix/build/prod/mdnsd /usr/bin/mdnsd

#headers
cp /usr/include/dns_sd.h /usr/include/dns_sd.h-bak
cp mDNSShared/dns_sd.h /usr/include/dns_sd.h

#libs
cp /usr/lib/libdns_sd.so /usr/lib/libdns_sd.so-bak
cp mDNSPosix/build/prod/libdns_sd.so /usr/lib/libdns_sd.so
ln -s -f /usr/lib/libdns_sd.so /usr/lib/libdns_sd.so.1
ln -s -f /usr/lib/libdns_sd.so /usr/lib/libnds_sd.so.1.0.0
cp /usr/lib/libnss_mdns-0.2.so /usr/lib/libnss_mdns-0.2.so-bak
cp mDNSPosix/build/prod/libnss_mdns-0.2.so /usr/lib/libnss_mdns-0.2.so
ln -s -f /usr/lib/libnss_mdns-0.2.so /usr/lib/libnss_mdns.so.2

#configs
cp /etc/nss_mdns.conf /etc/nss_mdns.conf-bak
cp mDNSPosix/nss_mdns.conf /etc/nss_mdns.conf
cp -f /etc/nsswitch.conf /etc/nsswitch.conf.pre-mdns
sed -e '/mdns/!s/^\(hosts:.*\)dns\(.*\)/\1mdns dns\2/' /etc/nsswitch.conf.pre-mdns > /etc/nsswitch.conf
cd ../
cp /etc/mdnsd-services.conf /etc/mdnsd-services.conf-bak
cp mdnsd-services.conf /etc/mdnsd-services.conf
cp /etc/mdns.conf /etc/mdns.conf-bak
cp mdnsd.conf /etc/mdns.conf

systemctl stop avahi-daemon
systemctl disable avahi-daemon
