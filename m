From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:28 +0000
Subject: [RFC PATCH 08/23] x86/hpet: Calculate ticks-per-second in a separate function
Message-Id: <1528851463-21140-9-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, iommu@lists.linux-foundation.org

It is easier to compute the expiration times of an HPET timer by using
its frequency (i.e., the number of times it ticks in a second) than its
period, as given in the capabilities register.

In addition to the HPET char driver, the HPET-based hardlockup detector
will also need to know the timer's frequency. Thus, create a common
function that both can use.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/char/hpet.c  | 31 +++++++++++++++++++++++++------
 include/linux/hpet.h |  1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index be426eb..1c9584a 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -838,6 +838,29 @@ static unsigned long hpet_calibrate(struct hpets *hpetp)
 	return ret;
 }
 
+u64 hpet_get_ticks_per_sec(u64 hpet_caps)
+{
+	u64 ticks_per_sec, period;
+
+	period = (hpet_caps & HPET_COUNTER_CLK_PERIOD_MASK) >>
+		 HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
+
+	/*
+	 * The frequency is the reciprocal of the period. The period is given
+	 * femtoseconds per second. Thus, prepare a dividend to obtain the
+	 * frequency in ticks per second.
+	 */
+
+	/* 10^15 femtoseconds per second */
+	ticks_per_sec = 1000000000000000uLL;
+	ticks_per_sec += period >> 1; /* round */
+
+	/* The quotient is put in the dividend. We drop the remainder. */
+	do_div(ticks_per_sec, period);
+
+	return ticks_per_sec;
+}
+
 int hpet_alloc(struct hpet_data *hdp)
 {
 	u64 cap, mcfg;
@@ -847,7 +870,6 @@ int hpet_alloc(struct hpet_data *hdp)
 	size_t siz;
 	struct hpet __iomem *hpet;
 	static struct hpets *last;
-	unsigned long period;
 	unsigned long long temp;
 	u32 remainder;
 
@@ -883,6 +905,8 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	cap = readq(&hpet->hpet_cap);
 
+	temp = hpet_get_ticks_per_sec(cap);
+
 	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
 
 	if (hpetp->hp_ntimer != ntimer) {
@@ -899,11 +923,6 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	last = hpetp;
 
-	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
-	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
-	temp += period >> 1; /* round */
-	do_div(temp, period);
 	hpetp->hp_tick_freq = temp; /* ticks per second */
 
 	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
diff --git a/include/linux/hpet.h b/include/linux/hpet.h
index 8604564..e7b36bcf4 100644
--- a/include/linux/hpet.h
+++ b/include/linux/hpet.h
@@ -107,5 +107,6 @@ static inline void hpet_reserve_timer(struct hpet_data *hd, int timer)
 }
 
 int hpet_alloc(struct hpet_data *);
+u64 hpet_get_ticks_per_sec(u64 hpet_caps);
 
 #endif				/* !__HPET__ */
-- 
2.7.4

