From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:26 +0000
Subject: [RFC PATCH 06/23] x86/ioapic: Add support for IRQCHIP_CAN_DELIVER_AS_NMI with interrupt remapping
Message-Id: <1528851463-21140-7-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, Juergen Gross <jgross@suse.com>, Baoquan He <bhe@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, iommu@lists.linux-foundation.org

Even though there is a delivery mode field at the entries of an IO APIC's
redirection table, the documentation of the majority of the IO APICs
explicitly states that interrupt delivery as non-maskable is not supported.
Thus,

However, when using an IO APIC in combination with the Intel VT-d interrupt
remapping functionality, the delivery of the interrupt to the CPU is
handled by the remapping hardware. In such a case, the interrupt can be
delivered as non maskable.

Thus, add the IRQCHIP_CAN_DELIVER_AS_NMI flag only when used in combination
with interrupt remapping.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/apic/io_apic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 10a20f8..39de91b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1911,7 +1911,8 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
 	.irq_eoi		= ioapic_ir_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_CAN_DELIVER_AS_NMI,
 };
 
 static inline void init_IO_APIC_traps(void)
-- 
2.7.4

