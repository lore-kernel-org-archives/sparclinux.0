From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 13 Jun 2018 08:42:19 +0000
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI watchdog operations
Message-Id: <20180613084219.GT12258@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<20180613174141.539fc6c1@roar.ozlabs.ibm.com>
In-Reply-To: <20180613174141.539fc6c1-a5aMA/AkCkgK5Ils6ZIQy0EOCMrvLtNR@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Babu Moger <babu.moger-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Philippe Ombredanne <pombredan>

On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:
> On Tue, 12 Jun 2018 17:57:32 -0700
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > Instead of exposing individual functions for the operations of the NMI
> > watchdog, define a common interface that can be used across multiple
> > implementations.
> > 
> > The struct nmi_watchdog_ops is defined for such operations. These initial
> > definitions include the enable, disable, start, stop, and cleanup
> > operations.
> > 
> > Only a single NMI watchdog can be used in the system. The operations of
> > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > variable is set to point the operations of the first NMI watchdog that
> > initializes successfully. Even though at this moment, the only available
> > NMI watchdog is the perf-based hardlockup detector. More implementations
> > can be added in the future.
> 
> Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> least have their own NMI watchdogs, it would be good to have those
> converted as well.

Yeah, agreed, this looks like half a patch.

> Is hpet a cross platform thing, or just x86? We should avoid
> proliferation of files under kernel/ I think, so with these watchdog
> driver structs then maybe implementations could go in drivers/ or
> arch/

HPET is mostly an x86 thing (altough it can be found elsewhere), but the
whole thing relies on the x86 NMI mechanism and is thus firmly arch/
material (like the sparc and ppc thing).
