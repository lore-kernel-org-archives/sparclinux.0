From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 15 Jun 2018 02:16:29 +0000
Subject: Re: [RFC PATCH 20/23] watchdog/hardlockup/hpet: Rotate interrupt among all monitored CPUs
Message-Id: <20180615021629.GD11625@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1806131140560.2280@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806131140560.2280-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoffer Dall <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Wed, Jun 13, 2018 at 11:48:09AM +0200, Thomas Gleixner wrote:
> On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > +	/* There are no CPUs to monitor. */
> > +	if (!cpumask_weight(&hdata->monitored_mask))
> > +		return NMI_HANDLED;
> > +
> >  	inspect_for_hardlockups(regs);
> >  
> > +	/*
> > +	 * Target a new CPU. Keep trying until we find a monitored CPU. CPUs
> > +	 * are addded and removed to this mask at cpu_up() and cpu_down(),
> > +	 * respectively. Thus, the interrupt should be able to be moved to
> > +	 * the next monitored CPU.
> > +	 */
> > +	spin_lock(&hld_data->lock);
> 
> Yuck. Taking a spinlock from NMI ...

I am sorry. I will look into other options for locking. Do you think rcu_lock
would help in this case? I need this locking because the CPUs being monitored
changes as CPUs come online and offline.

> 
> > +	for_each_cpu_wrap(cpu, &hdata->monitored_mask, smp_processor_id() + 1) {
> > +		if (!irq_set_affinity(hld_data->irq, cpumask_of(cpu)))
> > +			break;
> 
> ... and then calling into generic interrupt code which will take even more
> locks is completely broken.


I will into reworking how the destination of the interrupt is set.

Thanks and BR,

Ricardo
