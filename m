From: Meelis Roos <mroos@linux.ee>
Date: Thu, 10 Feb 2005 07:19:28 +0000
Subject: [2.6 PATCH] syntax errors by smp_{mb,rmb,wmb} on sparc32
Message-Id: <Pine.SOC.4.61.0502092331420.4099@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

smp_mb(), smp_rmp() and smp_wmb() definitions have a trailing semicolon 
and cause compilation errors in single statement context, like 
if-then-else on line 358 in include/linux/skbuff.h. This patch removes 
all three offending semicolons to make it compile.

Signed-off-by: Meelis Roos <mroos@linux.ee>


=== include/asm/system.h 1.21 vs edited ==--- 1.21/include/asm-sparc/system.h	2004-07-05 13:33:38 +03:00
+++ edited/include/asm/system.h	2005-02-09 23:22:39 +02:00
@@ -195,9 +195,9 @@
  #define read_barrier_depends()	do { } while(0)
  #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
  #define set_wmb(__var, __value) set_mb(__var, __value)
-#define smp_mb()	__asm__ __volatile__("":::"memory");
-#define smp_rmb()	__asm__ __volatile__("":::"memory");
-#define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_mb()	__asm__ __volatile__("":::"memory")
+#define smp_rmb()	__asm__ __volatile__("":::"memory")
+#define smp_wmb()	__asm__ __volatile__("":::"memory")
  #define smp_read_barrier_depends()	do { } while(0)

  #define nop() __asm__ __volatile__ ("nop");


-- 
Meelis Roos (mroos@linux.ee)
