From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 17 Jun 2013 06:13:41 +0000
Subject: Re: [PATCH] sparc32, leon: Enable interrupts before going idle to avoid getting stuck
Message-Id: <51BEA915.3000304@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1370847401-766-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1370847401-766-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2013-06-10 08:56, Andreas Larsson wrote:
> This enables interrupts for Leon before having the CPU enter power-down mode.
>
> Commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092, "sparc: Use generic idle loop",
> gets the CPU stuck on idle for Leon systems. On Leon, disabling interrupts and
> powering down the processor will get the processor stuck waiting for an
> interrupt that will never be reacted to.

Anything stopping this from going into v3.10-rc7? The issue is critical. 
Commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092 outright breaks the 
kernel for Leon systems.

Best Regards,
Andreas Larsson


>
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>
> I assume that going idle with interrupts disabled is the right thing to
> do for the other users of the sparc_idle function pointer. Otherwise,
> the right way to go is probably to enable interrupts in the 32-bit
> arch_cpu_idle before calling the idle function instead.
>
>   arch/sparc/kernel/leon_pmc.c |    7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
> index bdf53d9..b0b3967 100644
> --- a/arch/sparc/kernel/leon_pmc.c
> +++ b/arch/sparc/kernel/leon_pmc.c
> @@ -47,6 +47,10 @@ void pmc_leon_idle_fixup(void)
>   	 * MMU does not get a TLB miss here by using the MMU BYPASS ASI.
>   	 */
>   	register unsigned int address = (unsigned int)leon3_irqctrl_regs;
> +
> +	/* Interrupts need to be enabled to not hang the CPU */
> +	local_irq_enable();
> +
>   	__asm__ __volatile__ (
>   		"wr	%%g0, %%asr19\n"
>   		"lda	[%0] %1, %%g0\n"
> @@ -60,6 +64,9 @@ void pmc_leon_idle_fixup(void)
>    */
>   void pmc_leon_idle(void)
>   {
> +	/* Interrupts need to be enabled to not hang the CPU */
> +	local_irq_enable();
> +
>   	/* For systems without power-down, this will be no-op */
>   	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
>   }
>

