From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 19:30:20 +0000
Subject: Re: [PATCH] remove kbio.h
Message-Id: <20051107193020.GA31886@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107040657.GC16485@lst.de>
In-Reply-To: <20051107040657.GC16485@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 07, 2005 at 10:44:19AM -0800, David S. Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 7 Nov 2005 05:06:57 +0100
> 
> > The old keyboard driver is gone in 2.6, so the only user left are the
> > compat ioctls.
> 
> Applied, thanks.
> 
> There are some references in include/asm-m68k/kbio.h and
> via Documentation/ioctl-number.txt, you might want to kill
> those off too :-)

And references in the sunos_ioctl.c files that I missed, so this patch
broke compiling with those enabled.  Would you mind applying the
following patch that kills those two + the m68k and Documentation/
references?


Index: linux-2.6/Documentation/ioctl-number.txt
=================================--- linux-2.6.orig/Documentation/ioctl-number.txt	2005-10-31 12:23:01.000000000 +0100
+++ linux-2.6/Documentation/ioctl-number.txt	2005-11-07 11:43:50.000000000 +0100
@@ -130,8 +130,6 @@
 					<mailto:zapman@interlan.net>
 'i'	00-3F	linux/i2o.h
 'j'	00-3F	linux/joystick.h
-'k'	all	asm-sparc/kbio.h
-		asm-sparc64/kbio.h
 'l'	00-3F	linux/tcfs_fs.h		transparent cryptographic file system
 					<http://mikonos.dia.unisa.it/tcfs>
 'l'	40-7F	linux/udf_fs_i.h	in development:
Index: linux-2.6/arch/sparc/kernel/sunos_ioctl.c
=================================--- linux-2.6.orig/arch/sparc/kernel/sunos_ioctl.c	2005-10-31 12:23:19.000000000 +0100
+++ linux-2.6/arch/sparc/kernel/sunos_ioctl.c	2005-11-07 11:48:09.000000000 +0100
@@ -23,7 +23,6 @@
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <linux/file.h>
-#include <asm/kbio.h>
 
 #if 0
 extern char sunkbd_type;
Index: linux-2.6/arch/sparc64/kernel/sunos_ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/sunos_ioctl32.c	2005-10-31 12:23:19.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/sunos_ioctl32.c	2005-11-07 11:48:20.000000000 +0100
@@ -24,7 +24,6 @@
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <linux/compat.h>
-#include <asm/kbio.h>
 
 #define SUNOS_NR_OPEN	256
 
Index: linux-2.6/include/asm-m68k/kbio.h
=================================--- linux-2.6.orig/include/asm-m68k/kbio.h	2005-10-31 12:24:06.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1 +0,0 @@
-#include <asm-sparc/kbio.h>
