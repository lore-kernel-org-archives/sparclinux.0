From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 18 Mar 2004 14:22:25 +0000
Subject: fix ENOSYS from io_getevents()/NR_SYSCALLS
Message-Id: <20040318142225.GA2045@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

NR_SYSCALLS appears to be off by one, and so aio tests/etc. are failing
with -ENOSYS. __NR_io_getevents is 272, so the bgeu,pn NR_SYSCALLS etc.
checks mistakenly punt io_getevents() off to linux_sparc_ni_syscall().
The following patch gets the aio tests running.


-- wli


--- mm1-2.6.4-3/arch/sparc64/kernel/entry.S	2004-03-10 18:55:20.000000000 -0800
+++ mm1-2.6.4-4/arch/sparc64/kernel/entry.S	2004-03-11 22:00:49.608397000 -0800
@@ -26,7 +26,7 @@
 
 #define curptr      g6
 
-#define NR_SYSCALLS 272      /* Each OS is different... */
+#define NR_SYSCALLS 273      /* Each OS is different... */
 
 	.text
 	.align		32

