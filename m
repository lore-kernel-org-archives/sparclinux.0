From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 09 Aug 2004 22:59:20 +0000
Subject: /dev/random lacks entropy on sparc64
Message-Id: <1092092360.7938.50.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Whilst creating a new gpg key I noticed that there is typically very
little entropy in /dev/random.

cat /proc/sys/kernel/random/entropy_avail

was always showing numbers < 100. After a bit of digging I worked out
that this was due to add_timer_randomness() using jiffies to measure
time rather than a hires timesource (i386 and x86_64 use tsc). I knocked
the following patch and have tried this on 2.4.26 and this solves the
problem. 

I suspect that the patch needs some more work (probably shouldn't use
assembly directly in drivers/char/random.c). I'm not sure whether we
should really be calling something like tick_ops->get_tick(). But
actually tick_get_tick() would probably be appropriate on all machines
because we know that %tick is available on all v9 machines and
/dev/random doesn't absolutely need a common tick value across all cpus.

How does this sound?

Richard


shirehall:/tmp# diff -u linux-2.4.26.orig/drivers/char/random.c
linux-2.4.26/drivers/char/random.c
--- linux-2.4.26.orig/drivers/char/random.c     2004-02-18
13:36:31.000000000 +0000
+++ linux-2.4.26/drivers/char/random.c  2004-08-04 00:38:04.000000000
+0100
@@ -750,6 +750,17 @@
        __u32 high;
        rdtsc(time, high);
        num ^= high;
+#elif defined (__sparc_v9__)
+        unsigned long tmp;
+       unsigned high;
+
+        __asm__ __volatile__("rd        %%tick, %0\n\t"
+                             "srlx      %0, 32, %1\n\t"
+                             "srl       %1, 1, %1"
+                             : "=r" (tmp), "=r" (high));
+
+       time = (unsigned)tmp;
+       num ^= high;
 #else
        time = jiffies;
 #endif



-- 
richm@oldelvet.org.uk

