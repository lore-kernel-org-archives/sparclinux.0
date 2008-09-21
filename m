From: David Miller <davem@davemloft.net>
Date: Sun, 21 Sep 2008 05:04:42 +0000
Subject: [PATCH]: Fix disappearing PCI devices (was Re: psycho_irq_build:
Message-Id: <20080920.220442.07327164.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 12 Sep 2008 14:01:11 +0300 (EEST)

Ok, I think I know where your PCI QFE devices disappeared to.

> /pci@a,2000/pci@2/SUNW,qfe@810100,0 reg[0] -> 0
> /pci@a,2000/pci@2/SUNW,qfe@810100,0 reg[1] -> 0
> /pci@a,2000/pci@2/SUNW,qfe@810100,0: PCI swizzle [/pci@a,2000] 2 --> 5
> /pci@a,2000/pci@2/SUNW,qfe@810100,0: Apply IRQ trans [/pci@a,2000] 2 --> 1f

That's very wrong.  First, there should be one register resources.
Secondly, it should be something other than zero.

Looking at the prtconf, this DEC bridge sitting above the QFE devices
is named "pci" but it lacks a 'device_type' property.  This lack of
'device_type' property trips up the OF device layer resource building
code.

In all of the prtconf dumps we have in the prtconfs GIT repo, there is
no other system showing this.  I suppose it is something unique to the
OF code that build the device properties for the PCI bridge on the PCI
QFE cards.

Anyways, this patch below should fix the bug.  Let me know if it works.

Thanks!

sparc64: Fix disappearing PCI devices on e3500.

Based upon a bug report by Meelis Roos.

The OF device layer builds properties by matching bus types and
applying 'range' properties as appropriate, up to the root.

The match for "PCI" busses is looking at the 'device_type' property,
and this does work %99 of the time.

But on an E3500 system with a PCI QFE card, the DEC 21153 bridge
sitting above the QFE network interface devices has a 'name' of "pci",
but it completely lacks a 'device_type' property.  So we don't match
it as a PCI bus, and subsequently we end up with no resource values at
all for the devices sitting under that DEC bridge.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/of_device.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index f845f15..100ebd5 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -169,7 +169,7 @@ static unsigned long of_bus_default_get_flags(const u32 *addr, unsigned long fla
 
 static int of_bus_pci_match(struct device_node *np)
 {
-	if (!strcmp(np->type, "pci") || !strcmp(np->type, "pciex")) {
+	if (!strcmp(np->name, "pci")) {
 		const char *model = of_get_property(np, "model", NULL);
 
 		if (model && !strcmp(model, "SUNW,simba"))
@@ -200,7 +200,7 @@ static int of_bus_simba_match(struct device_node *np)
 	/* Treat PCI busses lacking ranges property just like
 	 * simba.
 	 */
-	if (!strcmp(np->type, "pci") || !strcmp(np->type, "pciex")) {
+	if (!strcmp(np->name, "pci")) {
 		if (!of_find_property(np, "ranges", NULL))
 			return 1;
 	}
@@ -429,7 +429,7 @@ static int __init use_1to1_mapping(struct device_node *pp)
 	 * it lacks a ranges property, and this will include
 	 * cases like Simba.
 	 */
-	if (!strcmp(pp->type, "pci") || !strcmp(pp->type, "pciex"))
+	if (!strcmp(pp->name, "pci"))
 		return 0;
 
 	return 1;
@@ -714,8 +714,7 @@ static unsigned int __init build_one_device_irq(struct of_device *op,
 				break;
 			}
 		} else {
-			if (!strcmp(pp->type, "pci") ||
-			    !strcmp(pp->type, "pciex")) {
+			if (!strcmp(pp->name, "pci")) {
 				unsigned int this_orig_irq = irq;
 
 				irq = pci_irq_swizzle(dp, pp, irq);
-- 
1.5.6.5

