From: Christoph Hellwig <hch@lst.de>
Date: Sat, 28 Feb 2009 21:22:35 +0000
Subject: [PATCH] jsflash: stop defining MAJOR_NR
Message-Id: <20090228212235.GA24377@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ever since early 2.5 kernels block drivers don't need to define MAJOR_NR
anymore, so use the JSFD_MAJOR defined directly and kill it.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/sbus/char/jsflash.c
=================================--- linux-2.6.orig/drivers/sbus/char/jsflash.c	2009-02-27 17:41:59.547168644 +0100
+++ linux-2.6/drivers/sbus/char/jsflash.c	2009-02-27 17:42:05.545295810 +0100
@@ -38,9 +38,6 @@
 #include <linux/string.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
-
-#define MAJOR_NR	JSFD_MAJOR
-
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
