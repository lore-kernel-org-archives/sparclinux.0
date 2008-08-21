From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 21:59:46 +0000
Subject: Re: [PATCH 1/3]: sparc: Implement irq_of_parse_and_map() and
Message-Id: <20080821.145946.01710005.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001017.261408123.davem@davemloft.net>
	<20080821215611.GA14354@oksana.dev.rtsoft.ru>
In-Reply-To: <20080821215611.GA14354@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: avorontsov@ru.mvista.com
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Fri, 22 Aug 2008 01:56:11 +0400

> On Thu, Aug 21, 2008 at 12:10:17AM -0700, David Miller wrote:
> > @@ -96,6 +96,14 @@ static inline void of_node_put(struct device_node *node)
> >  {
> >  }
> >  
> > +/* These routines are here to provide compatibility with how powerpc
> > + * handles IRQ mapping for OF device nodes.  We precompute and permanently
> > + * register them in the of_device objects, whereas powerpc computes them
> > + * on request.
> > + */
> > +extern int irq_of_parse_and_map(struct device_node *node, int index);
> 
> On powerpc irq_of_parse_and_map() returns unsigned type.
> 
> > +#define irq_dispose_mapping(irq) do { } while (0)
> 
> I'd rather write it as a static inline function, for type checking,
> plus, I think with this macros gcc may generate warnings about
> defined but unused variables.

Thanks, I'll fix that.

> > +
> >  /*
> >   * NB:  This is here while we transition from using asm/prom.h
> >   * to linux/of.h
> > diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
> > index cc4c235..56e9a71 100644
> > --- a/arch/sparc/kernel/of_device.c
> > +++ b/arch/sparc/kernel/of_device.c
> > @@ -29,6 +29,17 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
> >  }
> >  EXPORT_SYMBOL(of_find_device_by_node);
> >  
> > +int irq_of_parse_and_map(struct device_node *node, int index)
> > +{
> > +	struct of_device *op = of_find_device_by_node(node);
> > +
> > +	if (!op || index >= op->num_irqs)
> > +		return 0xffffffff;
> 
> This is valid virq, unfortunately. There is only one invalid virq: 0.
> With this most drivers will fail to identify 'there is no irq' case.
> Does virq0 has special meaning on sparc?

No, I'll fix this up, thanks.
