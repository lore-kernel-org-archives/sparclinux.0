From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 19 Apr 2011 18:47:42 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <20110419184742.GF20041@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 19, 2011 at 06:07:18PM +0200, Daniel Hellstrom wrote:
> Each CPU has a separate set of IRQ controller registers, this
> patch makes sure that the boot-cpu registers are used instead
> of CPU0's. Note that there are other parts of the SPARC32/LEON
> port which does not support booting on other than CPU0 anyway,
> however this this cleans up the IRQ controller layer in that
> regard.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  arch/sparc/include/asm/leon.h   |    1 +
>  arch/sparc/kernel/leon_kernel.c |   14 ++++++++------
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
> index 31fb2ac..1776f71 100644
> --- a/arch/sparc/include/asm/leon.h
> +++ b/arch/sparc/include/asm/leon.h
> @@ -335,6 +335,7 @@ extern int leon_flush_needed(void);
>  extern void leon_switch_mm(void);
>  extern int srmmu_swprobe_trace;
>  extern int leon3_ticker_irq;
> +extern int leon3_boot_cpu;

We already have boot_cpu_id - defiend in smp_32.c.
Could it be used rather than a leon specific variable?

We would need to define boot_cpu_id also in the non-SMP case
to do so - but this could also clean up code
in sun4d_irq.

Note: leon actually set this variable in head_32.S already.

	Sam
