#!/bin/sh
# FIXME: load selinux policy.  this should really be done after we switchroot 
if [ -x "$NEWROOT/usr/sbin/load_policy" ] && [ -e "$NEWROOT/etc/sysconfig/selinux" ]; then
    {
    chroot $NEWROOT /usr/sbin/load_policy -i 2>&1 
    if [ $? -eq 3 ]; then
	warn "Initial SELinux policy load failed and enforcing mode requested."
	warn "Not continuing"
	sleep 100d
	exit 1
    fi
    } | vinfo
fi
