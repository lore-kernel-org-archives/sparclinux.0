From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 10 Feb 2005 19:42:16 +0000
Subject: Re: [2.6 PATCH] syntax errors by smp_{mb,rmb,wmb} on sparc32
Message-Id: <20050210194216.GH13009@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502092331420.4099@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502092331420.4099@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 10 Feb 2005 09:19:28 +0200 (EET) Meelis Roos <mroos@linux.ee> wrote:
>>> smp_mb(), smp_rmp() and smp_wmb() definitions have a trailing semicolon 
>>> and cause compilation errors in single statement context, like 
>>> if-then-else on line 358 in include/linux/skbuff.h. This patch removes 
>>> all three offending semicolons to make it compile.
>>> Signed-off-by: Meelis Roos <mroos@linux.ee>

On Thu, Feb 10, 2005 at 12:23:41AM -0800, David S. Miller wrote:
>> Sorry, I should have checked this out when I fixed the same exact
> bug on sparc64.
>> I'll apply and push upstream, thanks.

On Thu, Feb 10, 2005 at 01:41:10AM -0800, William Lee Irwin III wrote:
> Sorry I didn't get around to this. Thanks for taking care of it.

I regenerated the diff by hand because it didn't apply to bk for some
reason, maybe mangled whitespace.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli

smp_mb(), smp_rmp() and smp_wmb() definitions have a trailing semicolon 
and cause compilation errors in single statement context, like 
if-then-else on line 358 in include/linux/skbuff.h. This patch removes 
all three offending semicolons to make it compile.

Signed-off-by: Meelis Roos <mroos@linux.ee>
=== include/asm-sparc/system.h 1.21 vs edited ==--- 1.21/include/asm-sparc/system.h	Mon Jul  5 03:33:38 2004
+++ edited/include/asm-sparc/system.h	Thu Feb 10 11:39:07 2005
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
