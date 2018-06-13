From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 13 Jun 2018 05:23:47 +0000
Subject: Re: [RFC PATCH 16/23] watchdog/hardlockup: Add an HPET-based hardlockup detector
Message-Id: <1e5bc136-4123-328a-2d2e-e6f2faef5bf4@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-17-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-17-git-send-email-ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoffer Dall <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Byungchul Park <byungchul.park-Hm3cg6mZ9cc@public.gmane.org>, Mathieu Desnoyers <math>

Hi,

On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c40c7b7..6e79833 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -828,6 +828,16 @@ config HARDLOCKUP_DETECTOR_PERF
>  	bool
>  	select SOFTLOCKUP_DETECTOR
>  
> +config HARDLOCKUP_DETECTOR_HPET
> +	bool "Use HPET Timer for Hard Lockup Detection"
> +	select SOFTLOCKUP_DETECTOR
> +	select HARDLOCKUP_DETECTOR
> +	depends on HPET_TIMER && HPET
> +	help
> +	  Say y to enable a hardlockup detector that is driven by an High-Precision
> +	  Event Timer. In addition to selecting this option, the command-line
> +	  parameter nmi_watchdog option. See Documentation/admin-guide/kernel-parameters.rst

The "In addition ..." thing is a broken (incomplete) sentence.

> +
>  #
>  # Enables a timestamp based low pass filter to compensate for perf based
>  # hard lockup detection which runs too fast due to turbo modes.


-- 
~Randy
