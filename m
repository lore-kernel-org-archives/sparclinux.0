From: Anton Blanchard <anton@samba.org>
Date: Tue, 10 Aug 2004 16:23:04 +0000
Subject: Re: /dev/random lacks entropy on sparc64
Message-Id: <20040810162304.GJ24690@krispykreme>
List-Id: <sparclinux.vger.kernel.org>
References: <1092092360.7938.50.camel@duncow>
In-Reply-To: <1092092360.7938.50.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> Whilst creating a new gpg key I noticed that there is typically very
> little entropy in /dev/random.
> 
> cat /proc/sys/kernel/random/entropy_avail
> 
> was always showing numbers < 100. After a bit of digging I worked out
> that this was due to add_timer_randomness() using jiffies to measure
> time rather than a hires timesource (i386 and x86_64 use tsc). I knocked
> the following patch and have tried this on 2.4.26 and this solves the
> problem. 
> 
> I suspect that the patch needs some more work (probably shouldn't use
> assembly directly in drivers/char/random.c). I'm not sure whether we
> should really be calling something like tick_ops->get_tick(). But
> actually tick_get_tick() would probably be appropriate on all machines
> because we know that %tick is available on all v9 machines and
> /dev/random doesn't absolutely need a common tick value across all cpus.

I remembered Arnd had a patch to use get_cycles(), this way we avoid
each architecture defining their own method. How does this look?

Anton

--

From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: Using get_cycles for add_timer_randomness
Date:	Sat, 16 Aug 2003 03:03:17 +0200

I noticed that only i386 and x86-64 are currently using
a high resolution timer source when adding randomness.
Since many architectures have a working get_cycles()
implementation, it seems rather straightforward to use
that.

Has this been discussed before, or can anyone comment
on the implementation below?

This patch attempts to take into account the size of
cycles_t, which is either 32 or 64 bits wide but
independent of the architecture's word size.

The behavior should be nearly identical to the
old one on i386, x86-64 and all architectures
without a time stamp counter, while finding
more entropy on the other architectures.

	Arnd <><

=== drivers/char/random.c 1.35 vs edited ==--- 1.35/drivers/char/random.c	Wed Aug  6 19:59:31 2003
+++ edited/drivers/char/random.c	Sat Aug 16 02:05:34 2003
@@ -711,8 +711,8 @@
 
 /* There is one of these per entropy source */
 struct timer_rand_state {
-	__u32		last_time;
-	__s32		last_delta,last_delta2;
+	cycles_t	last_time;
+	long		last_delta,last_delta2;
 	int		dont_count_entropy:1;
 };
 
@@ -729,27 +729,28 @@
  * The number "num" is also added to the pool - it should somehow describe
  * the type of event which just happened.  This is currently 0-255 for
  * keyboard scan codes, and 256 upwards for interrupts.
- * On the i386, this is assumed to be at most 16 bits, and the high bits
- * are used for a high-resolution timer.
+ * This is assumed to be at most 16 bits, and the high bits are used for
+ * high-resolution timers.
  *
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
-	__u32		time;
-	__s32		delta, delta2, delta3;
+	cycles_t	time;
+	long		delta, delta2, delta3;
 	int		entropy = 0;
 
-#if defined (__i386__) || defined (__x86_64__)
-	if (cpu_has_tsc) {
-		__u32 high;
-		rdtsc(time, high);
-		num ^= high;
+	/*
+	 * Use get_cycles() if implemented, otherwise fall back to
+	 * jiffies.
+	 */
+	time = get_cycles();
+	if (time != 0) {
+		if (sizeof (time) > 4) {
+			num ^= (u32)(time >> 32);
+		}
 	} else {
 		time = jiffies;
 	}
-#else
-	time = jiffies;
-#endif
 
 	/*
 	 * Calculate number of bits of randomness we probably added.
=== include/asm-i386/timex.h 1.5 vs edited ==--- 1.5/include/asm-i386/timex.h	Mon Jun  9 14:41:23 2003
+++ edited/include/asm-i386/timex.h	Sat Aug 16 02:17:05 2003
@@ -7,7 +7,7 @@
 #define _ASMi386_TIMEX_H
 
 #include <linux/config.h>
-#include <asm/msr.h>
+#include <asm/processor.h>
 
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
@@ -44,14 +44,17 @@
 
 static inline cycles_t get_cycles (void)
 {
+	unsigned long long ret=0;
+
 #ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
+	if (!cpu_has_tsc)
+		return 0;
+#endif
 
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
 	rdtscll(ret);
-	return ret;
 #endif
+	return ret;
 }
 
 extern unsigned long cpu_khz;
