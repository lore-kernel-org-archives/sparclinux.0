From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:22 +0000
Subject: [RFC PATCH 02/23] genirq: Introduce IRQD_DELIVER_AS_NMI
Message-Id: <1528851463-21140-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Doug Berger <opendmb@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org

Certain interrupt controllers (e.g., APIC) are capable of delivering
interrupts to the CPU as non-maskable. Add the new IRQD_DELIVER_AS_NMI
interrupt state flag. The purpose of this flag is to communicate to the
underlying irqchip whether the interrupt must be delivered in this manner.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Doug Berger <opendmb@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/irq.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 65916a3..7271a2c 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -208,6 +208,7 @@ struct irq_data {
  * IRQD_SINGLE_TARGET		- IRQ allows only a single affinity target
  * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  * IRQD_CAN_RESERVE		- Can use reservation mode
+ * IRQD_DELIVER_AS_NMI		- Deliver this interrupt as non-maskable
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -230,6 +231,7 @@ enum {
 	IRQD_SINGLE_TARGET		= (1 << 24),
 	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 	IRQD_CAN_RESERVE		= (1 << 26),
+	IRQD_DELIVER_AS_NMI		= (1 << 27),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -389,6 +391,16 @@ static inline bool irqd_can_reserve(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_CAN_RESERVE;
 }
 
+static inline void irqd_set_deliver_as_nmi(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_DELIVER_AS_NMI;
+}
+
+static inline bool irqd_deliver_as_nmi(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_DELIVER_AS_NMI;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
-- 
2.7.4

