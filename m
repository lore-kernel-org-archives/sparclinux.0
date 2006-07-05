From: Matt Foster <matt@mattfoster.me.uk>
Date: Wed, 05 Jul 2006 21:16:42 +0000
Subject: Hypersparc 2.6 SMP success
Message-Id: <Pine.LNX.4.61.0607052155590.1251@molnir.our.house>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Using Bob's patch against 2.6.17-rc5 my dual SS20 is up and running.
Several niggles so far:

1: With Bob's binary kernel image, module loading would always cause a
watchdog reset, so I've rebuilt a non modular kernel which seems to be
running OK using 2.6.17-rc5 plus Bobs patch.

2: Having tmpfs turned on seems to do bad things with spamassassin (the
SS20 is an inbound mail gateway). Every time spamassassin started it
would through an ext2 error along the lines of:
EXT2-fs error (device sdb4): ext2_check_page: bad entry in directory
#155601: rec_len is smaller than (sorry console buffer wraps at 80 cols)
and / would remount ro. Having disabled tmpfs in the startup scripts
this problem has gone away now.

3: I tried 2.6.17-git21 which builds, but always hangs after the booting
linux message. This happens with gcc-3.4 and gcc-3.3 (Debian sarge
package versions).

Anyway, great work Bob, keep it up.

The kernel I'm currently running is available at
http://mattfoster.me.uk/sparc if anyone wants to test, but due to the
boot size limitations it is stripped back to have only the bare things
needed to get an SS20 on the network (esp only SCSI driver, ext2 & ext3
only filesystems, sun lance only NIC driver, no iptables......)

Thanks,

Matt Foster
