From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 13 Jun 2018 08:34:19 +0000
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-Id: <20180613083419.GS12258@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-4-git-send-email-ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Levin,
	Alexander (Sasha Levin)" <alexander.levin-H+0wwilmMs1BDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 5426627..dbc5e02 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -61,6 +61,8 @@
>   *                interrupt handler after suspending interrupts. For system
>   *                wakeup devices users need to implement wakeup detection in
>   *                their interrupt handlers.
> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as non-maskable, if
> + *                supported by the chip.
>   */

NAK on the first 6 patches. You really _REALLY_ don't want to expose
NMIs to this level.
