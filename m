From: David Miller <davem@davemloft.net>
Date: Wed, 29 Apr 2009 22:52:18 +0000
Subject: Re: interrupt problem with multiple vnet devices
Message-Id: <20090429.155218.210110117.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200904292141.n3TLfmn16267@elf.torek.net>
In-Reply-To: <200904292141.n3TLfmn16267@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 29 Apr 2009 15:04:08 -0700 (PDT)

> But we should be working around that properly.  This check in
> sun4v_irq_eoi() and sun4v_virq_eoi():
> 
> 	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
> 		return;
> 
> Should prevent any problems due to that bug.

This is the commit that test comes from.  I assume you guys
would check the commit logs for something like this, but just
in case...

commit 5a606b72a4309a656cd1a19ad137dc5557c4b8ea
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Jul 9 22:40:36 2007 -0700

    [SPARC64]: Do not ACK an INO if it is disabled or inprogress.
    
    This is also a partial workaround for a bug in the LDOM firmware which
    double-transmits RX inos during high load.  Without this, such an
    event causes the kernel to loop forever in the interrupt call chain
    ACK'ing but never actually running the IRQ handler (and thus clearing
    the interrupt condition in the device).
    
    There is still a bad potential effect when double INOs occur,
    not covered by this changeset.  Namely, if the INO is already on
    the per-cpu INO vector list, we still blindly re-insert it and
    thus we can end up losing interrupts already linked in after
    it.
    
    We could deal with that by traversing the list before insertion,
    but that's too expensive for this edge case.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 6b6165d..634194e 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -309,6 +309,10 @@ static void sun4u_irq_disable(unsigned int virt_irq)
 static void sun4u_irq_end(unsigned int virt_irq)
 {
 	struct irq_handler_data *data = get_irq_chip_data(virt_irq);
+	struct irq_desc *desc = irq_desc + virt_irq;
+
+	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		return;
 
 	if (likely(data))
 		upa_writeq(ICLR_IDLE, data->iclr);
@@ -373,6 +377,10 @@ static void sun4v_irq_end(unsigned int virt_irq)
 {
 	struct ino_bucket *bucket = virt_irq_to_bucket(virt_irq);
 	unsigned int ino = bucket - &ivector_table[0];
+	struct irq_desc *desc = irq_desc + virt_irq;
+
+	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		return;
 
 	if (likely(bucket)) {
 		int err;
@@ -443,6 +451,10 @@ static void sun4v_virq_end(unsigned int virt_irq)
 {
 	struct ino_bucket *bucket = virt_irq_to_bucket(virt_irq);
 	unsigned int ino = bucket - &ivector_table[0];
+	struct irq_desc *desc = irq_desc + virt_irq;
+
+	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		return;
 
 	if (likely(bucket)) {
 		unsigned long dev_handle, dev_ino;
