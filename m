From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 14 Jun 2018 00:58:39 +0000
Subject: Re: [RFC PATCH 22/23] watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot parameter
Message-Id: <20180614005839.GA22358@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
In-Reply-To: <c2edf778-79cf-009d-6617-13e54ad8b93b-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoffer Dall <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Tue, Jun 12, 2018 at 10:26:57PM -0700, Randy Dunlap wrote:
> On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2040d4..a8833c7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2577,7 +2577,7 @@
> >  			Format: [state][,regs][,debounce][,die]
> >  
> >  	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
> > -			Format: [panic,][nopanic,][num]
> > +			Format: [panic,][nopanic,][num,][hpet]
> >  			Valid num: 0 or 1
> >  			0 - turn hardlockup detector in nmi_watchdog off
> >  			1 - turn hardlockup detector in nmi_watchdog on
> 
> This says that I can use "nmi_watchdog=hpet" without using 0 or 1.
> Is that correct?

Yes, this what I meant. In my view, if you set nmi_watchdog=hpet it
implies that you want to activate the NMI watchdog. In this case, perf.

I can see how this will be ambiguous for the case of perf and arch NMI
watchdogs.

Alternative, a new parameter could be added; such as nmi_watchdog_type. I
didn't want to add it in this patchset as I think that a single parameter
can handle the enablement and type of the NMI watchdog.

What do you think?

Thanks and BR,
Ricardo
