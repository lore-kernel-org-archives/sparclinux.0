From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 16 Jun 2018 00:46:31 +0000
Subject: Re: [RFC PATCH 20/23] watchdog/hardlockup/hpet: Rotate interrupt among all monitored CPUs
Message-Id: <20180616004631.GB6659@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1806131140560.2280@nanos.tec.linutronix.de>
	<20180615021629.GD11625@voyager>
	<alpine.DEB.2.21.1806151122070.2079@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806151122070.2079-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoffer Dall <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Fri, Jun 15, 2018 at 12:29:06PM +0200, Thomas Gleixner wrote:
> On Thu, 14 Jun 2018, Ricardo Neri wrote:
> > On Wed, Jun 13, 2018 at 11:48:09AM +0200, Thomas Gleixner wrote:
> > > On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > > > +	/* There are no CPUs to monitor. */
> > > > +	if (!cpumask_weight(&hdata->monitored_mask))
> > > > +		return NMI_HANDLED;
> > > > +
> > > >  	inspect_for_hardlockups(regs);
> > > >  
> > > > +	/*
> > > > +	 * Target a new CPU. Keep trying until we find a monitored CPU. CPUs
> > > > +	 * are addded and removed to this mask at cpu_up() and cpu_down(),
> > > > +	 * respectively. Thus, the interrupt should be able to be moved to
> > > > +	 * the next monitored CPU.
> > > > +	 */
> > > > +	spin_lock(&hld_data->lock);
> > > 
> > > Yuck. Taking a spinlock from NMI ...
> > 
> > I am sorry. I will look into other options for locking. Do you think rcu_lock
> > would help in this case? I need this locking because the CPUs being monitored
> > changes as CPUs come online and offline.
> 
> Sure, but you _cannot_ take any locks in NMI context which are also taken
> in !NMI context. And RCU will not help either. How so? The NMI can hit
> exactly before the CPU bit is cleared and then the CPU goes down. So RCU
> _cannot_ protect anything.
> 
> All you can do there is make sure that the TIMn_CONF is only ever accessed
> in !NMI code. Then you can stop the timer _before_ a CPU goes down and make
> sure that the eventually on the fly NMI is finished. After that you can
> fiddle with the CPU mask and restart the timer. Be aware that this is going
> to be more corner case handling that actual functionality.

Thanks for the suggestion. It makes sense to stop the timer when updating the
CPU mask. In this manner the timer will not cause any NMI.
> 
> > > > +	for_each_cpu_wrap(cpu, &hdata->monitored_mask, smp_processor_id() + 1) {
> > > > +		if (!irq_set_affinity(hld_data->irq, cpumask_of(cpu)))
> > > > +			break;
> > > 
> > > ... and then calling into generic interrupt code which will take even more
> > > locks is completely broken.
> > 
> > I will into reworking how the destination of the interrupt is set.
> 
> You have to consider two cases:
> 
>  1) !remapped mode:
> 
>     That's reasonably simple because you just have to deal with the HPET
>     TIMERn_PROCMSG_ROUT register. But then you need to do this directly and
>     not through any of the existing interrupt facilities.

Indeed, there is no need to use the generic interrupt faciities to set affinity;
I am dealing with an NMI anyways.
> 
>  2) remapped mode:
> 
>     That's way more complex as you _cannot_ ever do anything which touches
>     the IOMMU and the related tables.
> 
>     So you'd need to reserve an IOMMU remapping entry for each CPU upfront,
>     store the resulting value for the HPET TIMERn_PROCMSG_ROUT register in
>     per cpu storage and just modify that one from NMI.
> 
>     Though there might be subtle side effects involved, which are related to
>     the acknowledge part. You need to talk to the IOMMU wizards first.

I see. I will look into the code and prototype something that makes sense for
the IOMMU maintainers.

> 
> All in all, the idea itself is interesting, but the envisioned approach of
> round robin and no fast accessible NMI reason detection is going to create
> more problems than it solves.

I see it more clearly now.

Thanks and BR,
Ricardo
