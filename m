From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 Feb 2011 18:22:19 +0000
Subject: Re: [PATCH 5/5] sparc32: genirq support
Message-Id: <20110222182219.GA25832@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 20, 2011 at 10:30:05PM +0100, Josip Rodin wrote:
> On Sun, Feb 20, 2011 at 09:40:00PM +0100, Sam Ravnborg wrote:
> > --- a/arch/sparc/kernel/pcic.c
> > +++ b/arch/sparc/kernel/pcic.c
> 
> > -static void pcic_load_profile_irq(int cpu, unsigned int limit)
> > +static unsigned int pcic_startup_irq(struct irq_data *data)
> >  {
> > -	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
> > +	irq_link(data->irq);
> > +	pcic_unmask_irq(data);
> > +	return 0;
> >  }
> 
> > -static void pcic_enable_pil_irq(unsigned int pil)
> > +
> > +static void pcic_load_profile_irq(int cpu, unsigned int limit)
> >  {
> > -	writel(get_irqmask(pil), pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_CLEAR);
> > +	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
> >  }
> 
> So, continuing on my previous line of nitpicking :) you could also rearrange
> these two a bit, so they don't clutter up the diff like this.

I will try to split the changes in two patches.
There are several smaller things that can go in in first
patch.

I will prepare a v4 soon.

	Sam
