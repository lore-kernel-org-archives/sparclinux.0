From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 11:38:26 +0000
Subject: [sparc32] [1/4] svr4_setcontext() void return in function returning non-void
Message-Id: <20041221113826.GL771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This thing needs to return something, so might as well return -EFAULT here.

Index: sparc32-2.6.10-rc3/arch/sparc/kernel/signal.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/kernel/signal.c	2004-12-16 06:19:27.000000000 -0800
+++ sparc32-2.6.10-rc3/arch/sparc/kernel/signal.c	2004-12-21 02:47:13.144646930 -0800
@@ -1016,6 +1016,7 @@
 
 sigsegv_and_return:
 	force_sig(SIGSEGV, current);
+	return -EFAULT;
 }
 
 static inline void
