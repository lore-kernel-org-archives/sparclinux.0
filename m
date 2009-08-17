From: konrad@gaisler.com
Date: Mon, 17 Aug 2009 10:13:29 +0000
Subject: [PATCH 1/5] sparc,leon: CONFIG_SPARC_LEON option and leon specific files.
Message-Id: <1250504013-652-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

The macro CONFIG_SPARC_LEON will shield, if undefined, the sun-sparc
code from LEON specific code. In
particular include/asm/leon.h will get empty through #ifdef and
leon_kernel.c and leon_mm.c will not be compiled.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
Reviewed-by:   Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig                 |   11 +
 arch/sparc/include/asm/leon.h      |  362 ++++++++++++++++++++++++++++++++++++
 arch/sparc/include/asm/leon_amba.h |  263 ++++++++++++++++++++++++++
 arch/sparc/kernel/leon_kernel.c    |  203 ++++++++++++++++++++
 arch/sparc/mm/leon_mm.c            |  260 ++++++++++++++++++++++++++
 5 files changed, 1099 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/include/asm/leon.h
 create mode 100644 arch/sparc/include/asm/leon_amba.h
 create mode 100644 arch/sparc/kernel/leon_kernel.c
 create mode 100644 arch/sparc/mm/leon_mm.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 3f8b6a9..b847f88 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -437,6 +437,17 @@ config SERIAL_CONSOLE
 
 	  If unsure, say N.
 
+config SPARC_LEON
+	bool "Sparc Leon processor family"
+	depends on SPARC32
+	---help---
+	  If you say Y here if you are running on a SPARC-LEON processor.
+	  The LEON processor is a synthesizable VHDL model of the
+	  SPARC-v8 standard. LEON is  part of the GRLIB collection of
+	  IP cores that are distributed under GPL. GRLIB can be downloaded
+	  from www.gaisler.com. You can download a sparc-linux cross-compilation
+	  toolchain at www.gaisler.com.
+
 endmenu
 
 menu "Bus options (PCI etc.)"
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
new file mode 100644
index 0000000..28a42b7
--- /dev/null
+++ b/arch/sparc/include/asm/leon.h
@@ -0,0 +1,362 @@
+/*
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de,konrad@gaisler.com) Gaisler Research
+ * Copyright (C) 2004 Stefan Holst (mail@s-holst.de) Uni-Stuttgart
+ * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com) Aeroflex Gaisler AB
+ * Copyright (C) 2009 Konrad Eisele (konrad@gaisler.com) Aeroflex Gaisler AB
+ */
+
+#ifndef LEON_H_INCLUDE
+#define LEON_H_INCLUDE
+
+#ifdef CONFIG_SPARC_LEON
+
+#define ASI_LEON_NOCACHE	0x01
+
+#define ASI_LEON_DCACHE_MISS	0x1
+
+#define ASI_LEON_CACHEREGS	0x02
+#define ASI_LEON_IFLUSH		0x10
+#define ASI_LEON_DFLUSH		0x11
+
+#define ASI_LEON_MMUFLUSH	0x18
+#define ASI_LEON_MMUREGS	0x19
+#define ASI_LEON_BYPASS		0x1c
+#define ASI_LEON_FLUSH_PAGE	0x10
+
+/* mmu register access, ASI_LEON_MMUREGS */
+#define LEON_CNR_CTRL		0x000
+#define LEON_CNR_CTXP		0x100
+#define LEON_CNR_CTX		0x200
+#define LEON_CNR_F		0x300
+#define LEON_CNR_FADDR		0x400
+
+#define LEON_CNR_CTX_NCTX	256	/*number of MMU ctx */
+
+#define LEON_CNR_CTRL_TLBDIS	0x80000000
+
+#define LEON_MMUTLB_ENT_MAX	64
+
+/*
+ * diagnostic access from mmutlb.vhd:
+ * 0: pte address
+ * 4: pte
+ * 8: additional flags
+ */
+#define LEON_DIAGF_LVL		0x3
+#define LEON_DIAGF_WR		0x8
+#define LEON_DIAGF_WR_SHIFT	3
+#define LEON_DIAGF_HIT		0x10
+#define LEON_DIAGF_HIT_SHIFT	4
+#define LEON_DIAGF_CTX		0x1fe0
+#define LEON_DIAGF_CTX_SHIFT	5
+#define LEON_DIAGF_VALID	0x2000
+#define LEON_DIAGF_VALID_SHIFT	13
+
+/*
+ *  Interrupt Sources
+ *
+ *  The interrupt source numbers directly map to the trap type and to
+ *  the bits used in the Interrupt Clear, Interrupt Force, Interrupt Mask,
+ *  and the Interrupt Pending Registers.
+ */
+#define LEON_INTERRUPT_CORRECTABLE_MEMORY_ERROR	1
+#define LEON_INTERRUPT_UART_1_RX_TX		2
+#define LEON_INTERRUPT_UART_0_RX_TX		3
+#define LEON_INTERRUPT_EXTERNAL_0		4
+#define LEON_INTERRUPT_EXTERNAL_1		5
+#define LEON_INTERRUPT_EXTERNAL_2		6
+#define LEON_INTERRUPT_EXTERNAL_3		7
+#define LEON_INTERRUPT_TIMER1			8
+#define LEON_INTERRUPT_TIMER2			9
+#define LEON_INTERRUPT_EMPTY1			10
+#define LEON_INTERRUPT_EMPTY2			11
+#define LEON_INTERRUPT_OPEN_ETH			12
+#define LEON_INTERRUPT_EMPTY4			13
+#define LEON_INTERRUPT_EMPTY5			14
+#define LEON_INTERRUPT_EMPTY6			15
+
+/* irq masks */
+#define LEON_HARD_INT(x)	(1 << (x))	/* irq 0-15 */
+#define LEON_IRQMASK_R		0x0000fffe	/* bit 15- 1 of lregs.irqmask */
+#define LEON_IRQPRIO_R		0xfffe0000	/* bit 31-17 of lregs.irqmask */
+
+/* leon uart register definitions */
+#define LEON_OFF_UDATA	0x0
+#define LEON_OFF_USTAT	0x4
+#define LEON_OFF_UCTRL	0x8
+#define LEON_OFF_USCAL	0xc
+
+#define LEON_UCTRL_RE	0x01
+#define LEON_UCTRL_TE	0x02
+#define LEON_UCTRL_RI	0x04
+#define LEON_UCTRL_TI	0x08
+#define LEON_UCTRL_PS	0x10
+#define LEON_UCTRL_PE	0x20
+#define LEON_UCTRL_FL	0x40
+#define LEON_UCTRL_LB	0x80
+
+#define LEON_USTAT_DR	0x01
+#define LEON_USTAT_TS	0x02
+#define LEON_USTAT_TH	0x04
+#define LEON_USTAT_BR	0x08
+#define LEON_USTAT_OV	0x10
+#define LEON_USTAT_PE	0x20
+#define LEON_USTAT_FE	0x40
+
+#define LEON_MCFG2_SRAMDIS		0x00002000
+#define LEON_MCFG2_SDRAMEN		0x00004000
+#define LEON_MCFG2_SRAMBANKSZ		0x00001e00	/* [12-9] */
+#define LEON_MCFG2_SRAMBANKSZ_SHIFT	9
+#define LEON_MCFG2_SDRAMBANKSZ		0x03800000	/* [25-23] */
+#define LEON_MCFG2_SDRAMBANKSZ_SHIFT	23
+
+#define LEON_TCNT0_MASK	0x7fffff
+
+#define LEON_USTAT_ERROR (LEON_USTAT_OV | LEON_USTAT_PE | LEON_USTAT_FE)
+/* no break yet */
+
+#define ASI_LEON3_SYSCTRL		0x02
+#define ASI_LEON3_SYSCTRL_ICFG		0x08
+#define ASI_LEON3_SYSCTRL_DCFG		0x0c
+#define ASI_LEON3_SYSCTRL_CFG_SNOOPING (1 << 27)
+#define ASI_LEON3_SYSCTRL_CFG_SSIZE(c) (1 << ((c >> 20) & 0xf))
+
+#ifndef __ASSEMBLY__
+
+/* do a virtual address read without cache */
+static inline unsigned long leon_readnobuffer_reg(unsigned long paddr)
+{
+	unsigned long retval;
+	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+			     "=r"(retval) : "r"(paddr), "i"(ASI_LEON_NOCACHE));
+	return retval;
+}
+
+/* do a physical address bypass write, i.e. for 0x80000000 */
+static inline void leon_store_reg(unsigned long paddr, unsigned long value)
+{
+	__asm__ __volatile__("sta %0, [%1] %2\n\t" : : "r"(value), "r"(paddr),
+			     "i"(ASI_LEON_BYPASS) : "memory");
+}
+
+/* do a physical address bypass load, i.e. for 0x80000000 */
+static inline unsigned long leon_load_reg(unsigned long paddr)
+{
+	unsigned long retval;
+	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+			     "=r"(retval) : "r"(paddr), "i"(ASI_LEON_BYPASS));
+	return retval;
+}
+
+extern inline void leon_srmmu_disabletlb(void)
+{
+	unsigned int retval;
+	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
+			     "i"(ASI_LEON_MMUREGS));
+	retval |= LEON_CNR_CTRL_TLBDIS;
+	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
+			     "i"(ASI_LEON_MMUREGS) : "memory");
+}
+
+extern inline void leon_srmmu_enabletlb(void)
+{
+	unsigned int retval;
+	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
+			     "i"(ASI_LEON_MMUREGS));
+	retval = retval & ~LEON_CNR_CTRL_TLBDIS;
+	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
+			     "i"(ASI_LEON_MMUREGS) : "memory");
+}
+
+/* macro access for leon_load_reg() and leon_store_reg() */
+#define LEON3_BYPASS_LOAD_PA(x)	    (leon_load_reg((unsigned long)(x)))
+#define LEON3_BYPASS_STORE_PA(x, v) (leon_store_reg((unsigned long)(x), (unsigned long)(v)))
+#define LEON3_BYPASS_ANDIN_PA(x, v) LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) & v)
+#define LEON3_BYPASS_ORIN_PA(x, v)  LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) | v)
+#define LEON_BYPASS_LOAD_PA(x)      leon_load_reg((unsigned long)(x))
+#define LEON_BYPASS_STORE_PA(x, v)  leon_store_reg((unsigned long)(x), (unsigned long)(v))
+#define LEON_REGLOAD_PA(x)          leon_load_reg((unsigned long)(x)+LEON_PREGS)
+#define LEON_REGSTORE_PA(x, v)      leon_store_reg((unsigned long)(x)+LEON_PREGS, (unsigned long)(v))
+#define LEON_REGSTORE_OR_PA(x, v)   LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x) | (unsigned long)(v))
+#define LEON_REGSTORE_AND_PA(x, v)  LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x) & (unsigned long)(v))
+
+/* macro access for leon_readnobuffer_reg() */
+#define LEON_BYPASSCACHE_LOAD_VA(x) leon_readnobuffer_reg((unsigned long)(x))
+
+extern void sparc_leon_eirq_register(int eirq);
+extern void leon_init(void);
+extern void leon_switch_mm(void);
+extern void leon_init_IRQ(void);
+
+extern unsigned long last_valid_pfn;
+
+extern inline unsigned long sparc_leon3_get_dcachecfg(void)
+{
+	unsigned int retval;
+	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+			     "=r"(retval) :
+			     "r"(ASI_LEON3_SYSCTRL_DCFG),
+			     "i"(ASI_LEON3_SYSCTRL));
+	return retval;
+}
+
+/* enable snooping */
+extern inline void sparc_leon3_enable_snooping(void)
+{
+	__asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
+			  "set 0x800000, %%l2\n\t"
+			  "or  %%l2, %%l1, %%l2\n\t"
+			  "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
+};
+
+extern inline void sparc_leon3_disable_cache(void)
+{
+	__asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
+			  "set 0x00000f, %%l2\n\t"
+			  "andn  %%l2, %%l1, %%l2\n\t"
+			  "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
+};
+
+#endif /*!__ASSEMBLY__*/
+
+#ifdef CONFIG_SMP
+# define LEON3_IRQ_RESCHEDULE		13
+# define LEON3_IRQ_TICKER		(leon_percpu_timer_dev[0].irq)
+# define LEON3_IRQ_CROSS_CALL		15
+#endif
+
+#if defined(PAGE_SIZE_LEON_8K)
+#define LEON_PAGE_SIZE_LEON 1
+#elif defined(PAGE_SIZE_LEON_16K)
+#define LEON_PAGE_SIZE_LEON 2)
+#else
+#define LEON_PAGE_SIZE_LEON 0
+#endif
+
+#if LEON_PAGE_SIZE_LEON = 0
+/* [ 8, 6, 6 ] + 12 */
+#define LEON_PGD_SH    24
+#define LEON_PGD_M     0xff
+#define LEON_PMD_SH    18
+#define LEON_PMD_SH_V  (LEON_PGD_SH-2)
+#define LEON_PMD_M     0x3f
+#define LEON_PTE_SH    12
+#define LEON_PTE_M     0x3f
+#elif LEON_PAGE_SIZE_LEON = 1
+/* [ 7, 6, 6 ] + 13 */
+#define LEON_PGD_SH    25
+#define LEON_PGD_M     0x7f
+#define LEON_PMD_SH    19
+#define LEON_PMD_SH_V  (LEON_PGD_SH-1)
+#define LEON_PMD_M     0x3f
+#define LEON_PTE_SH    13
+#define LEON_PTE_M     0x3f
+#elif LEON_PAGE_SIZE_LEON = 2
+/* [ 6, 6, 6 ] + 14 */
+#define LEON_PGD_SH    26
+#define LEON_PGD_M     0x3f
+#define LEON_PMD_SH    20
+#define LEON_PMD_SH_V  (LEON_PGD_SH-0)
+#define LEON_PMD_M     0x3f
+#define LEON_PTE_SH    14
+#define LEON_PTE_M     0x3f
+#elif LEON_PAGE_SIZE_LEON = 3
+/* [ 4, 7, 6 ] + 15 */
+#define LEON_PGD_SH    28
+#define LEON_PGD_M     0x0f
+#define LEON_PMD_SH    21
+#define LEON_PMD_SH_V  (LEON_PGD_SH-0)
+#define LEON_PMD_M     0x7f
+#define LEON_PTE_SH    15
+#define LEON_PTE_M     0x3f
+#else
+#error cannot determine LEON_PAGE_SIZE_LEON
+#endif
+
+#define PAGE_MIN_SHIFT   (12)
+#define PAGE_MIN_SIZE    (1UL << PAGE_MIN_SHIFT)
+
+#define LEON3_XCCR_SETS_MASK  0x07000000UL
+#define LEON3_XCCR_SSIZE_MASK 0x00f00000UL
+
+#define LEON2_CCR_DSETS_MASK 0x03000000UL
+#define LEON2_CFG_SSIZE_MASK 0x00007000UL
+
+#ifndef __ASSEMBLY__
+extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
+extern void leon_flush_icache_all(void);
+extern void leon_flush_dcache_all(void);
+extern void leon_flush_cache_all(void);
+extern void leon_flush_tlb_all(void);
+extern int leon_flush_during_switch;
+extern int leon_flush_needed(void);
+
+struct vm_area_struct;
+extern void leon_flush_icache_all(void);
+extern void leon_flush_dcache_all(void);
+extern void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned long page);
+extern void leon_flush_cache_all(void);
+extern void leon_flush_tlb_all(void);
+extern int leon_flush_during_switch;
+extern int leon_flush_needed(void);
+extern void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned long page);
+
+/* struct that hold LEON3 cache configuration registers */
+struct leon3_cacheregs {
+	unsigned long ccr;	/* 0x00 - Cache Control Register  */
+	unsigned long iccr;     /* 0x08 - Instruction Cache Configuration Register */
+	unsigned long dccr;	/* 0x0c - Data Cache Configuration Register */
+};
+
+/* struct that hold LEON2 cache configuration register
+ * & configuration register
+ */
+struct leon2_cacheregs {
+	unsigned long ccr, cfg;
+};
+
+#ifdef __KERNEL__
+
+#include <linux/interrupt.h>
+
+struct device_node;
+extern int sparc_leon_eirq_get(int eirq, int cpu);
+extern irqreturn_t sparc_leon_eirq_isr(int dummy, void *dev_id);
+extern void sparc_leon_eirq_register(int eirq);
+extern void leon_clear_clock_irq(void);
+extern void leon_load_profile_irq(int cpu, unsigned int limit);
+extern void leon_init_timers(irq_handler_t counter_fn);
+extern void leon_clear_clock_irq(void);
+extern void leon_load_profile_irq(int cpu, unsigned int limit);
+extern void leon_trans_init(struct device_node *dp);
+extern void leon_node_init(struct device_node *dp, struct device_node ***nextp);
+extern void leon_init_IRQ(void);
+extern void leon_init(void);
+extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
+extern void init_leon(void);
+extern void poke_leonsparc(void);
+extern void leon3_getCacheRegs(struct leon3_cacheregs *regs);
+extern int leon_flush_needed(void);
+extern void leon_switch_mm(void);
+extern int srmmu_swprobe_trace;
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASSEMBLY__ */
+
+/* macros used in leon_mm.c */
+#define PFN(x)           ((x) >> PAGE_SHIFT)
+#define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
+#define _SRMMU_PTE_PMASK_LEON 0xffffffff
+
+#else /* defined(CONFIG_SPARC_LEON) */
+
+/* nop definitions for !LEON case */
+#define leon_init() do {} while (0)
+#define leon_switch_mm() do {} while (0)
+#define leon_init_IRQ() do {} while (0)
+#define init_leon() do {} while (0)
+
+#endif /* !defined(CONFIG_SPARC_LEON) */
+
+#endif
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
new file mode 100644
index 0000000..618e888
--- /dev/null
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -0,0 +1,263 @@
+/*
+*Copyright (C) 2004 Konrad Eisele (eiselekd@web.de,konrad@gaisler.com), Gaisler Research
+*Copyright (C) 2004 Stefan Holst (mail@s-holst.de), Uni-Stuttgart
+*Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),Konrad Eisele (konrad@gaisler.com) Aeroflex Gaisler AB
+*/
+
+#ifndef LEON_AMBA_H_INCLUDE
+#define LEON_AMBA_H_INCLUDE
+
+#ifndef __ASSEMBLY__
+
+struct amba_prom_registers {
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
+};
+
+#endif
+
+/*
+ *  The following defines the bits in the LEON UART Status Registers.
+ */
+
+#define LEON_REG_UART_STATUS_DR   0x00000001	/* Data Ready */
+#define LEON_REG_UART_STATUS_TSE  0x00000002	/* TX Send Register Empty */
+#define LEON_REG_UART_STATUS_THE  0x00000004	/* TX Hold Register Empty */
+#define LEON_REG_UART_STATUS_BR   0x00000008	/* Break Error */
+#define LEON_REG_UART_STATUS_OE   0x00000010	/* RX Overrun Error */
+#define LEON_REG_UART_STATUS_PE   0x00000020	/* RX Parity Error */
+#define LEON_REG_UART_STATUS_FE   0x00000040	/* RX Framing Error */
+#define LEON_REG_UART_STATUS_ERR  0x00000078	/* Error Mask */
+
+/*
+ *  The following defines the bits in the LEON UART Ctrl Registers.
+ */
+
+#define LEON_REG_UART_CTRL_RE     0x00000001	/* Receiver enable */
+#define LEON_REG_UART_CTRL_TE     0x00000002	/* Transmitter enable */
+#define LEON_REG_UART_CTRL_RI     0x00000004	/* Receiver interrupt enable */
+#define LEON_REG_UART_CTRL_TI     0x00000008	/* Transmitter irq */
+#define LEON_REG_UART_CTRL_PS     0x00000010	/* Parity select */
+#define LEON_REG_UART_CTRL_PE     0x00000020	/* Parity enable */
+#define LEON_REG_UART_CTRL_FL     0x00000040	/* Flow control enable */
+#define LEON_REG_UART_CTRL_LB     0x00000080	/* Loop Back enable */
+
+#define LEON3_GPTIMER_EN 1
+#define LEON3_GPTIMER_RL 2
+#define LEON3_GPTIMER_LD 4
+#define LEON3_GPTIMER_IRQEN 8
+#define LEON3_GPTIMER_SEPIRQ 8
+
+#define LEON23_REG_TIMER_CONTROL_EN    0x00000001 /* 1 = enable counting */
+/* 0 = hold scalar and counter */
+#define LEON23_REG_TIMER_CONTROL_RL    0x00000002 /* 1 = reload at 0 */
+						  /* 0 = stop at 0 */
+#define LEON23_REG_TIMER_CONTROL_LD    0x00000004 /* 1 = load counter */
+						  /* 0 = no function */
+#define LEON23_REG_TIMER_CONTROL_IQ    0x00000008 /* 1 = irq enable */
+						  /* 0 = no function */
+
+/*
+ *  The following defines the bits in the LEON PS/2 Status Registers.
+ */
+
+#define LEON_REG_PS2_STATUS_DR   0x00000001	/* Data Ready */
+#define LEON_REG_PS2_STATUS_PE   0x00000002	/* Parity error */
+#define LEON_REG_PS2_STATUS_FE   0x00000004	/* Framing error */
+#define LEON_REG_PS2_STATUS_KI   0x00000008	/* Keyboard inhibit */
+#define LEON_REG_PS2_STATUS_RF   0x00000010	/* RX buffer full */
+#define LEON_REG_PS2_STATUS_TF   0x00000020	/* TX buffer full */
+
+/*
+ *  The following defines the bits in the LEON PS/2 Ctrl Registers.
+ */
+
+#define LEON_REG_PS2_CTRL_RE 0x00000001	/* Receiver enable */
+#define LEON_REG_PS2_CTRL_TE 0x00000002	/* Transmitter enable */
+#define LEON_REG_PS2_CTRL_RI 0x00000004	/* Keyboard receive irq  */
+#define LEON_REG_PS2_CTRL_TI 0x00000008	/* Keyboard transmit irq */
+
+#define LEON3_IRQMPSTATUS_CPUNR     28
+#define LEON3_IRQMPSTATUS_BROADCAST 27
+
+#define GPTIMER_CONFIG_IRQNT(a)          (((a) >> 3) & 0x1f)
+#define GPTIMER_CONFIG_ISSEP(a)          ((a) & (1 << 8))
+#define GPTIMER_CONFIG_NTIMERS(a)        ((a) & (0x7))
+#define LEON3_GPTIMER_CTRL_PENDING       0x10
+#define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
+#define LEON3_GPTIMER_CTRL_ISPENDING(r)  (((r)&LEON3_GPTIMER_CTRL_PENDING) ? 1 : 0)
+
+#ifdef CONFIG_SPARC_LEON
+
+#ifndef __ASSEMBLY__
+
+struct leon3_irqctrl_regs_map {
+	u32 ilevel;
+	u32 ipend;
+	u32 iforce;
+	u32 iclear;
+	u32 mpstatus;
+	u32 mpbroadcast;
+	u32 notused02;
+	u32 notused03;
+	u32 notused10;
+	u32 notused11;
+	u32 notused12;
+	u32 notused13;
+	u32 notused20;
+	u32 notused21;
+	u32 notused22;
+	u32 notused23;
+	u32 mask[16];
+	u32 force[16];
+	/* Extended IRQ registers */
+	u32 intid[16];	/* 0xc0 */
+};
+
+struct leon3_apbuart_regs_map {
+	u32 data;
+	u32 status;
+	u32 ctrl;
+	u32 scaler;
+};
+
+struct leon3_gptimerelem_regs_map {
+	u32 val;
+	u32 rld;
+	u32 ctrl;
+	u32 unused;
+};
+
+struct leon3_gptimer_regs_map {
+	u32 scalar;
+	u32 scalar_reload;
+	u32 config;
+	u32 unused;
+	struct leon3_gptimerelem_regs_map e[8];
+};
+
+/*
+ *  Types and structure used for AMBA Plug & Play bus scanning
+ */
+
+#define AMBA_MAXAPB_DEVS 64
+#define AMBA_MAXAPB_DEVS_PERBUS 16
+
+struct amba_device_table {
+	int devnr;		   /* number of devices on AHB or APB bus */
+	unsigned int *addr[16];    /* addresses to the devices configuration tables */
+	unsigned int allocbits[1]; /* 0=unallocated, 1=allocated driver */
+};
+
+struct amba_apbslv_device_table {
+	int devnr;		                  /* number of devices on AHB or APB bus */
+	unsigned int *addr[AMBA_MAXAPB_DEVS];     /* addresses to the devices configuration tables */
+	unsigned int apbmst[AMBA_MAXAPB_DEVS];    /* apb master if a entry is a apb slave */
+	unsigned int apbmstidx[AMBA_MAXAPB_DEVS]; /* apb master idx if a entry is a apb slave */
+	unsigned int allocbits[4];                /* 0=unallocated, 1=allocated driver */
+};
+
+struct amba_confarea_type {
+	struct amba_confarea_type *next;/* next bus in chain */
+	struct amba_device_table ahbmst;
+	struct amba_device_table ahbslv;
+	struct amba_apbslv_device_table apbslv;
+	unsigned int apbmst;
+};
+
+/* collect apb slaves */
+struct amba_apb_device {
+	unsigned int start, irq, bus_id;
+	struct amba_confarea_type *bus;
+};
+
+/* collect ahb slaves */
+struct amba_ahb_device {
+	unsigned int start[4], irq, bus_id;
+	struct amba_confarea_type *bus;
+};
+
+struct device_node;
+void _amba_init(struct device_node *dp, struct device_node ***nextp);
+
+extern struct leon3_irqctrl_regs_map *leon3_irqctrl_regs;
+extern struct leon3_gptimer_regs_map *leon3_gptimer_regs;
+extern struct amba_apb_device leon_percpu_timer_dev[16];
+extern int leondebug_irq_disable;
+extern int leon_debug_irqout;
+extern unsigned long leon3_gptimer_irq;
+extern unsigned int sparc_leon_eirq;
+
+#endif /* __ASSEMBLY__ */
+
+#define LEON3_IO_AREA 0xfff00000
+#define LEON3_CONF_AREA 0xff000
+#define LEON3_AHB_SLAVE_CONF_AREA (1 << 11)
+
+#define LEON3_AHB_CONF_WORDS 8
+#define LEON3_APB_CONF_WORDS 2
+#define LEON3_AHB_MASTERS 16
+#define LEON3_AHB_SLAVES 16
+#define LEON3_APB_SLAVES 16
+#define LEON3_APBUARTS 8
+
+/* Vendor codes */
+#define VENDOR_GAISLER   1
+#define VENDOR_PENDER    2
+#define VENDOR_ESA       4
+#define VENDOR_OPENCORES 8
+
+/* Gaisler Research device id's */
+#define GAISLER_LEON3    0x003
+#define GAISLER_LEON3DSU 0x004
+#define GAISLER_ETHAHB   0x005
+#define GAISLER_APBMST   0x006
+#define GAISLER_AHBUART  0x007
+#define GAISLER_SRCTRL   0x008
+#define GAISLER_SDCTRL   0x009
+#define GAISLER_APBUART  0x00C
+#define GAISLER_IRQMP    0x00D
+#define GAISLER_AHBRAM   0x00E
+#define GAISLER_GPTIMER  0x011
+#define GAISLER_PCITRG   0x012
+#define GAISLER_PCISBRG  0x013
+#define GAISLER_PCIFBRG  0x014
+#define GAISLER_PCITRACE 0x015
+#define GAISLER_PCIDMA   0x016
+#define GAISLER_AHBTRACE 0x017
+#define GAISLER_ETHDSU   0x018
+#define GAISLER_PIOPORT  0x01A
+#define GAISLER_GRGPIO   0x01A
+#define GAISLER_AHBJTAG  0x01c
+#define GAISLER_ETHMAC   0x01D
+#define GAISLER_AHB2AHB  0x020
+#define GAISLER_USBDC    0x021
+#define GAISLER_ATACTRL  0x024
+#define GAISLER_DDRSPA   0x025
+#define GAISLER_USBEHC   0x026
+#define GAISLER_USBUHC   0x027
+#define GAISLER_I2CMST   0x028
+#define GAISLER_SPICTRL  0x02D
+#define GAISLER_DDR2SPA  0x02E
+#define GAISLER_SPIMCTRL 0x045
+#define GAISLER_LEON4    0x048
+#define GAISLER_LEON4DSU 0x049
+#define GAISLER_AHBSTAT  0x052
+#define GAISLER_FTMCTRL  0x054
+#define GAISLER_KBD      0x060
+#define GAISLER_VGA      0x061
+#define GAISLER_SVGA     0x063
+#define GAISLER_GRSYSMON 0x066
+#define GAISLER_GRACECTRL 0x067
+
+#define GAISLER_L2TIME   0xffd	/* internal device: leon2 timer */
+#define GAISLER_L2C      0xffe	/* internal device: leon2compat */
+#define GAISLER_PLUGPLAY 0xfff	/* internal device: plug & play configarea */
+
+#define amba_vendor(x) (((x) >> 24) & 0xff)
+
+#define amba_device(x) (((x) >> 12) & 0xfff)
+
+#endif /* !defined(CONFIG_SPARC_LEON) */
+
+#endif
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
new file mode 100644
index 0000000..54d8a5b
--- /dev/null
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -0,0 +1,203 @@
+/*
+ * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com) Aeroflex Gaisler AB
+ * Copyright (C) 2009 Konrad Eisele (konrad@gaisler.com) Aeroflex Gaisler AB
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/interrupt.h>
+#include <linux/of_device.h>
+#include <asm/oplib.h>
+#include <asm/timer.h>
+#include <asm/prom.h>
+#include <asm/leon.h>
+#include <asm/leon_amba.h>
+
+#include "prom.h"
+#include "irq.h"
+
+struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address, initialized by amba_init() */
+struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address, initialized by amba_init() */
+struct amba_apb_device leon_percpu_timer_dev[16];
+
+int leondebug_irq_disable;
+int leon_debug_irqout;
+static int dummy_master_l10_counter;
+
+unsigned long leon3_gptimer_irq; /* interrupt controller irq number, initialized by amba_init() */
+unsigned int sparc_leon_eirq;
+#define LEON_IMASK ((&leon3_irqctrl_regs->mask[0]))
+
+/* Return the IRQ of the pending IRQ on the extended IRQ controller */
+int sparc_leon_eirq_get(int eirq, int cpu)
+{
+	return LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->intid[cpu]) & 0x1f;
+}
+
+irqreturn_t sparc_leon_eirq_isr(int dummy, void *dev_id)
+{
+	printk(KERN_ERR "sparc_leon_eirq_isr: ERROR EXTENDED IRQ\n");
+	return IRQ_HANDLED;
+}
+
+/* The extended IRQ controller has been found, this function registers it */
+void sparc_leon_eirq_register(int eirq)
+{
+	int irq;
+
+	/* Register a "BAD" handler for this interrupt, it should never happen */
+	irq = request_irq(eirq, sparc_leon_eirq_isr,
+			  (IRQF_DISABLED | SA_STATIC_ALLOC), "extirq", NULL);
+
+	if (irq) {
+		printk(KERN_ERR
+		       "sparc_leon_eirq_register: unable to attach IRQ%d\n",
+		       eirq);
+	} else {
+		sparc_leon_eirq = eirq;
+	}
+
+}
+
+static inline unsigned long get_irqmask(unsigned int irq)
+{
+	unsigned long mask;
+
+	if (!irq || ((irq > 0xf) && !sparc_leon_eirq)
+	    || ((irq > 0x1f) && sparc_leon_eirq)) {
+		printk(KERN_ERR
+		       "leon_get_irqmask: false irq number: %d\n", irq);
+		mask = 0;
+	} else {
+		mask = LEON_HARD_INT(irq);
+	}
+	return mask;
+}
+
+static void leon_enable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr);
+	local_irq_save(flags);
+	LEON3_BYPASS_STORE_PA(LEON_IMASK,
+			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) | (mask)));
+	local_irq_restore(flags);
+}
+
+static void leon_disable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr);
+	local_irq_save(flags);
+	LEON3_BYPASS_STORE_PA(LEON_IMASK,
+			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) & ~(mask)));
+	local_irq_restore(flags);
+
+}
+
+void __init leon_init_timers(irq_handler_t counter_fn)
+{
+	int irq;
+
+	leondebug_irq_disable = 0;
+	leon_debug_irqout = 0;
+	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
+	dummy_master_l10_counter = 0;
+
+	if (leon3_gptimer_regs && leon3_irqctrl_regs) {
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].val, 0);
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].rld,
+				      (((1000000 / 100) - 1)));
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl, 0);
+
+	} else {
+		printk(KERN_ERR "No Timer/irqctrl found\n");
+		BUG();
+	}
+
+	irq = request_irq(leon3_gptimer_irq,
+			  counter_fn,
+			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+
+	if (irq) {
+		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
+		       LEON_INTERRUPT_TIMER1);
+		prom_halt();
+	}
+
+	if (leon3_gptimer_regs) {
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+	}
+}
+
+void leon_clear_clock_irq(void)
+{
+}
+
+void leon_load_profile_irq(int cpu, unsigned int limit)
+{
+	BUG();
+}
+
+
+
+
+void __init leon_trans_init(struct device_node *dp)
+{
+	if (strcmp(dp->type, "cpu") = 0 && strcmp(dp->name, "<NULL>") = 0) {
+		struct property *p;
+		p = of_find_property(dp, "mid", (void *)0);
+		if (p) {
+			int mid;
+			dp->name = prom_early_alloc(5 + 1);
+			memcpy(&mid, p->value, p->length);
+			sprintf((char *)dp->name, "cpu%.2d", mid);
+		}
+	}
+}
+
+void __initdata (*prom_amba_init)(struct device_node *dp, struct device_node ***nextp) = 0;
+
+void __init leon_node_init(struct device_node *dp, struct device_node ***nextp)
+{
+	if (prom_amba_init &&
+	    strcmp(dp->type, "ambapp") = 0 &&
+	    strcmp(dp->name, "ambapp0") = 0) {
+		prom_amba_init(dp, nextp);
+	}
+}
+
+void __init leon_init_IRQ(void)
+{
+	sparc_init_timers = leon_init_timers;
+
+	BTFIXUPSET_CALL(enable_irq, leon_enable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(disable_irq, leon_disable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(enable_pil_irq, leon_enable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(disable_pil_irq, leon_disable_irq, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq,
+			BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(load_profile_irq, leon_load_profile_irq,
+			BTFIXUPCALL_NOP);
+
+#ifdef CONFIG_SMP
+	BTFIXUPSET_CALL(set_cpu_int, leon_set_cpu_int, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(clear_cpu_int, leon_clear_ipi, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(set_irq_udt, leon_set_udt, BTFIXUPCALL_NORM);
+#endif
+
+}
+
+void __init leon_init(void)
+{
+	prom_build_more = &leon_node_init;
+}
diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
new file mode 100644
index 0000000..c0e0129
--- /dev/null
+++ b/arch/sparc/mm/leon_mm.c
@@ -0,0 +1,260 @@
+/*
+ *  linux/arch/sparc/mm/leon_m.c
+ *
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de, konrad@gaisler.com) Gaisler Research
+ * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com) Aeroflex Gaisler AB
+ * Copyright (C) 2009 Konrad Eisele (konrad@gaisler.com) Aeroflex Gaisler AB
+ *
+ * do srmmu probe in software
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/asi.h>
+#include <asm/leon.h>
+#include <asm/tlbflush.h>
+
+int leon_flush_during_switch = 1;
+int srmmu_swprobe_trace;
+
+unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr)
+{
+
+	unsigned int ctxtbl;
+	unsigned int pgd, pmd, ped;
+	unsigned int ptr;
+	unsigned int lvl, pte, paddrbase;
+	unsigned int ctx;
+	unsigned int paddr_calc;
+
+	paddrbase = 0;
+
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe: trace on\n");
+
+	ctxtbl = srmmu_get_ctable_ptr();
+	if (!(ctxtbl)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: srmmu_get_ctable_ptr returned 0=>0\n");
+		return 0;
+	}
+	if (!_pfn_valid(PFN(ctxtbl))) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO
+			       "swprobe: !_pfn_valid(%x)=>0\n",
+			       PFN(ctxtbl));
+		return 0;
+	}
+
+	ctx = srmmu_get_context();
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe:  --- ctx (%x) ---\n", ctx);
+
+	pgd = LEON_BYPASS_LOAD_PA(ctxtbl + (ctx * 4));
+
+	if (((pgd & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pgd is entry level 3\n");
+		lvl = 3;
+		pte = pgd;
+		paddrbase = pgd & _SRMMU_PTE_PMASK_LEON;
+		goto ready;
+	}
+	if (((pgd & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pgd is invalid => 0\n");
+		return 0;
+	}
+
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe:  --- pgd (%x) ---\n", pgd);
+
+	ptr = (pgd & SRMMU_PTD_PMASK) << 4;
+	ptr += ((((vaddr) >> LEON_PGD_SH) & LEON_PGD_M) * 4);
+	if (!_pfn_valid(PFN(ptr)))
+		return 0;
+
+	pmd = LEON_BYPASS_LOAD_PA(ptr);
+	if (((pmd & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pmd is entry level 2\n");
+		lvl = 2;
+		pte = pmd;
+		paddrbase = pmd & _SRMMU_PTE_PMASK_LEON;
+		goto ready;
+	}
+	if (((pmd & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pmd is invalid => 0\n");
+		return 0;
+	}
+
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe:  --- pmd (%x) ---\n", pmd);
+
+	ptr = (pmd & SRMMU_PTD_PMASK) << 4;
+	ptr += (((vaddr >> LEON_PMD_SH) & LEON_PMD_M) * 4);
+	if (!_pfn_valid(PFN(ptr))) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: !_pfn_valid(%x)=>0\n",
+			       PFN(ptr));
+		return 0;
+	}
+
+	ped = LEON_BYPASS_LOAD_PA(ptr);
+
+	if (((ped & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: ped is entry level 1\n");
+		lvl = 1;
+		pte = ped;
+		paddrbase = ped & _SRMMU_PTE_PMASK_LEON;
+		goto ready;
+	}
+	if (((ped & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: ped is invalid => 0\n");
+		return 0;
+	}
+
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe:  --- ped (%x) ---\n", ped);
+
+	ptr = (ped & SRMMU_PTD_PMASK) << 4;
+	ptr += (((vaddr >> LEON_PTE_SH) & LEON_PTE_M) * 4);
+	if (!_pfn_valid(PFN(ptr)))
+		return 0;
+
+	ptr = LEON_BYPASS_LOAD_PA(ptr);
+	if (((ptr & SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: ptr is entry level 0\n");
+		lvl = 0;
+		pte = ptr;
+		paddrbase = ptr & _SRMMU_PTE_PMASK_LEON;
+		goto ready;
+	}
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe: ptr is invalid => 0\n");
+	return 0;
+
+ready:
+	switch (lvl) {
+	case 0:
+		paddr_calc +		    (vaddr & ~(-1 << LEON_PTE_SH)) | ((pte & ~0xff) << 4);
+		break;
+	case 1:
+		paddr_calc +		    (vaddr & ~(-1 << LEON_PMD_SH)) | ((pte & ~0xff) << 4);
+		break;
+	case 2:
+		paddr_calc +		    (vaddr & ~(-1 << LEON_PGD_SH)) | ((pte & ~0xff) << 4);
+		break;
+	default:
+	case 3:
+		paddr_calc = vaddr;
+		break;
+	}
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe: padde %x\n", paddr_calc);
+	if (paddr)
+		*paddr = paddr_calc;
+	return paddrbase;
+}
+
+void leon_flush_icache_all(void)
+{
+	__asm__ __volatile__(" flush ");	/*iflush*/
+}
+
+void leon_flush_dcache_all(void)
+{
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
+			     "i"(ASI_LEON_DFLUSH) : "memory");
+}
+
+void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned long page)
+{
+	if (vma->vm_flags & VM_EXEC)
+		leon_flush_icache_all();
+	leon_flush_dcache_all();
+}
+
+void leon_flush_cache_all(void)
+{
+	__asm__ __volatile__(" flush ");	/*iflush*/
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
+			     "i"(ASI_LEON_DFLUSH) : "memory");
+}
+
+void leon_flush_tlb_all(void)
+{
+	leon_flush_cache_all();
+	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : : "r"(0x400),
+			     "i"(ASI_LEON_MMUFLUSH) : "memory");
+}
+
+/* get all cache regs */
+void leon3_getCacheRegs(struct leon3_cacheregs *regs)
+{
+	unsigned long ccr, iccr, dccr;
+
+	if (!regs)
+		return;
+	/* Get Cache regs from "Cache ASI" address 0x0, 0x8 and 0xC */
+	__asm__ __volatile__("lda [%%g0] %3, %0\n\t"
+			     "mov 0x08, %%g1\n\t"
+			     "lda [%%g1] %3, %1\n\t"
+			     "mov 0x0c, %%g1\n\t"
+			     "lda [%%g1] %3, %2\n\t"
+			     : "=r"(ccr), "=r"(iccr), "=r"(dccr)
+			       /* output */
+			     : "i"(ASI_LEON_CACHEREGS)	/* input */
+			     : "g1"	/* clobber list */
+	    );
+	regs->ccr = ccr;
+	regs->iccr = iccr;
+	regs->dccr = dccr;
+}
+
+/* Due to virtual cache we need to check cache configuration if
+ * it is possible to skip flushing in some cases.
+ *
+ * Leon2 and Leon3 differ in their way of telling cache information
+ *
+ */
+int leon_flush_needed(void)
+{
+	int flush_needed = -1;
+	unsigned int ssize, sets;
+	char *setStr[4] +	    { "direct mapped", "2-way associative", "3-way associative",
+		"4-way associative"
+	};
+	/* leon 3 */
+	struct leon3_cacheregs cregs;
+	leon3_getCacheRegs(&cregs);
+	sets = (cregs.dccr & LEON3_XCCR_SETS_MASK) >> 24;
+	/* (ssize=>realsize) 0=>1k, 1=>2k, 2=>4k, 3=>8k ... */
+	ssize = 1 << ((cregs.dccr & LEON3_XCCR_SSIZE_MASK) >> 20);
+
+	printk(KERN_INFO "CACHE: %s cache, set size %dk\n",
+	       sets > 3 ? "unknown" : setStr[sets], ssize);
+	if ((ssize <= (PAGE_SIZE / 1024)) && (sets = 0)) {
+		/* Set Size <= Page size  =>
+		   flush on every context switch not needed. */
+		flush_needed = 0;
+		printk(KERN_INFO "CACHE: not flushing on every context switch\n");
+	}
+	return flush_needed;
+}
+
+void leon_switch_mm(void)
+{
+	flush_tlb_mm((void *)0);
+	if (leon_flush_during_switch)
+		leon_flush_cache_all();
+}
-- 
1.6.3.2

