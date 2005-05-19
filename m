From: Bob Breuer <breuerr@mc.net>
Date: Thu, 19 May 2005 15:24:05 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6
Message-Id: <428CAF95.4000802@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jurij Smakov wrote:
> Hi again,
> 
> I have now tried the pristine 2.6.11.10 kernel and it fails on mounting 
> initrd too on my Hypersparc-powered SS10. The last messages (same as 
> with Debian kernels) I see are:
> 
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> RAMDISK: cramfs filesystem found at block 0
             ^^^^
I don't think my initrds have been of the cramfs type.

> RAMDISK: Loading 2556KiB [1 disk] into ram disk... done.
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(0,0)
>  <0>Press L1-A to return to the boot prom
> 
> It would be nice if you (or someone else) could confirm (or not :-) 
> that, since it would eliminate possible initrd/toolchain problems.
> 
> http://www.wooyd.org/misc/sparc32.config

With that config, I can't boot the resulting image because it's too 
large for the silo that I'm using.

[root@sparky linux-2.6.11.10]# ls -l arch/sparc/boot/image
-rwxr-xr-x  1 root root 2921764 May 19 04:34 arch/sparc/boot/image
Built with: gcc version 3.3.4 20040623 (Red Hat 3.3.4-2)

Here's the similar output from the latest Aurora kernel:

Linux version 2.6.11-1.1166sp1 (root@arthur.devel.redhat.com) (gcc 
version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Fri Mar 4 21:55:08 EST 2005
...
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 156k freed
Red Hat nash version 4.1.18 starting
Mounted /proc filesystem
...

No explicit mention of a ramdisk, but nash is the shell used with the 
initrd.

Some more details about that kernel and it's initrd:

[root@sparky boot]# ls -l *1166*
-rw-r--r--  1 root root   25816 Mar  4 21:07 config-2.6.11-1.1166sp1
-rw-r--r--  1 root root  753917 Mar  7 10:09 initrd-2.6.11-1.1166sp1.img
-rw-r--r--  1 root root  453452 Mar  4 21:07 System.map-2.6.11-1.1166sp1
-rwxr-xr-x  1 root root 2471360 Mar  4 21:31 vmlinuz-2.6.11-1.1166sp1
[root@sparky boot]# file vmlinuz-2.6.11-1.1166sp1 

vmlinuz-2.6.11-1.1166sp1: ELF 32-bit MSB executable, SPARC, version 1
(SYSV), statically linked, stripped
[root@sparky boot]# file initrd-2.6.11-1.1166sp1.img
initrd-2.6.11-1.1166sp1.img: gzip compressed data, from Unix, max 
compression
[root@sparky boot]# zcat initrd-2.6.11-1.1166sp1.img >/tmp/initrd
[root@sparky boot]# file /tmp/initrd
/tmp/initrd: ASCII cpio archive (SVR4 with no CRC)

Looks like my initrd is a cpio archive instead of cramfs.

And here's the versions of my mkinitrd and silo:
   mkinitrd-4.1.18-2
   silo-1.4.8-1

Bob
