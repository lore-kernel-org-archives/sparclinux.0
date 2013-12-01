From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 01 Dec 2013 19:02:20 +0000
Subject: SPARC: 3.13-rc1 and newer: kernel size issue with tftpboot.img
Message-Id: <20131201190220.GC30823@blackmetal.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Sun Ultra 5/10 (OpenBoot 3.25) seems to have 10 MB limitation for the
tftpboot.img. With larger images "boot net" will fail with "Fast Data
Access MMU Miss":

	Rebooting with command: boot net
	Boot device: /pci@1f,0/pci@1,1/network@1,1  File and args:
	a00000 Fast Data Access MMU Miss
	ok

tftpboot.img size seem to be roughly uncompressed kernel text/data +
bss + compressed initramfs. Until 3.13-rc1 the 10 MB size limitation
has not been an issue. With 3.12, normal kernel + GLIBC + busybox +
other tools will result in a 7 MB image. However, 3.13-rc1 introduced
a huge increase in bss size:

	   text    data     bss     dec     hex filename
	4214999  341664  320496 4877159  4a6b67 vmlinux-3.12
	4242584  350216 4588328 9181128  8c17c8 vmlinux-3.13-rc1

As a result in will be practically impossible to create an useful/working
tftpboot.img fitting into 10 MB.

The bloat seems to be coming from arch/sparc/mm/init_64.c:

	   text    data     bss     dec     hex filename
	  10147   13536 4335264 4358947  428323 arch/sparc/mm/init_64.o

The cause is MAX_PHYS_ADDRESS_BITS changing from 41 to 47. Would it be
possible to make this configurable for legacy SPARCs? Manually patching
this value back to 41 seems to at least produce a bootable image (no
further testing done).

A.
