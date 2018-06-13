From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:25 +0000
Subject: [RFC PATCH 05/23] x86/msi: Add support for IRQCHIP_CAN_DELIVER_AS_NMI
Message-Id: <1528851463-21140-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>, iommu@lists.linux-foundation.org

As per the Intel 64 and IA-32 Architectures Software Developer's Manual
Volume 3 Section 10.11.2, the delivery mode field of the interrupt message
can be set to configure as non-maskable. Declare support to deliver non-
maskable interrupts by adding IRQCHIP_CAN_DELIVER_AS_NMI.

When composing the interrupt message, the delivery mode is obtained from
the configuration of the interrupt data.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/apic/msi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 12202ac..68b6a04 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -29,6 +29,9 @@ static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct irq_cfg *cfg = irqd_cfg(data);
 
+	if (irqd_deliver_as_nmi(data))
+		cfg->delivery_mode = dest_NMI;
+
 	msg->address_hi = MSI_ADDR_BASE_HI;
 
 	if (x2apic_enabled())
@@ -297,7 +300,7 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg = irq_msi_compose_msg,
 	.irq_write_msi_msg = hpet_msi_write_msg,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_CAN_DELIVER_AS_NMI,
 };
 
 static irq_hw_number_t hpet_msi_get_hwirq(struct msi_domain_info *info,
-- 
2.7.4

