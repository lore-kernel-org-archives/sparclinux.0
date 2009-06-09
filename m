From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 09 Jun 2009 20:02:18 +0000
Subject: Re: [PATCH 1/7] CONFIG_LEON option
Message-Id: <20090609200218.GG7181@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45CF.8070106@gaisler.com>
In-Reply-To: <4A2E45CF.8070106@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 09, 2009 at 01:21:51PM +0200, Konrad Eisele wrote:
> From f34daa99d7a0f397a5314142abf951ef8305dfea Mon Sep 17 00:00:00 2001
> From: Konrad Eisele <konrad@gaisler.com>
> Date: Tue, 9 Jun 2009 12:50:43 +0200
> Subject: [PATCH 1/7] CONFIG_LEON option
> This macro will shield, if undefined, the sun-sparc code
> from LEON specific code. In particular include/asm/leon.h
> will get empty through #ifdef arch/sparc/kernel/leon.c not
> compiled through Makefile:obj-$(CONFIG_LEON)
> arch/sparc/mm/leon.c not compiled through Makefile:obj-$(CONFIG_LEON)
> 
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>

Hi Konrad.

I will give you some quick first comments as I'm busy.

Note that the patch is wordwrapped - so it cannot be applied as is.
Please look at using git send-email.
Also this mail contained two copies of the patch..

Try it out with --dry-run + --no-cc (or something like that).
Then you can see how it works.

> 
> +config LEON
> +	bool "Leon processor family"
> +	depends on SPARC32
> +	---help---
> +	  If you say Y here if you are running on a LEON processor.

I would have preferred SPARC_LEON here - but no strong opinion on that.
Rationale is that LEON is a specialzation of a sparc.

>  menu "Bus options (PCI etc.)"
> diff --git a/arch/sparc/configs/sparc32_defconfig 
> b/arch/sparc/configs/sparc32_defconfig
> index 09ab46e..3556a60 100644
> --- a/arch/sparc/configs/sparc32_defconfig
> +++ b/arch/sparc/configs/sparc32_defconfig
> @@ -147,6 +147,7 @@ CONFIG_UNEVICTABLE_LRU=y
>  CONFIG_SUN_PM=y
>  # CONFIG_SPARC_LED is not set
>  CONFIG_SERIAL_CONSOLE=y
> +# CONFIG_LEON is not set
> 
>  #
>  # Bus options (PCI etc.)

defconfig updates like this is not needed.
The default is n so that would be picked up anyway.

But please consider introducing a sparc_leon_defconfig that can
be used by build monkeys to build a leon kernel.

> diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
> new file mode 100644
> index 0000000..b440994
> --- /dev/null
> +++ b/arch/sparc/include/asm/leon.h
> @@ -0,0 +1,678 @@
> +/*
> +*Copyright (C) 2004 Konrad Eisele (eiselekd@web.de,
> +*konrad@gaisler.com), Gaisler Research
> +*Copyright (C) 2004 Stefan Holst (mail@s-holst.de), Uni-Stuttgart
> +*Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
> +*Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB
> +*/
> +
> +#ifndef LEON_H_INCLUDE
> +#define LEON_H_INCLUDE
> +
> +#if defined(CONFIG_LEON)

We usually use the shorter:
#ifdef CONFIG_LEON
is there is only one symbol to check.

> +
> +#define ASI_LEON_NOCACHE	0x01
> +
> +#define ASI_LEON_DCACHE_MISS	0x1
> +
> +#define ASI_LEON_CACHEREGS 0x02
> +#define ASI_LEON_IFLUSH		0x10
> +#define ASI_LEON_DFLUSH		0x11
> +
> +#define ASI_LEON_MMUFLUSH	0x18
> +#define ASI_LEON_MMUREGS	0x19
> +#define ASI_LEON_BYPASS		0x1c
> +#define ASI_LEON_FLUSH_PAGE	0x10
> +

> +#define LEON_TYPEDEF typedef
> +#define LEON_VOLATILE volatile
This obscufation shall die.

Also you really need to revisit all the abuses of volatile.
Please read: Documentation/volatile-considered-harmful.txt


> +/*
> +constant ASI_SYSR    : asi_type := "00010"; -- 0x02
> +constant ASI_UINST   : asi_type := "01000"; -- 0x08
> +constant ASI_SINST   : asi_type := "01001"; -- 0x09
> +constant ASI_UDATA   : asi_type := "01010"; -- 0x0A
> +constant ASI_SDATA   : asi_type := "01011"; -- 0x0B
> +constant ASI_ITAG    : asi_type := "01100"; -- 0x0C
> +constant ASI_IDATA   : asi_type := "01101"; -- 0x0D
> +constant ASI_DTAG    : asi_type := "01110"; -- 0x0E
> +constant ASI_DDATA   : asi_type := "01111"; -- 0x0F
> +constant ASI_IFLUSH  : asi_type := "10000"; -- 0x10
> +constant ASI_DFLUSH  : asi_type := "10001"; -- 0x11
> +
> +constant ASI_FLUSH_PAGE     : std_logic_vector(4 downto 0) := "10000";
> +constant ASI_FLUSH_CTX      : std_logic_vector(4 downto 0) := "10011";
> +
> +constant ASI_DCTX           : std_logic_vector(4 downto 0) := "10100";
> +constant ASI_ICTX           : std_logic_vector(4 downto 0) := "10101";
> +
> +constant ASI_MMUFLUSHPROBE  : std_logic_vector(4 downto 0) := "11000";
> +constant ASI_MMUREGS        : std_logic_vector(4 downto 0) := "11001";
> +constant ASI_MMU_BP         : std_logic_vector(4 downto 0) := "11100";
> +constant ASI_MMU_DIAG       : std_logic_vector(4 downto 0) := "11101";
> +constant ASI_MMU_DSU        : std_logic_vector(4 downto 0) := "11111";
> +*/
This comment block confuses me. Looks like some VHDL sneaked in.
Could you update the proper definitons one-by-one?

> +
> +#ifdef CONFIG_OPEN_ETH
> +#define LEON_ETH_BASE_ADD ((unsigned long)LEON_VA_ETHERMAC)
> +/* map leon on ethermac adress space at pa 0xb0000000 */
> +#define LEON_VA_ETHERMAC     DVMA_VADDR
> +#endif
At best this looks like some leon specific driver thing?


> +
> +#ifndef __ASSEMBLY__
> +
> +/* do a virtual address read without cache */
> +static inline unsigned long leon_readnobuffer_reg(unsigned long paddr)
> +{
> +	unsigned long retval;
> +	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
> +			     "=r"(retval) : "r"(paddr), 
> "i"(ASI_LEON_NOCACHE));
> +	return retval;
> +}

Here volatile is OK.
[But I do not claim I understand the assembler stuff].

> +
> +#define HARDDBG_PRINTF(fmt, arg...) do {		\
> +		char b[1000];				\
> +		sprintf(b, fmt, ## arg);		\
> +		console_print_LEON(b); } while (0)
> +#define HARDDBG_FUNC  \
> +	HARDDBG_PRINTF("[->%03d @ %22s()]:\n" , __LINE__, __func__);
> +#define HARDDBG_FUNCOUT \
> +	HARDDBG_PRINTF("[<-%03d @ %22s()]:\n" , __LINE__, __func__);
> +#define HARDDBG_OUT(fmt, arg...) \
> +	HARDDBG_PRINTF("[->%03d @ %22s()]:" fmt , __LINE__, __func__, ## 
> arg);
Rest of sparc does not have such stuff.
Why do leon need it?

> +#if 1

Not needed.

> +#ifndef __ASSEMBLER__
> +
A lot of what follows could be used from assebler with no problem.
Try to restrict your no asm groups to non compatible stuff - with
some common sense applied.

> +
> +struct amba_prom_registers {
> +	unsigned int phys_addr;	/* The physical address of this register */
> +	unsigned int reg_size;	/* How many bytes does this register take 
> up? */
> +};
For stuff that maps to HW use bitspecific types like u32, u16 etc.

> +
> +LEON_TYPEDEF struct {
> +	LEON_VOLATILE unsigned int ilevel;
> +	LEON_VOLATILE unsigned int ipend;
> +	LEON_VOLATILE unsigned int iforce;
> +	LEON_VOLATILE unsigned int iclear;
> +	LEON_VOLATILE unsigned int mpstatus;
> +	LEON_VOLATILE unsigned int mpbroadcast;
> +	LEON_VOLATILE unsigned int notused02;
> +	LEON_VOLATILE unsigned int notused03;
> +	LEON_VOLATILE unsigned int notused10;
> +	LEON_VOLATILE unsigned int notused11;
> +	LEON_VOLATILE unsigned int notused12;
> +	LEON_VOLATILE unsigned int notused13;
> +	LEON_VOLATILE unsigned int notused20;
> +	LEON_VOLATILE unsigned int notused21;
> +	LEON_VOLATILE unsigned int notused22;
> +	LEON_VOLATILE unsigned int notused23;
> +	LEON_VOLATILE unsigned int mask[16];
> +	LEON_VOLATILE unsigned int force[16];
> +	/* Extended IRQ registers */
> +	LEON_VOLATILE unsigned int intid[16];	/* 0xc0 */
> +} LEON3_IrqCtrl_Regs_Map;
> +

1) do not use typedefs
2) user lower case names
3) use bitwidt specific types

These comments apply to several types following this one.

> +
> +#define GPTIMER_CONFIG_IRQNT(a) (((a) >> 3) & 0x1f)
> +#define GPTIMER_CONFIG_ISSEP(a) ((a)&(1<<8))
> +#define GPTIMER_CONFIG_NTIMERS(a) ((a)&(0x7))
> +#define LEON3_GPTIMER_CTRL_PENDING 0x10
> +#define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
> +#define LEON3_GPTIMER_CTRL_ISPENDING(r) \
> +	(((r)&LEON3_GPTIMER_CTRL_PENDING) ? 1 : 0)

Consider this style:
> +#define GPTIMER_CONFIG_IRQNT(a)          (((a) >> 3) & 0x1f)
> +#define GPTIMER_CONFIG_ISSEP(a)          ((a)&(1<<8))
> +#define GPTIMER_CONFIG_NTIMERS(a)        ((a)&(0x7))
> +#define LEON3_GPTIMER_CTRL_PENDING       0x10
> +#define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
> +#define LEON3_GPTIMER_CTRL_ISPENDING(r)  (((r)&LEON3_GPTIMER_CTRL_PENDING) ? 1 : 0)

Btw - 80 is not a hard limit.
Break it when it makes sense.

> +
> +LEON_TYPEDEF void (*GPTIMER_CALLBACK) (void);

small caps..


> +LEON_TYPEDEF struct _sparc_gptimer {
> +	LEON3_GpTimer_Regs_Map *inst;
> +	unsigned int ctrl, reload, value, scalarreload;
> +	int irq, flags, idxinst, idx, enabled, connected, minscalar;
> +	int ticksPerSecond, stat;
> +	GPTIMER_CALLBACK callback;
> +	int arg;
> +} sparc_gptimer;

> +LEON_TYPEDEF struct _sparc_gptimer {
> +     LEON3_GpTimer_Regs_Map *inst;
> +     unsigned int            ctrl;
        unsigned int            reload;
        unsigned int            value;
        unsigned int            scalarreload;
        ....

> +     int irq, flags, idxinst, idx, enabled, connected, minscalar;
> +     int ticksPerSecond, stat;
> +     GPTIMER_CALLBACK callback;
> +     int arg;
> +} sparc_gptimer;
leon_gptimer?

Add the following to amba.h?
Or maybe leon_amba.h to split up things?

> + *  Types and structure used for AMBA Plug & Play bus scanning
> + */
> +
> +#define AMBA_MAXAPB_DEVS 64
> +#define AMBA_MAXAPB_DEVS_PERBUS 16
> +
> +LEON_TYPEDEF struct amba_device_table {
> +	int devnr;		/* number of devices on AHB or APB bus */
> +	/* addresses to the devices configuration tables */
> +	unsigned int *addr[16];
> +	/* 0=unallocated, 1=allocated driver */
> +	unsigned int allocbits[1];
> +} amba_device_table;
> +
> +LEON_TYPEDEF struct amba_apbslv_device_table {
> +	int devnr;		/* number of devices on AHB or APB bus */
> +	/* addresses to the devices configuration tables */
> +	unsigned int *addr[AMBA_MAXAPB_DEVS];
> +	/* apb master if a entry is a apb slave */
> +	unsigned int apbmst[AMBA_MAXAPB_DEVS];
> +	/* apb master idx if a entry is a apb slave */
> +	unsigned int apbmstidx[AMBA_MAXAPB_DEVS];
> +	unsigned int allocbits[4];/* 0=unallocated, 1=allocated driver */
> +} amba_apbslv_device_table;
> +
> +LEON_TYPEDEF struct _amba_confarea_type {
> +	struct _amba_confarea_type *next;/* next bus in chain */
> +	amba_device_table ahbmst;
> +	amba_device_table ahbslv;
> +	amba_apbslv_device_table apbslv;
> +	unsigned int apbmst;
> +} amba_confarea_type;
> +
> +/* collect apb slaves */
> +LEON_TYPEDEF struct amba_apb_device {
> +	unsigned int start, irq, bus_id;
> +	amba_confarea_type *bus;
> +} amba_apb_device;
> +
> +/* collect ahb slaves */
> +LEON_TYPEDEF struct amba_ahb_device {
> +	unsigned int start[4], irq, bus_id;
> +	amba_confarea_type *bus;
> +} amba_ahb_device;
> +
> +extern void sparc_leon_eirq_register(int eirq);
> +
> +#if defined(CONFIG_SMP)
> +# define LEON3_IRQ_RESCHEDULE		13
> +# define LEON3_IRQ_TICKER		(leon_percpu_timer_dev[0].irq)
> +# define LEON3_IRQ_CROSS_CALL		15
> +#endif
> +
> +#define ASI_LEON3_SYSCTRL		0x02
> +#define ASI_LEON3_SYSCTRL_ICFG		0x08
> +#define ASI_LEON3_SYSCTRL_DCFG		0x0c
> +#define ASI_LEON3_SYSCTRL_CFG_SNOOPING (1<<27)
> +#define ASI_LEON3_SYSCTRL_CFG_SSIZE(c) (1<<((c>>20)&0xf))
spaes around operator - also in macros.

> +
> +/* GCC for the host includes this, older GCC versions complain about
> + * sparc assembler if host is not a SPARC.
> + */
> +#ifdef __sparc

But his is a kernel only file - confused?

> +
> +extern inline unsigned long sparc_leon3_get_dcachecfg(void)
> +{
> +	unsigned int retval;
> +	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
> +			     "=r"(retval) :
> +			     "r"(ASI_LEON3_SYSCTRL_DCFG),
> +			     "i"(ASI_LEON3_SYSCTRL));
> +	return retval;
> +}
> +
> +/*enable snooping*/
> +extern inline void sparc_leon3_enable_snooping(void)
> +{
> +	__asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
> +			  "set 0x800000, %%l2\n\t"
> +			  "or  %%l2, %%l1, %%l2\n\t"
> +			  "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
> +};
> +
> +extern inline void sparc_leon3_disable_cache(void)
> +{
> +	__asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
> +			  "set 0x00000f, %%l2\n\t"
> +			  "andn  %%l2, %%l1, %%l2\n\t"
> +			  "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
> +};
> +#endif
> +
> +#endif /*!__ASSEMBLER__*/
> +
> +#if defined(PAGE_SIZE_LEON_8K)
> +#define CONFIG_PAGE_SIZE_LEON 1
> +#elif defined(PAGE_SIZE_LEON_16K)
> +#define CONFIG_PAGE_SIZE_LEON 2)
> +#else
> +#define CONFIG_PAGE_SIZE_LEON 0
> +#endif
> +
> +#if CONFIG_PAGE_SIZE_LEON = 0
> +/* [ 8, 6, 6 ] + 12 */
> +#define LEON_PGD_SH 24
> +#define LEON_PGD_M  0xff
> +#define LEON_PMD_SH 18
> +#define LEON_PMD_SH_V (LEON_PGD_SH-2)
> +#define LEON_PMD_M  0x3f
> +#define LEON_PTE_SH 12
> +#define LEON_PTE_M  0x3f
> +#elif CONFIG_PAGE_SIZE_LEON = 1
> +/* [ 7, 6, 6 ] + 13 */
> +#define LEON_PGD_SH 25
> +#define LEON_PGD_M  0x7f
> +#define LEON_PMD_SH 19
> +#define LEON_PMD_SH_V (LEON_PGD_SH-1)
> +#define LEON_PMD_M  0x3f
> +#define LEON_PTE_SH 13
> +#define LEON_PTE_M  0x3f
> +#elif CONFIG_PAGE_SIZE_LEON = 2
> +/* [ 6, 6, 6 ] + 14 */
> +#define LEON_PGD_SH 26
> +#define LEON_PGD_M  0x3f
> +#define LEON_PMD_SH 20
> +#define LEON_PMD_SH_V (LEON_PGD_SH-0)
> +#define LEON_PMD_M  0x3f
> +#define LEON_PTE_SH 14
> +#define LEON_PTE_M  0x3f
> +#elif CONFIG_PAGE_SIZE_LEON = 3
> +/* [ 4, 7, 6 ] + 15 */
> +#define LEON_PGD_SH 28
> +#define LEON_PGD_M  0x0f
> +#define LEON_PMD_SH 21
> +#define LEON_PMD_SH_V (LEON_PGD_SH-0)
> +#define LEON_PMD_M  0x7f
> +#define LEON_PTE_SH 15
> +#define LEON_PTE_M  0x3f
> +#else
> +#error cannot determine CONFIG_PAGE_SIZE_LEON
> +#endif
> +
> +#endif /* LEON3 */

Veritical alignmnet would be good.

> +
> +#define PAGE_MIN_SHIFT   (12)
> +#define PAGE_MIN_SIZE    (1UL << PAGE_MIN_SHIFT)

Use AC(1,UL) so this is usefull from assembler.

> +
> +#define LEON3_XCCR_SETS_MASK  0x07000000UL
> +#define LEON3_XCCR_SSIZE_MASK 0x00f00000UL
> +
> +#define LEON2_CCR_DSETS_MASK 0x03000000UL
> +#define LEON2_CFG_SSIZE_MASK 0x00007000UL
> +
> +#ifndef __ASSEMBLY__
> +#define srmmu_hwprobe(addr) (srmmu_swprobe(addr, 0) & SRMMU_PTE_PMASK)
> +extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long 
> *paddr);
> +extern void leon_flush_icache_all(void);
> +extern void leon_flush_dcache_all(void);
> +extern void leon_flush_cache_all(void);
> +extern void leon_flush_tlb_all(void);
> +extern int leon_flush_during_switch;
> +extern int leon_flush_needed(void);
> +
> +/* struct that hold LEON3 cache configuration registers */
> +struct leon3_cacheregs {	/* ASI=2 Address - name */
> +	unsigned long ccr;	/* 0x00 - Cache Control Register  */
> +	/* 0x08 - Instruction Cache Configuration Register */
> +	unsigned long iccr;
> +	unsigned long dccr;	/* 0x0c - Data Cache Configuration Register 
> */
> +};
> +
> +/* struct that hold LEON2 cache configuration register
> +   & configuration register */
> +struct leon2_cacheregs {
> +	unsigned long ccr, cfg;
> +};
> +
> +#endif
> +
> +#define LEON3_IO_AREA 0xfff00000
> +#define LEON3_CONF_AREA 0xff000
> +#define LEON3_AHB_SLAVE_CONF_AREA (1 << 11)
> +
> +#define LEON3_AHB_CONF_WORDS 8
> +#define LEON3_APB_CONF_WORDS 2
> +#define LEON3_AHB_MASTERS 16
> +#define LEON3_AHB_SLAVES 16
> +#define LEON3_APB_SLAVES 16
> +#define LEON3_APBUARTS 8
> +
> +/* Vendor codes */
> +#define VENDOR_GAISLER   1
> +#define VENDOR_PENDER    2
> +#define VENDOR_ESA       4
> +#define VENDOR_OPENCORES 8
> +
> +/* Gaisler Research device id's */
> +#define GAISLER_LEON3    0x003
> +#define GAISLER_LEON3DSU 0x004
> +#define GAISLER_ETHAHB   0x005
> +#define GAISLER_APBMST   0x006
> +#define GAISLER_AHBUART  0x007
> +#define GAISLER_SRCTRL   0x008
> +#define GAISLER_SDCTRL   0x009
> +#define GAISLER_APBUART  0x00C
> +#define GAISLER_IRQMP    0x00D
> +#define GAISLER_AHBRAM   0x00E
> +#define GAISLER_GPTIMER  0x011
> +#define GAISLER_PCITRG   0x012
> +#define GAISLER_PCISBRG  0x013
> +#define GAISLER_PCIFBRG  0x014
> +#define GAISLER_PCITRACE 0x015
> +#define GAISLER_PCIDMA   0x016
> +#define GAISLER_AHBTRACE 0x017
> +#define GAISLER_ETHDSU   0x018
> +#define GAISLER_PIOPORT  0x01A
> +#define GAISLER_GRGPIO   0x01A
> +#define GAISLER_AHBJTAG  0x01c
> +#define GAISLER_ETHMAC   0x01D
> +#define GAISLER_AHB2AHB  0x020
> +#define GAISLER_USBDC    0x021
> +#define GAISLER_ATACTRL  0x024
> +#define GAISLER_DDRSPA   0x025
> +#define GAISLER_USBEHC   0x026
> +#define GAISLER_USBUHC   0x027
> +#define GAISLER_I2CMST   0x028
> +#define GAISLER_SPICTRL  0x02D
> +#define GAISLER_DDR2SPA  0x02E
> +#define GAISLER_SPIMCTRL 0x045
> +#define GAISLER_LEON4    0x048
> +#define GAISLER_LEON4DSU 0x049
> +#define GAISLER_AHBSTAT  0x052
> +#define GAISLER_FTMCTRL  0x054
> +#define GAISLER_KBD      0x060
> +#define GAISLER_VGA      0x061
> +#define GAISLER_SVGA     0x063
> +#define GAISLER_GRSYSMON 0x066
> +#define GAISLER_GRACECTRL 0x067
> +
> +#define GAISLER_L2TIME   0xffd	/* internal device: leon2 timer */
> +#define GAISLER_L2C      0xffe	/* internal device: leon2compat */
> +#define GAISLER_PLUGPLAY 0xfff	/* internal device: plug & play 
> configarea */
> +
> +#define amba_vendor(x) (((x) >> 24) & 0xff)
> +
> +#define amba_device(x) (((x) >> 12) & 0xfff)
> +
> +#endif /*defined(CONFIG_LEON) */
> +
> +#endif

> diff --git a/arch/sparc/kernel/leon.c b/arch/sparc/kernel/leon.c
> new file mode 100644
> index 0000000..2b60398
> --- /dev/null
> +++ b/arch/sparc/kernel/leon.c
> @@ -0,0 +1,310 @@
> +/* Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
> +   Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/interrupt.h>
> +#include <asm/prom.h>
> +#include <asm/oplib.h>
> +#include <asm/leon.h>
> +#include <asm/timer.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>

Please use following order:
1) All linux/* includes. The longest lines first.
--space--
2) All asm/* includes. The longest lines first
--space--
3) All local includes


> +
> +#include "prom.h"
> +#include "irq.h"
> +
> +LEON_VOLATILE LEON3_IrqCtrl_Regs_Map *LEON3_IrqCtrl_Regs;
> +LEON_VOLATILE LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs;
> +amba_apb_device leon_percpu_timer_dev[16];
> +#define LEON3_SMPTicker_Regs \
> +	((LEON3_GpTimer_Regs_Map *)leon_percpu_timer_dev[0].start)
> +int leondebug_irq_disable;
> +int leon_debug_irqout;
> +static int dummy_master_l10_counter;
> +
> +unsigned long LEON3_GpTimer_Irq;
> +unsigned int sparc_leon_eirq;
Global variables often deserve a comment.

> +#undef LEON_IMASK
> +#define LEON_IMASK ((&LEON3_IrqCtrl_Regs->mask[0]))
Hack - is it needed?


> +
> +/* Return the IRQ of the pending IRQ on the extended IRQ controller */
> +int sparc_leon_eirq_get(int eirq, int cpu)
> +{
> +	return LEON3_BYPASS_LOAD_PA(&LEON3_IrqCtrl_Regs->intid[cpu]) & 0x1f;
> +}

I wonder what this UPPERCASE LEON3_BYPASS_LOAD_PA thing is?

> +void leon_disable_irq(unsigned int irq_nr)
> +{
> +	unsigned long mask, flags;
> +	mask = get_irqmask(irq_nr);
> +	local_irq_save(flags);
> +	LEON3_BYPASS_STORE_PA(LEON_IMASK,
> +			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) & ~(mask)));
> +	local_irq_restore(flags);
> +
> +}
> +
> +void __init leon_init_timers(irq_handler_t counter_fn)
> +{
> +	int irq;
> +
> +	leondebug_irq_disable = 0;
> +	leon_debug_irqout = 0;
> +	master_l10_counter = &dummy_master_l10_counter;
> +	dummy_master_l10_counter = 0;
> +
> +	if (LEON3_GpTimer_Regs && LEON3_IrqCtrl_Regs) {
> +		/*regs -> timerctrl1 = 0; */
> +		/*regs -> timercnt1 = 0; */
> +		/*regs -> timerload1 = (((1000000/100) - 1));*/
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].val, 0);
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].rld,
> +				      (((1000000 / 100) - 1)));
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].ctrl, 0);
> +
> +#ifdef CONFIG_SMP
> +# if defined(CONFIG_LEONSMP_USETIMER2)
> +		leon_percpu_timer_dev[0].start = (int)LEON3_GpTimer_Regs;
> +		leon_percpu_timer_dev[0].irq = LEON3_GpTimer_Irq + 1;
> +
> +		if (!
> +		    (LEON3_BYPASS_LOAD_PA(&LEON3_GpTimer_Regs->config) &
> +		     (1 << LEON3_GPTIMER_SEPIRQ))) {
> +			prom_printf
> +			    ("irq timer not configured with seperate irqs 
> \n");
> +			BUG();
> +		}
> +
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].val, 0);
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].rld,
> +				      (((1000000 / 100) - 1)));
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].ctrl, 0);
> +#else
> +		{
> +			leon_percpu_timer_dev[0].start = 0;
> +			int i > +			amba_get_free_apbslv_devices(VENDOR_GAISLER,
> +						     GAISLER_GPTIMER,
> +						     leon_percpu_timer_dev,
> +						     2);
> +			if (i < 1) {
> +				prom_printf("Cannot lock "
> +					    "GAISLER_GPTIMER timer "
> +					    "for smp-ticker\n");
> +				BUG();
> +			}
> +			if (leon_percpu_timer_dev[0].start =
> +			    LEON3_GpTimer_Regs) {
> +				if (i < 2) {
> +					prom_printf("Cannot lock"
> +						    " GAISLER_GPTIMER timer "
> +						    "for smp-ticker\n");
> +					BUG();
> +				}
> +				leon_percpu_timer_dev[0] > +				    leon_percpu_timer_dev[1];
> +			}
> +
> +			printk(KERN_INFO "Leon smp ticker at 0x%x irq %d\n",
> +			       leon_percpu_timer_dev[0].start,
> +			       leon_percpu_timer_dev[0].irq);
> +
> +		 LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].val,
> +					      0);
> +		 LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].rld,
> +					      (((1000000 / 100) - 1)));
> +		 LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].ctrl,
> +					      0);
> +
> +			/* copy over 100hz scaler */
> +			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->scalar,
> +					      LEON3_BYPASS_LOAD_PA
> +					      (&LEON3_GpTimer_Regs->scalar));
> +			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->
> +					      scalar_reload,
> +					      LEON3_BYPASS_LOAD_PA
> +					      (&LEON3_GpTimer_Regs->
> +					       scalar_reload));
> +
> +		}
> +# endif
> +# endif
No space between # and endif.
And please add a comment with the conent of the if so we can follow it.
(Do not do that for short if/endif blocks).

> +	} else {
> +		while (1)
> +			printk(KERN_ERR "No Timer/irqctrl found\n");
> +	}
> +
> +	irq = request_irq(LEON3_GpTimer_Irq,
> +			  counter_fn,
> +			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
> +
> +	if (irq) {
> +		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
> +		       LEON_INTERRUPT_TIMER1);
> +		prom_halt();
> +	}
> +# ifdef CONFIG_SMP
> +	{
> +		unsigned long flags;
> +		struct tt_entry *trap_table > +		    &sparc_ttable[SP_TRAP_IRQ1 +
> +				  (leon_percpu_timer_dev[0].irq - 1)];
> +
> +		extern unsigned int real_irq_entry[], smpleon_ticker[];
> +		extern unsigned int patchme_maybe_smp_msg[];
> +
> +		/* For SMP we use the level 14 ticker, however the bootup 
> code
> +		 * has copied the firmwares level 14 vector into boot cpu's
> +		 * trap table, we must fix this now or we get squashed.
> +		 */
> +		local_irq_save(flags);
> +
> +		patchme_maybe_smp_msg[0] = 0x01000000;	/* NOP out the 
> branch */
> +
> +		/* Adjust so that we jump directly to smpleon_ticker */
> +		trap_table->inst_three += smpleon_ticker - real_irq_entry;
> +
> +		local_flush_cache_all();
> +		local_irq_restore(flags);
> +	}
> +# endif
> +
> +	if (LEON3_GpTimer_Regs) {
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].ctrl,
> +				      LEON3_GPTIMER_EN |
> +				      LEON3_GPTIMER_RL |
> +				      LEON3_GPTIMER_LD | 
> LEON3_GPTIMER_IRQEN);
> +#if defined(CONFIG_SMP)
> +# if defined(CONFIG_LEONSMP_USETIMER2)
> +		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].ctrl,
> +				      LEON3_GPTIMER_EN |
> +				      LEON3_GPTIMER_RL |
> +				      LEON3_GPTIMER_LD | 
> LEON3_GPTIMER_IRQEN);
> +
> +# else
> +		LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].ctrl,
> +				      LEON3_GPTIMER_EN |
> +				      LEON3_GPTIMER_RL |
> +				      LEON3_GPTIMER_LD | 
> LEON3_GPTIMER_IRQEN);
> +# endif
> +#endif
> +	}
This function could use a few helper function
to make it more readable and with less ifdeffery.


> +
> +}
> +
> +void leon_clear_clock_irq(void)
> +{
> +}
> +
> +void leon_load_profile_irq(int cpu, unsigned int limit)
> +{
> +	BUG();
> +}
> +
> +#if defined(CONFIG_LEON)
> +void _amba_init(struct device_node *dp, struct device_node ***nextp);
> +#endif

This file is leon specific - so why this ifdef/endif?
And I think this prototype belong in a header?

> +
> +void console_print_LEON(const char *p);
Same here - why not in a header?

> +
> +void __init leon_trans_init(struct device_node *dp)
> +{
> +	if (strcmp(dp->type, "cpu") = 0 && strcmp(dp->name, "<NULL>") = 0) 
> {
> +		struct property *p;
> +		p = of_find_property(dp, "mid", 0);
> +		if (p) {
> +			int mid;
> +			dp->name = prom_early_alloc(5 + 1);
> +			memcpy(&mid, p->value, p->length);
> +			sprintf((char *)dp->name, "cpu%.2d", mid);
> +		}
> +	}
> +}
> +
> +void __init leon_node_init(struct device_node *dp, struct device_node 
> ***nextp)
> +{
> +	if (strcmp(dp->type, "ambapp") = 0 &&
> +	    strcmp(dp->name, "ambapp0") = 0) {
> +#if defined(CONFIG_LEON)
> +		_amba_init(dp, nextp);
> +#endif
> +	}
> +}
> +
> +void __init leon_init_IRQ(void)
> +{
> +	sparc_init_timers = leon_init_timers;
> +
> +	BTFIXUPSET_CALL(enable_irq, leon_enable_irq, BTFIXUPCALL_NORM);
> +	BTFIXUPSET_CALL(disable_irq, leon_disable_irq, BTFIXUPCALL_NORM);
> +	BTFIXUPSET_CALL(enable_pil_irq, leon_enable_irq, BTFIXUPCALL_NORM);
> +	BTFIXUPSET_CALL(disable_pil_irq, leon_disable_irq, BTFIXUPCALL_NORM);
> +
> +	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq,
> +			BTFIXUPCALL_NORM);
> +	BTFIXUPSET_CALL(load_profile_irq, leon_load_profile_irq,
> +			BTFIXUPCALL_NOP);
> +
> +#ifdef CONFIG_SMP
> +	BTFIXUPSET_CALL(set_cpu_int, leon_set_cpu_int, BTFIXUPCALL_NORM);
> +	BTFIXUPSET_CALL(clear_cpu_int, leon_clear_ipi, BTFIXUPCALL_NORM);
> +	BTFIXUPSET_CALL(set_irq_udt, leon_set_udt, BTFIXUPCALL_NORM);
> +#endif
> +
> +}
Please revisit all funtions and check if they all need to be non-static.

> diff --git a/arch/sparc/mm/leon.c b/arch/sparc/mm/leon.c
> new file mode 100644
> index 0000000..5271328
> --- /dev/null
> +++ b/arch/sparc/mm/leon.c
> @@ -0,0 +1,266 @@
> +/*
> + *  linux/arch/sparc/mm/leon.c
> + *
> + * Copyright (C) 2004 Konrad Eisele
> + * (eiselekd@web.de, konrad@gaisler.com), Gaisler Research
> + * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
> + * Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB
> + *
> + * do srmmu probe in software
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <asm/asi.h>
> +#include <asm/leon.h>
> +
> +int leon_flush_during_switch = 1;
> +
> +#define PFN(x) ((x) >> PAGE_SHIFT)
> +extern unsigned long last_valid_pfn;
Move to header file.


> +/* max_mapnr not initialized yet */
> +#define _pfn_valid(pfn)	((pfn < last_valid_pfn) && (pfn >= 
> PFN(phys_base)))
> +#define _SRMMU_PTE_PMASK 0xffffffff
> +
> +int srmmu_swprobe_trace;
> +unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr)
> +{
> +
> +	unsigned int ctxtbl;
> +	unsigned int pgd, pmd, ped;
> +	unsigned int ptr;
> +	unsigned int lvl, pte, paddrbase;
> +	unsigned int ctx;
> +	unsigned int paddr_calc;
> +
> +	paddrbase = 0;
> +
> +	if (srmmu_swprobe_trace)
> +		printk(KERN_INFO "swprobe: trace on\n");
> +
> +	ctxtbl = srmmu_get_ctable_ptr();
> +	if (!(ctxtbl)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: srmmu_get_ctable_ptr 
> returned 0=>0\n");
> +		return 0;
> +	}
> +	if (!_pfn_valid(PFN(ctxtbl))) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO
> +			       "swprobe: !_pfn_valid(%x)=>0\n",
> +			       PFN(ctxtbl));
> +		return 0;
> +	}
> +
> +	ctx = srmmu_get_context();
> +	if (srmmu_swprobe_trace)
> +		printk(KERN_INFO "swprobe:  --- ctx (%x) ---\n", ctx);
> +
> +	pgd = LEON_BYPASS_LOAD_PA(ctxtbl + (ctx * 4));
> +
> +	if (((pgd & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: pgd is entry level 3\n");
> +		lvl = 3;
> +		pte = pgd;
> +		paddrbase = pgd & _SRMMU_PTE_PMASK;
> +		goto ready;
> +	}
> +	if (((pgd & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: pgd is invalid => 0\n");
> +		return 0;
> +	}
> +
> +	if (srmmu_swprobe_trace)
> +		printk(KERN_INFO "swprobe:  --- pgd (%x) ---\n", pgd);
> +
> +	ptr = (pgd & SRMMU_PTD_PMASK) << 4;
> +	ptr += ((((vaddr) >> LEON_PGD_SH) & LEON_PGD_M) * 4);
> +	if (!_pfn_valid(PFN(ptr)))
> +		return 0;
> +
> +	pmd = LEON_BYPASS_LOAD_PA(ptr);
> +	if (((pmd & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: pmd is entry level 2\n");
> +		lvl = 2;
> +		pte = pmd;
> +		paddrbase = pmd & _SRMMU_PTE_PMASK;
> +		goto ready;
> +	}
> +	if (((pmd & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: pmd is invalid => 0\n");
> +		return 0;
> +	}
> +
> +	if (srmmu_swprobe_trace)
> +		printk(KERN_INFO "swprobe:  --- pmd (%x) ---\n", pmd);
> +
> +	ptr = (pmd & SRMMU_PTD_PMASK) << 4;
> +	ptr += (((vaddr >> LEON_PMD_SH) & LEON_PMD_M) * 4);
> +	if (!_pfn_valid(PFN(ptr))) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: !_pfn_valid(%x)=>0\n",
> +			       PFN(ptr));
> +		return 0;
> +	}
> +
> +	ped = LEON_BYPASS_LOAD_PA(ptr);
> +
> +	if (((ped & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: ped is entry level 1\n");
> +		lvl = 1;
> +		pte = ped;
> +		paddrbase = ped & _SRMMU_PTE_PMASK;
> +		goto ready;
> +	}
> +	if (((ped & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: ped is invalid => 0\n");
> +		return 0;
> +	}
> +
> +	if (srmmu_swprobe_trace)
> +		printk(KERN_INFO "swprobe:  --- ped (%x) ---\n", ped);
> +
> +	ptr = (ped & SRMMU_PTD_PMASK) << 4;
> +	ptr += (((vaddr >> LEON_PTE_SH) & LEON_PTE_M) * 4);
> +	if (!_pfn_valid(PFN(ptr)))
> +		return 0;
> +
> +	ptr = LEON_BYPASS_LOAD_PA(ptr);
> +	if (((ptr & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
> +		if (srmmu_swprobe_trace)
> +			printk(KERN_INFO "swprobe: ptr is entry level 0\n");
> +		lvl = 0;
> +		pte = ptr;
> +		paddrbase = ptr & _SRMMU_PTE_PMASK;
> +		goto ready;
> +	}
> +	if (srmmu_swprobe_trace)
> +		printk(KERN_INFO "swprobe: ptr is invalid => 0\n");
> +	return 0;
> +
> +ready:
> +	switch (lvl) {
> +	case 0:
> +		paddr_calc > +		    (vaddr & ~(-1 << LEON_PTE_SH)) | ((pte & ~0xff) << 4);
> +		break;
> +	case 1:
> +		paddr_calc > +		    (vaddr & ~(-1 << LEON_PMD_SH)) | ((pte & ~0xff) << 4);
> +		break;
> +	case 2:
> +		paddr_calc > +		    (vaddr & ~(-1 << LEON_PGD_SH)) | ((pte & ~0xff) << 4);
> +		break;
> +	default:
> +	case 3:
> +		paddr_calc = vaddr;
> +		break;
> +	}
> +	if (srmmu_swprobe_trace)
> +		printk(KERN_INFO "swprobe: padde %x\n", paddr_calc);
> +	if (paddr)
> +		*paddr = paddr_calc;
> +	return paddrbase;
> +}
> +
> +void leon_flush_icache_all(void)
> +{
> +#if defined(CONFIG_LEON)
> +	__asm__ __volatile__(" flush ");	/*iflush*/
> +#endif
> +}
> +
> +void leon_flush_dcache_all(void)
> +{
> +#if defined(CONFIG_LEON)
> +	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
> +			     "i"(ASI_LEON_DFLUSH) : "memory");
> +#endif
> +}
This is leon spacif - drop the ifdefs.

> +
> +void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned long page)
> +{
> +	if (vma->vm_flags & VM_EXEC)
> +		leon_flush_icache_all();
> +	leon_flush_dcache_all();
> +}
> +
> +void leon_flush_cache_all(void)
> +{
> +#if defined(CONFIG_LEON)
> +	__asm__ __volatile__(" flush ");	/*iflush*/
> +	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
> +			     "i"(ASI_LEON_DFLUSH) : "memory");
> +#endif
> +}
Again - drop ifdefs.

> +
> +void leon_flush_tlb_all(void)
> +{
> +#if defined(CONFIG_LEON)
> +	leon_flush_cache_all();
> +	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : : "r"(0x400),
> +			     "i"(ASI_LEON_MMUFLUSH) : "memory");
> +#endif
> +}
Again (will stop now - fix them all up).

> +
> +/* get all cache regs */
> +void leon3_getCacheRegs(struct leon3_cacheregs *regs)
> +{
> +	unsigned long ccr, iccr, dccr;
> +
> +	if (!regs)
> +		return;
> +	/* Get Cache regs from "Cache ASI" address 0x0, 0x8 and 0xC */
> +	__asm__ __volatile__("lda [%%g0] %3, %0\n\t"
> +			     "mov 0x08, %%g1\n\t"
> +			     "lda [%%g1] %3, %1\n\t"
> +			     "mov 0x0c, %%g1\n\t"
> +			     "lda [%%g1] %3, %2\n\t"
> +			     : "=r"(ccr), "=r"(iccr), "=r"(dccr)
> +			       /* output */
> +			     : "i"(ASI_LEON_CACHEREGS)	/* input */
> +			     : "g1"	/* clobber list */
> +	    );
> +	regs->ccr = ccr;
> +	regs->iccr = iccr;
> +	regs->dccr = dccr;
> +}
> +
> +/* Due to virtual cache we need to check cache configuration if
> + * it is possible to skip flushing in some cases.
> + *
> + * Leon2 and Leon3 differ in their way of telling cache information
> + *
> + */
> +int leon_flush_needed(void)
> +{
> +	int flush_needed = -1;
> +	unsigned int ssize, sets;
> +	char *setStr[4] > +	    { "direct mapped", "2-way associative", "3-way associative",
> +		"4-way associative"
> +	};
> +	/* leon 3 */
> +	struct leon3_cacheregs cregs;
> +	leon3_getCacheRegs(&cregs);
> +	sets = (cregs.dccr & LEON3_XCCR_SETS_MASK) >> 24;
> +	/* (ssize=>realsize) 0=>1k, 1=>2k, 2=>4k, 3=>8k ... */
> +	ssize = 1 << ((cregs.dccr & LEON3_XCCR_SSIZE_MASK) >> 20);
> +
> +	printk(KERN_INFO "CACHE: %s cache, set size %dk\n",
> +	       sets > 3 ? "unknown" : setStr[sets], ssize);
> +	if ((ssize <= (PAGE_SIZE / 1024)) && (sets = 0)) {
> +		/* Set Size <= Page size  =>
> +		   flush on every context switch not needed. */
> +		flush_needed = 0;
> +		printk(KERN_INFO "CACHE: not flushing on every context 
> switch\n");
> +	}
> +	return flush_needed;
> +}


	Sam
