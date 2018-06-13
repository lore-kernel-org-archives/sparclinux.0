From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:29 +0000
Subject: [RFC PATCH 09/23] x86/hpet: Reserve timer for the HPET hardlockup detector
Message-Id: <1528851463-21140-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, iommu@lists.linux-foundation.org

HPET timer 2 will be used to drive the HPET-based hardlockup detector.
Reserve such timer to ensure it cannot be used by user space programs or
clock events.

When looking for MSI-capable timers for clock events, skip timer 2 if
the HPET hardlockup detector is selected.

Also, do not assign an IO APIC pin to timer 2 of the HPET. A subsequent
changeset will handle the interrupt setup of the timer used for the
hardlockup detector.

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
 arch/x86/include/asm/hpet.h |  3 +++
 arch/x86/kernel/hpet.c      | 19 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 9e0afde..3266796 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -61,6 +61,9 @@
  */
 #define HPET_MIN_PERIOD		100000UL
 
+/* Timer used for the hardlockup detector */
+#define HPET_WD_TIMER_NR 2
+
 /* hpet memory map physical address */
 extern unsigned long hpet_address;
 extern unsigned long force_hpet_address;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3fa1d3f..b03faee 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -185,7 +185,8 @@ do {								\
 
 /*
  * When the hpet driver (/dev/hpet) is enabled, we need to reserve
- * timer 0 and timer 1 in case of RTC emulation.
+ * timer 0 and timer 1 in case of RTC emulation. Timer 2 is reserved in case
+ * the HPET-based hardlockup detector is used.
  */
 #ifdef CONFIG_HPET
 
@@ -195,7 +196,7 @@ static void hpet_reserve_platform_timers(unsigned int id)
 {
 	struct hpet __iomem *hpet = hpet_virt_address;
 	struct hpet_timer __iomem *timer = &hpet->hpet_timers[2];
-	unsigned int nrtimers, i;
+	unsigned int nrtimers, i, start_timer;
 	struct hpet_data hd;
 
 	nrtimers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
@@ -210,6 +211,13 @@ static void hpet_reserve_platform_timers(unsigned int id)
 	hpet_reserve_timer(&hd, 1);
 #endif
 
+	if (IS_ENABLED(CONFIG_HARDLOCKUP_DETECTOR_HPET)) {
+		hpet_reserve_timer(&hd, HPET_WD_TIMER_NR);
+		start_timer = HPET_WD_TIMER_NR + 1;
+	} else {
+		start_timer = HPET_WD_TIMER_NR;
+	}
+
 	/*
 	 * NOTE that hd_irq[] reflects IOAPIC input pins (LEGACY_8254
 	 * is wrong for i8259!) not the output IRQ.  Many BIOS writers
@@ -218,7 +226,7 @@ static void hpet_reserve_platform_timers(unsigned int id)
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < nrtimers; timer++, i++) {
+	for (i = start_timer; i < nrtimers; timer++, i++) {
 		hd.hd_irq[i] = (readl(&timer->hpet_config) &
 			Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
 	}
@@ -630,6 +638,11 @@ static void hpet_msi_capability_lookup(unsigned int start_timer)
 		struct hpet_dev *hdev = &hpet_devs[num_timers_used];
 		unsigned int cfg = hpet_readl(HPET_Tn_CFG(i));
 
+		/* Do not use timer reserved for the HPET watchdog. */
+		if (IS_ENABLED(CONFIG_HARDLOCKUP_DETECTOR_HPET) &&
+		    i = HPET_WD_TIMER_NR)
+			continue;
+
 		/* Only consider HPET timer with MSI support */
 		if (!(cfg & HPET_TN_FSB_CAP))
 			continue;
-- 
2.7.4

