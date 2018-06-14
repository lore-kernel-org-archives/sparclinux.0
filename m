From: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 14 Jun 2018 01:41:44 +0000
Subject: Re: [RFC PATCH 14/23] watchdog/hardlockup: Decouple the hardlockup detector from perf
Message-Id: <20180614114144.05891a04@roar.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<20180613084324.GU12258@hirez.programming.kicks-ass.net>
	<20180614011901.GA22652@voyager>
In-Reply-To: <20180614011901.GA22652@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Babu Moger <babu.moger-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>

On Wed, 13 Jun 2018 18:19:01 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> On Wed, Jun 13, 2018 at 10:43:24AM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 12, 2018 at 05:57:34PM -0700, Ricardo Neri wrote:  
> > > The current default implementation of the hardlockup detector assumes that
> > > it is implemented using perf events.  
> > 
> > The sparc and powerpc things are very much not using perf.  
> 
> Isn't it true that the current hardlockup detector
> (under kernel/watchdog_hld.c) is based on perf?

arch/powerpc/kernel/watchdog.c is a powerpc implementation that uses
the kernel/watchdog_hld.c framework.

> As far as I understand,
> this hardlockup detector is constructed using perf events for architectures
> that don't provide an NMI watchdog. Perhaps I can be more specific and say
> that this synthetized detector is based on perf.

The perf detector is like that, but we want NMI watchdogs to share
the watchdog_hld code as much as possible even for arch specific NMI
watchdogs, so that kernel and user interfaces and behaviour are
consistent.

Other arch watchdogs like sparc are a little older so they are not
using HLD. You don't have to change those for your series, but it
would be good to bring them into the fold if possible at some time.
IIRC sparc was slightly non-trivial because it has some differences
in sysctl or cmdline APIs that we don't want to break.

But powerpc at least needs to be updated if you change hld apis.

Thanks,
Nick
