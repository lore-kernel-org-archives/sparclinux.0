From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 15 Jun 2018 02:03:14 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <20180615020314.GA11625@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Wed, Jun 13, 2018 at 11:40:00AM +0200, Thomas Gleixner wrote:
> On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > @@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
> >  	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> >  		kick_timer(hdata);
> >  
> > +	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");
> 
> Eeew.

If you don't mind me asking. What is the problem with this error message?
> 
> >  /**
> > + * hardlockup_detector_nmi_handler() - NMI Interrupt handler
> > + * @val:	Attribute associated with the NMI. Not used.
> > + * @regs:	Register values as seen when the NMI was asserted
> > + *
> > + * When an NMI is issued, look for hardlockups. If the timer is not periodic,
> > + * kick it. The interrupt is always handled when if delivered via the
> > + * Front-Side Bus.
> > + *
> > + * Returns:
> > + *
> > + * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
> > + * otherwise.
> > + */
> > +static int hardlockup_detector_nmi_handler(unsigned int val,
> > +					   struct pt_regs *regs)
> > +{
> > +	struct hpet_hld_data *hdata = hld_data;
> > +	unsigned int use_fsb;
> > +
> > +	/*
> > +	 * If FSB delivery mode is used, the timer interrupt is programmed as
> > +	 * edge-triggered and there is no need to check the ISR register.
> > +	 */
> > +	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;
> > +
> > +	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
> > +		return NMI_DONE;
> 
> So for 'use_fsb = True' every single NMI will fall through into the
> watchdog code below.
> 
> > +	inspect_for_hardlockups(regs);
> > +
> > +	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > +		kick_timer(hdata);
> 
> And in case that the HPET does not support periodic mode this reprogramms
> the timer on every NMI which means that while perf is running the watchdog
> will never ever detect anything.

Yes. I see that this is wrong. With MSI interrupts, as far as I can
see, there is not a way to make sure that the HPET timer caused the NMI
perhaps the only option is to use an IO APIC interrupt and read the
interrupt status register.

> 
> Aside of that, reading TWO HPET registers for every NMI is insane. HPET
> access is horribly slow, so any high frequency perf monitoring will take a
> massive performance hit.

If an IO APIC interrupt is used, only HPET register (the status register)
would need to be read for every NMI. Would that be more acceptable? Otherwise,
there is no way to determine if the HPET cause the NMI.

Alternatively, there could be a counter that skips reading the HPET status
register (and the detection of hardlockups) for every X NMIs. This would
reduce the overall frequency of HPET register reads.

Is that more acceptable?

Thanks and BR,
Ricardo
