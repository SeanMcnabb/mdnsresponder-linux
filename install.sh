#!/bin/bash

cd mDNSResponder-1310.80.1

#binaries
cp Clients/build/dns-sd /usr/bin/dns-sd
cp mDNSPosix/build/prod/mdnsd /usr/bin/mdnsd

#headers
cp mDNSShared/dns_sd.h /usr/include/dns_sd.h

#libs
cp mDNSPosix/build/prod/libdns_sd.so /usr/lib/libdns_sd.so
ln -s -f /usr/lib/libdns_sd.so /usr/lib/libdns_sd.so.1
ln -s -f /usr/lib/libdns_sd.so /usr/lib/libnds_sd.so.1.0.0
cp mDNSPosix/build/prod/libnss_mdns-0.2.so /usr/lib/libnss_mdns-0.2.so
ln -s -f /usr/lib/libnss_mdns-0.2.so /usr/lib/libnss_mdns.so.2

#configs
cp mDNSPosix/nss_mdns.conf /etc/nss_mdns.conf
cp -f /etc/nsswitch.conf /etc/nsswitch.conf.pre-mdns
sed -e '/mdns/!s/^\(hosts:.*\)dns\(.*\)/\1mdns dns\2/' /etc/nsswitch.conf.pre-mdns > /etc/nsswitch.conf

systemctl stop avahi-daemon
systemctl disable avahi-deamon
