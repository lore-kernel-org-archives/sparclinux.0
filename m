From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 15 Jun 2018 09:19:09 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com> <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de> <20180615020314.GA11625@voyager>
In-Reply-To: <20180615020314.GA11625@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Thu, 14 Jun 2018, Ricardo Neri wrote:
> On Wed, Jun 13, 2018 at 11:40:00AM +0200, Thomas Gleixner wrote:
> > On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > > @@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
> > >  	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > >  		kick_timer(hdata);
> > >  
> > > +	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");
> > 
> > Eeew.
> 
> If you don't mind me asking. What is the problem with this error message?

The problem is not the error message. The problem is the abuse of
request_irq() and the fact that this irq handler function exists in the
first place for something which is NMI based.

> > And in case that the HPET does not support periodic mode this reprogramms
> > the timer on every NMI which means that while perf is running the watchdog
> > will never ever detect anything.
> 
> Yes. I see that this is wrong. With MSI interrupts, as far as I can
> see, there is not a way to make sure that the HPET timer caused the NMI
> perhaps the only option is to use an IO APIC interrupt and read the
> interrupt status register.
> 
> > Aside of that, reading TWO HPET registers for every NMI is insane. HPET
> > access is horribly slow, so any high frequency perf monitoring will take a
> > massive performance hit.
> 
> If an IO APIC interrupt is used, only HPET register (the status register)
> would need to be read for every NMI. Would that be more acceptable? Otherwise,
> there is no way to determine if the HPET cause the NMI.

You need level trigger for the HPET status register to be useful at all
because in edge mode the interrupt status bits read always 0.

That means you have to fiddle with the IOAPIC acknowledge magic from NMI
context. Brilliant idea. If the NMI hits in the middle of a regular
io_apic_read() then the interrupted code will endup with the wrong index
register. Not to talk about the fun which the affinity rotation from NMI
context would bring.

Do not even think about using IOAPIC and level for this.

> Alternatively, there could be a counter that skips reading the HPET status
> register (and the detection of hardlockups) for every X NMIs. This would
> reduce the overall frequency of HPET register reads.

Great plan. So if the watchdog is the only NMI (because perf is off) then
you delay the watchdog detection by that count.

You neither can do a time based check, because time might be corrupted and
then you end up in lala land as well.

Thanks,

	tglx
