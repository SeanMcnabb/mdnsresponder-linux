#!/bin/bash

mDNSResponderVersion=mDNSResponder-1310.80.1
docker run -it --rm -v "$(pwd)":/src -w /src ubuntu_build /bin/bash -c "
    ls ;
    echo $mDNSResponderVersion ;
    wget --no-check-certificate https://opensource.apple.com/tarballs/mDNSResponder/$mDNSResponderVersion.tar.gz ;
    tar -zxf $mDNSResponderVersion.tar.gz --no-same-owner ;
    rm -R $mDNSResponderVersion.tar.gz ;
    sed -i 's,cc ,$CC ,g' $mDNSResponderVersion/Clients/Makefile ;
    patch -u $mDNSResponderVersion/Clients/dns-sd.c -i Clients-dns-sd.c.patch ;
    cd $mDNSResponderVersion/mDNSPosix ;
    sed -i 's,/var/run,/run,g' Makefile ;
    make clean ;
    make os=linux ;
"