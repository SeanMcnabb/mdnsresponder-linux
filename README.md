# mdnsresponder-linux
mDNSResponder build for linux

The build.sh file will pull the listed version of mDNSResonder from apple and compile it against ubuntu 22.04 LTS from a docker image.

The install.sh will install built binaries
 - The install.sh is intended for arch based systems but may work on others
This will disable the avahi daemon on systemd
 - if using another init system, you will need to disable the avahi daemon manually
This will replace files used by the avahi daemon (do not delete avahi, you still need it on your system)
 - printer discovery services may stop working but any printers currently added in cups will still work
 - you can undo this by reinstalling avahi, but you shouldn't notice any breaking changes
A system service file hasn't been built yet, feel free to write your own, or just start the mdsnd executable when you want to use it