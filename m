From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 21 Jun 2018 00:25:18 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <20180621002518.GA16266@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
 <20180615020314.GA11625@voyager>
 <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
 <20180616005103.GC6659@voyager>
 <alpine.DEB.2.21.1806161517050.1582@nanos.tec.linutronix.de>
 <20180620001535.GA27531@voyager>
 <c040d4e7-f33b-9c93-6f5a-6bf960943e36@infradead.org>
In-Reply-To: <c040d4e7-f33b-9c93-6f5a-6bf960943e36@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami

On Tue, Jun 19, 2018 at 05:25:09PM -0700, Randy Dunlap wrote:
> On 06/19/2018 05:15 PM, Ricardo Neri wrote:
> > On Sat, Jun 16, 2018 at 03:24:49PM +0200, Thomas Gleixner wrote:
> >> On Fri, 15 Jun 2018, Ricardo Neri wrote:
> >>> On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
> >>>> On Thu, 14 Jun 2018, Ricardo Neri wrote:
> >>>>> Alternatively, there could be a counter that skips reading the HPET status
> >>>>> register (and the detection of hardlockups) for every X NMIs. This would
> >>>>> reduce the overall frequency of HPET register reads.
> >>>>
> >>>> Great plan. So if the watchdog is the only NMI (because perf is off) then
> >>>> you delay the watchdog detection by that count.
> >>>
> >>> OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
> >>> register per NMI just to check in the status register if the HPET timer
> >>> caused the NMI?
> >>
> >> The status register is useless in case of MSI. MSI is edge triggered ....
> >>
> >> The only register which gives you proper information is the counter
> >> register itself. That adds an massive overhead to each NMI, because the
> >> counter register access is synchronized to the HPET clock with hardware
> >> magic. Plus on larger systems, the HPET access is cross node and even
> >> slower.
> > 
> > It starts to sound that the HPET is too slow to drive the hardlockup detector.
> > 
> > Would it be possible to envision a variant of this implementation? In this
> > variant, the HPET only targets a single CPU. The actual hardlockup detector
> > is implemented by this single CPU sending interprocessor interrupts to the
> > rest of the CPUs.
> > 
> > In this manner only one CPU has to deal with the slowness of the HPET; the
> > rest of the CPUs don't have to read or write any HPET registers. A sysfs
> > entry could be added to configure which CPU will have to deal with the HPET
> > timer. However, profiling could not be done accurately on such CPU.
> 
> Please forgive my simple question:
> 
> What happens when this one CPU is the one that locks up?

I think that in this particular case this one CPU would check for hardlockups
on itself when it receives the NMI from the HPET timer. It would also issue
NMIs to the other monitored processors.

Thanks and BR,
Ricardo
