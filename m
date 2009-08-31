From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 31 Aug 2009 23:53:53 +0000
Subject: Re: [PATCH 1/1] sparc,leon: Sparc-Leon SMP support
Message-Id: <646765f40908311653k15be74d0s242667e9606fcd3b@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1251726441-1032-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1251726441-1032-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Konrad,

A couple of things that stood out from a quick read over the code.

On Mon, Aug 31, 2009 at 23:47, <konrad@gaisler.com> wrote:
> From: Konrad Eisele <konrad@gaisler.com>
>
> Support SMP for a Sparc-Leon multiprocessor system.
> Add Leon specific SMP code to arch/sparc/kernel/leon_smp.c.
>
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
> ---
> =A0arch/sparc/include/asm/leon.h =A0 =A0 =A0| =A0 28 +++
> =A0arch/sparc/include/asm/leon_amba.h | =A0 =A03 +
> =A0arch/sparc/include/asm/smp_32.h =A0 =A0| =A0 =A09 +
> =A0arch/sparc/kernel/Makefile =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/sparc/kernel/entry.S =A0 =A0 =A0 =A0 =A0| =A0 33 +++
> =A0arch/sparc/kernel/head_32.S =A0 =A0 =A0 =A0| =A0 22 ++
> =A0arch/sparc/kernel/ioport.c =A0 =A0 =A0 =A0 | =A0 =A05 +
> =A0arch/sparc/kernel/leon_kernel.c =A0 =A0| =A0 94 +++++++
> =A0arch/sparc/kernel/leon_smp.c =A0 =A0 =A0 | =A0468 ++++++++++++++++++++=
++++++++++++++++
> =A0arch/sparc/kernel/smp_32.c =A0 =A0 =A0 =A0 | =A0 10 +
> =A0arch/sparc/kernel/trampoline_32.S =A0| =A0 69 ++++++-
> =A0arch/sparc/mm/srmmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +-
> =A012 files changed, 745 insertions(+), 3 deletions(-)
> =A0create mode 100644 arch/sparc/kernel/leon_smp.c
>
> diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/=
leon_amba.h
> index 618e888..57d2eae 100644
> --- a/arch/sparc/include/asm/leon_amba.h
> +++ b/arch/sparc/include/asm/leon_amba.h
> @@ -188,6 +188,9 @@ extern int leon_debug_irqout;
> =A0extern unsigned long leon3_gptimer_irq;
> =A0extern unsigned int sparc_leon_eirq;
>
> +int amba_get_free_apbslv_devices(int vendor, int device, struct amba_apb=
_device *dev, int nr);
> +
> +
> =A0#endif /* __ASSEMBLY__ */
>
> =A0#define LEON3_IO_AREA 0xfff00000

Should this be in a different patch? it doesn't seem to be related to
the SMP changes.

> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_ker=
nel.c
> index 54d8a5b..ab449b4 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -12,15 +12,20 @@
> =A0#include <linux/of_platform.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/of_device.h>
> +
> =A0#include <asm/oplib.h>
> =A0#include <asm/timer.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/leon.h>
> =A0#include <asm/leon_amba.h>
> +#include <asm/traps.h>
> +#include <asm/cacheflush.h>
>
> =A0#include "prom.h"
> =A0#include "irq.h"
>
> +#define CONFIG_LEONSMP_USETIMER2
> +

Should this be a KConfig symbol?

> =A0struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt contro=
ller base address, initialized by amba_init() */
> =A0struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller=
 base address, initialized by amba_init() */
> =A0struct amba_apb_device leon_percpu_timer_dev[16];
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 509b1ff..d55c255 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -2301,7 +2301,8 @@ void __init ld_mmu_srmmu(void)
> =A0 =A0 =A0 =A0BTFIXUPSET_CALL(flush_cache_mm, smp_flush_cache_mm, BTFIXU=
PCALL_NORM);
> =A0 =A0 =A0 =A0BTFIXUPSET_CALL(flush_cache_range, smp_flush_cache_range, =
BTFIXUPCALL_NORM);
> =A0 =A0 =A0 =A0BTFIXUPSET_CALL(flush_cache_page, smp_flush_cache_page, BT=
FIXUPCALL_NORM);
> - =A0 =A0 =A0 if (sparc_cpu_model !=3D sun4d) {
> + =A0 =A0 =A0 if (sparc_cpu_model !=3D sun4d &&
> + =A0 =A0 =A0 =A0 =A0 sparc_cpu_model !=3D sparc_leon) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTFIXUPSET_CALL(flush_tlb_all, smp_flush_t=
lb_all, BTFIXUPCALL_NORM);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTFIXUPSET_CALL(flush_tlb_mm, smp_flush_tl=
b_mm, BTFIXUPCALL_NORM);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTFIXUPSET_CALL(flush_tlb_range, smp_flush=
_tlb_range, BTFIXUPCALL_NORM);

Again, doesn't seem SMP related.

Other than those small issues, on a first read-through, this seems
like a good patch.

Good work!

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
