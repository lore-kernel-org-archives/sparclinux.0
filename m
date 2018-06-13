From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 13 Jun 2018 09:07:20 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <20180613090720.GV12258@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-18-git-send-email-ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoffer Dall <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Byungchul Park <byungchul.park-ntMhUJTgEBQ@public.gmane.org>

On Tue, Jun 12, 2018 at 05:57:37PM -0700, Ricardo Neri wrote:

+static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
+{
+       unsigned long this_isr;
+       unsigned int lvl_trig;
+
+       this_isr = hpet_readl(HPET_STATUS) & BIT(hdata->num);
+
+       lvl_trig = hpet_readl(HPET_Tn_CFG(hdata->num)) & HPET_TN_LEVEL;
+
+       if (lvl_trig && this_isr)
+               return true;
+
+       return false;
+}

> +static int hardlockup_detector_nmi_handler(unsigned int val,
> +					   struct pt_regs *regs)
> +{
> +	struct hpet_hld_data *hdata = hld_data;
> +	unsigned int use_fsb;
> +
> +	/*
> +	 * If FSB delivery mode is used, the timer interrupt is programmed as
> +	 * edge-triggered and there is no need to check the ISR register.
> +	 */
> +	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;

Please do explain.. That FSB thing basically means MSI. But there's only
a single NMI vector. How do we know this NMI came from the HPET?

> +
> +	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))

So you add _2_ HPET reads for every single NMI that gets triggered...
and IIRC HPET reads are _sllooooowwwwww_.

> +		return NMI_DONE;
> +
> +	inspect_for_hardlockups(regs);
> +
> +	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> +		kick_timer(hdata);
> +
> +	/* Acknowledge interrupt if in level-triggered mode */
> +	if (!use_fsb)
> +		hpet_writel(BIT(hdata->num), HPET_STATUS);
> +
> +	return NMI_HANDLED;

So if I read this right, when in FSB/MSI mode, we'll basically _always_
claim every single NMI as handled?

That's broken.

> +}
