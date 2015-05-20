From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Wed, 20 May 2015 10:00:08 +0000
Subject: [RFC v1 20/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Message-Id: <1432116013-25902-21-git-send-email-jiang.liu@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Andreas Larsson <andreas@gaisler.com>, Jiang Liu <jiang.li>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-alpha@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, sparclinux@vger.kernel.org, lguest@lists.ozlabs.org

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/alpha/kernel/irq.c             |    2 +-
 arch/avr32/mach-at32ap/extint.c     |    2 +-
 arch/avr32/mach-at32ap/pio.c        |    2 +-
 arch/blackfin/kernel/ipipe.c        |    4 ++--
 arch/c6x/platforms/megamod-pic.c    |    3 ++-
 arch/sparc/kernel/leon_kernel.c     |    2 +-
 arch/sparc/kernel/leon_pci_grpci1.c |    2 +-
 arch/sparc/kernel/leon_pci_grpci2.c |    2 +-
 arch/tile/kernel/pci_gx.c           |    4 ++--
 arch/unicore32/kernel/irq.c         |    3 ++-
 arch/x86/kernel/irq_64.c            |    2 +-
 arch/x86/lguest/boot.c              |    2 +-
 12 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index bd8e47699cad..d2704d53aac8 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -118,6 +118,6 @@ handle_irq(int irq)
 	}
 
 	irq_enter();
-	generic_handle_irq_desc(irq, desc);
+	generic_handle_irq_desc(desc);
 	irq_exit();
 }
diff --git a/arch/avr32/mach-at32ap/extint.c b/arch/avr32/mach-at32ap/extint.c
index cfb298d66305..b83a974b7855 100644
--- a/arch/avr32/mach-at32ap/extint.c
+++ b/arch/avr32/mach-at32ap/extint.c
@@ -144,7 +144,7 @@ static struct irq_chip eic_chip = {
 	.irq_set_type	= eic_set_irq_type,
 };
 
-static void demux_eic_irq(unsigned int irq, struct irq_desc *desc)
+static void demux_eic_irq(struct irq_desc *desc)
 {
 	struct eic *eic = irq_desc_get_handler_data(desc);
 	unsigned long status, pending;
diff --git a/arch/avr32/mach-at32ap/pio.c b/arch/avr32/mach-at32ap/pio.c
index 2583e6cc44e9..85009bbc01e6 100644
--- a/arch/avr32/mach-at32ap/pio.c
+++ b/arch/avr32/mach-at32ap/pio.c
@@ -281,7 +281,7 @@ static struct irq_chip gpio_irqchip = {
 	.irq_set_type	= gpio_irq_type,
 };
 
-static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void gpio_irq_handler(struct irq_desc *desc)
 {
 	struct pio_device	*pio = irq_desc_get_chip_data(desc);
 	unsigned		gpio_irq;
diff --git a/arch/blackfin/kernel/ipipe.c b/arch/blackfin/kernel/ipipe.c
index f657b38163e3..8daca4d56992 100644
--- a/arch/blackfin/kernel/ipipe.c
+++ b/arch/blackfin/kernel/ipipe.c
@@ -54,9 +54,9 @@ atomic_t __ipipe_irq_lvdepth[IVG15 + 1];
 unsigned long __ipipe_irq_lvmask = bfin_no_irqs;
 EXPORT_SYMBOL(__ipipe_irq_lvmask);
 
-static void __ipipe_ack_irq(unsigned irq, struct irq_desc *desc)
+static void __ipipe_ack_irq(struct irq_desc *desc)
 {
-	desc->ipipe_ack(irq, desc);
+	desc->ipipe_ack(irq_desc_get_irq(desc), desc);
 }
 
 /*
diff --git a/arch/c6x/platforms/megamod-pic.c b/arch/c6x/platforms/megamod-pic.c
index 74e3371eb824..c15f0b15faf4 100644
--- a/arch/c6x/platforms/megamod-pic.c
+++ b/arch/c6x/platforms/megamod-pic.c
@@ -93,12 +93,13 @@ static struct irq_chip megamod_chip = {
 	.irq_unmask	= unmask_megamod,
 };
 
-static void megamod_irq_cascade(unsigned int irq, struct irq_desc *desc)
+static void megamod_irq_cascade(struct irq_desc *desc)
 {
 	struct megamod_cascade_data *cascade;
 	struct megamod_pic *pic;
 	u32 events;
 	int n, idx;
+	unsigned int irq;
 
 	cascade = irq_desc_get_handler_data(desc);
 
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 0299f052a2ef..42efcf85f721 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -53,7 +53,7 @@ static inline unsigned int leon_eirq_get(int cpu)
 }
 
 /* Handle one or multiple IRQs from the extended interrupt controller */
-static void leon_handle_ext_irq(unsigned int irq, struct irq_desc *desc)
+static void leon_handle_ext_irq(struct irq_desc *desc)
 {
 	unsigned int eirq;
 	struct irq_bucket *p;
diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index 3382f7b3eeef..1e77128a8f88 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -357,7 +357,7 @@ static struct irq_chip grpci1_irq = {
 };
 
 /* Handle one or multiple IRQs from the PCI core */
-static void grpci1_pci_flow_irq(unsigned int irq, struct irq_desc *desc)
+static void grpci1_pci_flow_irq(struct irq_desc *desc)
 {
 	struct grpci1_priv *priv = grpci1priv;
 	int i, ack = 0;
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 94e392bdee7d..0398fc2c0e44 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -498,7 +498,7 @@ static struct irq_chip grpci2_irq = {
 };
 
 /* Handle one or multiple IRQs from the PCI core */
-static void grpci2_pci_flow_irq(unsigned int irq, struct irq_desc *desc)
+static void grpci2_pci_flow_irq(struct irq_desc *desc)
 {
 	struct grpci2_priv *priv = grpci2priv;
 	int i, ack = 0;
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index 65b701b3b5ed..4c017d0d2de8 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -304,7 +304,7 @@ static struct irq_chip tilegx_legacy_irq_chip = {
  * to Linux which just calls handle_level_irq() after clearing the
  * MAC INTx Assert status bit associated with this interrupt.
  */
-static void trio_handle_level_irq(unsigned int irq, struct irq_desc *desc)
+static void trio_handle_level_irq(struct irq_desc *desc)
 {
 	struct pci_controller *controller = irq_desc_get_handler_data(desc);
 	gxio_trio_context_t *trio_context = controller->trio;
@@ -313,7 +313,7 @@ static void trio_handle_level_irq(unsigned int irq, struct irq_desc *desc)
 	unsigned int reg_offset;
 	uint64_t level_mask;
 
-	handle_level_irq(irq, desc);
+	handle_level_irq(desc);
 
 	/*
 	 * Clear the INTx Level status, otherwise future interrupts are
diff --git a/arch/unicore32/kernel/irq.c b/arch/unicore32/kernel/irq.c
index 0be5ccd7ccd2..adfa1d1fb255 100644
--- a/arch/unicore32/kernel/irq.c
+++ b/arch/unicore32/kernel/irq.c
@@ -113,9 +113,10 @@ static struct irq_chip puv3_low_gpio_chip = {
  * and call the handler.
  */
 static void
-puv3_gpio_handler(unsigned int irq, struct irq_desc *desc)
+puv3_gpio_handler(struct irq_desc *desc)
 {
 	unsigned int mask;
+	unsigned int irq;
 
 	mask = readl(GPIO_GEDR);
 	do {
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index bc4604e500a3..eca6d5e3ad25 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -78,6 +78,6 @@ bool handle_irq(unsigned irq, struct pt_regs *regs)
 	if (unlikely(!desc))
 		return false;
 
-	generic_handle_irq_desc(irq, desc);
+	generic_handle_irq_desc(desc);
 	return true;
 }
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index cab9aaa7802c..24efba1c1f3d 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1021,7 +1021,7 @@ static struct clock_event_device lguest_clockevent = {
  * This is the Guest timer interrupt handler (hardware interrupt 0).  We just
  * call the clockevent infrastructure and it does whatever needs doing.
  */
-static void lguest_time_irq(unsigned int irq, struct irq_desc *desc)
+static void lguest_time_irq(struct irq_desc *desc)
 {
 	unsigned long flags;
 
-- 
1.7.10.4

