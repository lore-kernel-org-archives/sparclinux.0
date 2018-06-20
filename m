From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 20 Jun 2018 00:15:35 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <20180620001535.GA27531@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
	<20180615020314.GA11625@voyager>
	<alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
	<20180616005103.GC6659@voyager>
	<alpine.DEB.2.21.1806161517050.1582@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806161517050.1582-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoffer Dall <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Sat, Jun 16, 2018 at 03:24:49PM +0200, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Ricardo Neri wrote:
> > On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
> > > On Thu, 14 Jun 2018, Ricardo Neri wrote:
> > > > Alternatively, there could be a counter that skips reading the HPET status
> > > > register (and the detection of hardlockups) for every X NMIs. This would
> > > > reduce the overall frequency of HPET register reads.
> > > 
> > > Great plan. So if the watchdog is the only NMI (because perf is off) then
> > > you delay the watchdog detection by that count.
> > 
> > OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
> > register per NMI just to check in the status register if the HPET timer
> > caused the NMI?
> 
> The status register is useless in case of MSI. MSI is edge triggered ....
> 
> The only register which gives you proper information is the counter
> register itself. That adds an massive overhead to each NMI, because the
> counter register access is synchronized to the HPET clock with hardware
> magic. Plus on larger systems, the HPET access is cross node and even
> slower.

It starts to sound that the HPET is too slow to drive the hardlockup detector.

Would it be possible to envision a variant of this implementation? In this
variant, the HPET only targets a single CPU. The actual hardlockup detector
is implemented by this single CPU sending interprocessor interrupts to the
rest of the CPUs.

In this manner only one CPU has to deal with the slowness of the HPET; the
rest of the CPUs don't have to read or write any HPET registers. A sysfs
entry could be added to configure which CPU will have to deal with the HPET
timer. However, profiling could not be done accurately on such CPU.

Thanks and BR,
Ricardo
