From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 01 Sep 2009 06:54:10 +0000
Subject: Re: [PATCH 1/1] sparc,leon: Sparc-Leon SMP support
Message-Id: <4A9CC512.8020601@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1251726441-1032-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1251726441-1032-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Julian Calaby wrote:
> Konrad,
> 
> A couple of things that stood out from a quick read over the code.
> 
> On Mon, Aug 31, 2009 at 23:47, <konrad@gaisler.com> wrote:
>> From: Konrad Eisele <konrad@gaisler.com>
>>
>> Support SMP for a Sparc-Leon multiprocessor system.
>> Add Leon specific SMP code to arch/sparc/kernel/leon_smp.c.
>>
>> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
>> ---
>>  arch/sparc/include/asm/leon.h      |   28 +++
>>  arch/sparc/include/asm/leon_amba.h |    3 +
>>  arch/sparc/include/asm/smp_32.h    |    9 +
>>  arch/sparc/kernel/Makefile         |    2 +-
>>  arch/sparc/kernel/entry.S          |   33 +++
>>  arch/sparc/kernel/head_32.S        |   22 ++
>>  arch/sparc/kernel/ioport.c         |    5 +
>>  arch/sparc/kernel/leon_kernel.c    |   94 +++++++
>>  arch/sparc/kernel/leon_smp.c       |  468 ++++++++++++++++++++++++++++++++++++
>>  arch/sparc/kernel/smp_32.c         |   10 +
>>  arch/sparc/kernel/trampoline_32.S  |   69 ++++++-
>>  arch/sparc/mm/srmmu.c              |    5 +-
>>  12 files changed, 745 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/sparc/kernel/leon_smp.c
>>
>> diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
>> index 618e888..57d2eae 100644
>> --- a/arch/sparc/include/asm/leon_amba.h
>> +++ b/arch/sparc/include/asm/leon_amba.h
>> @@ -188,6 +188,9 @@ extern int leon_debug_irqout;
>>  extern unsigned long leon3_gptimer_irq;
>>  extern unsigned int sparc_leon_eirq;
>>
>> +int amba_get_free_apbslv_devices(int vendor, int device, struct amba_apb_device *dev, int nr);
>> +
>> +

I'll remove it. It is not used by the patch. It was related to a
cleanup the I did in conjunction with the CONFIG_LEONSMP_USETIMER2 define
below.

>>  #endif /* __ASSEMBLY__ */
>>
>>  #define LEON3_IO_AREA 0xfff00000
> 
> Should this be in a different patch? it doesn't seem to be related to
> the SMP changes.
> 
>> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
>> index 54d8a5b..ab449b4 100644
>> --- a/arch/sparc/kernel/leon_kernel.c
>> +++ b/arch/sparc/kernel/leon_kernel.c
>> @@ -12,15 +12,20 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/of_device.h>
>> +
>>  #include <asm/oplib.h>
>>  #include <asm/timer.h>
>>  #include <asm/prom.h>
>>  #include <asm/leon.h>
>>  #include <asm/leon_amba.h>
>> +#include <asm/traps.h>
>> +#include <asm/cacheflush.h>
>>
>>  #include "prom.h"
>>  #include "irq.h"
>>
>> +#define CONFIG_LEONSMP_USETIMER2
>> +
> 
> Should this be a KConfig symbol?

Yes, but I tool it out of Kconfig to make the patch smaller. I'll remove this and the
dependent part.

> 
>>  struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address, initialized by amba_init() */
>>  struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address, initialized by amba_init() */
>>  struct amba_apb_device leon_percpu_timer_dev[16];
>> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
>> index 509b1ff..d55c255 100644
>> --- a/arch/sparc/mm/srmmu.c
>> +++ b/arch/sparc/mm/srmmu.c
>> @@ -2301,7 +2301,8 @@ void __init ld_mmu_srmmu(void)
>>        BTFIXUPSET_CALL(flush_cache_mm, smp_flush_cache_mm, BTFIXUPCALL_NORM);
>>        BTFIXUPSET_CALL(flush_cache_range, smp_flush_cache_range, BTFIXUPCALL_NORM);
>>        BTFIXUPSET_CALL(flush_cache_page, smp_flush_cache_page, BTFIXUPCALL_NORM);
>> -       if (sparc_cpu_model != sun4d) {
>> +       if (sparc_cpu_model != sun4d &&
>> +           sparc_cpu_model != sparc_leon) {
>>                BTFIXUPSET_CALL(flush_tlb_all, smp_flush_tlb_all, BTFIXUPCALL_NORM);
>>                BTFIXUPSET_CALL(flush_tlb_mm, smp_flush_tlb_mm, BTFIXUPCALL_NORM);
>>                BTFIXUPSET_CALL(flush_tlb_range, smp_flush_tlb_range, BTFIXUPCALL_NORM);
> 
> Again, doesn't seem SMP related.

This is in srmmu.c inside a CONFIG_SMP section:
#ifdef CONFIG_SMP
	/* El switcheroo... */
   ...
 >> +       if (sparc_cpu_model != sun4d &&
 >> +           sparc_cpu_model != sparc_leon) {
   ...
#endif

> 
> Other than those small issues, on a first read-through, this seems
> like a good patch.
> 
> Good work!
> 
> Thanks,
> 

