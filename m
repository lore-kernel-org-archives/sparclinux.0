From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 09 Jun 2009 11:21:51 +0000
Subject: [PATCH 1/7] CONFIG_LEON option
Message-Id: <4A2E45CF.8070106@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030500070100000506010603"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------030500070100000506010603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From f34daa99d7a0f397a5314142abf951ef8305dfea Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:50:43 +0200
Subject: [PATCH 1/7] CONFIG_LEON option
This macro will shield, if undefined, the sun-sparc code
from LEON specific code. In particular include/asm/leon.h
will get empty through #ifdef arch/sparc/kernel/leon.c not
compiled through Makefile:obj-$(CONFIG_LEON)
arch/sparc/mm/leon.c not compiled through Makefile:obj-$(CONFIG_LEON)

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
  arch/sparc/Kconfig                   |    6
  arch/sparc/configs/sparc32_defconfig |    1
  arch/sparc/include/asm/leon.h        |  678 ++++++++++++++++++++++++++++++++++
  arch/sparc/kernel/leon.c             |  310 ++++++++++++++++
  arch/sparc/mm/leon.c                 |  266 +++++++++++++
  5 files changed, 1261 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 2185cf9..9f7aeb6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -435,6 +435,12 @@ config SERIAL_CONSOLE

  	  If unsure, say N.

+config LEON
+	bool "Leon processor family"
+	depends on SPARC32
+	---help---
+	  If you say Y here if you are running on a LEON processor.
+
  endmenu

  menu "Bus options (PCI etc.)"
diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index 09ab46e..3556a60 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -147,6 +147,7 @@ CONFIG_UNEVICTABLE_LRU=y
  CONFIG_SUN_PM=y
  # CONFIG_SPARC_LED is not set
  CONFIG_SERIAL_CONSOLE=y
+# CONFIG_LEON is not set

  #
  # Bus options (PCI etc.)
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
new file mode 100644
index 0000000..b440994
--- /dev/null
+++ b/arch/sparc/include/asm/leon.h
@@ -0,0 +1,678 @@
+/*
+*Copyright (C) 2004 Konrad Eisele (eiselekd@web.de,
+*konrad@gaisler.com), Gaisler Research
+*Copyright (C) 2004 Stefan Holst (mail@s-holst.de), Uni-Stuttgart
+*Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
+*Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB
+*/
+
+#ifndef LEON_H_INCLUDE
+#define LEON_H_INCLUDE
+
+#if defined(CONFIG_LEON)
+
+#define ASI_LEON_NOCACHE	0x01
+
+#define ASI_LEON_DCACHE_MISS	0x1
+
+#define ASI_LEON_CACHEREGS 0x02
+#define ASI_LEON_IFLUSH		0x10
+#define ASI_LEON_DFLUSH		0x11
+
+#define ASI_LEON_MMUFLUSH	0x18
+#define ASI_LEON_MMUREGS	0x19
+#define ASI_LEON_BYPASS		0x1c
+#define ASI_LEON_FLUSH_PAGE	0x10
+
+#define LEON_TYPEDEF typedef
+#define LEON_VOLATILE volatile
+
+/*
+constant ASI_SYSR    : asi_type := "00010"; -- 0x02
+constant ASI_UINST   : asi_type := "01000"; -- 0x08
+constant ASI_SINST   : asi_type := "01001"; -- 0x09
+constant ASI_UDATA   : asi_type := "01010"; -- 0x0A
+constant ASI_SDATA   : asi_type := "01011"; -- 0x0B
+constant ASI_ITAG    : asi_type := "01100"; -- 0x0C
+constant ASI_IDATA   : asi_type := "01101"; -- 0x0D
+constant ASI_DTAG    : asi_type := "01110"; -- 0x0E
+constant ASI_DDATA   : asi_type := "01111"; -- 0x0F
+constant ASI_IFLUSH  : asi_type := "10000"; -- 0x10
+constant ASI_DFLUSH  : asi_type := "10001"; -- 0x11
+
+constant ASI_FLUSH_PAGE     : std_logic_vector(4 downto 0) := "10000";
+constant ASI_FLUSH_CTX      : std_logic_vector(4 downto 0) := "10011";
+
+constant ASI_DCTX           : std_logic_vector(4 downto 0) := "10100";
+constant ASI_ICTX           : std_logic_vector(4 downto 0) := "10101";
+
+constant ASI_MMUFLUSHPROBE  : std_logic_vector(4 downto 0) := "11000";
+constant ASI_MMUREGS        : std_logic_vector(4 downto 0) := "11001";
+constant ASI_MMU_BP         : std_logic_vector(4 downto 0) := "11100";
+constant ASI_MMU_DIAG       : std_logic_vector(4 downto 0) := "11101";
+constant ASI_MMU_DSU        : std_logic_vector(4 downto 0) := "11111";
+*/
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
+#define LEON_USTAT_ERROR (LEON_USTAT_OV|LEON_USTAT_PE|LEON_USTAT_FE)
+/*no break yet */
+
+#ifdef CONFIG_OPEN_ETH
+#define LEON_ETH_BASE_ADD ((unsigned long)LEON_VA_ETHERMAC)
+/* map leon on ethermac adress space at pa 0xb0000000 */
+#define LEON_VA_ETHERMAC     DVMA_VADDR
+#endif
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
+#define LEON3_BYPASS_LOAD_PA(x)	(leon_load_reg((unsigned long)(x)))
+#define LEON3_BYPASS_STORE_PA(x, v) \
+	(leon_store_reg((unsigned long)(x), (unsigned long)(v)))
+#define LEON3_BYPASS_ANDIN_PA(x, v) \
+	LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) & v)
+#define LEON3_BYPASS_ORIN_PA(x, v) \
+	LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) | v)
+
+#define LEON_BYPASS_LOAD_PA(x)		\
+	leon_load_reg((unsigned long)(x))
+#define LEON_BYPASSCACHE_LOAD_VA(x)	\
+	leon_readnobuffer_reg((unsigned long)(x))
+#define LEON_BYPASS_STORE_PA(x, v)	\
+	leon_store_reg((unsigned long)(x), (unsigned long)(v))
+#define LEON_REGLOAD_PA(x)		\
+	leon_load_reg((unsigned long)(x)+LEON_PREGS)
+#define LEON_REGSTORE_PA(x, v)		\
+	leon_store_reg((unsigned long)(x)+LEON_PREGS, (unsigned long)(v))
+#define LEON_REGSTORE_OR_PA(x, v)	\
+	LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x)|(unsigned long)(v))
+#define LEON_REGSTORE_AND_PA(x, v)	\
+	LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x)&(unsigned long)(v))
+
+/*#define LEONSETUP_MEM_BASEADDR 0x40000000*/
+
+#define HARDDBG_PRINTF(fmt, arg...) do {		\
+		char b[1000];				\
+		sprintf(b, fmt, ## arg);		\
+		console_print_LEON(b); } while (0)
+#define HARDDBG_FUNC  \
+	HARDDBG_PRINTF("[->%03d @ %22s()]:\n" , __LINE__, __func__);
+#define HARDDBG_FUNCOUT \
+	HARDDBG_PRINTF("[<-%03d @ %22s()]:\n" , __LINE__, __func__);
+#define HARDDBG_OUT(fmt, arg...) \
+	HARDDBG_PRINTF("[->%03d @ %22s()]:" fmt , __LINE__, __func__, ## arg);
+
+#endif /* !ASM */
+
+#if 1
+
+#ifndef __ASSEMBLER__
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
+struct amba_prom_registers {
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
+};
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int ilevel;
+	LEON_VOLATILE unsigned int ipend;
+	LEON_VOLATILE unsigned int iforce;
+	LEON_VOLATILE unsigned int iclear;
+	LEON_VOLATILE unsigned int mpstatus;
+	LEON_VOLATILE unsigned int mpbroadcast;
+	LEON_VOLATILE unsigned int notused02;
+	LEON_VOLATILE unsigned int notused03;
+	LEON_VOLATILE unsigned int notused10;
+	LEON_VOLATILE unsigned int notused11;
+	LEON_VOLATILE unsigned int notused12;
+	LEON_VOLATILE unsigned int notused13;
+	LEON_VOLATILE unsigned int notused20;
+	LEON_VOLATILE unsigned int notused21;
+	LEON_VOLATILE unsigned int notused22;
+	LEON_VOLATILE unsigned int notused23;
+	LEON_VOLATILE unsigned int mask[16];
+	LEON_VOLATILE unsigned int force[16];
+	/* Extended IRQ registers */
+	LEON_VOLATILE unsigned int intid[16];	/* 0xc0 */
+} LEON3_IrqCtrl_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int data;
+	LEON_VOLATILE unsigned int status;
+	LEON_VOLATILE unsigned int ctrl;
+	LEON_VOLATILE unsigned int scaler;
+} LEON3_APBUART_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int val;
+	LEON_VOLATILE unsigned int rld;
+	LEON_VOLATILE unsigned int ctrl;
+	LEON_VOLATILE unsigned int unused;
+} LEON3_GpTimerElem_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int scalar;
+	LEON_VOLATILE unsigned int scalar_reload;
+	LEON_VOLATILE unsigned int config;
+	LEON_VOLATILE unsigned int unused;
+	LEON_VOLATILE LEON3_GpTimerElem_Regs_Map e[8];
+} LEON3_GpTimer_Regs_Map;
+
+#define GPTIMER_CONFIG_IRQNT(a) (((a) >> 3) & 0x1f)
+#define GPTIMER_CONFIG_ISSEP(a) ((a)&(1<<8))
+#define GPTIMER_CONFIG_NTIMERS(a) ((a)&(0x7))
+#define LEON3_GPTIMER_CTRL_PENDING 0x10
+#define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
+#define LEON3_GPTIMER_CTRL_ISPENDING(r) \
+	(((r)&LEON3_GPTIMER_CTRL_PENDING) ? 1 : 0)
+
+LEON_TYPEDEF void (*GPTIMER_CALLBACK) (void);
+LEON_TYPEDEF struct _sparc_gptimer {
+	LEON3_GpTimer_Regs_Map *inst;
+	unsigned int ctrl, reload, value, scalarreload;
+	int irq, flags, idxinst, idx, enabled, connected, minscalar;
+	int ticksPerSecond, stat;
+	GPTIMER_CALLBACK callback;
+	int arg;
+} sparc_gptimer;
+
+#define GPTIMER_INST_TIMER_MAX 8
+LEON_TYPEDEF struct _sparc_gptimer_inst {
+	LEON3_GpTimer_Regs_Map *base;
+	unsigned int scalarreload;
+	int count, baseirq, free, config, connected, minscalar;
+	sparc_gptimer timers[GPTIMER_INST_TIMER_MAX];
+} sparc_gptimer_inst;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int iodata;
+	LEON_VOLATILE unsigned int ioout;
+	LEON_VOLATILE unsigned int iodir;
+	LEON_VOLATILE unsigned int irqmask;
+	LEON_VOLATILE unsigned int irqpol;
+	LEON_VOLATILE unsigned int irqedge;
+} LEON3_IOPORT_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int write;
+	LEON_VOLATILE unsigned int dummy;
+	LEON_VOLATILE unsigned int txcolor;
+	LEON_VOLATILE unsigned int bgcolor;
+} LEON3_VGA_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int status;	/* 0x00 */
+	LEON_VOLATILE unsigned int video_length;	/* 0x04 */
+	LEON_VOLATILE unsigned int front_porch;	/* 0x08 */
+	LEON_VOLATILE unsigned int sync_length;	/* 0x0c */
+	LEON_VOLATILE unsigned int line_length;	/* 0x10 */
+	LEON_VOLATILE unsigned int fb_pos;	/* 0x14 */
+	LEON_VOLATILE unsigned int clk_vector[4];	/* 0x18 */
+	LEON_VOLATILE unsigned int clut;	/* 0x28 */
+} LEON3_GRVGA_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int data;
+	LEON_VOLATILE unsigned int status;
+	LEON_VOLATILE unsigned int ctrl;
+	LEON_VOLATILE unsigned int reload;
+} LEON3_APBPS2_REGS_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int cfg_stat;
+	LEON_VOLATILE unsigned int bar0;
+	LEON_VOLATILE unsigned int page0;
+	LEON_VOLATILE unsigned int bar1;
+	LEON_VOLATILE unsigned int page1;
+	LEON_VOLATILE unsigned int iomap;
+	LEON_VOLATILE unsigned int stat_cmd;
+	LEON_VOLATILE unsigned int irq;
+} LEON3_GRPCI_Regs_Map;
+
+/*
+ *  Types and structure used for AMBA Plug & Play bus scanning
+ */
+
+#define AMBA_MAXAPB_DEVS 64
+#define AMBA_MAXAPB_DEVS_PERBUS 16
+
+LEON_TYPEDEF struct amba_device_table {
+	int devnr;		/* number of devices on AHB or APB bus */
+	/* addresses to the devices configuration tables */
+	unsigned int *addr[16];
+	/* 0=unallocated, 1=allocated driver */
+	unsigned int allocbits[1];
+} amba_device_table;
+
+LEON_TYPEDEF struct amba_apbslv_device_table {
+	int devnr;		/* number of devices on AHB or APB bus */
+	/* addresses to the devices configuration tables */
+	unsigned int *addr[AMBA_MAXAPB_DEVS];
+	/* apb master if a entry is a apb slave */
+	unsigned int apbmst[AMBA_MAXAPB_DEVS];
+	/* apb master idx if a entry is a apb slave */
+	unsigned int apbmstidx[AMBA_MAXAPB_DEVS];
+	unsigned int allocbits[4];/* 0=unallocated, 1=allocated driver */
+} amba_apbslv_device_table;
+
+LEON_TYPEDEF struct _amba_confarea_type {
+	struct _amba_confarea_type *next;/* next bus in chain */
+	amba_device_table ahbmst;
+	amba_device_table ahbslv;
+	amba_apbslv_device_table apbslv;
+	unsigned int apbmst;
+} amba_confarea_type;
+
+/* collect apb slaves */
+LEON_TYPEDEF struct amba_apb_device {
+	unsigned int start, irq, bus_id;
+	amba_confarea_type *bus;
+} amba_apb_device;
+
+/* collect ahb slaves */
+LEON_TYPEDEF struct amba_ahb_device {
+	unsigned int start[4], irq, bus_id;
+	amba_confarea_type *bus;
+} amba_ahb_device;
+
+extern void sparc_leon_eirq_register(int eirq);
+
+#if defined(CONFIG_SMP)
+# define LEON3_IRQ_RESCHEDULE		13
+# define LEON3_IRQ_TICKER		(leon_percpu_timer_dev[0].irq)
+# define LEON3_IRQ_CROSS_CALL		15
+#endif
+
+#define ASI_LEON3_SYSCTRL		0x02
+#define ASI_LEON3_SYSCTRL_ICFG		0x08
+#define ASI_LEON3_SYSCTRL_DCFG		0x0c
+#define ASI_LEON3_SYSCTRL_CFG_SNOOPING (1<<27)
+#define ASI_LEON3_SYSCTRL_CFG_SSIZE(c) (1<<((c>>20)&0xf))
+
+/* GCC for the host includes this, older GCC versions complain about
+ * sparc assembler if host is not a SPARC.
+ */
+#ifdef __sparc
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
+/*enable snooping*/
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
+#endif
+
+#endif /*!__ASSEMBLER__*/
+
+#if defined(PAGE_SIZE_LEON_8K)
+#define CONFIG_PAGE_SIZE_LEON 1
+#elif defined(PAGE_SIZE_LEON_16K)
+#define CONFIG_PAGE_SIZE_LEON 2)
+#else
+#define CONFIG_PAGE_SIZE_LEON 0
+#endif
+
+#if CONFIG_PAGE_SIZE_LEON == 0
+/* [ 8, 6, 6 ] + 12 */
+#define LEON_PGD_SH 24
+#define LEON_PGD_M  0xff
+#define LEON_PMD_SH 18
+#define LEON_PMD_SH_V (LEON_PGD_SH-2)
+#define LEON_PMD_M  0x3f
+#define LEON_PTE_SH 12
+#define LEON_PTE_M  0x3f
+#elif CONFIG_PAGE_SIZE_LEON == 1
+/* [ 7, 6, 6 ] + 13 */
+#define LEON_PGD_SH 25
+#define LEON_PGD_M  0x7f
+#define LEON_PMD_SH 19
+#define LEON_PMD_SH_V (LEON_PGD_SH-1)
+#define LEON_PMD_M  0x3f
+#define LEON_PTE_SH 13
+#define LEON_PTE_M  0x3f
+#elif CONFIG_PAGE_SIZE_LEON == 2
+/* [ 6, 6, 6 ] + 14 */
+#define LEON_PGD_SH 26
+#define LEON_PGD_M  0x3f
+#define LEON_PMD_SH 20
+#define LEON_PMD_SH_V (LEON_PGD_SH-0)
+#define LEON_PMD_M  0x3f
+#define LEON_PTE_SH 14
+#define LEON_PTE_M  0x3f
+#elif CONFIG_PAGE_SIZE_LEON == 3
+/* [ 4, 7, 6 ] + 15 */
+#define LEON_PGD_SH 28
+#define LEON_PGD_M  0x0f
+#define LEON_PMD_SH 21
+#define LEON_PMD_SH_V (LEON_PGD_SH-0)
+#define LEON_PMD_M  0x7f
+#define LEON_PTE_SH 15
+#define LEON_PTE_M  0x3f
+#else
+#error cannot determine CONFIG_PAGE_SIZE_LEON
+#endif
+
+#endif /* LEON3 */
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
+#define srmmu_hwprobe(addr) (srmmu_swprobe(addr, 0) & SRMMU_PTE_PMASK)
+extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
+extern void leon_flush_icache_all(void);
+extern void leon_flush_dcache_all(void);
+extern void leon_flush_cache_all(void);
+extern void leon_flush_tlb_all(void);
+extern int leon_flush_during_switch;
+extern int leon_flush_needed(void);
+
+/* struct that hold LEON3 cache configuration registers */
+struct leon3_cacheregs {	/* ASI=2 Address - name */
+	unsigned long ccr;	/* 0x00 - Cache Control Register  */
+	/* 0x08 - Instruction Cache Configuration Register */
+	unsigned long iccr;
+	unsigned long dccr;	/* 0x0c - Data Cache Configuration Register */
+};
+
+/* struct that hold LEON2 cache configuration register
+   & configuration register */
+struct leon2_cacheregs {
+	unsigned long ccr, cfg;
+};
+
+#endif
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
+#endif /*defined(CONFIG_LEON) */
+
+#endif
diff --git a/arch/sparc/kernel/leon.c b/arch/sparc/kernel/leon.c
new file mode 100644
index 0000000..2b60398
--- /dev/null
+++ b/arch/sparc/kernel/leon.c
@@ -0,0 +1,310 @@
+/* Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
+   Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/interrupt.h>
+#include <asm/prom.h>
+#include <asm/oplib.h>
+#include <asm/leon.h>
+#include <asm/timer.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+#include "prom.h"
+#include "irq.h"
+
+LEON_VOLATILE LEON3_IrqCtrl_Regs_Map *LEON3_IrqCtrl_Regs;
+LEON_VOLATILE LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs;
+amba_apb_device leon_percpu_timer_dev[16];
+#define LEON3_SMPTicker_Regs \
+	((LEON3_GpTimer_Regs_Map *)leon_percpu_timer_dev[0].start)
+int leondebug_irq_disable;
+int leon_debug_irqout;
+static int dummy_master_l10_counter;
+
+unsigned long LEON3_GpTimer_Irq;
+unsigned int sparc_leon_eirq;
+#undef LEON_IMASK
+#define LEON_IMASK ((&LEON3_IrqCtrl_Regs->mask[0]))
+
+/* Return the IRQ of the pending IRQ on the extended IRQ controller */
+int sparc_leon_eirq_get(int eirq, int cpu)
+{
+	return LEON3_BYPASS_LOAD_PA(&LEON3_IrqCtrl_Regs->intid[cpu]) & 0x1f;
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
+	/* Register a "BAD" handler for this interrupt,
+	   it should never happen */
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
+void leon_enable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr);
+	local_irq_save(flags);
+	LEON3_BYPASS_STORE_PA(LEON_IMASK,
+			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) | (mask)));
+	local_irq_restore(flags);
+}
+
+void leon_disable_irq(unsigned int irq_nr)
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
+	master_l10_counter = &dummy_master_l10_counter;
+	dummy_master_l10_counter = 0;
+
+	if (LEON3_GpTimer_Regs && LEON3_IrqCtrl_Regs) {
+		/*regs -> timerctrl1 = 0; */
+		/*regs -> timercnt1 = 0; */
+		/*regs -> timerload1 = (((1000000/100) - 1));*/
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].val, 0);
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].rld,
+				      (((1000000 / 100) - 1)));
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].ctrl, 0);
+
+#ifdef CONFIG_SMP
+# if defined(CONFIG_LEONSMP_USETIMER2)
+		leon_percpu_timer_dev[0].start = (int)LEON3_GpTimer_Regs;
+		leon_percpu_timer_dev[0].irq = LEON3_GpTimer_Irq + 1;
+
+		if (!
+		    (LEON3_BYPASS_LOAD_PA(&LEON3_GpTimer_Regs->config) &
+		     (1 << LEON3_GPTIMER_SEPIRQ))) {
+			prom_printf
+			    ("irq timer not configured with seperate irqs \n");
+			BUG();
+		}
+
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].val, 0);
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].rld,
+				      (((1000000 / 100) - 1)));
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].ctrl, 0);
+#else
+		{
+			leon_percpu_timer_dev[0].start = 0;
+			int i =
+			amba_get_free_apbslv_devices(VENDOR_GAISLER,
+						     GAISLER_GPTIMER,
+						     leon_percpu_timer_dev,
+						     2);
+			if (i < 1) {
+				prom_printf("Cannot lock "
+					    "GAISLER_GPTIMER timer "
+					    "for smp-ticker\n");
+				BUG();
+			}
+			if (leon_percpu_timer_dev[0].start ==
+			    LEON3_GpTimer_Regs) {
+				if (i < 2) {
+					prom_printf("Cannot lock"
+						    " GAISLER_GPTIMER timer "
+						    "for smp-ticker\n");
+					BUG();
+				}
+				leon_percpu_timer_dev[0] =
+				    leon_percpu_timer_dev[1];
+			}
+
+			printk(KERN_INFO "Leon smp ticker at 0x%x irq %d\n",
+			       leon_percpu_timer_dev[0].start,
+			       leon_percpu_timer_dev[0].irq);
+
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].val,
+					      0);
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].rld,
+					      (((1000000 / 100) - 1)));
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].ctrl,
+					      0);
+
+			/* copy over 100hz scaler */
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->scalar,
+					      LEON3_BYPASS_LOAD_PA
+					      (&LEON3_GpTimer_Regs->scalar));
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->
+					      scalar_reload,
+					      LEON3_BYPASS_LOAD_PA
+					      (&LEON3_GpTimer_Regs->
+					       scalar_reload));
+
+		}
+# endif
+# endif
+	} else {
+		while (1)
+			printk(KERN_ERR "No Timer/irqctrl found\n");
+	}
+
+	irq = request_irq(LEON3_GpTimer_Irq,
+			  counter_fn,
+			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+
+	if (irq) {
+		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
+		       LEON_INTERRUPT_TIMER1);
+		prom_halt();
+	}
+# ifdef CONFIG_SMP
+	{
+		unsigned long flags;
+		struct tt_entry *trap_table =
+		    &sparc_ttable[SP_TRAP_IRQ1 +
+				  (leon_percpu_timer_dev[0].irq - 1)];
+
+		extern unsigned int real_irq_entry[], smpleon_ticker[];
+		extern unsigned int patchme_maybe_smp_msg[];
+
+		/* For SMP we use the level 14 ticker, however the bootup code
+		 * has copied the firmwares level 14 vector into boot cpu's
+		 * trap table, we must fix this now or we get squashed.
+		 */
+		local_irq_save(flags);
+
+		patchme_maybe_smp_msg[0] = 0x01000000;	/* NOP out the branch */
+
+		/* Adjust so that we jump directly to smpleon_ticker */
+		trap_table->inst_three += smpleon_ticker - real_irq_entry;
+
+		local_flush_cache_all();
+		local_irq_restore(flags);
+	}
+# endif
+
+	if (LEON3_GpTimer_Regs) {
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+#if defined(CONFIG_SMP)
+# if defined(CONFIG_LEONSMP_USETIMER2)
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+
+# else
+		LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+# endif
+#endif
+	}
+
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
+#if defined(CONFIG_LEON)
+void _amba_init(struct device_node *dp, struct device_node ***nextp);
+#endif
+
+void console_print_LEON(const char *p);
+
+void __init leon_trans_init(struct device_node *dp)
+{
+	if (strcmp(dp->type, "cpu") == 0 && strcmp(dp->name, "<NULL>") == 0) {
+		struct property *p;
+		p = of_find_property(dp, "mid", 0);
+		if (p) {
+			int mid;
+			dp->name = prom_early_alloc(5 + 1);
+			memcpy(&mid, p->value, p->length);
+			sprintf((char *)dp->name, "cpu%.2d", mid);
+		}
+	}
+}
+
+void __init leon_node_init(struct device_node *dp, struct device_node ***nextp)
+{
+	if (strcmp(dp->type, "ambapp") == 0 &&
+	    strcmp(dp->name, "ambapp0") == 0) {
+#if defined(CONFIG_LEON)
+		_amba_init(dp, nextp);
+#endif
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
diff --git a/arch/sparc/mm/leon.c b/arch/sparc/mm/leon.c
new file mode 100644
index 0000000..5271328
--- /dev/null
+++ b/arch/sparc/mm/leon.c
@@ -0,0 +1,266 @@
+/*
+ *  linux/arch/sparc/mm/leon.c
+ *
+ * Copyright (C) 2004 Konrad Eisele
+ * (eiselekd@web.de, konrad@gaisler.com), Gaisler Research
+ * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
+ * Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB
+ *
+ * do srmmu probe in software
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/asi.h>
+#include <asm/leon.h>
+
+int leon_flush_during_switch = 1;
+
+#define PFN(x) ((x) >> PAGE_SHIFT)
+extern unsigned long last_valid_pfn;
+/* max_mapnr not initialized yet */
+#define _pfn_valid(pfn)	((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
+#define _SRMMU_PTE_PMASK 0xffffffff
+
+int srmmu_swprobe_trace;
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
+	if (((pgd & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pgd is entry level 3\n");
+		lvl = 3;
+		pte = pgd;
+		paddrbase = pgd & _SRMMU_PTE_PMASK;
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
+	if (((pmd & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pmd is entry level 2\n");
+		lvl = 2;
+		pte = pmd;
+		paddrbase = pmd & _SRMMU_PTE_PMASK;
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
+	if (((ped & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: ped is entry level 1\n");
+		lvl = 1;
+		pte = ped;
+		paddrbase = ped & _SRMMU_PTE_PMASK;
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
+	if (((ptr & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: ptr is entry level 0\n");
+		lvl = 0;
+		pte = ptr;
+		paddrbase = ptr & _SRMMU_PTE_PMASK;
+		goto ready;
+	}
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe: ptr is invalid => 0\n");
+	return 0;
+
+ready:
+	switch (lvl) {
+	case 0:
+		paddr_calc =
+		    (vaddr & ~(-1 << LEON_PTE_SH)) | ((pte & ~0xff) << 4);
+		break;
+	case 1:
+		paddr_calc =
+		    (vaddr & ~(-1 << LEON_PMD_SH)) | ((pte & ~0xff) << 4);
+		break;
+	case 2:
+		paddr_calc =
+		    (vaddr & ~(-1 << LEON_PGD_SH)) | ((pte & ~0xff) << 4);
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
+#if defined(CONFIG_LEON)
+	__asm__ __volatile__(" flush ");	/*iflush*/
+#endif
+}
+
+void leon_flush_dcache_all(void)
+{
+#if defined(CONFIG_LEON)
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
+			     "i"(ASI_LEON_DFLUSH) : "memory");
+#endif
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
+#if defined(CONFIG_LEON)
+	__asm__ __volatile__(" flush ");	/*iflush*/
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
+			     "i"(ASI_LEON_DFLUSH) : "memory");
+#endif
+}
+
+void leon_flush_tlb_all(void)
+{
+#if defined(CONFIG_LEON)
+	leon_flush_cache_all();
+	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : : "r"(0x400),
+			     "i"(ASI_LEON_MMUFLUSH) : "memory");
+#endif
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
+	char *setStr[4] =
+	    { "direct mapped", "2-way associative", "3-way associative",
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
+	if ((ssize <= (PAGE_SIZE / 1024)) && (sets == 0)) {
+		/* Set Size <= Page size  ==>
+		   flush on every context switch not needed. */
+		flush_needed = 0;
+		printk(KERN_INFO "CACHE: not flushing on every context switch\n");
+	}
+	return flush_needed;
+}
-- 
1.4.2.1


--------------030500070100000506010603
Content-Type: text/plain;
 name="0001-CONFIG_LEON-option.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-CONFIG_LEON-option.txt"

From f34daa99d7a0f397a5314142abf951ef8305dfea Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:50:43 +0200
Subject: [PATCH 1/7] CONFIG_LEON option
This macro will shield, if undefined, the sun-sparc code
from LEON specific code. In particular include/asm/leon.h
will get empty through #ifdef arch/sparc/kernel/leon.c not
compiled through Makefile:obj-$(CONFIG_LEON)
arch/sparc/mm/leon.c not compiled through Makefile:obj-$(CONFIG_LEON)

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/Kconfig                   |    6 
 arch/sparc/configs/sparc32_defconfig |    1 
 arch/sparc/include/asm/leon.h        |  678 ++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/leon.c             |  310 ++++++++++++++++
 arch/sparc/mm/leon.c                 |  266 +++++++++++++
 5 files changed, 1261 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 2185cf9..9f7aeb6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -435,6 +435,12 @@ config SERIAL_CONSOLE
 
 	  If unsure, say N.
 
+config LEON
+	bool "Leon processor family"
+	depends on SPARC32
+	---help---
+	  If you say Y here if you are running on a LEON processor.
+
 endmenu
 
 menu "Bus options (PCI etc.)"
diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index 09ab46e..3556a60 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -147,6 +147,7 @@ CONFIG_UNEVICTABLE_LRU=y
 CONFIG_SUN_PM=y
 # CONFIG_SPARC_LED is not set
 CONFIG_SERIAL_CONSOLE=y
+# CONFIG_LEON is not set
 
 #
 # Bus options (PCI etc.)
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
new file mode 100644
index 0000000..b440994
--- /dev/null
+++ b/arch/sparc/include/asm/leon.h
@@ -0,0 +1,678 @@
+/*
+*Copyright (C) 2004 Konrad Eisele (eiselekd@web.de,
+*konrad@gaisler.com), Gaisler Research
+*Copyright (C) 2004 Stefan Holst (mail@s-holst.de), Uni-Stuttgart
+*Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
+*Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB
+*/
+
+#ifndef LEON_H_INCLUDE
+#define LEON_H_INCLUDE
+
+#if defined(CONFIG_LEON)
+
+#define ASI_LEON_NOCACHE	0x01
+
+#define ASI_LEON_DCACHE_MISS	0x1
+
+#define ASI_LEON_CACHEREGS 0x02
+#define ASI_LEON_IFLUSH		0x10
+#define ASI_LEON_DFLUSH		0x11
+
+#define ASI_LEON_MMUFLUSH	0x18
+#define ASI_LEON_MMUREGS	0x19
+#define ASI_LEON_BYPASS		0x1c
+#define ASI_LEON_FLUSH_PAGE	0x10
+
+#define LEON_TYPEDEF typedef
+#define LEON_VOLATILE volatile
+
+/*
+constant ASI_SYSR    : asi_type := "00010"; -- 0x02
+constant ASI_UINST   : asi_type := "01000"; -- 0x08
+constant ASI_SINST   : asi_type := "01001"; -- 0x09
+constant ASI_UDATA   : asi_type := "01010"; -- 0x0A
+constant ASI_SDATA   : asi_type := "01011"; -- 0x0B
+constant ASI_ITAG    : asi_type := "01100"; -- 0x0C
+constant ASI_IDATA   : asi_type := "01101"; -- 0x0D
+constant ASI_DTAG    : asi_type := "01110"; -- 0x0E
+constant ASI_DDATA   : asi_type := "01111"; -- 0x0F
+constant ASI_IFLUSH  : asi_type := "10000"; -- 0x10
+constant ASI_DFLUSH  : asi_type := "10001"; -- 0x11
+
+constant ASI_FLUSH_PAGE     : std_logic_vector(4 downto 0) := "10000";
+constant ASI_FLUSH_CTX      : std_logic_vector(4 downto 0) := "10011";
+
+constant ASI_DCTX           : std_logic_vector(4 downto 0) := "10100";
+constant ASI_ICTX           : std_logic_vector(4 downto 0) := "10101";
+
+constant ASI_MMUFLUSHPROBE  : std_logic_vector(4 downto 0) := "11000";
+constant ASI_MMUREGS        : std_logic_vector(4 downto 0) := "11001";
+constant ASI_MMU_BP         : std_logic_vector(4 downto 0) := "11100";
+constant ASI_MMU_DIAG       : std_logic_vector(4 downto 0) := "11101";
+constant ASI_MMU_DSU        : std_logic_vector(4 downto 0) := "11111";
+*/
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
+#define LEON_USTAT_ERROR (LEON_USTAT_OV|LEON_USTAT_PE|LEON_USTAT_FE)
+/*no break yet */
+
+#ifdef CONFIG_OPEN_ETH
+#define LEON_ETH_BASE_ADD ((unsigned long)LEON_VA_ETHERMAC)
+/* map leon on ethermac adress space at pa 0xb0000000 */
+#define LEON_VA_ETHERMAC     DVMA_VADDR
+#endif
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
+#define LEON3_BYPASS_LOAD_PA(x)	(leon_load_reg((unsigned long)(x)))
+#define LEON3_BYPASS_STORE_PA(x, v) \
+	(leon_store_reg((unsigned long)(x), (unsigned long)(v)))
+#define LEON3_BYPASS_ANDIN_PA(x, v) \
+	LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) & v)
+#define LEON3_BYPASS_ORIN_PA(x, v) \
+	LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) | v)
+
+#define LEON_BYPASS_LOAD_PA(x)		\
+	leon_load_reg((unsigned long)(x))
+#define LEON_BYPASSCACHE_LOAD_VA(x)	\
+	leon_readnobuffer_reg((unsigned long)(x))
+#define LEON_BYPASS_STORE_PA(x, v)	\
+	leon_store_reg((unsigned long)(x), (unsigned long)(v))
+#define LEON_REGLOAD_PA(x)		\
+	leon_load_reg((unsigned long)(x)+LEON_PREGS)
+#define LEON_REGSTORE_PA(x, v)		\
+	leon_store_reg((unsigned long)(x)+LEON_PREGS, (unsigned long)(v))
+#define LEON_REGSTORE_OR_PA(x, v)	\
+	LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x)|(unsigned long)(v))
+#define LEON_REGSTORE_AND_PA(x, v)	\
+	LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x)&(unsigned long)(v))
+
+/*#define LEONSETUP_MEM_BASEADDR 0x40000000*/
+
+#define HARDDBG_PRINTF(fmt, arg...) do {		\
+		char b[1000];				\
+		sprintf(b, fmt, ## arg);		\
+		console_print_LEON(b); } while (0)
+#define HARDDBG_FUNC  \
+	HARDDBG_PRINTF("[->%03d @ %22s()]:\n" , __LINE__, __func__);
+#define HARDDBG_FUNCOUT \
+	HARDDBG_PRINTF("[<-%03d @ %22s()]:\n" , __LINE__, __func__);
+#define HARDDBG_OUT(fmt, arg...) \
+	HARDDBG_PRINTF("[->%03d @ %22s()]:" fmt , __LINE__, __func__, ## arg);
+
+#endif /* !ASM */
+
+#if 1
+
+#ifndef __ASSEMBLER__
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
+struct amba_prom_registers {
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
+};
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int ilevel;
+	LEON_VOLATILE unsigned int ipend;
+	LEON_VOLATILE unsigned int iforce;
+	LEON_VOLATILE unsigned int iclear;
+	LEON_VOLATILE unsigned int mpstatus;
+	LEON_VOLATILE unsigned int mpbroadcast;
+	LEON_VOLATILE unsigned int notused02;
+	LEON_VOLATILE unsigned int notused03;
+	LEON_VOLATILE unsigned int notused10;
+	LEON_VOLATILE unsigned int notused11;
+	LEON_VOLATILE unsigned int notused12;
+	LEON_VOLATILE unsigned int notused13;
+	LEON_VOLATILE unsigned int notused20;
+	LEON_VOLATILE unsigned int notused21;
+	LEON_VOLATILE unsigned int notused22;
+	LEON_VOLATILE unsigned int notused23;
+	LEON_VOLATILE unsigned int mask[16];
+	LEON_VOLATILE unsigned int force[16];
+	/* Extended IRQ registers */
+	LEON_VOLATILE unsigned int intid[16];	/* 0xc0 */
+} LEON3_IrqCtrl_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int data;
+	LEON_VOLATILE unsigned int status;
+	LEON_VOLATILE unsigned int ctrl;
+	LEON_VOLATILE unsigned int scaler;
+} LEON3_APBUART_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int val;
+	LEON_VOLATILE unsigned int rld;
+	LEON_VOLATILE unsigned int ctrl;
+	LEON_VOLATILE unsigned int unused;
+} LEON3_GpTimerElem_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int scalar;
+	LEON_VOLATILE unsigned int scalar_reload;
+	LEON_VOLATILE unsigned int config;
+	LEON_VOLATILE unsigned int unused;
+	LEON_VOLATILE LEON3_GpTimerElem_Regs_Map e[8];
+} LEON3_GpTimer_Regs_Map;
+
+#define GPTIMER_CONFIG_IRQNT(a) (((a) >> 3) & 0x1f)
+#define GPTIMER_CONFIG_ISSEP(a) ((a)&(1<<8))
+#define GPTIMER_CONFIG_NTIMERS(a) ((a)&(0x7))
+#define LEON3_GPTIMER_CTRL_PENDING 0x10
+#define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
+#define LEON3_GPTIMER_CTRL_ISPENDING(r) \
+	(((r)&LEON3_GPTIMER_CTRL_PENDING) ? 1 : 0)
+
+LEON_TYPEDEF void (*GPTIMER_CALLBACK) (void);
+LEON_TYPEDEF struct _sparc_gptimer {
+	LEON3_GpTimer_Regs_Map *inst;
+	unsigned int ctrl, reload, value, scalarreload;
+	int irq, flags, idxinst, idx, enabled, connected, minscalar;
+	int ticksPerSecond, stat;
+	GPTIMER_CALLBACK callback;
+	int arg;
+} sparc_gptimer;
+
+#define GPTIMER_INST_TIMER_MAX 8
+LEON_TYPEDEF struct _sparc_gptimer_inst {
+	LEON3_GpTimer_Regs_Map *base;
+	unsigned int scalarreload;
+	int count, baseirq, free, config, connected, minscalar;
+	sparc_gptimer timers[GPTIMER_INST_TIMER_MAX];
+} sparc_gptimer_inst;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int iodata;
+	LEON_VOLATILE unsigned int ioout;
+	LEON_VOLATILE unsigned int iodir;
+	LEON_VOLATILE unsigned int irqmask;
+	LEON_VOLATILE unsigned int irqpol;
+	LEON_VOLATILE unsigned int irqedge;
+} LEON3_IOPORT_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int write;
+	LEON_VOLATILE unsigned int dummy;
+	LEON_VOLATILE unsigned int txcolor;
+	LEON_VOLATILE unsigned int bgcolor;
+} LEON3_VGA_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int status;	/* 0x00 */
+	LEON_VOLATILE unsigned int video_length;	/* 0x04 */
+	LEON_VOLATILE unsigned int front_porch;	/* 0x08 */
+	LEON_VOLATILE unsigned int sync_length;	/* 0x0c */
+	LEON_VOLATILE unsigned int line_length;	/* 0x10 */
+	LEON_VOLATILE unsigned int fb_pos;	/* 0x14 */
+	LEON_VOLATILE unsigned int clk_vector[4];	/* 0x18 */
+	LEON_VOLATILE unsigned int clut;	/* 0x28 */
+} LEON3_GRVGA_Regs_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int data;
+	LEON_VOLATILE unsigned int status;
+	LEON_VOLATILE unsigned int ctrl;
+	LEON_VOLATILE unsigned int reload;
+} LEON3_APBPS2_REGS_Map;
+
+LEON_TYPEDEF struct {
+	LEON_VOLATILE unsigned int cfg_stat;
+	LEON_VOLATILE unsigned int bar0;
+	LEON_VOLATILE unsigned int page0;
+	LEON_VOLATILE unsigned int bar1;
+	LEON_VOLATILE unsigned int page1;
+	LEON_VOLATILE unsigned int iomap;
+	LEON_VOLATILE unsigned int stat_cmd;
+	LEON_VOLATILE unsigned int irq;
+} LEON3_GRPCI_Regs_Map;
+
+/*
+ *  Types and structure used for AMBA Plug & Play bus scanning
+ */
+
+#define AMBA_MAXAPB_DEVS 64
+#define AMBA_MAXAPB_DEVS_PERBUS 16
+
+LEON_TYPEDEF struct amba_device_table {
+	int devnr;		/* number of devices on AHB or APB bus */
+	/* addresses to the devices configuration tables */
+	unsigned int *addr[16];
+	/* 0=unallocated, 1=allocated driver */
+	unsigned int allocbits[1];
+} amba_device_table;
+
+LEON_TYPEDEF struct amba_apbslv_device_table {
+	int devnr;		/* number of devices on AHB or APB bus */
+	/* addresses to the devices configuration tables */
+	unsigned int *addr[AMBA_MAXAPB_DEVS];
+	/* apb master if a entry is a apb slave */
+	unsigned int apbmst[AMBA_MAXAPB_DEVS];
+	/* apb master idx if a entry is a apb slave */
+	unsigned int apbmstidx[AMBA_MAXAPB_DEVS];
+	unsigned int allocbits[4];/* 0=unallocated, 1=allocated driver */
+} amba_apbslv_device_table;
+
+LEON_TYPEDEF struct _amba_confarea_type {
+	struct _amba_confarea_type *next;/* next bus in chain */
+	amba_device_table ahbmst;
+	amba_device_table ahbslv;
+	amba_apbslv_device_table apbslv;
+	unsigned int apbmst;
+} amba_confarea_type;
+
+/* collect apb slaves */
+LEON_TYPEDEF struct amba_apb_device {
+	unsigned int start, irq, bus_id;
+	amba_confarea_type *bus;
+} amba_apb_device;
+
+/* collect ahb slaves */
+LEON_TYPEDEF struct amba_ahb_device {
+	unsigned int start[4], irq, bus_id;
+	amba_confarea_type *bus;
+} amba_ahb_device;
+
+extern void sparc_leon_eirq_register(int eirq);
+
+#if defined(CONFIG_SMP)
+# define LEON3_IRQ_RESCHEDULE		13
+# define LEON3_IRQ_TICKER		(leon_percpu_timer_dev[0].irq)
+# define LEON3_IRQ_CROSS_CALL		15
+#endif
+
+#define ASI_LEON3_SYSCTRL		0x02
+#define ASI_LEON3_SYSCTRL_ICFG		0x08
+#define ASI_LEON3_SYSCTRL_DCFG		0x0c
+#define ASI_LEON3_SYSCTRL_CFG_SNOOPING (1<<27)
+#define ASI_LEON3_SYSCTRL_CFG_SSIZE(c) (1<<((c>>20)&0xf))
+
+/* GCC for the host includes this, older GCC versions complain about
+ * sparc assembler if host is not a SPARC.
+ */
+#ifdef __sparc
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
+/*enable snooping*/
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
+#endif
+
+#endif /*!__ASSEMBLER__*/
+
+#if defined(PAGE_SIZE_LEON_8K)
+#define CONFIG_PAGE_SIZE_LEON 1
+#elif defined(PAGE_SIZE_LEON_16K)
+#define CONFIG_PAGE_SIZE_LEON 2)
+#else
+#define CONFIG_PAGE_SIZE_LEON 0
+#endif
+
+#if CONFIG_PAGE_SIZE_LEON == 0
+/* [ 8, 6, 6 ] + 12 */
+#define LEON_PGD_SH 24
+#define LEON_PGD_M  0xff
+#define LEON_PMD_SH 18
+#define LEON_PMD_SH_V (LEON_PGD_SH-2)
+#define LEON_PMD_M  0x3f
+#define LEON_PTE_SH 12
+#define LEON_PTE_M  0x3f
+#elif CONFIG_PAGE_SIZE_LEON == 1
+/* [ 7, 6, 6 ] + 13 */
+#define LEON_PGD_SH 25
+#define LEON_PGD_M  0x7f
+#define LEON_PMD_SH 19
+#define LEON_PMD_SH_V (LEON_PGD_SH-1)
+#define LEON_PMD_M  0x3f
+#define LEON_PTE_SH 13
+#define LEON_PTE_M  0x3f
+#elif CONFIG_PAGE_SIZE_LEON == 2
+/* [ 6, 6, 6 ] + 14 */
+#define LEON_PGD_SH 26
+#define LEON_PGD_M  0x3f
+#define LEON_PMD_SH 20
+#define LEON_PMD_SH_V (LEON_PGD_SH-0)
+#define LEON_PMD_M  0x3f
+#define LEON_PTE_SH 14
+#define LEON_PTE_M  0x3f
+#elif CONFIG_PAGE_SIZE_LEON == 3
+/* [ 4, 7, 6 ] + 15 */
+#define LEON_PGD_SH 28
+#define LEON_PGD_M  0x0f
+#define LEON_PMD_SH 21
+#define LEON_PMD_SH_V (LEON_PGD_SH-0)
+#define LEON_PMD_M  0x7f
+#define LEON_PTE_SH 15
+#define LEON_PTE_M  0x3f
+#else
+#error cannot determine CONFIG_PAGE_SIZE_LEON
+#endif
+
+#endif /* LEON3 */
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
+#define srmmu_hwprobe(addr) (srmmu_swprobe(addr, 0) & SRMMU_PTE_PMASK)
+extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
+extern void leon_flush_icache_all(void);
+extern void leon_flush_dcache_all(void);
+extern void leon_flush_cache_all(void);
+extern void leon_flush_tlb_all(void);
+extern int leon_flush_during_switch;
+extern int leon_flush_needed(void);
+
+/* struct that hold LEON3 cache configuration registers */
+struct leon3_cacheregs {	/* ASI=2 Address - name */
+	unsigned long ccr;	/* 0x00 - Cache Control Register  */
+	/* 0x08 - Instruction Cache Configuration Register */
+	unsigned long iccr;
+	unsigned long dccr;	/* 0x0c - Data Cache Configuration Register */
+};
+
+/* struct that hold LEON2 cache configuration register
+   & configuration register */
+struct leon2_cacheregs {
+	unsigned long ccr, cfg;
+};
+
+#endif
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
+#endif /*defined(CONFIG_LEON) */
+
+#endif
diff --git a/arch/sparc/kernel/leon.c b/arch/sparc/kernel/leon.c
new file mode 100644
index 0000000..2b60398
--- /dev/null
+++ b/arch/sparc/kernel/leon.c
@@ -0,0 +1,310 @@
+/* Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
+   Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/interrupt.h>
+#include <asm/prom.h>
+#include <asm/oplib.h>
+#include <asm/leon.h>
+#include <asm/timer.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+#include "prom.h"
+#include "irq.h"
+
+LEON_VOLATILE LEON3_IrqCtrl_Regs_Map *LEON3_IrqCtrl_Regs;
+LEON_VOLATILE LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs;
+amba_apb_device leon_percpu_timer_dev[16];
+#define LEON3_SMPTicker_Regs \
+	((LEON3_GpTimer_Regs_Map *)leon_percpu_timer_dev[0].start)
+int leondebug_irq_disable;
+int leon_debug_irqout;
+static int dummy_master_l10_counter;
+
+unsigned long LEON3_GpTimer_Irq;
+unsigned int sparc_leon_eirq;
+#undef LEON_IMASK
+#define LEON_IMASK ((&LEON3_IrqCtrl_Regs->mask[0]))
+
+/* Return the IRQ of the pending IRQ on the extended IRQ controller */
+int sparc_leon_eirq_get(int eirq, int cpu)
+{
+	return LEON3_BYPASS_LOAD_PA(&LEON3_IrqCtrl_Regs->intid[cpu]) & 0x1f;
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
+	/* Register a "BAD" handler for this interrupt,
+	   it should never happen */
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
+void leon_enable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr);
+	local_irq_save(flags);
+	LEON3_BYPASS_STORE_PA(LEON_IMASK,
+			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) | (mask)));
+	local_irq_restore(flags);
+}
+
+void leon_disable_irq(unsigned int irq_nr)
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
+	master_l10_counter = &dummy_master_l10_counter;
+	dummy_master_l10_counter = 0;
+
+	if (LEON3_GpTimer_Regs && LEON3_IrqCtrl_Regs) {
+		/*regs -> timerctrl1 = 0; */
+		/*regs -> timercnt1 = 0; */
+		/*regs -> timerload1 = (((1000000/100) - 1));*/
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].val, 0);
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].rld,
+				      (((1000000 / 100) - 1)));
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].ctrl, 0);
+
+#ifdef CONFIG_SMP
+# if defined(CONFIG_LEONSMP_USETIMER2)
+		leon_percpu_timer_dev[0].start = (int)LEON3_GpTimer_Regs;
+		leon_percpu_timer_dev[0].irq = LEON3_GpTimer_Irq + 1;
+
+		if (!
+		    (LEON3_BYPASS_LOAD_PA(&LEON3_GpTimer_Regs->config) &
+		     (1 << LEON3_GPTIMER_SEPIRQ))) {
+			prom_printf
+			    ("irq timer not configured with seperate irqs \n");
+			BUG();
+		}
+
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].val, 0);
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].rld,
+				      (((1000000 / 100) - 1)));
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].ctrl, 0);
+#else
+		{
+			leon_percpu_timer_dev[0].start = 0;
+			int i =
+			amba_get_free_apbslv_devices(VENDOR_GAISLER,
+						     GAISLER_GPTIMER,
+						     leon_percpu_timer_dev,
+						     2);
+			if (i < 1) {
+				prom_printf("Cannot lock "
+					    "GAISLER_GPTIMER timer "
+					    "for smp-ticker\n");
+				BUG();
+			}
+			if (leon_percpu_timer_dev[0].start ==
+			    LEON3_GpTimer_Regs) {
+				if (i < 2) {
+					prom_printf("Cannot lock"
+						    " GAISLER_GPTIMER timer "
+						    "for smp-ticker\n");
+					BUG();
+				}
+				leon_percpu_timer_dev[0] =
+				    leon_percpu_timer_dev[1];
+			}
+
+			printk(KERN_INFO "Leon smp ticker at 0x%x irq %d\n",
+			       leon_percpu_timer_dev[0].start,
+			       leon_percpu_timer_dev[0].irq);
+
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].val,
+					      0);
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].rld,
+					      (((1000000 / 100) - 1)));
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].ctrl,
+					      0);
+
+			/* copy over 100hz scaler */
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->scalar,
+					      LEON3_BYPASS_LOAD_PA
+					      (&LEON3_GpTimer_Regs->scalar));
+			LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->
+					      scalar_reload,
+					      LEON3_BYPASS_LOAD_PA
+					      (&LEON3_GpTimer_Regs->
+					       scalar_reload));
+
+		}
+# endif
+# endif
+	} else {
+		while (1)
+			printk(KERN_ERR "No Timer/irqctrl found\n");
+	}
+
+	irq = request_irq(LEON3_GpTimer_Irq,
+			  counter_fn,
+			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+
+	if (irq) {
+		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
+		       LEON_INTERRUPT_TIMER1);
+		prom_halt();
+	}
+# ifdef CONFIG_SMP
+	{
+		unsigned long flags;
+		struct tt_entry *trap_table =
+		    &sparc_ttable[SP_TRAP_IRQ1 +
+				  (leon_percpu_timer_dev[0].irq - 1)];
+
+		extern unsigned int real_irq_entry[], smpleon_ticker[];
+		extern unsigned int patchme_maybe_smp_msg[];
+
+		/* For SMP we use the level 14 ticker, however the bootup code
+		 * has copied the firmwares level 14 vector into boot cpu's
+		 * trap table, we must fix this now or we get squashed.
+		 */
+		local_irq_save(flags);
+
+		patchme_maybe_smp_msg[0] = 0x01000000;	/* NOP out the branch */
+
+		/* Adjust so that we jump directly to smpleon_ticker */
+		trap_table->inst_three += smpleon_ticker - real_irq_entry;
+
+		local_flush_cache_all();
+		local_irq_restore(flags);
+	}
+# endif
+
+	if (LEON3_GpTimer_Regs) {
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[0].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+#if defined(CONFIG_SMP)
+# if defined(CONFIG_LEONSMP_USETIMER2)
+		LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs->e[1].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+
+# else
+		LEON3_BYPASS_STORE_PA(&LEON3_SMPTicker_Regs->e[0].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+# endif
+#endif
+	}
+
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
+#if defined(CONFIG_LEON)
+void _amba_init(struct device_node *dp, struct device_node ***nextp);
+#endif
+
+void console_print_LEON(const char *p);
+
+void __init leon_trans_init(struct device_node *dp)
+{
+	if (strcmp(dp->type, "cpu") == 0 && strcmp(dp->name, "<NULL>") == 0) {
+		struct property *p;
+		p = of_find_property(dp, "mid", 0);
+		if (p) {
+			int mid;
+			dp->name = prom_early_alloc(5 + 1);
+			memcpy(&mid, p->value, p->length);
+			sprintf((char *)dp->name, "cpu%.2d", mid);
+		}
+	}
+}
+
+void __init leon_node_init(struct device_node *dp, struct device_node ***nextp)
+{
+	if (strcmp(dp->type, "ambapp") == 0 &&
+	    strcmp(dp->name, "ambapp0") == 0) {
+#if defined(CONFIG_LEON)
+		_amba_init(dp, nextp);
+#endif
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
diff --git a/arch/sparc/mm/leon.c b/arch/sparc/mm/leon.c
new file mode 100644
index 0000000..5271328
--- /dev/null
+++ b/arch/sparc/mm/leon.c
@@ -0,0 +1,266 @@
+/*
+ *  linux/arch/sparc/mm/leon.c
+ *
+ * Copyright (C) 2004 Konrad Eisele
+ * (eiselekd@web.de, konrad@gaisler.com), Gaisler Research
+ * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
+ * Konrad Eisele (konrad@gaisler.com) Gaisler-Aeroflex AB
+ *
+ * do srmmu probe in software
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/asi.h>
+#include <asm/leon.h>
+
+int leon_flush_during_switch = 1;
+
+#define PFN(x) ((x) >> PAGE_SHIFT)
+extern unsigned long last_valid_pfn;
+/* max_mapnr not initialized yet */
+#define _pfn_valid(pfn)	((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
+#define _SRMMU_PTE_PMASK 0xffffffff
+
+int srmmu_swprobe_trace;
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
+	if (((pgd & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pgd is entry level 3\n");
+		lvl = 3;
+		pte = pgd;
+		paddrbase = pgd & _SRMMU_PTE_PMASK;
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
+	if (((pmd & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: pmd is entry level 2\n");
+		lvl = 2;
+		pte = pmd;
+		paddrbase = pmd & _SRMMU_PTE_PMASK;
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
+	if (((ped & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: ped is entry level 1\n");
+		lvl = 1;
+		pte = ped;
+		paddrbase = ped & _SRMMU_PTE_PMASK;
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
+	if (((ptr & SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+		if (srmmu_swprobe_trace)
+			printk(KERN_INFO "swprobe: ptr is entry level 0\n");
+		lvl = 0;
+		pte = ptr;
+		paddrbase = ptr & _SRMMU_PTE_PMASK;
+		goto ready;
+	}
+	if (srmmu_swprobe_trace)
+		printk(KERN_INFO "swprobe: ptr is invalid => 0\n");
+	return 0;
+
+ready:
+	switch (lvl) {
+	case 0:
+		paddr_calc =
+		    (vaddr & ~(-1 << LEON_PTE_SH)) | ((pte & ~0xff) << 4);
+		break;
+	case 1:
+		paddr_calc =
+		    (vaddr & ~(-1 << LEON_PMD_SH)) | ((pte & ~0xff) << 4);
+		break;
+	case 2:
+		paddr_calc =
+		    (vaddr & ~(-1 << LEON_PGD_SH)) | ((pte & ~0xff) << 4);
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
+#if defined(CONFIG_LEON)
+	__asm__ __volatile__(" flush ");	/*iflush*/
+#endif
+}
+
+void leon_flush_dcache_all(void)
+{
+#if defined(CONFIG_LEON)
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
+			     "i"(ASI_LEON_DFLUSH) : "memory");
+#endif
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
+#if defined(CONFIG_LEON)
+	__asm__ __volatile__(" flush ");	/*iflush*/
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
+			     "i"(ASI_LEON_DFLUSH) : "memory");
+#endif
+}
+
+void leon_flush_tlb_all(void)
+{
+#if defined(CONFIG_LEON)
+	leon_flush_cache_all();
+	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : : "r"(0x400),
+			     "i"(ASI_LEON_MMUFLUSH) : "memory");
+#endif
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
+	char *setStr[4] =
+	    { "direct mapped", "2-way associative", "3-way associative",
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
+	if ((ssize <= (PAGE_SIZE / 1024)) && (sets == 0)) {
+		/* Set Size <= Page size  ==>
+		   flush on every context switch not needed. */
+		flush_needed = 0;
+		printk(KERN_INFO "CACHE: not flushing on every context switch\n");
+	}
+	return flush_needed;
+}
-- 
1.4.2.1


--------------030500070100000506010603--
