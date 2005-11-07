From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 04:05:20 +0000
Subject: [PATCH] remove alloc_user_space()
Message-Id: <20051107040520.GA16485@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

this inline routine in arch/sparc64/kernel/ioctl32.c is completely
unused and superceeded by compat_alloc_user_space()


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:21:59.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:22:01.000000000 +0100
@@ -27,17 +27,6 @@
  */
 #define A(__x) compat_ptr(__x)
 
-static __inline__ void *alloc_user_space(long len)
-{
-	struct pt_regs *regs = current_thread_info()->kregs;
-	unsigned long usp = regs->u_regs[UREG_I6];
-
-	if (!(test_thread_flag(TIF_32BIT)))
-		usp += STACK_BIAS;
-
-	return (void *) (usp - len);
-}
-
 #define CODE
 #include "compat_ioctl.c"
 
