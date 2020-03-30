From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Mon, 30 Mar 2020 08:41:09 +0000
Subject: Suspected bug in wait syscall or similar
Message-Id: <1848982.8N1hjUtedq@eto.sf-tec.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2420172.Oy1am9670f"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart2420172.Oy1am9670f
Content-Type: multipart/mixed; boundary="nextPart2387461.dWpZuIcutC"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2387461.dWpZuIcutC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I run a 32 bit Gentoo userspace on my T5120 with a 64 bit kernel (5.5.7 at the 
moment). This is nothing really new, I see this for a while, but it seems to 
got a bit worse lately.

My observations are:
-the testsuite of the fish shell often hangs. A subprocess goes zombie, but 
the parent never cleans this up
-some multiprocess python tests hang similar
-during boot the machine often hangs during the first few init scripts, 
usually after mounting debugfs or so. My initial suspect was missing random 
here, but that is not the case as it seems (RNG is seeded way before that 
point). It still seems that the machine boots if I send a few linebreaks via 
serial console before the userspace takes over
-yesterday shutting down was broken, every step where openrc tried to shutdown 
something hung:

root     63402  0.0  0.0   2880   832 ?        S    23:16   0:00 /sbin/openrc-
run /etc/init.d/save-keymaps --lockfd 7 stop
root     63403  0.2  0.0      0     0 ?        Z    23:16   0:00 [openrc-
run.sh] <defunct>

I was able to strace a bit of this while I killed the openrc processes from 
another SSH connection.

When I read about https://sourceware.org/git/?
p=glibc.git;a=commit;h=b33e946fbb1659d2c5937c4dd756a7c49a132dff I thought that 
this may solve the issue, but I rebuild my glibc in a chroot with that patch 
and at least the fish testsuite hangs are unchanged.

Has anyone a clue what's going on there?

Eike
--nextPart2387461.dWpZuIcutC
Content-Disposition: attachment; filename="castor-shutdown-hang.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="castor-shutdown-hang.txt"

[pid 63881] stat64("/etc/init.d/local", {st_mode=S_IFREG|0755, st_size=2752, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/local", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/agetty", {st_mode=S_IFREG|0755, st_size=1233, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/agetty", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/lvm", {st_mode=S_IFREG|0755, st_size=4474, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/lvm", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/device-mapper", {st_mode=S_IFREG|0755, st_size=3707, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/device-mapper", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/ntpd", {st_mode=S_IFREG|0755, st_size=489, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/ntpd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/sysfs", {st_mode=S_IFREG|0755, st_size=3301, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/sysfs", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/udev", {st_mode=S_IFREG|0755, st_size=2236, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/udev", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/save-termencoding", {st_mode=S_IFREG|0755, st_size=987, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/save-termencoding", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/save-keymaps", {st_mode=S_IFREG|0755, st_size=865, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/save-keymaps", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/bootmisc", {st_mode=S_IFREG|0755, st_size=5887, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/bootmisc", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/procfs", {st_mode=S_IFREG|0755, st_size=1262, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/procfs", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/devfs", {st_mode=S_IFREG|0755, st_size=3622, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/devfs", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/netmount", {st_mode=S_IFREG|0755, st_size=2071, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/netmount", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/ntp-client", {st_mode=S_IFREG|0755, st_size=720, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/ntp-client", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/pydoc-3.7", {st_mode=S_IFREG|0755, st_size=595, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/pydoc-3.7", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/syslog-ng", {st_mode=S_IFREG|0755, st_size=1891, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/syslog-ng", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/sntp", {st_mode=S_IFREG|0755, st_size=484, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/sntp", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/lvm-monitoring", {st_mode=S_IFREG|0755, st_size=963, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/lvm-monitoring", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/nagios", {st_mode=S_IFREG|0755, st_size=1972, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/nagios", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/iptables", {st_mode=S_IFREG|0755, st_size=2787, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/iptables", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/functions.sh", {st_mode=S_IFREG|0644, st_size=3127, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/functions.sh", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/sshd", {st_mode=S_IFREG|0755, st_size=2675, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/sshd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/s6-svscan", {st_mode=S_IFREG|0755, st_size=1030, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/s6-svscan", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/numlock", {st_mode=S_IFREG|0755, st_size=1119, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/numlock", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/net.lo", {st_mode=S_IFREG|0755, st_size=19780, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/net.lo", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/keymaps", {st_mode=S_IFREG|0755, st_size=1984, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/keymaps", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/init.d/udev-trigger", {st_mode=S_IFREG|0755, st_size=2595, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/init.d/udev-trigger", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] getdents64(3, /* 0 entries */, 32768) = 0
[pid 63881] close(3)                    = 0
[pid 63881] stat64("/etc/conf.d", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = 3
[pid 63881] fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63881] getdents64(3, /* 49 entries */, 32768) = 1520
[pid 63881] stat64("/etc/conf.d/rsyncd", {st_mode=S_IFREG|0644, st_size=149, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/rsyncd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/hwclock", {st_mode=S_IFREG|0644, st_size=857, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/hwclock", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/ip6tables", {st_mode=S_IFREG|0644, st_size=690, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/ip6tables", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/killprocs", {st_mode=S_IFREG|0644, st_size=235, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/killprocs", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/mdadm", {st_mode=S_IFREG|0644, st_size=205, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/mdadm", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/hostname", {st_mode=S_IFREG|0644, st_size=56, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/hostname", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/smartd", {st_mode=S_IFREG|0644, st_size=107, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/smartd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/pydoc-2.7", {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/pydoc-2.7", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/postgresql-12", {st_mode=S_IFREG|0644, st_size=2465, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/postgresql-12", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/dmesg", {st_mode=S_IFREG|0644, st_size=117, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/dmesg", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/urandom", {st_mode=S_IFREG|0644, st_size=282, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/urandom", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/consolefont", {st_mode=S_IFREG|0644, st_size=876, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/consolefont", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/fsck", {st_mode=S_IFREG|0644, st_size=1593, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/fsck", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/mdraid", {st_mode=S_IFREG|0644, st_size=383, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/mdraid", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/pydoc-3.6", {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/pydoc-3.6", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/swap", {st_mode=S_IFREG|0644, st_size=490, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/swap", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/udev-settle", {st_mode=S_IFREG|0644, st_size=187, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/udev-settle", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/pciparm", {st_mode=S_IFREG|0644, st_size=988, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/pciparm", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/modules", {st_mode=S_IFREG|0644, st_size=891, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/modules", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/opentmpfiles-setup", {st_mode=S_IFREG|0644, st_size=54, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/opentmpfiles-setup", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/mtab", {st_mode=S_IFREG|0644, st_size=693, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/mtab", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/gpsd", {st_mode=S_IFREG|0644, st_size=198, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/gpsd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/cronie", {st_mode=S_IFREG|0644, st_size=110, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/cronie", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/git-daemon", {st_mode=S_IFREG|0644, st_size=710, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/git-daemon", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/busybox-ntpd", {st_mode=S_IFREG|0644, st_size=186, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/busybox-ntpd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/busybox-watchdog", {st_mode=S_IFREG|0644, st_size=232, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/busybox-watchdog", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/opentmpfiles-dev", {st_mode=S_IFREG|0644, st_size=54, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/opentmpfiles-dev", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/apache2", {st_mode=S_IFREG|0644, st_size=3161, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/apache2", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/svnserve", {st_mode=S_IFREG|0644, st_size=322, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/svnserve", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/net-online", {st_mode=S_IFREG|0644, st_size=672, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/net-online", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/localmount", {st_mode=S_IFREG|0644, st_size=389, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/localmount", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/agetty", {st_mode=S_IFREG|0644, st_size=196, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/agetty", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/lvm", {st_mode=S_IFREG|0644, st_size=282, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/lvm", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/device-mapper", {st_mode=S_IFREG|0644, st_size=15, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/device-mapper", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/ntpd", {st_mode=S_IFREG|0644, st_size=182, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/ntpd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/udev", {st_mode=S_IFREG|0644, st_size=279, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/udev", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/bootmisc", {st_mode=S_IFREG|0644, st_size=475, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/bootmisc", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/devfs", {st_mode=S_IFREG|0644, st_size=348, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/devfs", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/netmount", {st_mode=S_IFREG|0644, st_size=1600, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/netmount", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/ntp-client", {st_mode=S_IFREG|0644, st_size=776, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/ntp-client", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/pydoc-3.7", {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/pydoc-3.7", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/syslog-ng", {st_mode=S_IFREG|0644, st_size=1557, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/syslog-ng", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/sntp", {st_mode=S_IFREG|0644, st_size=149, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/sntp", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/iptables", {st_mode=S_IFREG|0644, st_size=687, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/iptables", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/sshd", {st_mode=S_IFREG|0644, st_size=774, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/sshd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/keymaps", {st_mode=S_IFREG|0644, st_size=911, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/keymaps", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] stat64("/etc/conf.d/udev-trigger", {st_mode=S_IFREG|0644, st_size=1264, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/conf.d/udev-trigger", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] getdents64(3, /* 0 entries */, 32768) = 0
[pid 63881] close(3)                    = 0
[pid 63881] stat64("/usr/etc/init.d", 0xffbfc418) = -1 ENOENT (No such file or directory)
[pid 63881] stat64("/usr/etc/conf.d", 0xffbfc418) = -1 ENOENT (No such file or directory)
[pid 63881] stat64("/usr/local/etc/conf.d", 0xffbfc418) = -1 ENOENT (No such file or directory)
[pid 63881] stat64("/etc/rc.conf", {st_mode=S_IFREG|0644, st_size=12378, ...}) = 0
[pid 63881] openat(AT_FDCWD, "/etc/rc.conf", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
[pid 63881] openat(AT_FDCWD, "/run/openrc/depconfig", O_RDONLY) = 3
[pid 63881] fstat64(3, {st_mode=S_IFREG|0644, st_size=29, ...}) = 0
[pid 63881] read(3, "/etc/lvm/lvm.conf\n/etc/fstab\n", 8192) = 29
[pid 63881] read(3, "", 8192)           = 0
[pid 63881] close(3)                    = 0
[pid 63881] openat(AT_FDCWD, "/run/openrc/deptree", O_RDONLY) = 3
[pid 63881] fstat64(3, {st_mode=S_IFREG|0644, st_size=24961, ...}) = 0
[pid 63881] read(3, "depinfo_0_service='agetty'\ndepin"..., 8192) = 8192
[pid 63881] read(3, "svscan'\ndepinfo_27_iafter_58='sa"..., 8192) = 8192
[pid 63881] read(3, "_56_ibefore_1='local'\ndepinfo_56"..., 8192) = 8192
[pid 63881] read(3, "fo_91_iafter_1='sysctl'\ndepinfo_"..., 8192) = 385
[pid 63881] read(3, "", 8192)           = 0
[pid 63881] close(3)                    = 0
[pid 63881] pipe([3, 4])                = 3
[pid 63881] fcntl64(3, F_GETFD)         = 0
[pid 63881] fcntl64(3, F_SETFD, FD_CLOEXEC) = 0
[pid 63881] fcntl64(4, F_GETFD)         = 0
[pid 63881] fcntl64(4, F_SETFD, FD_CLOEXEC) = 0
[pid 63881] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63882 attached
, child_tidptr=0xf7f1d418) = 63882
[pid 63882] stat64("/run/openrc/openrc-run.sh",  <unfinished ...>
[pid 63881] poll([{fd=3, events=POLLIN}], 1, -1 <unfinished ...>
[pid 63882] <... stat64 resumed>0xffbfd4b8) = -1 ENOENT (No such file or directory)
[pid 63882] execve("/lib/rc/sh/openrc-run.sh", ["/lib/rc/sh/openrc-run.sh", "/etc/init.d/sshd", "stop"], 0x7001d5b8 /* 33 vars */) = 0
[pid 63882] brk(NULL)                   = 0x700da000
[pid 63882] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63882] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63882] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7f90000
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/lib/libreadline.so.7", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\345 \0\0\0004"..., 512) = 512
[pid 63882] fstat64(3, {st_mode=S_IFREG|0555, st_size=271680, ...}) = 0
[pid 63882] mmap2(NULL, 340312, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7f3c000
[pid 63882] mprotect(0xf7f7a000, 57344, PROT_NONE) = 0
[pid 63882] mmap2(0xf7f88000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3c000) = 0xf7f88000
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63882] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63882] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7d8c000
[pid 63882] mprotect(0xf7f24000, 65536, PROT_NONE) = 0
[pid 63882] mmap2(0xf7f34000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7f34000
[pid 63882] mmap2(0xf7f38000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7f38000
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/lib/libtinfow.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\212`\0\0\0004"..., 512) = 512
[pid 63882] fstat64(3, {st_mode=S_IFREG|0755, st_size=209452, ...}) = 0
[pid 63882] mmap2(NULL, 275104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7d48000
[pid 63882] mprotect(0xf7d7a000, 57344, PROT_NONE) = 0
[pid 63882] mmap2(0xf7d88000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf7d88000
[pid 63882] close(3)                    = 0
[pid 63882] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fd0000
[pid 63882] mprotect(0xf7f34000, 8192, PROT_READ) = 0
[pid 63882] mprotect(0xf7d88000, 8192, PROT_READ) = 0
[pid 63882] mprotect(0xf7f88000, 8192, PROT_READ) = 0
[pid 63882] mprotect(0x700cc000, 8192, PROT_READ) = 0
[pid 63882] mprotect(0xf7fd4000, 8192, PROT_READ) = 0
[pid 63882] munmap(0xf7f90000, 69720)   = 0
[pid 63882] openat(AT_FDCWD, "/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = -1 ENXIO (No such device or address)
[pid 63882] ioctl(0, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63882] fstat64(0, {st_mode=S_IFCHR|0600, st_rdev=makedev(0x5, 0x1), ...}) = 0
[pid 63882] brk(NULL)                   = 0x700da000
[pid 63882] brk(0x700fc000)             = 0x700fc000
[pid 63882] readlink("/proc/self/fd/0", "/dev/console", 4095) = 12
[pid 63882] stat64("/dev/console", {st_mode=S_IFCHR|0600, st_rdev=makedev(0x5, 0x1), ...}) = 0
[pid 63882] openat(AT_FDCWD, "/dev/console", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=4869456, ...}) = 0
[pid 63882] mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7b48000
[pid 63882] mmap2(NULL, 2596864, PROT_READ, MAP_PRIVATE, 3, 0x1de000) = 0xf78ce000
[pid 63882] close(3)                    = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63882] ioctl(-1, TIOCGPGRP, 0xff893668) = -1 EBADF (Bad file descriptor)
[pid 63882] sysinfo({uptime=1079301, loads=[7424, 9088, 89440], totalram=4134979, freeram=2364059, sharedram=960275, bufferram=70849, totalswap=0, freeswap=0, procs=525, totalhigh=0, freehigh=0, mem_unit=8192}) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGQUIT, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] uname({sysname="Linux", nodename="castor", ...}) = 0
[pid 63882] getcwd("/", 8192)           = 2
[pid 63882] getpid()                    = 63882
[pid 63882] openat(AT_FDCWD, "/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=26386, ...}) = 0
[pid 63882] mmap2(NULL, 26386, PROT_READ, MAP_SHARED, 3, 0) = 0xf7fc8000
[pid 63882] close(3)                    = 0
[pid 63882] getppid()                   = 63881
[pid 63882] socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
[pid 63882] connect(3, {sa_family=AF_UNIX, sun_path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
[pid 63882] close(3)                    = 0
[pid 63882] socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
[pid 63882] connect(3, {sa_family=AF_UNIX, sun_path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/etc/nsswitch.conf", O_RDONLY|O_CLOEXEC) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=332, ...}) = 0
[pid 63882] read(3, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 332
[pid 63882] read(3, "", 4096)           = 0
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63882] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7f90000
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/lib/libnss_db.so.2", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\21\340\0\0\0004"..., 512) = 512
[pid 63882] fstat64(3, {st_mode=S_IFREG|0755, st_size=26248, ...}) = 0
[pid 63882] mmap2(NULL, 103336, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf78b4000
[pid 63882] mprotect(0xf78ba000, 57344, PROT_NONE) = 0
[pid 63882] mmap2(0xf78c8000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0xf78c8000
[pid 63882] mmap2(0xf78cc000, 5032, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf78cc000
[pid 63882] close(3)                    = 0
[pid 63882] openat(AT_FDCWD, "/lib/libnss_files.so.2", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63882] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\32 \0\0\0004"..., 512) = 512
[pid 63882] fstat64(3, {st_mode=S_IFREG|0755, st_size=42748, ...}) = 0
[pid 63882] mmap2(NULL, 132288, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7890000
[pid 63882] mprotect(0xf789a000, 57344, PROT_NONE) = 0
[pid 63882] mmap2(0xf78a8000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0xf78a8000
[pid 63882] mmap2(0xf78ac000, 17600, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf78ac000
[pid 63882] close(3)                    = 0
[pid 63882] mprotect(0xf78a8000, 8192, PROT_READ) = 0
[pid 63882] mprotect(0xf78c8000, 8192, PROT_READ) = 0
[pid 63882] munmap(0xf7f90000, 69720)   = 0
[pid 63882] openat(AT_FDCWD, "/var/db/passwd.db", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63882] openat(AT_FDCWD, "/etc/passwd", O_RDONLY|O_CLOEXEC) = 3
[pid 63882] _llseek(3, 0, [0], SEEK_CUR) = 0
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=2429, ...}) = 0
[pid 63882] read(3, "root:x:0:0:root:/root:/bin/bash\n"..., 4096) = 2429
[pid 63882] close(3)                    = 0
[pid 63882] getpid()                    = 63882
[pid 63882] getpgrp()                   = 62241
[pid 63882] ioctl(2, TIOCGPGRP, 0xff893500) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63882] ioctl(2, TIOCGPGRP, 0xff893440) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63882] getrlimit(RLIMIT_NPROC, {rlim_cur=129205, rlim_max=129205}) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/openrc-run.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] stat64("/lib/rc/sh/openrc-run.sh", {st_mode=S_IFREG|0755, st_size=8960, ...}) = 0
[pid 63882] ioctl(3, TCGETS, 0xff893620) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63882] _llseek(3, 0, [0], SEEK_CUR) = 0
[pid 63882] read(3, "#!/bin/sh\n# Shell wrapper for op"..., 80) = 80
[pid 63882] _llseek(3, 0, [0], SEEK_SET) = 0
[pid 63882] getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=4*1024}) = 0
[pid 63882] fcntl64(255, F_GETFD)       = -1 EBADF (Bad file descriptor)
[pid 63882] dup2(3, 255)                = 255
[pid 63882] close(3)                    = 0
[pid 63882] fcntl64(255, F_SETFD, FD_CLOEXEC) = 0
[pid 63882] fcntl64(255, F_GETFL)       = 0x40000 (flags O_RDONLY|O_LARGEFILE)
[pid 63882] fstat64(255, {st_mode=S_IFREG|0755, st_size=8960, ...}) = 0
[pid 63882] _llseek(255, 0, [0], SEEK_CUR) = 0
[pid 63882] read(255, "#!/bin/sh\n# Shell wrapper for op"..., 8192) = 8192
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/functions.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=3127, ...}) = 0
[pid 63882] read(3, "# Allow any sh script to work wi"..., 3127) = 3127
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63883 attached
, child_tidptr=0xf7fd0958) = 63883
[pid 63883] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63883] <... getpid resumed>)       = 63883
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63883] close(255 <unfinished ...>
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63883] <... close resumed>)        = 0
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] close(4 <unfinished ...>
[pid 63883] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] <... close resumed>)        = 0
[pid 63883] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] read(3,  <unfinished ...>
[pid 63883] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63883] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63883] dup2(4, 1)                  = 1
[pid 63883] close(4)                    = 0
[pid 63883] close(3)                    = 0
[pid 63883] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63883] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63883] write(1, "/opt/bin:/var/qmail/bin\n", 24) = 24
[pid 63882] <... read resumed>"/opt/bin:/var/qmail/bin\n", 128) = 24
[pid 63882] read(3,  <unfinished ...>
[pid 63883] exit_group(0)               = ?
[pid 63883] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63883
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63884 attached
, child_tidptr=0xf7fd0958) = 63884
[pid 63884] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63884] <... getpid resumed>)       = 63884
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63884] close(255 <unfinished ...>
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63884] <... close resumed>)        = 0
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] close(4 <unfinished ...>
[pid 63884] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] <... close resumed>)        = 0
[pid 63884] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] read(3,  <unfinished ...>
[pid 63884] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] dup2(4, 1)                  = 1
[pid 63884] close(4)                    = 0
[pid 63884] close(3)                    = 0
[pid 63884] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63884] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63884] stat64("/lib/rc/bin/eval_ecolors", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63884] stat64("/lib/rc/bin/eval_ecolors", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63884] geteuid32()                 = 0
[pid 63884] getegid32()                 = 0
[pid 63884] getuid32()                  = 0
[pid 63884] getgid32()                  = 0
[pid 63884] access("/lib/rc/bin/eval_ecolors", X_OK) = 0
[pid 63884] stat64("/lib/rc/bin/eval_ecolors", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63884] geteuid32()                 = 0
[pid 63884] getegid32()                 = 0
[pid 63884] getuid32()                  = 0
[pid 63884] getgid32()                  = 0
[pid 63884] access("/lib/rc/bin/eval_ecolors", R_OK) = 0
[pid 63884] stat64("/lib/rc/bin/eval_ecolors", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63884] stat64("/lib/rc/bin/eval_ecolors", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63884] geteuid32()                 = 0
[pid 63884] getegid32()                 = 0
[pid 63884] getuid32()                  = 0
[pid 63884] getgid32()                  = 0
[pid 63884] access("/lib/rc/bin/eval_ecolors", X_OK) = 0
[pid 63884] stat64("/lib/rc/bin/eval_ecolors", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63884] geteuid32()                 = 0
[pid 63884] getegid32()                 = 0
[pid 63884] getuid32()                  = 0
[pid 63884] getgid32()                  = 0
[pid 63884] access("/lib/rc/bin/eval_ecolors", R_OK) = 0
[pid 63884] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63884] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63885 attached
, child_tidptr=0xf7fd0958) = 63885
[pid 63885] getpid( <unfinished ...>
[pid 63884] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63885] <... getpid resumed>)       = 63885
[pid 63884] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63885] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63884] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63885] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63884] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63885] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63885] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63884] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63885] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63885] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63884] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63885] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63885] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63884] <... rt_sigaction resumed>{sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63885] <... rt_sigaction resumed>{sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] waitpid(-1,  <unfinished ...>
[pid 63885] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63885] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63885] execve("/lib/rc/bin/eval_ecolors", ["eval_ecolors"], 0x700f0428 /* 36 vars */) = 0
[pid 63885] brk(NULL)                   = 0x70018000
[pid 63885] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls/v9v2/v9v/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls/v9v2/v9v", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls/v9v2/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls/v9v2", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls/v9v/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls/v9v", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/tls", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/v9v2/v9v/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/v9v2/v9v", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/v9v2/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/v9v2", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/v9v/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/v9v", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63885] stat64("/lib/v9", 0xfff44c90) = -1 ENOENT (No such file or directory)
[pid 63885] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63885] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63885] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63885] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79b4000
[pid 63885] mprotect(0xf79c0000, 57344, PROT_NONE) = 0
[pid 63885] mmap2(0xf79ce000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf79ce000
[pid 63885] close(3)                    = 0
[pid 63885] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63885] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63885] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63885] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf799c000
[pid 63885] mprotect(0xf79a0000, 57344, PROT_NONE) = 0
[pid 63885] mmap2(0xf79ae000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf79ae000
[pid 63885] close(3)                    = 0
[pid 63885] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63885] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63885] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63885] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf77ec000
[pid 63885] mprotect(0xf7984000, 65536, PROT_NONE) = 0
[pid 63885] mmap2(0xf7994000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7994000
[pid 63885] mmap2(0xf7998000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7998000
[pid 63885] close(3)                    = 0
[pid 63885] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63885] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63885] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf77d8000
[pid 63885] close(3)                    = 0
[pid 63885] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63885] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63885] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63885] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7794000
[pid 63885] mprotect(0xf77c4000, 65536, PROT_NONE) = 0
[pid 63885] mmap2(0xf77d4000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf77d4000
[pid 63885] close(3)                    = 0
[pid 63885] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7a00000
[pid 63885] mprotect(0xf7994000, 8192, PROT_READ) = 0
[pid 63885] mprotect(0xf77d4000, 8192, PROT_READ) = 0
[pid 63885] mprotect(0xf79ae000, 8192, PROT_READ) = 0
[pid 63885] mprotect(0xf79ce000, 8192, PROT_READ) = 0
[pid 63885] mprotect(0x70014000, 8192, PROT_READ) = 0
[pid 63885] mprotect(0xf7a04000, 8192, PROT_READ) = 0
[pid 63885] munmap(0xf77d8000, 69720)   = 0
[pid 63885] ioctl(1, TCGETS, 0xfff455f8) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(1, TCGETS, 0xfff45448) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63885] brk(NULL)                   = 0x70018000
[pid 63885] brk(0x7003a000)             = 0x7003a000
[pid 63885] stat64("/etc/terminfo", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63885] stat64("/usr/share/terminfo", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63885] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63885] access("/etc/terminfo/l/linux", R_OK) = 0
[pid 63885] openat(AT_FDCWD, "/etc/terminfo/l/linux", O_RDONLY|O_LARGEFILE) = 3
[pid 63885] fstat64(3, {st_mode=S_IFREG|0644, st_size=1730, ...}) = 0
[pid 63885] read(3, "\32\1\24\0\35\0\20\0}\1E\3linux|linux console\0"..., 4096) = 1730
[pid 63885] read(3, "", 4096)           = 0
[pid 63885] close(3)                    = 0
[pid 63885] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TIOCGWINSZ, 0xfff454ec) = 0
[pid 63885] ioctl(1, TCGETS, 0xfff455f8) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(1, TCGETS, 0xfff455f8) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(1, TCGETS, 0xfff455f8) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(1, TCGETS, 0xfff455f8) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(1, TCGETS, 0xfff455f8) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] ioctl(2, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63885] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63885] write(1, "GOOD='\33[1m\33[32m'\nWARN='\33[1m\33[33m"..., 103) = 103
[pid 63882] <... read resumed>"GOOD='\33[1m\33[32m'\nWARN='\33[1m\33[33m"..., 128) = 103
[pid 63885] exit_group(0 <unfinished ...>
[pid 63882] read(3,  <unfinished ...>
[pid 63885] <... exit_group resumed>)   = ?
[pid 63885] +++ exited with 0 +++
[pid 63884] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63885
[pid 63884] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63884] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63884] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=63885, si_uid=0, si_status=0, si_utime=0, si_stime=1} ---
[pid 63884] waitpid(-1, 0xff891d84, WNOHANG) = -1 ECHILD (No child processes)
[pid 63884] sigreturn({mask=[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32]}) = 0
[pid 63884] exit_group(0)               = ?
[pid 63884] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63884
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/rc-functions.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=2710, ...}) = 0
[pid 63882] read(3, "# Copyright (c) 2007 Gentoo Foun"..., 2710) = 2710
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] stat64("/lib/rc/sh/rc-cgroup.sh", {st_mode=S_IFREG|0644, st_size=6290, ...}) = 0
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/rc-cgroup.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=6290, ...}) = 0
[pid 63882] read(3, "# Copyright (c) 2012-2015 The Op"..., 6290) = 6290
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] brk(0x7011e000)             = 0x7011e000
[pid 63882] stat64("/sbin/livecd-functions.sh", 0xff8928e8) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/etc/rc.conf", {st_mode=S_IFREG|0644, st_size=12378, ...}) = 0
[pid 63882] openat(AT_FDCWD, "/etc/rc.conf", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=12378, ...}) = 0
[pid 63882] read(3, "# Global OpenRC configuration se"..., 12378) = 12378
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] stat64("/etc/rc.conf.d", 0xff8930f8) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/etc/init.d/../conf.d/sshd.shutdown", 0xff8928e8) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/etc/init.d/../conf.d/sshd", {st_mode=S_IFREG|0644, st_size=774, ...}) = 0
[pid 63882] openat(AT_FDCWD, "/etc/init.d/../conf.d/sshd", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=774, ...}) = 0
[pid 63882] read(3, "# /etc/conf.d/sshd: config file "..., 774) = 774
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/runit.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=1706, ...}) = 0
[pid 63882] read(3, "# Copyright (c) 2016 The OpenRC "..., 1706) = 1706
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/s6.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=2235, ...}) = 0
[pid 63882] read(3, "# Start / stop / status function"..., 2235) = 2235
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] brk(0x70140000)             = 0x70140000
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/start-stop-daemon.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=3381, ...}) = 0
[pid 63882] read(3, "# start / stop / status function"..., 3381) = 3381
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] openat(AT_FDCWD, "/lib/rc/sh/supervise-daemon.sh", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0644, st_size=3032, ...}) = 0
[pid 63882] read(3, "# start / stop / status function"..., 3032) = 3032
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] openat(AT_FDCWD, "/etc/init.d/sshd", O_RDONLY|O_LARGEFILE) = 3
[pid 63882] fstat64(3, {st_mode=S_IFREG|0755, st_size=2675, ...}) = 0
[pid 63882] read(3, "#!/sbin/openrc-run\n# Copyright 1"..., 2675) = 2675
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] _llseek(255, -2200, [5992], SEEK_CUR) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63886 attached
, child_tidptr=0xf7fd0958) = 63886
[pid 63886] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63886] <... getpid resumed>)       = 63886
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63886] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63886] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63886] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63886] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63886] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63886] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63886] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63886] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63886] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63886] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63886] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63886] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63886] dup2(4, 1)                  = 1
[pid 63886] close(4)                    = 0
[pid 63886] close(3)                    = 0
[pid 63886] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63886] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63886] write(1, "cgroup_add_service\n", 19) = 19
[pid 63882] <... read resumed>"cgroup_add_service\n", 128) = 19
[pid 63882] read(3,  <unfinished ...>
[pid 63886] exit_group(0)               = ?
[pid 63886] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63886
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63882] stat64("/lib/rc/sbin/grep", 0xff892698) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/lib/rc/bin/grep", 0xff892698) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63882] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/bin/grep", X_OK)   = 0
[pid 63882] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/bin/grep", R_OK)   = 0
[pid 63882] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63882] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/bin/grep", X_OK)   = 0
[pid 63882] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/bin/grep", R_OK)   = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [INT TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [INT TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63887 attached
, child_tidptr=0xf7fd0958) = 63887
[pid 63887] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63887] <... getpid resumed>)       = 63887
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63887] close(255)                  = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63887] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63887] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63887] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63887] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63887] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63887] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63887] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63887] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63887] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63887] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63887] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63887] execve("/bin/grep", ["grep", "-qs", "/sys/fs/cgroup", "/proc/1/mountinfo"], 0x7011f148 /* 38 vars */) = 0
[pid 63887] brk(NULL)                   = 0x70046000
[pid 63887] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63887] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63887] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63887] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7980000
[pid 63887] close(3)                    = 0
[pid 63887] openat(AT_FDCWD, "/lib/libpcre.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63887] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\20\0\0\0\0004"..., 512) = 512
[pid 63887] fstat64(3, {st_mode=S_IFREG|0755, st_size=452224, ...}) = 0
[pid 63887] mmap2(NULL, 516680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7900000
[pid 63887] mprotect(0xf796e000, 57344, PROT_NONE) = 0
[pid 63887] mmap2(0xf797c000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6c000) = 0xf797c000
[pid 63887] close(3)                    = 0
[pid 63887] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63887] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63887] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63887] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7750000
[pid 63887] mprotect(0xf78e8000, 65536, PROT_NONE) = 0
[pid 63887] mmap2(0xf78f8000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf78f8000
[pid 63887] mmap2(0xf78fc000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf78fc000
[pid 63887] close(3)                    = 0
[pid 63887] openat(AT_FDCWD, "/lib/libpthread.so.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63887] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0W\200\0\0\0004"..., 512) = 512
[pid 63887] fstat64(3, {st_mode=S_IFREG|0755, st_size=144720, ...}) = 0
[pid 63887] mmap2(NULL, 189896, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7720000
[pid 63887] mprotect(0xf773c000, 57344, PROT_NONE) = 0
[pid 63887] mmap2(0xf774a000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0xf774a000
[pid 63887] mmap2(0xf774e000, 1480, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf774e000
[pid 63887] close(3)                    = 0
[pid 63887] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf79c0000
[pid 63887] mprotect(0xf78f8000, 8192, PROT_READ) = 0
[pid 63887] mprotect(0xf774a000, 8192, PROT_READ) = 0
[pid 63887] mprotect(0xf797c000, 8192, PROT_READ) = 0
[pid 63887] mprotect(0x7003e000, 8192, PROT_READ) = 0
[pid 63887] mprotect(0xf79c4000, 8192, PROT_READ) = 0
[pid 63887] munmap(0xf7980000, 69720)   = 0
[pid 63887] set_tid_address(0xf79c0958) = 63887
[pid 63887] set_robust_list(0xf79c0960, 12) = 0
[pid 63887] rt_sigaction(SIGRTMIN, {sa_handler=0xf7724f40, sa_mask=[], sa_flags=SA_SIGINFO}, NULL, 0xf7737358, 8) = 0
[pid 63887] rt_sigaction(SIGRT_1, {sa_handler=0xf7725020, sa_mask=[], sa_flags=SA_RESTART|SA_SIGINFO}, NULL, 0xf7737358, 8) = 0
[pid 63887] rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
[pid 63887] getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=2147483647}) = 0
[pid 63887] brk(NULL)                   = 0x70046000
[pid 63887] brk(0x70068000)             = 0x70068000
[pid 63887] openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63887] fstat64(3, {st_mode=S_IFREG|0644, st_size=4869456, ...}) = 0
[pid 63887] mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7520000
[pid 63887] mmap2(NULL, 2596864, PROT_READ, MAP_PRIVATE, 3, 0x1de000) = 0xf72a6000
[pid 63887] close(3)                    = 0
[pid 63887] openat(AT_FDCWD, "/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
[pid 63887] fstat64(3, {st_mode=S_IFREG|0644, st_size=26386, ...}) = 0
[pid 63887] mmap2(NULL, 26386, PROT_READ, MAP_SHARED, 3, 0) = 0xf79b8000
[pid 63887] close(3)                    = 0
[pid 63887] futex(0xf78fb4c4, FUTEX_WAKE_PRIVATE, 2147483647) = 0
[pid 63887] sigaltstack({ss_sp=0x70040858, ss_flags=0, ss_size=16384}, NULL) = 0
[pid 63887] rt_sigaction(SIGSEGV, {sa_handler=0x7000c1e0, sa_mask=[], sa_flags=SA_ONSTACK|SA_NODEFER|SA_RESETHAND|SA_SIGINFO}, NULL, 0xf7784378, 8) = 0
[pid 63887] openat(AT_FDCWD, "/proc/1/mountinfo", O_RDONLY|O_NOCTTY|O_LARGEFILE) = 3
[pid 63887] fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63887] read(3, "20 24 0:5 / /proc rw,nosuid,node"..., 98304) = 493
[pid 63887] read(3, "", 98304)          = 0
[pid 63887] close(3)                    = 0
[pid 63887] close(1)                    = 0
[pid 63887] close(2)                    = 0
[pid 63887] exit_group(1)               = ?
[pid 63887] +++ exited with 1 +++
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 63887
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] openat(AT_FDCWD, "/sys/fs/cgroup/", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = 3
[pid 63882] fstat64(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
[pid 63882] getdents64(3, /* 2 entries */, 32768) = 48
[pid 63882] getdents64(3, /* 0 entries */, 32768) = 0
[pid 63882] close(3)                    = 0
[pid 63882] faccessat(AT_FDCWD, "/sys/fs/cgroup/*/tasks", W_OK) = -1 ENOENT (No such file or directory)
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] stat64("/sys/fs/cgroup/openrc", 0xff8922f0) = -1 ENOENT (No such file or directory)
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63888 attached
, child_tidptr=0xf7fd0958) = 63888
[pid 63888] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63888] <... getpid resumed>)       = 63888
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63888] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63888] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63888] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63888] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63888] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63888] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63888] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63888] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63888] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63888] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63888] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63888] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63888] dup2(4, 1)                  = 1
[pid 63888] close(4)                    = 0
[pid 63888] close(3)                    = 0
[pid 63888] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63888] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63888] write(1, "cgroup_set_limits\n", 18) = 18
[pid 63882] <... read resumed>"cgroup_set_limits\n", 128) = 18
[pid 63882] read(3,  <unfinished ...>
[pid 63888] exit_group(0)               = ?
[pid 63888] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63888
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63889 attached
, child_tidptr=0xf7fd0958) = 63889
[pid 63889] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63889] <... getpid resumed>)       = 63889
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63889] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63889] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63889] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63889] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63889] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63889] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63889] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63889] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63889] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63889] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63889] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63889] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63889] dup2(4, 1)                  = 1
[pid 63889] close(4)                    = 0
[pid 63889] close(3)                    = 0
[pid 63889] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63889] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63889] write(1, "cgroup2_set_limits\n", 19) = 19
[pid 63882] <... read resumed>"cgroup2_set_limits\n", 128) = 19
[pid 63882] read(3,  <unfinished ...>
[pid 63889] exit_group(0)               = ?
[pid 63889] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63889
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] read(255, "\neval \"printf '%s\\n' $required_d"..., 8192) = 2968
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [INT TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [INT TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] _llseek(255, -2802, [6158], SEEK_CUR) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63890 attached
, child_tidptr=0xf7fd0958) = 63890
[pid 63890] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63890] <... getpid resumed>)       = 63890
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] close(4)                    = 0
[pid 63890] close(255)                  = 0
[pid 63882] close(4 <unfinished ...>
[pid 63890] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = -1 EBADF (Bad file descriptor)
[pid 63890] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63890] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD],  <unfinished ...>
[pid 63890] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63890] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD <unfinished ...>
[pid 63890] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63890] close(3strace: Process 63891 attached
)                    = 0
[pid 63882] <... clone resumed>, child_tidptr=0xf7fd0958) = 63891
[pid 63890] dup2(4, 1 <unfinished ...>
[pid 63891] getpid( <unfinished ...>
[pid 63890] <... dup2 resumed>)         = 1
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63891] <... getpid resumed>)       = 63891
[pid 63890] close(4 <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63890] <... close resumed>)        = 0
[pid 63882] close(3 <unfinished ...>
[pid 63891] close(255 <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63891] <... close resumed>)        = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63891] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63891] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63890] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63891] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63890] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63891] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63890] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63890] <... rt_sigaction resumed>{sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63891] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63890] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63890] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63882] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63891] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63890] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63890] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63891] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63890] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63890] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63891] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63890] ioctl(2, TIOCGPGRP <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63890] <... ioctl resumed>, 0xff893118) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63891] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63890] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63890] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63891] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63890] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63891] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63890] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63891] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63890] rt_sigprocmask(SIG_BLOCK, NULL,  <unfinished ...>
[pid 63891] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63890] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63891] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63891] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63891] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63890] fstat64(1,  <unfinished ...>
[pid 63891] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63890] <... fstat64 resumed>{st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63891] ioctl(2, TIOCGPGRP, 0xff8931c0) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63891] dup2(3, 0)                  = 0
[pid 63891] close(3 <unfinished ...>
[pid 63890] write(1, "\n", 1 <unfinished ...>
[pid 63891] <... close resumed>)        = 0
[pid 63890] <... write resumed>)        = 1
[pid 63890] exit_group(0 <unfinished ...>
[pid 63891] ioctl(0, TCGETS <unfinished ...>
[pid 63890] <... exit_group resumed>)   = ?
[pid 63891] <... ioctl resumed>, 0xff892bc0) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63891] _llseek(0, 0, 0xff892c60, SEEK_CUR) = -1 ESPIPE (Illegal seek)
[pid 63891] read(0, "\n", 1)            = 1
[pid 63890] +++ exited with 0 +++
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63890
[pid 63891] ioctl(0, TCGETS <unfinished ...>
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63891] <... ioctl resumed>, 0xff892bc0) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63891] _llseek(0, 0, 0xff892c60, SEEK_CUR) = -1 ESPIPE (Illegal seek)
[pid 63891] read(0, "", 1)              = 0
[pid 63891] exit_group(0)               = ?
[pid 63891] +++ exited with 0 +++
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63891
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] close(3)                    = -1 EBADF (Bad file descriptor)
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] read(255, "[ $? -ne 0 ] && exit 1\nunset _d\n"..., 8192) = 2802
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] _llseek(255, -2606, [6354], SEEK_CUR) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63892 attached
, child_tidptr=0xf7fd0958) = 63892
[pid 63892] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63892] <... getpid resumed>)       = 63892
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] close(4)                    = 0
[pid 63892] close(255)                  = 0
[pid 63882] close(4 <unfinished ...>
[pid 63892] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = -1 EBADF (Bad file descriptor)
[pid 63892] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63892] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD],  <unfinished ...>
[pid 63892] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63892] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD <unfinished ...>
[pid 63892] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63892] close(3)                    = 0
strace: Process 63893 attached
[pid 63892] dup2(4, 1 <unfinished ...>
[pid 63882] <... clone resumed>, child_tidptr=0xf7fd0958) = 63893
[pid 63892] <... dup2 resumed>)         = 1
[pid 63893] getpid( <unfinished ...>
[pid 63892] close(4 <unfinished ...>
[pid 63893] <... getpid resumed>)       = 63893
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63892] <... close resumed>)        = 0
[pid 63893] close(255 <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63893] <... close resumed>)        = 0
[pid 63882] close(3 <unfinished ...>
[pid 63893] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63892] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63893] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63892] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63893] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63892] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63893] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63892] <... rt_sigaction resumed>{sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63893] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63893] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63892] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63893] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63892] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63893] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63892] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63893] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63892] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63893] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63893] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63892] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63893] <... rt_sigaction resumed>{sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63892] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63893] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63893] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63892] ioctl(2, TIOCGPGRP <unfinished ...>
[pid 63893] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63892] <... ioctl resumed>, 0xff893118) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63893] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63892] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63893] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63892] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63893] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63892] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63893] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63892] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63893] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63893] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63892] rt_sigprocmask(SIG_BLOCK, NULL,  <unfinished ...>
[pid 63893] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63892] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63893] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63893] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63892] fstat64(1,  <unfinished ...>
[pid 63893] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63892] <... fstat64 resumed>{st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63893] ioctl(2, TIOCGPGRP, 0xff8931c0) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63893] dup2(3, 0)                  = 0
[pid 63893] close(3 <unfinished ...>
[pid 63892] write(1, "\n", 1 <unfinished ...>
[pid 63893] <... close resumed>)        = 0
[pid 63892] <... write resumed>)        = 1
[pid 63893] ioctl(0, TCGETS <unfinished ...>
[pid 63892] exit_group(0 <unfinished ...>
[pid 63893] <... ioctl resumed>, 0xff892bc0) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63892] <... exit_group resumed>)   = ?
[pid 63893] _llseek(0, 0, 0xff892c60, SEEK_CUR) = -1 ESPIPE (Illegal seek)
[pid 63893] read(0, "\n", 1)            = 1
[pid 63892] +++ exited with 0 +++
[pid 63893] ioctl(0, TCGETS <unfinished ...>
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63892
[pid 63893] <... ioctl resumed>, 0xff892bc0) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63893] _llseek(0, 0, 0xff892c60, SEEK_CUR) = -1 ESPIPE (Illegal seek)
[pid 63893] read(0, "", 1)              = 0
[pid 63893] exit_group(0)               = ?
[pid 63893] +++ exited with 0 +++
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63893
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] close(3)                    = -1 EBADF (Bad file descriptor)
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] read(255, "[ $? -ne 0 ] && exit 1\nunset _f\n"..., 8192) = 2606
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] _llseek(255, -8, [8952], SEEK_CUR) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63895 attached
, child_tidptr=0xf7fd0958) = 63895
[pid 63895] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63895] <... getpid resumed>)       = 63895
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63895] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63895] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63895] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63895] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63895] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63895] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63895] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63895] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63895] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63895] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63895] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63895] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63895] dup2(4, 1)                  = 1
[pid 63895] close(4)                    = 0
[pid 63895] close(3)                    = 0
[pid 63895] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63895] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63895] write(1, "stop\n", 5)       = 5
[pid 63882] <... read resumed>"stop\n", 128) = 5
[pid 63882] read(3,  <unfinished ...>
[pid 63895] exit_group(0)               = ?
[pid 63895] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63895
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] stat64("/run/openrc/softlevel", {st_mode=S_IFREG|0644, st_size=8, ...}) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63896 attached
, child_tidptr=0xf7fd0958) = 63896
[pid 63896] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63896] <... getpid resumed>)       = 63896
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63896] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63896] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63896] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63896] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63896] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63896] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63896] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63896] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63896] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63896] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63896] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63896] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63896] dup2(4, 1)                  = 1
[pid 63896] close(4)                    = 0
[pid 63896] close(3)                    = 0
[pid 63896] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63896] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63896] write(1, "stop_pre\n", 9)   = 9
[pid 63882] <... read resumed>"stop_pre\n", 128) = 9
[pid 63882] read(3,  <unfinished ...>
[pid 63896] exit_group(0)               = ?
[pid 63896] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63896
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63897 attached
, child_tidptr=0xf7fd0958) = 63897
[pid 63897] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63897] <... getpid resumed>)       = 63897
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63897] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63897] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63897] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63897] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63897] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] dup2(4, 1)                  = 1
[pid 63897] close(4)                    = 0
[pid 63897] close(3)                    = 0
[pid 63897] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63897] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63897] stat64("/lib/rc/sbin/service_get_value", 0xff88fd80) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63897] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63897] geteuid32()                 = 0
[pid 63897] getegid32()                 = 0
[pid 63897] getuid32()                  = 0
[pid 63897] getgid32()                  = 0
[pid 63897] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63897] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63897] geteuid32()                 = 0
[pid 63897] getegid32()                 = 0
[pid 63897] getuid32()                  = 0
[pid 63897] getgid32()                  = 0
[pid 63897] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63897] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63897] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63897] geteuid32()                 = 0
[pid 63897] getegid32()                 = 0
[pid 63897] getuid32()                  = 0
[pid 63897] getgid32()                  = 0
[pid 63897] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63897] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63897] geteuid32()                 = 0
[pid 63897] getegid32()                 = 0
[pid 63897] getuid32()                  = 0
[pid 63897] getgid32()                  = 0
[pid 63897] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63897] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63897] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63897] execve("/lib/rc/bin/service_get_value", ["service_get_value", "command"], 0x7011f148 /* 38 vars */) = 0
[pid 63897] brk(NULL)                   = 0x70016000
[pid 63897] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls/v9v2/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls/v9v2/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls/v9v2/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls/v9v2", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/tls", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/v9v2/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/v9v2/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/v9v2/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/v9v2", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63897] stat64("/lib/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63897] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63897] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63897] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63897] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7b1c000
[pid 63897] mprotect(0xf7b28000, 57344, PROT_NONE) = 0
[pid 63897] mmap2(0xf7b36000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf7b36000
[pid 63897] close(3)                    = 0
[pid 63897] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63897] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63897] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63897] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7b04000
[pid 63897] mprotect(0xf7b08000, 57344, PROT_NONE) = 0
[pid 63897] mmap2(0xf7b16000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf7b16000
[pid 63897] close(3)                    = 0
[pid 63897] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63897] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63897] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63897] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7954000
[pid 63897] mprotect(0xf7aec000, 65536, PROT_NONE) = 0
[pid 63897] mmap2(0xf7afc000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7afc000
[pid 63897] mmap2(0xf7b00000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7b00000
[pid 63897] close(3)                    = 0
[pid 63897] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63897] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63897] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7940000
[pid 63897] close(3)                    = 0
[pid 63897] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63897] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63897] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63897] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf78fc000
[pid 63897] mprotect(0xf792c000, 65536, PROT_NONE) = 0
[pid 63897] mmap2(0xf793c000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf793c000
[pid 63897] close(3)                    = 0
[pid 63897] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7b68000
[pid 63897] mprotect(0xf7afc000, 8192, PROT_READ) = 0
[pid 63897] mprotect(0xf793c000, 8192, PROT_READ) = 0
[pid 63897] mprotect(0xf7b16000, 8192, PROT_READ) = 0
[pid 63897] mprotect(0xf7b36000, 8192, PROT_READ) = 0
[pid 63897] mprotect(0x70012000, 8192, PROT_READ) = 0
[pid 63897] mprotect(0xf7b6c000, 8192, PROT_READ) = 0
[pid 63897] munmap(0xf7940000, 69720)   = 0
[pid 63897] brk(NULL)                   = 0x70016000
[pid 63897] brk(0x70038000)             = 0x70038000
[pid 63897] openat(AT_FDCWD, "/run/openrc/options/sshd/command", O_RDONLY|O_CLOEXEC) = 3
[pid 63897] fstat64(3, {st_mode=S_IFREG|0644, st_size=14, ...}) = 0
[pid 63897] fstat64(3, {st_mode=S_IFREG|0644, st_size=14, ...}) = 0
[pid 63897] read(3, "/usr/sbin/sshd", 8192) = 14
[pid 63897] close(3)                    = 0
[pid 63897] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63897] write(1, "/usr/sbin/sshd", 14) = 14
[pid 63882] <... read resumed>"/usr/sbin/sshd", 128) = 14
[pid 63897] exit_group(0 <unfinished ...>
[pid 63882] read(3,  <unfinished ...>
[pid 63897] <... exit_group resumed>)   = ?
[pid 63897] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63897
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63898 attached
, child_tidptr=0xf7fd0958) = 63898
[pid 63898] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63898] <... getpid resumed>)       = 63898
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63898] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63898] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63898] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63898] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63898] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] dup2(4, 1)                  = 1
[pid 63898] close(4)                    = 0
[pid 63898] close(3)                    = 0
[pid 63898] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63898] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63898] stat64("/lib/rc/sbin/service_get_value", 0xff88fed8) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63898] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63898] geteuid32()                 = 0
[pid 63898] getegid32()                 = 0
[pid 63898] getuid32()                  = 0
[pid 63898] getgid32()                  = 0
[pid 63898] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63898] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63898] geteuid32()                 = 0
[pid 63898] getegid32()                 = 0
[pid 63898] getuid32()                  = 0
[pid 63898] getgid32()                  = 0
[pid 63898] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63898] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63898] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63898] geteuid32()                 = 0
[pid 63898] getegid32()                 = 0
[pid 63898] getuid32()                  = 0
[pid 63898] getgid32()                  = 0
[pid 63898] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63898] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63898] geteuid32()                 = 0
[pid 63898] getegid32()                 = 0
[pid 63898] getuid32()                  = 0
[pid 63898] getgid32()                  = 0
[pid 63898] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63898] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63898] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63898] execve("/lib/rc/bin/service_get_value", ["service_get_value", "chroot"], 0x7011f148 /* 38 vars */) = 0
[pid 63898] brk(NULL)                   = 0x70016000
[pid 63898] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls/v9v2/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls/v9v2/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls/v9v2/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls/v9v2", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/tls", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/v9v2/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/v9v2/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/v9v2/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/v9v2", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/v9v/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/v9v", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] stat64("/lib/v9", 0xffb42c30) = -1 ENOENT (No such file or directory)
[pid 63898] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63898] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63898] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63898] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7f28000
[pid 63898] mprotect(0xf7f34000, 57344, PROT_NONE) = 0
[pid 63898] mmap2(0xf7f42000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf7f42000
[pid 63898] close(3)                    = 0
[pid 63898] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63898] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63898] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63898] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7f10000
[pid 63898] mprotect(0xf7f14000, 57344, PROT_NONE) = 0
[pid 63898] mmap2(0xf7f22000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf7f22000
[pid 63898] close(3)                    = 0
[pid 63898] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63898] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63898] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63898] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7d60000
[pid 63898] mprotect(0xf7ef8000, 65536, PROT_NONE) = 0
[pid 63898] mmap2(0xf7f08000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7f08000
[pid 63898] mmap2(0xf7f0c000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7f0c000
[pid 63898] close(3)                    = 0
[pid 63898] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63898] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63898] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7d4c000
[pid 63898] close(3)                    = 0
[pid 63898] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63898] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63898] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63898] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7d08000
[pid 63898] mprotect(0xf7d38000, 65536, PROT_NONE) = 0
[pid 63898] mmap2(0xf7d48000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf7d48000
[pid 63898] close(3)                    = 0
[pid 63898] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f74000
[pid 63898] mprotect(0xf7f08000, 8192, PROT_READ) = 0
[pid 63898] mprotect(0xf7d48000, 8192, PROT_READ) = 0
[pid 63898] mprotect(0xf7f22000, 8192, PROT_READ) = 0
[pid 63898] mprotect(0xf7f42000, 8192, PROT_READ) = 0
[pid 63898] mprotect(0x70012000, 8192, PROT_READ) = 0
[pid 63898] mprotect(0xf7f78000, 8192, PROT_READ) = 0
[pid 63898] munmap(0xf7d4c000, 69720)   = 0
[pid 63898] brk(NULL)                   = 0x70016000
[pid 63898] brk(0x70038000)             = 0x70038000
[pid 63898] openat(AT_FDCWD, "/run/openrc/options/sshd/chroot", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63898] exit_group(1)               = ?
[pid 63898] +++ exited with 1 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 63898
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63899 attached
, child_tidptr=0xf7fd0958) = 63899
[pid 63899] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63899] <... getpid resumed>)       = 63899
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63899] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63899] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63899] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63899] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63899] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] dup2(4, 1)                  = 1
[pid 63899] close(4)                    = 0
[pid 63899] close(3)                    = 0
[pid 63899] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63899] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63899] stat64("/lib/rc/sbin/service_get_value", 0xff890030) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63899] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63899] geteuid32()                 = 0
[pid 63899] getegid32()                 = 0
[pid 63899] getuid32()                  = 0
[pid 63899] getgid32()                  = 0
[pid 63899] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63899] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63899] geteuid32()                 = 0
[pid 63899] getegid32()                 = 0
[pid 63899] getuid32()                  = 0
[pid 63899] getgid32()                  = 0
[pid 63899] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63899] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63899] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63899] geteuid32()                 = 0
[pid 63899] getegid32()                 = 0
[pid 63899] getuid32()                  = 0
[pid 63899] getgid32()                  = 0
[pid 63899] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63899] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63899] geteuid32()                 = 0
[pid 63899] getegid32()                 = 0
[pid 63899] getuid32()                  = 0
[pid 63899] getgid32()                  = 0
[pid 63899] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63899] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63899] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63899] execve("/lib/rc/bin/service_get_value", ["service_get_value", "pidfile"], 0x7011f148 /* 38 vars */) = 0
[pid 63899] brk(NULL)                   = 0x70016000
[pid 63899] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls/v9v2/v9v/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls/v9v2/v9v", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls/v9v2/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls/v9v2", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls/v9v/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls/v9v", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/tls", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/v9v2/v9v/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/v9v2/v9v", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/v9v2/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/v9v2", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/v9v/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/v9v", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63899] stat64("/lib/v9", 0xffe4cc30) = -1 ENOENT (No such file or directory)
[pid 63899] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63899] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63899] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63899] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7bc4000
[pid 63899] mprotect(0xf7bd0000, 57344, PROT_NONE) = 0
[pid 63899] mmap2(0xf7bde000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf7bde000
[pid 63899] close(3)                    = 0
[pid 63899] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63899] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63899] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63899] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7bac000
[pid 63899] mprotect(0xf7bb0000, 57344, PROT_NONE) = 0
[pid 63899] mmap2(0xf7bbe000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf7bbe000
[pid 63899] close(3)                    = 0
[pid 63899] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63899] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63899] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63899] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79fc000
[pid 63899] mprotect(0xf7b94000, 65536, PROT_NONE) = 0
[pid 63899] mmap2(0xf7ba4000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7ba4000
[pid 63899] mmap2(0xf7ba8000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7ba8000
[pid 63899] close(3)                    = 0
[pid 63899] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63899] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63899] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf79e8000
[pid 63899] close(3)                    = 0
[pid 63899] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63899] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63899] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63899] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79a4000
[pid 63899] mprotect(0xf79d4000, 65536, PROT_NONE) = 0
[pid 63899] mmap2(0xf79e4000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf79e4000
[pid 63899] close(3)                    = 0
[pid 63899] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7c10000
[pid 63899] mprotect(0xf7ba4000, 8192, PROT_READ) = 0
[pid 63899] mprotect(0xf79e4000, 8192, PROT_READ) = 0
[pid 63899] mprotect(0xf7bbe000, 8192, PROT_READ) = 0
[pid 63899] mprotect(0xf7bde000, 8192, PROT_READ) = 0
[pid 63899] mprotect(0x70012000, 8192, PROT_READ) = 0
[pid 63899] mprotect(0xf7c14000, 8192, PROT_READ) = 0
[pid 63899] munmap(0xf79e8000, 69720)   = 0
[pid 63899] brk(NULL)                   = 0x70016000
[pid 63899] brk(0x70038000)             = 0x70038000
[pid 63899] openat(AT_FDCWD, "/run/openrc/options/sshd/pidfile", O_RDONLY|O_CLOEXEC) = 3
[pid 63899] fstat64(3, {st_mode=S_IFREG|0644, st_size=13, ...}) = 0
[pid 63899] fstat64(3, {st_mode=S_IFREG|0644, st_size=13, ...}) = 0
[pid 63899] read(3, "/run/sshd.pid", 8192) = 13
[pid 63899] close(3)                    = 0
[pid 63899] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63899] write(1, "/run/sshd.pid", 13) = 13
[pid 63882] <... read resumed>"/run/sshd.pid", 128) = 13
[pid 63899] exit_group(0 <unfinished ...>
[pid 63882] read(3,  <unfinished ...>
[pid 63899] <... exit_group resumed>)   = ?
[pid 63899] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63899
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63900 attached
, child_tidptr=0xf7fd0958) = 63900
[pid 63900] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63900] <... getpid resumed>)       = 63900
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63900] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63900] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63900] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63900] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63900] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] dup2(4, 1)                  = 1
[pid 63900] close(4)                    = 0
[pid 63900] close(3)                    = 0
[pid 63900] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63900] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63900] stat64("/lib/rc/sbin/service_get_value", 0xff890188) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63900] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63900] geteuid32()                 = 0
[pid 63900] getegid32()                 = 0
[pid 63900] getuid32()                  = 0
[pid 63900] getgid32()                  = 0
[pid 63900] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63900] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63900] geteuid32()                 = 0
[pid 63900] getegid32()                 = 0
[pid 63900] getuid32()                  = 0
[pid 63900] getgid32()                  = 0
[pid 63900] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63900] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63900] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63900] geteuid32()                 = 0
[pid 63900] getegid32()                 = 0
[pid 63900] getuid32()                  = 0
[pid 63900] getgid32()                  = 0
[pid 63900] access("/lib/rc/bin/service_get_value", X_OK) = 0
[pid 63900] stat64("/lib/rc/bin/service_get_value", {st_mode=S_IFREG|0755, st_size=18860, ...}) = 0
[pid 63900] geteuid32()                 = 0
[pid 63900] getegid32()                 = 0
[pid 63900] getuid32()                  = 0
[pid 63900] getgid32()                  = 0
[pid 63900] access("/lib/rc/bin/service_get_value", R_OK) = 0
[pid 63900] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63900] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63900] execve("/lib/rc/bin/service_get_value", ["service_get_value", "procname"], 0x7011f148 /* 38 vars */) = 0
[pid 63900] brk(NULL)                   = 0x70016000
[pid 63900] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls/v9v2/v9v/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls/v9v2/v9v", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls/v9v2/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls/v9v2", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls/v9v/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls/v9v", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/tls", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/v9v2/v9v/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/v9v2/v9v", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/v9v2/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/v9v2", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/v9v/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/v9v", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] stat64("/lib/v9", 0xffa0ec30) = -1 ENOENT (No such file or directory)
[pid 63900] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63900] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63900] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63900] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7cf8000
[pid 63900] mprotect(0xf7d04000, 57344, PROT_NONE) = 0
[pid 63900] mmap2(0xf7d12000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf7d12000
[pid 63900] close(3)                    = 0
[pid 63900] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63900] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63900] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63900] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7ce0000
[pid 63900] mprotect(0xf7ce4000, 57344, PROT_NONE) = 0
[pid 63900] mmap2(0xf7cf2000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf7cf2000
[pid 63900] close(3)                    = 0
[pid 63900] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63900] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63900] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63900] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7b30000
[pid 63900] mprotect(0xf7cc8000, 65536, PROT_NONE) = 0
[pid 63900] mmap2(0xf7cd8000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7cd8000
[pid 63900] mmap2(0xf7cdc000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7cdc000
[pid 63900] close(3)                    = 0
[pid 63900] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63900] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63900] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7b1c000
[pid 63900] close(3)                    = 0
[pid 63900] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63900] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63900] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63900] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7ad8000
[pid 63900] mprotect(0xf7b08000, 65536, PROT_NONE) = 0
[pid 63900] mmap2(0xf7b18000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf7b18000
[pid 63900] close(3)                    = 0
[pid 63900] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7d44000
[pid 63900] mprotect(0xf7cd8000, 8192, PROT_READ) = 0
[pid 63900] mprotect(0xf7b18000, 8192, PROT_READ) = 0
[pid 63900] mprotect(0xf7cf2000, 8192, PROT_READ) = 0
[pid 63900] mprotect(0xf7d12000, 8192, PROT_READ) = 0
[pid 63900] mprotect(0x70012000, 8192, PROT_READ) = 0
[pid 63900] mprotect(0xf7d48000, 8192, PROT_READ) = 0
[pid 63900] munmap(0xf7b1c000, 69720)   = 0
[pid 63900] brk(NULL)                   = 0x70016000
[pid 63900] brk(0x70038000)             = 0x70038000
[pid 63900] openat(AT_FDCWD, "/run/openrc/options/sshd/procname", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63900] exit_group(1)               = ?
[pid 63900] +++ exited with 1 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 63900
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63882] stat64("/lib/rc/sbin/ebegin", 0xff891210) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/lib/rc/bin/ebegin", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] stat64("/lib/rc/bin/ebegin", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/ebegin", X_OK) = 0
[pid 63882] stat64("/lib/rc/bin/ebegin", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/ebegin", R_OK) = 0
[pid 63882] stat64("/lib/rc/bin/ebegin", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] stat64("/lib/rc/bin/ebegin", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/ebegin", X_OK) = 0
[pid 63882] stat64("/lib/rc/bin/ebegin", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/ebegin", R_OK) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [INT TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [INT TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63901 attached
, child_tidptr=0xf7fd0958) = 63901
[pid 63901] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63901] <... getpid resumed>)       = 63901
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63901] close(255)                  = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63901] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63901] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63901] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63901] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63901] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63901] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63901] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63901] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63901] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63901] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63901] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63901] execve("/lib/rc/bin/ebegin", ["ebegin", "Stopping sshd"], 0x7011f148 /* 38 vars */) = 0
[pid 63901] brk(NULL)                   = 0x70018000
[pid 63901] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls/v9v2/v9v/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls/v9v2/v9v", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls/v9v2/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls/v9v2", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls/v9v/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls/v9v", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/tls", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/v9v2/v9v/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/v9v2/v9v", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/v9v2/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/v9v2", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/v9v/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/v9v", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63901] stat64("/lib/v9", 0xffa84c50) = -1 ENOENT (No such file or directory)
[pid 63901] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63901] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63901] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63901] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7a00000
[pid 63901] mprotect(0xf7a0c000, 57344, PROT_NONE) = 0
[pid 63901] mmap2(0xf7a1a000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf7a1a000
[pid 63901] close(3)                    = 0
[pid 63901] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63901] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63901] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63901] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79e8000
[pid 63901] mprotect(0xf79ec000, 57344, PROT_NONE) = 0
[pid 63901] mmap2(0xf79fa000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf79fa000
[pid 63901] close(3)                    = 0
[pid 63901] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63901] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63901] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63901] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7838000
[pid 63901] mprotect(0xf79d0000, 65536, PROT_NONE) = 0
[pid 63901] mmap2(0xf79e0000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf79e0000
[pid 63901] mmap2(0xf79e4000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf79e4000
[pid 63901] close(3)                    = 0
[pid 63901] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63901] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63901] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7824000
[pid 63901] close(3)                    = 0
[pid 63901] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63901] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63901] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63901] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf77e0000
[pid 63901] mprotect(0xf7810000, 65536, PROT_NONE) = 0
[pid 63901] mmap2(0xf7820000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf7820000
[pid 63901] close(3)                    = 0
[pid 63901] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7a4c000
[pid 63901] mprotect(0xf79e0000, 8192, PROT_READ) = 0
[pid 63901] mprotect(0xf7820000, 8192, PROT_READ) = 0
[pid 63901] mprotect(0xf79fa000, 8192, PROT_READ) = 0
[pid 63901] mprotect(0xf7a1a000, 8192, PROT_READ) = 0
[pid 63901] mprotect(0x70014000, 8192, PROT_READ) = 0
[pid 63901] mprotect(0xf7a50000, 8192, PROT_READ) = 0
[pid 63901] munmap(0xf7824000, 69720)   = 0
[pid 63901] brk(NULL)                   = 0x70018000
[pid 63901] brk(0x7003a000)             = 0x7003a000
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] stat64("/etc/terminfo", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63901] stat64("/usr/share/terminfo", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63901] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63901] access("/etc/terminfo/l/linux", R_OK) = 0
[pid 63901] openat(AT_FDCWD, "/etc/terminfo/l/linux", O_RDONLY|O_LARGEFILE) = 3
[pid 63901] fstat64(3, {st_mode=S_IFREG|0644, st_size=1730, ...}) = 0
[pid 63901] read(3, "\32\1\24\0\35\0\20\0}\1E\3linux|linux console\0"..., 4096) = 1730
[pid 63901] read(3, "", 4096)           = 0
[pid 63901] close(3)                    = 0
[pid 63901] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TIOCGWINSZ, 0xffa85414) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(0x5, 0x1), ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63901] write(1, " \33[1m\33[32m*\33[m\17 Stopping sshd\33[K"..., 37) = 37
[pid 63901] exit_group(0)               = ?
[pid 63901] +++ exited with 0 +++
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63901
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63882] stat64("/lib/rc/sbin/start-stop-daemon", 0xff891368) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/lib/rc/bin/start-stop-daemon", 0xff891368) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/bin/start-stop-daemon", 0xff891368) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/sbin/start-stop-daemon", {st_mode=S_IFREG|0755, st_size=43844, ...}) = 0
[pid 63882] stat64("/sbin/start-stop-daemon", {st_mode=S_IFREG|0755, st_size=43844, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/sbin/start-stop-daemon", X_OK) = 0
[pid 63882] stat64("/sbin/start-stop-daemon", {st_mode=S_IFREG|0755, st_size=43844, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/sbin/start-stop-daemon", R_OK) = 0
[pid 63882] stat64("/sbin/start-stop-daemon", {st_mode=S_IFREG|0755, st_size=43844, ...}) = 0
[pid 63882] stat64("/sbin/start-stop-daemon", {st_mode=S_IFREG|0755, st_size=43844, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/sbin/start-stop-daemon", X_OK) = 0
[pid 63882] stat64("/sbin/start-stop-daemon", {st_mode=S_IFREG|0755, st_size=43844, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/sbin/start-stop-daemon", R_OK) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63902 attached
, child_tidptr=0xf7fd0958) = 63902
[pid 63902] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63902] <... getpid resumed>)       = 63902
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63902] close(255 <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63902] <... close resumed>)        = 0
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63902] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63902] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63902] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63902] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63902] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63902] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63902] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63902] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63902] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63902] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63902] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63902] execve("/sbin/start-stop-daemon", ["start-stop-daemon", "--stop", "--exec", "/usr/sbin/sshd", "--pidfile", "/run/sshd.pid"], 0x7011f148 /* 38 vars */) = 0
[pid 63902] brk(NULL)                   = 0x7001c000
[pid 63902] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls/v9v2/v9v/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls/v9v2/v9v", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls/v9v2/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls/v9v2", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls/v9v/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls/v9v", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/tls", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/v9v2/v9v/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/v9v2/v9v", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/v9v2/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/v9v2", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/v9v/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/v9v", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] stat64("/lib/v9", 0xffdf6c00) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63902] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79a4000
[pid 63902] mprotect(0xf79b0000, 57344, PROT_NONE) = 0
[pid 63902] mmap2(0xf79be000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf79be000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63902] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf798c000
[pid 63902] mprotect(0xf7990000, 57344, PROT_NONE) = 0
[pid 63902] mmap2(0xf799e000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf799e000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/lib/libpam.so.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\31\200\0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=51316, ...}) = 0
[pid 63902] mmap2(NULL, 115664, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf796c000
[pid 63902] mprotect(0xf7978000, 57344, PROT_NONE) = 0
[pid 63902] mmap2(0xf7986000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf7986000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63902] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf77bc000
[pid 63902] mprotect(0xf7954000, 65536, PROT_NONE) = 0
[pid 63902] mmap2(0xf7964000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7964000
[pid 63902] mmap2(0xf7968000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7968000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63902] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf77a8000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63902] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7764000
[pid 63902] mprotect(0xf7794000, 65536, PROT_NONE) = 0
[pid 63902] mmap2(0xf77a4000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf77a4000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/lib/libdl.so.2", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\v \0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=17872, ...}) = 0
[pid 63902] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf79f0000
[pid 63902] mmap2(NULL, 82336, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf774c000
[pid 63902] mprotect(0xf7750000, 57344, PROT_NONE) = 0
[pid 63902] mmap2(0xf775e000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf775e000
[pid 63902] close(3)                    = 0
[pid 63902] mprotect(0xf7964000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0xf775e000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0xf77a4000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0xf7986000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0xf799e000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0xf79be000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0x70018000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0xf79f4000, 8192, PROT_READ) = 0
[pid 63902] munmap(0xf77a8000, 69720)   = 0
[pid 63902] rt_sigaction(SIGINT, {sa_handler=0x70004700, sa_mask=[], sa_flags=0}, NULL, 0xf77f0388, 8) = 0
[pid 63902] rt_sigaction(SIGQUIT, {sa_handler=0x70004700, sa_mask=[], sa_flags=0}, NULL, 0xf77f0388, 8) = 0
[pid 63902] rt_sigaction(SIGTERM, {sa_handler=0x70004700, sa_mask=[], sa_flags=0}, NULL, 0xf77f0388, 8) = 0
[pid 63902] getuid32()                  = 0
[pid 63902] brk(NULL)                   = 0x7001c000
[pid 63902] brk(0x7003e000)             = 0x7003e000
[pid 63902] socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
[pid 63902] connect(3, {sa_family=AF_UNIX, sun_path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
[pid 63902] close(3)                    = 0
[pid 63902] socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
[pid 63902] connect(3, {sa_family=AF_UNIX, sun_path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/etc/nsswitch.conf", O_RDONLY|O_CLOEXEC) = 3
[pid 63902] fstat64(3, {st_mode=S_IFREG|0644, st_size=332, ...}) = 0
[pid 63902] read(3, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 332
[pid 63902] read(3, "", 4096)           = 0
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63902] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf77a8000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/lib/libnss_db.so.2", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\21\340\0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=26248, ...}) = 0
[pid 63902] mmap2(NULL, 103336, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7730000
[pid 63902] mprotect(0xf7736000, 57344, PROT_NONE) = 0
[pid 63902] mmap2(0xf7744000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0xf7744000
[pid 63902] mmap2(0xf7748000, 5032, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7748000
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/lib/libnss_files.so.2", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63902] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\32 \0\0\0004"..., 512) = 512
[pid 63902] fstat64(3, {st_mode=S_IFREG|0755, st_size=42748, ...}) = 0
[pid 63902] mmap2(NULL, 132288, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf770c000
[pid 63902] mprotect(0xf7716000, 57344, PROT_NONE) = 0
[pid 63902] mmap2(0xf7724000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0xf7724000
[pid 63902] mmap2(0xf7728000, 17600, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7728000
[pid 63902] close(3)                    = 0
[pid 63902] mprotect(0xf7724000, 8192, PROT_READ) = 0
[pid 63902] mprotect(0xf7744000, 8192, PROT_READ) = 0
[pid 63902] munmap(0xf77a8000, 69720)   = 0
[pid 63902] openat(AT_FDCWD, "/var/db/passwd.db", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/etc/passwd", O_RDONLY|O_CLOEXEC) = 3
[pid 63902] _llseek(3, 0, [0], SEEK_CUR) = 0
[pid 63902] fstat64(3, {st_mode=S_IFREG|0644, st_size=2429, ...}) = 0
[pid 63902] read(3, "root:x:0:0:root:/root:/bin/bash\n"..., 4096) = 2429
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/run/sshd.pid", O_RDONLY) = 3
[pid 63902] fstat64(3, {st_mode=S_IFREG|0644, st_size=5, ...}) = 0
[pid 63902] read(3, "2639\n", 8192)     = 5
[pid 63902] close(3)                    = 0
[pid 63902] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63902] openat(AT_FDCWD, "/etc/localtime", O_RDONLY|O_CLOEXEC) = 3
[pid 63902] fstat64(3, {st_mode=S_IFREG|0644, st_size=2298, ...}) = 0
[pid 63902] fstat64(3, {st_mode=S_IFREG|0644, st_size=2298, ...}) = 0
[pid 63902] read(3, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0\0"..., 4096) = 2298
[pid 63902] _llseek(3, -1449, [849], SEEK_CUR) = 0
[pid 63902] read(3, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0\0"..., 4096) = 1449
[pid 63902] close(3)                    = 0
[pid 63902] socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC, 0) = 3
[pid 63902] connect(3, {sa_family=AF_UNIX, sun_path="/dev/log"}, 110) = -1 ECONNREFUSED (Connection refused)
[pid 63902] close(3)                    = 0
[pid 63902] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63902] socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC, 0) = 3
[pid 63902] connect(3, {sa_family=AF_UNIX, sun_path="/dev/log"}, 110) = -1 ECONNREFUSED (Connection refused)
[pid 63902] close(3)                    = 0
[pid 63902] openat(AT_FDCWD, "/proc", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = 3
[pid 63902] fstat64(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
[pid 63902] stat64("/proc/self/status", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] openat(AT_FDCWD, "/proc/self/status", O_RDONLY) = 4
[pid 63902] fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] read(4, "Name:\tstart-stop-daem\nUmask:\t002"..., 1024) = 1017
[pid 63902] read(4, "", 1024)           = 0
[pid 63902] close(4)                    = 0
[pid 63902] stat64("/proc/self/ns/pid", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] readlink("/proc/self/ns/pid", "pid:[4026531836]", 29) = 16
[pid 63902] getdents64(3, /* 585 entries */, 32768) = 15744
[pid 63902] stat64("/proc/2639/ns/pid", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] readlink("/proc/2639/ns/pid", "pid:[4026531836]", 29) = 16
[pid 63902] getdents64(3, /* 0 entries */, 32768) = 0
[pid 63902] close(3)                    = 0
[pid 63902] time(NULL)                  = 1585517169 (2020-03-29T23:26:09+0200)
[pid 63902] socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC, 0) = 3
[pid 63902] connect(3, {sa_family=AF_UNIX, sun_path="/dev/log"}, 110) = -1 ECONNREFUSED (Connection refused)
[pid 63902] close(3)                    = 0
[pid 63902] kill(2639, SIGTERM)         = 0
[pid 63902] openat(AT_FDCWD, "/proc", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = 3
[pid 63902] fstat64(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
[pid 63902] stat64("/proc/self/status", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] openat(AT_FDCWD, "/proc/self/status", O_RDONLY) = 4
[pid 63902] fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] read(4, "Name:\tstart-stop-daem\nUmask:\t002"..., 1024) = 1017
[pid 63902] read(4, "", 1024)           = 0
[pid 63902] close(4)                    = 0
[pid 63902] stat64("/proc/self/ns/pid", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] readlink("/proc/self/ns/pid", "pid:[4026531836]", 29) = 16
[pid 63902] getdents64(3, /* 585 entries */, 32768) = 15744
[pid 63902] stat64("/proc/2639/ns/pid", 0xffdf6328) = -1 ENOENT (No such file or directory)
[pid 63902] getdents64(3, /* 0 entries */, 32768) = 0
[pid 63902] close(3)                    = 0
[pid 63902] kill(2639, 0)               = -1 ESRCH (No such process)
[pid 63902] nanosleep({tv_sec=0, tv_nsec=20000000}, NULL) = 0
[pid 63902] openat(AT_FDCWD, "/proc", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = 3
[pid 63902] fstat64(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
[pid 63902] stat64("/proc/self/status", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] openat(AT_FDCWD, "/proc/self/status", O_RDONLY) = 4
[pid 63902] fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] read(4, "Name:\tstart-stop-daem\nUmask:\t002"..., 1024) = 1017
[pid 63902] read(4, "", 1024)           = 0
[pid 63902] close(4)                    = 0
[pid 63902] stat64("/proc/self/ns/pid", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63902] readlink("/proc/self/ns/pid", "pid:[4026531836]", 29) = 16
[pid 63902] getdents64(3, /* 584 entries */, 32768) = 15720
[pid 63902] getdents64(3, /* 0 entries */, 32768) = 0
[pid 63902] close(3)                    = 0
[pid 63902] stat64("/run/sshd.pid", 0xffdf7590) = -1 ENOENT (No such file or directory)
[pid 63902] openat(AT_FDCWD, "/run/openrc/daemons/sshd", O_RDONLY|O_NONBLOCK|O_NDELAY|O_LARGEFILE|O_CLOEXEC|O_DIRECTORY) = 3
[pid 63902] fstat64(3, {st_mode=S_IFDIR|0755, st_size=60, ...}) = 0
[pid 63902] getdents64(3, /* 3 entries */, 32768) = 72
[pid 63902] openat(AT_FDCWD, "/run/openrc/daemons/sshd/001", O_RDONLY) = 4
[pid 63902] fstat64(4, {st_mode=S_IFREG|0644, st_size=141, ...}) = 0
[pid 63902] read(4, "exec=/usr/sbin/sshd\nargv_0=/usr/"..., 8192) = 141
[pid 63902] close(4)                    = 0
[pid 63902] unlink("/run/openrc/daemons/sshd/001") = 0
[pid 63902] getdents64(3, /* 0 entries */, 32768) = 0
[pid 63902] close(3)                    = 0
[pid 63902] exit_group(0)               = ?
[pid 63902] +++ exited with 0 +++
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63902
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63882] stat64("/lib/rc/sbin/eend", 0xff8914c0) = -1 ENOENT (No such file or directory)
[pid 63882] stat64("/lib/rc/bin/eend", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] stat64("/lib/rc/bin/eend", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/eend", X_OK) = 0
[pid 63882] stat64("/lib/rc/bin/eend", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/eend", R_OK) = 0
[pid 63882] stat64("/lib/rc/bin/eend", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] stat64("/lib/rc/bin/eend", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/eend", X_OK) = 0
[pid 63882] stat64("/lib/rc/bin/eend", {st_mode=S_IFREG|0755, st_size=27276, ...}) = 0
[pid 63882] geteuid32()                 = 0
[pid 63882] getegid32()                 = 0
[pid 63882] getuid32()                  = 0
[pid 63882] getgid32()                  = 0
[pid 63882] access("/lib/rc/bin/eend", R_OK) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63903 attached
, child_tidptr=0xf7fd0958) = 63903
[pid 63903] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63903] <... getpid resumed>)       = 63903
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63903] close(255)                  = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63903] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63903] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63903] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63903] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63903] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63903] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63903] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63903] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1,  <unfinished ...>
[pid 63903] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63903] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63903] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63903] execve("/lib/rc/bin/eend", ["eend", "0", "Failed to stop sshd"], 0x7011f148 /* 38 vars */) = 0
[pid 63903] brk(NULL)                   = 0x70018000
[pid 63903] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls/v9v2/v9v/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls/v9v2/v9v", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls/v9v2/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls/v9v2", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls/v9v/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls/v9v", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/tls/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/tls", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/v9v2/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/v9v2/v9v/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/v9v2/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/v9v2/v9v", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/v9v2/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/v9v2/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/v9v2/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/v9v2", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/v9v/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/v9v/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/v9v/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/v9v", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/v9/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 63903] stat64("/lib/v9", 0xffbf6c40) = -1 ENOENT (No such file or directory)
[pid 63903] openat(AT_FDCWD, "/lib/librc.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63903] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34 \0\0\0004"..., 512) = 512
[pid 63903] fstat64(3, {st_mode=S_IFREG|0755, st_size=51536, ...}) = 0
[pid 63903] mmap2(NULL, 115968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79d8000
[pid 63903] mprotect(0xf79e4000, 57344, PROT_NONE) = 0
[pid 63903] mmap2(0xf79f2000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0xf79f2000
[pid 63903] close(3)                    = 0
[pid 63903] openat(AT_FDCWD, "/lib/libeinfo.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63903] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\r\0\0\0\0004"..., 512) = 512
[pid 63903] fstat64(3, {st_mode=S_IFREG|0755, st_size=18036, ...}) = 0
[pid 63903] mmap2(NULL, 85176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79c0000
[pid 63903] mprotect(0xf79c4000, 57344, PROT_NONE) = 0
[pid 63903] mmap2(0xf79d2000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf79d2000
[pid 63903] close(3)                    = 0
[pid 63903] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63903] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63903] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63903] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7810000
[pid 63903] mprotect(0xf79a8000, 65536, PROT_NONE) = 0
[pid 63903] mmap2(0xf79b8000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf79b8000
[pid 63903] mmap2(0xf79bc000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf79bc000
[pid 63903] close(3)                    = 0
[pid 63903] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63903] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63903] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf77fc000
[pid 63903] close(3)                    = 0
[pid 63903] openat(AT_FDCWD, "/lib/libtinfo.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63903] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\211@\0\0\0004"..., 512) = 512
[pid 63903] fstat64(3, {st_mode=S_IFREG|0755, st_size=209404, ...}) = 0
[pid 63903] mmap2(NULL, 275016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf77b8000
[pid 63903] mprotect(0xf77e8000, 65536, PROT_NONE) = 0
[pid 63903] mmap2(0xf77f8000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf77f8000
[pid 63903] close(3)                    = 0
[pid 63903] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7a24000
[pid 63903] mprotect(0xf79b8000, 8192, PROT_READ) = 0
[pid 63903] mprotect(0xf77f8000, 8192, PROT_READ) = 0
[pid 63903] mprotect(0xf79d2000, 8192, PROT_READ) = 0
[pid 63903] mprotect(0xf79f2000, 8192, PROT_READ) = 0
[pid 63903] mprotect(0x70014000, 8192, PROT_READ) = 0
[pid 63903] mprotect(0xf7a28000, 8192, PROT_READ) = 0
[pid 63903] munmap(0xf77fc000, 69720)   = 0
[pid 63903] brk(NULL)                   = 0x70018000
[pid 63903] brk(0x7003a000)             = 0x7003a000
[pid 63903] ioctl(1, TIOCGWINSZ, 0xffbf75e4) = 0
[pid 63903] fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(0x5, 0x1), ...}) = 0
[pid 63903] ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
[pid 63903] write(1, " [ ok ]\n", 8)    = 8
[pid 63903] exit_group(0)               = ?
[pid 63903] +++ exited with 0 +++
[pid 63882] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63903
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63904 attached
, child_tidptr=0xf7fd0958) = 63904
[pid 63904] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63904] <... getpid resumed>)       = 63904
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63904] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63904] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63904] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63904] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63904] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63904] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63904] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63904] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63904] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63904] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63904] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63904] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63904] dup2(4, 1)                  = 1
[pid 63904] close(4)                    = 0
[pid 63904] close(3)                    = 0
[pid 63904] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63904] stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid 63904] stat64("/lib/rc/sbin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/lib/rc/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/sbin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/sbin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/usr/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/usr/sbin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/usr/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/usr/sbin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/usr/local/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/usr/local/sbin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/opt/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] stat64("/var/qmail/bin/stop_post", 0xff891958) = -1 ENOENT (No such file or directory)
[pid 63904] exit_group(1)               = ?
[pid 63904] +++ exited with 1 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 63904
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63905 attached
, child_tidptr=0xf7fd0958) = 63905
[pid 63905] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63905] <... getpid resumed>)       = 63905
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63905] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63905] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63905] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63905] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63905] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63905] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63905] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63905] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63905] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63905] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63905] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63905] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63905] dup2(4, 1)                  = 1
[pid 63905] close(4)                    = 0
[pid 63905] close(3)                    = 0
[pid 63905] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63905] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63905] write(1, "cgroup_cleanup\n", 15) = 15
[pid 63882] <... read resumed>"cgroup_cleanup\n", 128) = 15
[pid 63882] read(3,  <unfinished ...>
[pid 63905] exit_group(0)               = ?
[pid 63905] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63905
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63906 attached
, child_tidptr=0xf7fd0958) = 63906
[pid 63906] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63906] <... getpid resumed>)       = 63906
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63906] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63906] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63906] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63906] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63906] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63906] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63906] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63906] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63906] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63906] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63906] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63906] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63906] dup2(4, 1)                  = 1
[pid 63906] close(4)                    = 0
[pid 63906] close(3)                    = 0
[pid 63906] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63906] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63906] write(1, "cgroup2_remove\n", 15) = 15
[pid 63882] <... read resumed>"cgroup2_remove\n", 128) = 15
[pid 63882] read(3,  <unfinished ...>
[pid 63906] exit_group(0)               = ?
[pid 63906] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63906
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] pipe([3, 4])                = 3
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63907 attached
, child_tidptr=0xf7fd0958) = 63907
[pid 63907] getpid( <unfinished ...>
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63907] <... getpid resumed>)       = 63907
[pid 63882] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART},  <unfinished ...>
[pid 63907] close(255 <unfinished ...>
[pid 63882] <... rt_sigaction resumed>{sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63907] <... close resumed>)        = 0
[pid 63882] close(4 <unfinished ...>
[pid 63907] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63882] <... close resumed>)        = 0
[pid 63907] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63882] read(3,  <unfinished ...>
[pid 63907] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigaction(SIGCHLD, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] dup2(4, 1)                  = 1
[pid 63907] close(4)                    = 0
[pid 63907] close(3)                    = 0
[pid 63907] rt_sigprocmask(SIG_BLOCK, NULL, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63907] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63907] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63907] geteuid32()                 = 0
[pid 63907] getegid32()                 = 0
[pid 63907] getuid32()                  = 0
[pid 63907] getgid32()                  = 0
[pid 63907] access("/bin/grep", X_OK)   = 0
[pid 63907] stat64("/bin/grep", {st_mode=S_IFREG|0755, st_size=199420, ...}) = 0
[pid 63907] geteuid32()                 = 0
[pid 63907] getegid32()                 = 0
[pid 63907] getuid32()                  = 0
[pid 63907] getgid32()                  = 0
[pid 63907] access("/bin/grep", R_OK)   = 0
[pid 63907] rt_sigprocmask(SIG_BLOCK, [INT CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63907] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 63908 attached
, child_tidptr=0xf7fd0958) = 63908
[pid 63908] getpid( <unfinished ...>
[pid 63907] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63908] <... getpid resumed>)       = 63908
[pid 63907] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63908] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63908] rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63907] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63908] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63908] rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63907] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32],  <unfinished ...>
[pid 63908] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid 63908] rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63907] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 63908] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] <... rt_sigprocmask resumed>[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63908] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63907] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63908] <... rt_sigaction resumed>{sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] <... rt_sigaction resumed>{sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63908] rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0},  <unfinished ...>
[pid 63907] waitpid(-1,  <unfinished ...>
[pid 63908] <... rt_sigaction resumed>{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63908] rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x7003ee00, sa_mask=[], sa_flags=SA_RESTART}, 0xf7dc0388, 8) = 0
[pid 63908] execve("/bin/grep", ["grep", "-qw", "cgroup2", "/proc/filesystems"], 0x7011f148 /* 38 vars */) = 0
[pid 63908] brk(NULL)                   = 0x70046000
[pid 63908] access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
[pid 63908] openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63908] fstat64(3, {st_mode=S_IFREG|0644, st_size=69720, ...}) = 0
[pid 63908] mmap2(NULL, 69720, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7b88000
[pid 63908] close(3)                    = 0
[pid 63908] openat(AT_FDCWD, "/lib/libpcre.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63908] read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\20\0\0\0\0004"..., 512) = 512
[pid 63908] fstat64(3, {st_mode=S_IFREG|0755, st_size=452224, ...}) = 0
[pid 63908] mmap2(NULL, 516680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7b08000
[pid 63908] mprotect(0xf7b76000, 57344, PROT_NONE) = 0
[pid 63908] mmap2(0xf7b84000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6c000) = 0xf7b84000
[pid 63908] close(3)                    = 0
[pid 63908] openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63908] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\305\240\0\0\0004"..., 512) = 512
[pid 63908] fstat64(3, {st_mode=S_IFREG|0755, st_size=1690460, ...}) = 0
[pid 63908] mmap2(NULL, 1759640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7958000
[pid 63908] mprotect(0xf7af0000, 65536, PROT_NONE) = 0
[pid 63908] mmap2(0xf7b00000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x198000) = 0xf7b00000
[pid 63908] mmap2(0xf7b04000, 6552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7b04000
[pid 63908] close(3)                    = 0
[pid 63908] openat(AT_FDCWD, "/lib/libpthread.so.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63908] read(3, "\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0W\200\0\0\0004"..., 512) = 512
[pid 63908] fstat64(3, {st_mode=S_IFREG|0755, st_size=144720, ...}) = 0
[pid 63908] mmap2(NULL, 189896, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7928000
[pid 63908] mprotect(0xf7944000, 57344, PROT_NONE) = 0
[pid 63908] mmap2(0xf7952000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0xf7952000
[pid 63908] mmap2(0xf7956000, 1480, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7956000
[pid 63908] close(3)                    = 0
[pid 63908] mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7bc8000
[pid 63908] mprotect(0xf7b00000, 8192, PROT_READ) = 0
[pid 63908] mprotect(0xf7952000, 8192, PROT_READ) = 0
[pid 63908] mprotect(0xf7b84000, 8192, PROT_READ) = 0
[pid 63908] mprotect(0x7003e000, 8192, PROT_READ) = 0
[pid 63908] mprotect(0xf7bcc000, 8192, PROT_READ) = 0
[pid 63908] munmap(0xf7b88000, 69720)   = 0
[pid 63908] set_tid_address(0xf7bc8958) = 63908
[pid 63908] set_robust_list(0xf7bc8960, 12) = 0
[pid 63908] rt_sigaction(SIGRTMIN, {sa_handler=0xf792cf40, sa_mask=[], sa_flags=SA_SIGINFO}, NULL, 0xf793f358, 8) = 0
[pid 63908] rt_sigaction(SIGRT_1, {sa_handler=0xf792d020, sa_mask=[], sa_flags=SA_RESTART|SA_SIGINFO}, NULL, 0xf793f358, 8) = 0
[pid 63908] rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
[pid 63908] getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=2147483647}) = 0
[pid 63908] brk(NULL)                   = 0x70046000
[pid 63908] brk(0x70068000)             = 0x70068000
[pid 63908] openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
[pid 63908] fstat64(3, {st_mode=S_IFREG|0644, st_size=4869456, ...}) = 0
[pid 63908] mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7728000
[pid 63908] mmap2(NULL, 2596864, PROT_READ, MAP_PRIVATE, 3, 0x1de000) = 0xf74ae000
[pid 63908] close(3)                    = 0
[pid 63908] openat(AT_FDCWD, "/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
[pid 63908] fstat64(3, {st_mode=S_IFREG|0644, st_size=26386, ...}) = 0
[pid 63908] mmap2(NULL, 26386, PROT_READ, MAP_SHARED, 3, 0) = 0xf7bc0000
[pid 63908] close(3)                    = 0
[pid 63908] futex(0xf7b034c4, FUTEX_WAKE_PRIVATE, 2147483647) = 0
[pid 63908] sigaltstack({ss_sp=0x70040858, ss_flags=0, ss_size=16384}, NULL) = 0
[pid 63908] rt_sigaction(SIGSEGV, {sa_handler=0x7000c1e0, sa_mask=[], sa_flags=SA_ONSTACK|SA_NODEFER|SA_RESETHAND|SA_SIGINFO}, NULL, 0xf798c378, 8) = 0
[pid 63908] openat(AT_FDCWD, "/proc/filesystems", O_RDONLY|O_NOCTTY|O_LARGEFILE) = 3
[pid 63908] fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid 63908] read(3, "nodev\tsysfs\nnodev\ttmpfs\nnodev\tbd"..., 98304) = 241
[pid 63908] brk(0x7008a000)             = 0x7008a000
[pid 63908] close(1)                    = 0
[pid 63908] close(2)                    = 0
[pid 63908] exit_group(0)               = ?
[pid 63908] +++ exited with 0 +++
[pid 63907] <... waitpid resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63908
[pid 63907] rt_sigaction(SIGINT, {sa_handler=0x7005d7a0, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63907] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63907] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=63908, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
[pid 63907] waitpid(-1, 0xff8902b4, WNOHANG) = -1 ECHILD (No child processes)
[pid 63907] sigreturn({mask=[TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32]}) = 0
[pid 63907] fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 63907] write(1, "/sys/fs/cgroup/unified", 22) = 22
[pid 63882] <... read resumed>"/sys/fs/cgroup/unified", 128) = 22
[pid 63882] read(3,  <unfinished ...>
[pid 63907] exit_group(0)               = ?
[pid 63907] +++ exited with 0 +++
[pid 63882] <... read resumed>"", 128)  = 0
[pid 63882] close(3)                    = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigaction(SIGINT, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 63907
[pid 63882] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x7003a920, sa_mask=[], sa_flags=0}, 0xf7dc0388, 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] stat64("/sys/fs/cgroup/unified/sshd", 0xff891368) = -1 ENOENT (No such file or directory)
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] read(255, "\nexit 0\n", 8192) = 8
[pid 63882] rt_sigprocmask(SIG_BLOCK, [CHLD], [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], 8) = 0
[pid 63882] rt_sigprocmask(SIG_SETMASK, [TRAP ABRT FPE SEGV PIPE ALRM TERM TSTP CHLD XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2 RT_3 RT_4 RT_5 RT_7 RT_8 RT_9 RT_11 RT_13 RT_14 RT_15 RT_18 RT_20 RT_24 RT_25 RT_26 RT_27 RT_28 RT_29 RT_30 RT_31 RT_32], NULL, 8) = 0
[pid 63882] exit_group(0)               = ?
[pid 63882] +++ exited with 0 +++


--nextPart2387461.dWpZuIcutC--

--nextPart2420172.Oy1am9670f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCXoGwpgAKCRBcpIk+abn8
TnVnAJwPcufBvzCzxh/zOtajFplyrjrWCgCfcgM36MSRL3v28f2Je0MPa9mE7P4=
=cfXo
-----END PGP SIGNATURE-----

--nextPart2420172.Oy1am9670f--
