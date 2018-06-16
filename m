From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 16 Jun 2018 00:51:03 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <20180616005103.GC6659@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
	<20180615020314.GA11625@voyager>
	<alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806151029210.2079-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoffer Dall <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
> On Thu, 14 Jun 2018, Ricardo Neri wrote:
> > On Wed, Jun 13, 2018 at 11:40:00AM +0200, Thomas Gleixner wrote:
> > > On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > > > @@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
> > > >  	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > > >  		kick_timer(hdata);
> > > >  
> > > > +	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");
> > > 
> > > Eeew.
> > 
> > If you don't mind me asking. What is the problem with this error message?
> 
> The problem is not the error message. The problem is the abuse of
> request_irq() and the fact that this irq handler function exists in the
> first place for something which is NMI based.

I wanted to add this handler in case the interrupt was not configured correctly
to be delivered as NMI (e.g., not supported by the hardware). I see your point.
Perhaps this is not needed. There is code in place to complain when an interrupt
that nobody was expecting happens.

> 
> > > And in case that the HPET does not support periodic mode this reprogramms
> > > the timer on every NMI which means that while perf is running the watchdog
> > > will never ever detect anything.
> > 
> > Yes. I see that this is wrong. With MSI interrupts, as far as I can
> > see, there is not a way to make sure that the HPET timer caused the NMI
> > perhaps the only option is to use an IO APIC interrupt and read the
> > interrupt status register.
> > 
> > > Aside of that, reading TWO HPET registers for every NMI is insane. HPET
> > > access is horribly slow, so any high frequency perf monitoring will take a
> > > massive performance hit.
> > 
> > If an IO APIC interrupt is used, only HPET register (the status register)
> > would need to be read for every NMI. Would that be more acceptable? Otherwise,
> > there is no way to determine if the HPET cause the NMI.
> 
> You need level trigger for the HPET status register to be useful at all
> because in edge mode the interrupt status bits read always 0.

Indeed.

> 
> That means you have to fiddle with the IOAPIC acknowledge magic from NMI
> context. Brilliant idea. If the NMI hits in the middle of a regular
> io_apic_read() then the interrupted code will endup with the wrong index
> register. Not to talk about the fun which the affinity rotation from NMI
> context would bring.
> 
> Do not even think about using IOAPIC and level for this.

OK. I will stay away of it and focus on MSI.
> 
> > Alternatively, there could be a counter that skips reading the HPET status
> > register (and the detection of hardlockups) for every X NMIs. This would
> > reduce the overall frequency of HPET register reads.
> 
> Great plan. So if the watchdog is the only NMI (because perf is off) then
> you delay the watchdog detection by that count.

OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
register per NMI just to check in the status register if the HPET timer
caused the NMI?

Thanks and BR,
Ricardo
