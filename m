From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 12 Mar 2004 06:03:50 +0000
Subject: NR_SYSCALLS vs. io_getevents()
Message-Id: <20040312060350.GE655@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sure enough, io_getevents() is getting back -ENOSYS when it shouldn't.
At first glance it looks like a one-off in entry.S; Maybe this helps:


-- wli


--- mm1-2.6.4-3/arch/sparc64/kernel/entry.S	2004-03-10 18:55:20.000000000 -0800
+++ mm1-2.6.4-4/arch/sparc64/kernel/entry.S	2004-03-11 22:00:49.608397000 -0800
@@ -26,7 +26,7 @@
 
 #define curptr      g6
 
-#define NR_SYSCALLS 272      /* Each OS is different... */
+#define NR_SYSCALLS 273      /* Each OS is different... */
 
 	.text
 	.align		32

