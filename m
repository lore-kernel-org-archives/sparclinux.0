From: Meelis Roos <mroos@linux.ee>
Date: Fri, 11 Feb 2005 10:36:48 +0000
Subject: 2.4 too - was  [2.6 PATCH] syntax errors by smp_{mb,rmb,wmb} on
Message-Id: <Pine.SOC.4.61.0502111234140.26741@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Hi Melis,
> the same holds true for 2.4.29 @ line 124, 125, 126 in the system.h file. This ought to be the same problem, isn't it? I do not have a sparc32 system, but maybe you can check,

Yes, the same compilation problem is also present in current 2.4. Patch 
is below, output from bk diffs -u and read into pine with ^R - does it 
work this time?

=== include/asm-sparc/system.h 1.8 vs edited ==--- 1.8/include/asm-sparc/system.h	2003-12-14 07:50:29 +02:00
+++ edited/include/asm-sparc/system.h	2005-02-11 10:52:00 +02:00
@@ -295,11 +295,11 @@
  #define wmb()	mb()
  #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
  #define set_wmb(__var, __value) set_mb(__var, __value)
-#define smp_mb()	__asm__ __volatile__("":::"memory");
-#define smp_rmb()	__asm__ __volatile__("":::"memory");
-#define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_mb()	__asm__ __volatile__("":::"memory")
+#define smp_rmb()	__asm__ __volatile__("":::"memory")
+#define smp_wmb()	__asm__ __volatile__("":::"memory")

-#define nop() __asm__ __volatile__ ("nop");
+#define nop() __asm__ __volatile__ ("nop")

  /* This has special calling conventions */
  #ifndef CONFIG_SMP

-- 
Meelis Roos (mroos@linux.ee)
