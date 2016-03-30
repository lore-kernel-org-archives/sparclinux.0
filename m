From: David Miller <davem@davemloft.net>
Date: Wed, 30 Mar 2016 01:55:30 +0000
Subject: [PATCH] silo: Fix signed overflow issues with 'clock-frequency'.
Message-Id: <20160329.215530.2250921348428748122.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Process it as an unsigned quantity so that all 32-bit values
work properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 second/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/second/timer.c b/second/timer.c
index 7f03996..da3f92e 100644
--- a/second/timer.c
+++ b/second/timer.c
@@ -43,7 +43,7 @@ static int len_to_free;
 static unsigned long long sun4u_tickcmpr;
 static int sun4u_notimer = 0;
 static struct mostek48t02 *mregs;
-static long clock_frequency;
+static unsigned long clock_frequency;
 
 #define TICKER_VIRTUAL 		0xfc000000
 #define SUN4C_TIMER_PHYSADDR	0xf3000000
@@ -145,7 +145,8 @@ static inline int sun4u_init_timer ()
     	    prom_getstring(node, "device_type", node_str, sizeof(node_str));
             if (!strcmp(node_str, "cpu")) {
                 foundcpu = 1;
-                clock_frequency = prom_getintdefault(node, "clock-frequency", 0) / 100;
+                clock_frequency = prom_getintdefault(node, "clock-frequency", 0);
+                clock_frequency /= 100;
             }
         }
         if (notimer) {
@@ -154,8 +155,10 @@ static inline int sun4u_init_timer ()
                 notimer = 0;
         }
     }
-    if (!foundcpu || !clock_frequency)
-        clock_frequency = prom_getint(prom_root_node, "clock-frequency") / 100;
+    if (!foundcpu || !clock_frequency) {
+        clock_frequency = prom_getint(prom_root_node, "clock-frequency");
+        clock_frequency /= 100;
+    }
     if (notimer && !sun4v_cpu) {
         sun4u_notimer = 1;
         __asm__ __volatile__ ("\t"
-- 
2.1.0

