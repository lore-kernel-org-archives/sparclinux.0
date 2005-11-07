From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 04:08:29 +0000
Subject: [PATCH] remove duplicated compat ioctl entries
Message-Id: <20051107040829.GE16485@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

all these are handled by fs/compat_ioctls.c already.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:22:14.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:22:18.000000000 +0100
@@ -503,11 +503,7 @@
 COMPATIBLE_IOCTL(OPROMSETCUR)
 COMPATIBLE_IOCTL(OPROMPCI2NODE)
 COMPATIBLE_IOCTL(OPROMPATH2NODE)
-/* Big L */
-COMPATIBLE_IOCTL(LOOP_SET_STATUS64)
-COMPATIBLE_IOCTL(LOOP_GET_STATUS64)
 /* Big A */
-COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
 #if defined(CONFIG_DRM) || defined(CONFIG_DRM_MODULE)
 COMPATIBLE_IOCTL(DRM_IOCTL_GET_MAGIC)
 COMPATIBLE_IOCTL(DRM_IOCTL_IRQ_BUSID)
