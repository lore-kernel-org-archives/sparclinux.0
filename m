From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 21:06:51 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213210651.GA27283@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110213192952.GD25069@merkur.ravnborg.org>
In-Reply-To: <20110213192952.GD25069@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 13, 2011 at 12:54:01PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 13 Feb 2011 20:29:52 +0100
> 
> > +unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
> > +{
> > +	unsigned int i;
>  ...
> > +	for (i = 1; i < NR_IRQS; i++) {
> > +		if (irq_table[i].irq = real_irq && irq_table[i].irq = pil)
> > +			return i;
> > +	}
>  ...
> > +	irq_table[i].irq = i;
> > +	irq_table[i].pil = pil;
> > +
> > +	return i;
> > +}
> 
> Well, what is it?  Are we storing "real_irq" in irq_table[].irq or
> "i"?  I think it's supposed to be "real_irq" and that's one of the
> reasons your implementation isn't working :-)

Good catch. I changed the above as I require irq in handler_irq()
to lookup the relevant irq_desc. But I obviously scrwed up.

From handler_irq():

                unsigned int irq;

                irq = p->irq;
                desc = irq_to_desc(irq);

                if (!(desc->status & IRQ_DISABLED))
                        desc->handle_irq(irq, desc);

So I fixed this - but result is the same - we hang in calibrate_dealy().

	Sam

My fix looks like this:

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index f92cd34..31658bd 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -123,6 +123,7 @@ static void irq_panic(irq_handler_t handler)
 
 struct irq_bucket {
 	struct irq_bucket *next;
+	unsigned int real_irq;
 	unsigned int irq;
 	unsigned int pil;
 };
@@ -138,7 +139,7 @@ unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
 	unsigned int i;
 
 	for (i = 1; i < NR_IRQS; i++) {
-		if (irq_table[i].irq = real_irq && irq_table[i].irq = pil)
+		if (irq_table[i].real_irq = real_irq && irq_table[i].pil = pil)
 			return i;
 	}
 
@@ -151,6 +152,7 @@ unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
 		printk(KERN_ERR "IRQ: Out of virtual IRQs.\n");
 		return 0;
 	}
+	irq_table[i].real_irq = real_irq;
 	irq_table[i].irq = i;
 	irq_table[i].pil = pil;
 



