From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 21 Apr 2006 04:30:59 +0000
Subject: [PATCH]: Fix Ultra10 SILO timer
Message-Id: <20060420.213059.126448042.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Ok, this should fix the Ultra10 problem and keep Niagara
working at the same time.  I tested this successfully on my
T2 box.

--- second/timer.c.~1~	2006-04-20 21:18:49.000000000 -0700
+++ second/timer.c	2006-04-20 21:21:19.000000000 -0700
@@ -40,6 +40,8 @@
 static volatile struct sun4c_timer_info *sun4c_timer;
 static unsigned char *addr_to_free = 0;
 static int len_to_free;
+static unsigned long long sun4u_tickcmpr;
+static int sun4u_notimer = 0;
 static struct mostek48t02 *mregs;
 static long clock_frequency;
 
@@ -154,6 +156,16 @@
     }
     if (!foundcpu || !clock_frequency)
         clock_frequency = prom_getint(prom_root_node, "clock-frequency") / 100;
+    if (notimer) {
+        sun4u_notimer = 1;
+        __asm__ __volatile__ ("\t"
+        	"rd	%%tick_cmpr, %%g1\n\t"
+        	"stx	%%g1, [%0]\n\t"
+        	"mov	1, %%g1\n\t"
+        	"sllx    %%g1, 63, %%g1\n\t"
+        	"wr      %%g1, 0, %%tick_cmpr"
+        	: : "r" (&sun4u_tickcmpr) : "g1");
+    }
     return 0;
 }
 
@@ -194,6 +206,12 @@
 
 void close_timer ()
 {
+    if (sun4u_notimer) {
+        __asm__ __volatile__("\t"
+        	"ldx	[%0], %%g1\n\t"
+        	"wr	%%g1, 0, %%tick_cmpr"
+        	: : "r" (&sun4u_tickcmpr) : "g1");
+    }
     if (addr_to_free) {
         if (addr_to_free = (unsigned char *)0xffffffff)
             sun4c_unmapio (TICKER_VIRTUAL);
