From: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 14 Jun 2018 02:32:50 +0000
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI watchdog operations
Message-Id: <20180614123250.230667f6@roar.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<20180613174141.539fc6c1@roar.ozlabs.ibm.com>
	<20180613084219.GT12258@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
	<20180613215225.2a938abc@roar.ozlabs.ibm.com>
	<20180614013117.GC22652@voyager>
In-Reply-To: <20180614013117.GC22652@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Babu Moger <babu.moger-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>

On Wed, 13 Jun 2018 18:31:17 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> On Wed, Jun 13, 2018 at 09:52:25PM +1000, Nicholas Piggin wrote:
> > On Wed, 13 Jun 2018 11:26:49 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >   
> > > On Wed, 13 Jun 2018, Peter Zijlstra wrote:  
> > > > On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:    
> > > > > On Tue, 12 Jun 2018 17:57:32 -0700
> > > > > Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > > > >     
> > > > > > Instead of exposing individual functions for the operations of the NMI
> > > > > > watchdog, define a common interface that can be used across multiple
> > > > > > implementations.
> > > > > > 
> > > > > > The struct nmi_watchdog_ops is defined for such operations. These initial
> > > > > > definitions include the enable, disable, start, stop, and cleanup
> > > > > > operations.
> > > > > > 
> > > > > > Only a single NMI watchdog can be used in the system. The operations of
> > > > > > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > > > > > variable is set to point the operations of the first NMI watchdog that
> > > > > > initializes successfully. Even though at this moment, the only available
> > > > > > NMI watchdog is the perf-based hardlockup detector. More implementations
> > > > > > can be added in the future.    
> > > > > 
> > > > > Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> > > > > least have their own NMI watchdogs, it would be good to have those
> > > > > converted as well.    
> > > > 
> > > > Yeah, agreed, this looks like half a patch.    
> > > 
> > > Though I'm not seeing the advantage of it. That kind of NMI watchdogs are
> > > low level architecture details so having yet another 'ops' data structure
> > > with a gazillion of callbacks, checks and indirections does not provide
> > > value over the currently available weak stubs.  
> > 
> > The other way to go of course is librify the perf watchdog and make an
> > x86 watchdog that selects between perf and hpet... I also probably
> > prefer that for code such as this, but I wouldn't strongly object to
> > ops struct if I'm not writing the code. It's not that bad is it?  
> 
> My motivation to add the ops was that the hpet and perf watchdog share
> significant portions of code.

Right, a good motivation.

> I could look into creating the library for
> common code and relocate the hpet watchdog into arch/x86 for the hpet-
> specific parts.

If you can investigate that approach, that would be appreciated. I hope
I did not misunderstand you there, Thomas.

Basically you would have perf infrastructure and hpet infrastructure,
and then the x86 watchdog driver will use one or the other of those. The
generic watchdog driver will be just a simple shim that uses the perf
infrastructure. Then hopefully the powerpc driver would require almost
no change.

Thanks,
Nick
