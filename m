From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:21 +0000
Subject: [RFC PATCH 01/23] x86/apic: Add a parameter for the APIC delivery mode
Message-Id: <1528851463-21140-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, Joerg Roedel <joro@8bytes.org>, Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, Wincy Van <fanwenyi0529@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, iommu@lis

Until now, the delivery mode of APIC interrupts is set to the default
mode set in the APIC driver. However, there are no restrictions in hardware
to configure each interrupt with a different delivery mode. Specifying the
delivery mode per interrupt is useful when one is interested in changing
the delivery mode of a particular interrupt. For instance, this can be used
to deliver an interrupt as non-maskable.

Add a new member, delivery_mode, to struct irq_cfg. Also, update the
configuration of the delivery mode in the IO APIC, the MSI APIC and the
Intel interrupt remapping driver to use this new per-interrupt member to
configure their respective interrupt tables.

In order to keep the current behavior, initialize the delivery mode of
each interrupt with the with the delivery mode of the APIC driver in use
when the interrupt data is allocated.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wincy Van <fanwenyi0529@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hw_irq.h       |  5 +++--
 arch/x86/include/asm/msidef.h       |  3 +++
 arch/x86/kernel/apic/io_apic.c      |  2 +-
 arch/x86/kernel/apic/msi.c          |  2 +-
 arch/x86/kernel/apic/vector.c       |  8 ++++++++
 arch/x86/platform/uv/uv_irq.c       |  2 +-
 drivers/iommu/intel_irq_remapping.c | 10 +++++-----
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 32e666e..c024e59 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -117,8 +117,9 @@ struct irq_alloc_info {
 };
 
 struct irq_cfg {
-	unsigned int		dest_apicid;
-	unsigned int		vector;
+	unsigned int				dest_apicid;
+	unsigned int				vector;
+	enum ioapic_irq_destination_types	delivery_mode;
 };
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
diff --git a/arch/x86/include/asm/msidef.h b/arch/x86/include/asm/msidef.h
index ee2f8cc..6aef434 100644
--- a/arch/x86/include/asm/msidef.h
+++ b/arch/x86/include/asm/msidef.h
@@ -16,6 +16,9 @@
 					 MSI_DATA_VECTOR_MASK)
 
 #define MSI_DATA_DELIVERY_MODE_SHIFT	8
+#define MSI_DATA_DELIVERY_MODE_MASK	0x00000700
+#define MSI_DATA_DELIVERY_MODE(dm)	(((dm) << MSI_DATA_DELIVERY_MODE_SHIFT) & \
+					 MSI_DATA_DELIVERY_MODE_MASK)
 #define  MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_MODE_SHIFT)
 #define  MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_MODE_SHIFT)
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7553819..10a20f8 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2887,8 +2887,8 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 			   struct IO_APIC_route_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode = apic->irq_delivery_mode;
 	entry->dest_mode     = apic->irq_dest_mode;
+	entry->delivery_mode = cfg->delivery_mode;
 	entry->dest	     = cfg->dest_apicid;
 	entry->vector	     = cfg->vector;
 	entry->trigger	     = data->trigger;
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index ce503c9..12202ac 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -45,7 +45,7 @@ static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->data  		MSI_DATA_TRIGGER_EDGE |
 		MSI_DATA_LEVEL_ASSERT |
-		MSI_DATA_DELIVERY_FIXED |
+		MSI_DATA_DELIVERY_MODE(cfg->delivery_mode) |
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb6f7a2..dfe0a2a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -547,6 +547,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
+
+		/*
+		 * Initialize the delivery mode of this irq to match
+		 * the default delivery mode of the APIC. This could be
+		 * changed later when the interrupt is activated.
+		 */
+		 apicd->hw_irq_cfg.delivery_mode = apic->irq_delivery_mode;
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index e4cb9f4..c88508b 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,7 +35,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->irq_delivery_mode;
+	entry->delivery_mode	= cfg->delivery_mode;
 	entry->dest_mode	= apic->irq_dest_mode;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 3062a15..9f3a04d 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1045,7 +1045,7 @@ static int reenable_irq_remapping(int eim)
 	return -1;
 }
 
-static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
+static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 {
 	memset(irte, 0, sizeof(*irte));
 
@@ -1059,9 +1059,9 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->irq_delivery_mode;
-	irte->vector = vector;
-	irte->dest_id = IRTE_DEST(dest);
+	irte->dlvry_mode = irq_cfg->delivery_mode;
+	irte->vector = irq_cfg->vector;
+	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 	irte->redir_hint = 1;
 }
 
@@ -1238,7 +1238,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 	struct irte *irte = &data->irte_entry;
 	struct msi_msg *msg = &data->msi_entry;
 
-	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
+	prepare_irte(irte, irq_cfg);
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
-- 
2.7.4

