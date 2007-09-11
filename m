From: =?ISO-8859-1?Q?Iv=E1n_Chavero?= <ichavero@uach.mx>
Date: Tue, 11 Sep 2007 20:23:58 +0000
Subject: SILO problem on a T1000
Message-Id: <46E6F95E.9080204@uach.mx>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello, I have a problem with SILO. I've successfully installed gentoo 
2007.0 on my T1000, i run silo and it does not return any error.


But when i try to boot i get this error:

boot disk


  .... Big Fat Output ....


Sun Fire(TM) T1000, No Keyboard
Copyright 2006 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.23.4, 8184 MB memory available, Serial #75689954.
Ethernet address 0:14:4f:82:ef:e2, Host ID: 8482efe2.



Rebooting with command: boot disk
Boot device: /pci@7c0/pci@0/pci@8/scsi@2/disk@0,0  File and args:
The file just loaded does not appear to be executable.

the same is with boot disk:c, and boot disk:a

I have run SILO with multiple switch combinations, this are the latest i ran

netboot-20070724 / # silo -u -f
/etc/silo.conf appears to be valid
netboot-20070724 / # silo -u -f -t
/etc/silo.conf appears to be valid


my silo.conf:


partition = 1
timeout = 10
image = /boot/kernel-2.6.22-gentoo-r5-vegito
         label = gentoo-linux
         root = /dev/sda1




my partition table is like this:

fdisk -l

Disk /dev/sda (Sun disk label): 24 heads, 424 sectors, 14087 cylinders
Units = cylinders of 10176 * 512 bytes

    Device Flag    Start       End    Blocks   Id  System
/dev/sda1             1      1919   9758784   83  Linux native
/dev/sda2  u       1919      2617   3551424   82  Linux swap
/dev/sda3             0     14087  71674656    5  Whole disk
/dev/sda4          2617     14087  58359360   83  Linux native



i had /dev/sda1 starting on cylinder 0 and got the same behaviour so i 
think that i'm doing something wrong with SILO or the ultra.b file does 
not work well with OpenBoot 4.23.4

I'm lost here i've done all can think of doing and read and reread the 
http://www.sparc-boot.org, http://www.ultralinux.org, gentoo docs and 
older posts to this list and nothing. I could really use some help.

Thanks in advance.


