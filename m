From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2009 12:22:56 +0000
Subject: Re: esp scsi problem on shutdown - sunhme related?
Message-Id: <20090304.042256.64908696.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2009 04:09:58 -0800 (PST)

> I'm not exactly sure how I'll fix this.  I'll try to come
> up with a scheme and post a patch for you to test tomorrow.

I lied :-)  I think the following simple approach might
work.

Can you give it a try?

Thanks!

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index e289376..e1a40b3 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -325,15 +325,12 @@ static void sun4u_set_affinity(unsigned int virt_irq,
 
 static void sun4u_irq_disable(unsigned int virt_irq)
 {
-	struct irq_handler_data *data = get_irq_chip_data(virt_irq);
-
-	if (likely(data)) {
-		unsigned long imap = data->imap;
-		unsigned long tmp = upa_readq(imap);
-
-		tmp &= ~IMAP_VALID;
-		upa_writeq(tmp, imap);
-	}
+	/* Don't do anything.  The desc->status check for
+	 * IRQ_DISABLED in handler_irq() will skip the
+	 * handler call and that will leave the interrupt
+	 * in the sent state.  The next ->enable() call will
+	 * hit the ICLR register to reset the state machine.
+	 */
 }
 
 static void sun4u_irq_eoi(unsigned int virt_irq)
@@ -746,7 +743,8 @@ void handler_irq(int irq, struct pt_regs *regs)
 
 		desc = irq_desc + virt_irq;
 
-		desc->handle_irq(virt_irq, desc);
+		if (!(desc->status & IRQ_DISABLED))
+			desc->handle_irq(virt_irq, desc);
 
 		bucket_pa = next_pa;
 	}
