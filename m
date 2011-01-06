From: daniel@gaisler.com
Date: Thu, 06 Jan 2011 16:51:58 +0000
Subject: Re: [PATCH] SPARC/LEON: Made sysclk and per-cpu ticker use
Message-Id: <20110106115158.dg4rlo9vnocsgw4c@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1294224160-7333-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294224160-7333-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



On Wed, 5 Jan 2011 20:09:07  0100, Sam Ravnborg  wrote:
On Wed, Jan 05, 2011 at 11:42:39AM  0100, Daniel Hellstrom wrote:
  > > This patch makes the per-cpu ticker share the timer with the=20
system clock,
  > > it will save HZ interrupts on the boot CPU and free one timer resourc=
e.=20
  > >
  > > The LEON SMP port requires only one timer from now on.=20
  >
  > Looks good as far as I could review it.=20
  >
  > I'm reluctant to give it an "Acked-by" / "Reviewed-by"
  > as I am not confident enough with this code to do so.=20
  >
  > One little nit below..=20
  >
  >  Sam
  >
  >
  > >
  > > Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
  > > ---
  > >  arch/sparc/include/asm/leon.h      |    2  -
  > >  arch/sparc/include/asm/leon_amba.h |    3  -
  > >  arch/sparc/kernel/entry.S          |    3  -
  > >  arch/sparc/kernel/leon_kernel.c    |   45        =20
----------------------------
  > >  arch/sparc/kernel/leon_smp.c       |    9       -
  > >  5 files changed, 23 insertions( ), 39 deletions(-)
  > >
  > > diff --git a/arch/sparc/include/asm/leon.h=20
b/arch/sparc/include/asm/leon.h
  > > index 8580d17..b9df4a9 100644
  > > --- a/arch/sparc/include/asm/leon.h
  > >     b/arch/sparc/include/asm/leon.h
  > > @@ -240,7  240,7 @@ static inline int sparc_leon3_cpuid(void)
  > >
  > >  #ifdef CONFIG_SMP
  > >  # define LEON3_IRQ_RESCHEDULE 13
  > > -# define LEON3_IRQ_TICKER (leon_percpu_timer_dev[0].irq)
  > >  # define LEON3_IRQ_TICKER (leon3_gptimer_irq   leon3_gptimer_idx)
  > >  # define LEON3_IRQ_CROSS_CALL 15
  > >  #endif
  > >
  > > diff --git a/arch/sparc/include/asm/leon_amba.h=20
b/arch/sparc/include/asm/leon_amba.h
  > > index 263c719..db3f408 100644
  > > --- a/arch/sparc/include/asm/leon_amba.h
  > >     b/arch/sparc/include/asm/leon_amba.h
  > > @@ -182,11  182,12 @@ void _amba_init(struct device_node *dp,=20
struct device_node ***nextp);
  > >
  > >  extern struct leon3_irqctrl_regs_map *leon3_irqctrl_regs;
  > >  extern struct leon3_gptimer_regs_map *leon3_gptimer_regs;
  > > -extern struct amba_apb_device leon_percpu_timer_dev[16];
  > >  extern int leondebug_irq_disable;
  > >  extern int leon_debug_irqout;
  > >  extern unsigned long leon3_gptimer_irq;
  > >  extern unsigned long leon3_gptimer_idx; /*Timer Index (0..6)=20
within Timer Core*/
  > >  extern unsigned int sparc_leon_eirq;
  > >  extern unsigned long leon3_cpu_idx;
  > >
  > >  #endif /* __ASSEMBLY__ */
  > >
  > > diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
  > > index 1504df8..d34c180 100644
  > > --- a/arch/sparc/kernel/entry.S
  > >     b/arch/sparc/kernel/entry.S
  > > @@ -411,8  411,9 @@ smpleon_ticker:
  > >   WRITE_PAUSE
  > >   wr %g2, PSR_ET, %psr
  > >   WRITE_PAUSE
  > >   mov %l7, %o0 ! irq level
  >
  > I am about to rename this argument to pil as this is the content
  > of the PIL of PSR we pass here.=20
  > irq will be an more opauge number.=20
  >
  > But all other places in SPARC32 name it irq today.=20
  > So I can also rename it here when I get to it.=20
  >
  > (Comment about naming also apply for the C code.=20

Ok, good point, will think of that in the future,
  =C2=A0
  Thanks,
  Daniel

