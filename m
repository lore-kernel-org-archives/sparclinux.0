From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Dec 2020 18:43:36 +0000
Subject: [PATCH v1 02/13] sparc32: Drop floppy support
Message-Id: <20201218184347.2180772-3-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o

LEON do not have floppy support so we can drop it

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Denis Efremov <efremov@linux.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: sparclinux@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/Kconfig                 |   2 +-
 arch/sparc/include/asm/floppy.h    | 786 ++++++++++++++++++++++++++++-
 arch/sparc/include/asm/floppy_32.h | 393 ---------------
 arch/sparc/include/asm/floppy_64.h | 779 ----------------------------
 arch/sparc/kernel/entry.S          | 137 -----
 arch/sparc/kernel/irq.h            |   3 -
 arch/sparc/kernel/irq_32.c         |  93 ----
 arch/sparc/kernel/kernel.h         |   2 -
 8 files changed, 779 insertions(+), 1416 deletions(-)
 delete mode 100644 arch/sparc/include/asm/floppy_32.h
 delete mode 100644 arch/sparc/include/asm/floppy_64.h

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c9c34dc52b7d..2c6d8d834f9a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -200,7 +200,7 @@ config GENERIC_CALIBRATE_DELAY
 
 config ARCH_MAY_HAVE_PC_FDC
 	bool
-	default y
+	default y if SPARC64
 
 config EMULATED_CMPXCHG
 	bool
diff --git a/arch/sparc/include/asm/floppy.h b/arch/sparc/include/asm/floppy.h
index 4b315802e635..070c8c1f5c8f 100644
--- a/arch/sparc/include/asm/floppy.h
+++ b/arch/sparc/include/asm/floppy.h
@@ -1,9 +1,779 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ___ASM_SPARC_FLOPPY_H
-#define ___ASM_SPARC_FLOPPY_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/floppy_64.h>
-#else
-#include <asm/floppy_32.h>
-#endif
-#endif
+/* floppy.h: Sparc specific parts of the Floppy driver.
+ *
+ * Copyright (C) 1996, 2007, 2008 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ *
+ * Ultra/PCI support added: Sep 1997  Eddie C. Dost  (ecd@skynet.be)
+ */
+
+#ifndef __ASM_SPARC64_FLOPPY_H
+#define __ASM_SPARC64_FLOPPY_H
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/auxio.h>
+
+/*
+ * Define this to enable exchanging drive 0 and 1 if only drive 1 is
+ * probed on PCI machines.
+ */
+#undef PCI_FDC_SWAP_DRIVES
+
+
+/* References:
+ * 1) Netbsd Sun floppy driver.
+ * 2) NCR 82077 controller manual
+ * 3) Intel 82077 controller manual
+ */
+struct sun_flpy_controller {
+	volatile unsigned char status1_82077; /* Auxiliary Status reg. 1 */
+	volatile unsigned char status2_82077; /* Auxiliary Status reg. 2 */
+	volatile unsigned char dor_82077;     /* Digital Output reg. */
+	volatile unsigned char tapectl_82077; /* Tape Control reg */
+	volatile unsigned char status_82077;  /* Main Status Register. */
+#define drs_82077              status_82077   /* Digital Rate Select reg. */
+	volatile unsigned char data_82077;    /* Data fifo. */
+	volatile unsigned char ___unused;
+	volatile unsigned char dir_82077;     /* Digital Input reg. */
+#define dcr_82077              dir_82077      /* Config Control reg. */
+};
+
+/* You'll only ever find one controller on an Ultra anyways. */
+static struct sun_flpy_controller *sun_fdc = (struct sun_flpy_controller *)-1;
+unsigned long fdc_status;
+static struct platform_device *floppy_op = NULL;
+
+struct sun_floppy_ops {
+	unsigned char	(*fd_inb) (unsigned long port, unsigned int reg);
+	void		(*fd_outb) (unsigned char value, unsigned long base,
+				    unsigned int reg);
+	void		(*fd_enable_dma) (void);
+	void		(*fd_disable_dma) (void);
+	void		(*fd_set_dma_mode) (int);
+	void		(*fd_set_dma_addr) (char *);
+	void		(*fd_set_dma_count) (int);
+	unsigned int	(*get_dma_residue) (void);
+	int		(*fd_request_irq) (void);
+	void		(*fd_free_irq) (void);
+	int		(*fd_eject) (int);
+};
+
+static struct sun_floppy_ops sun_fdops;
+
+#define fd_inb(base, reg)         sun_fdops.fd_inb(base, reg)
+#define fd_outb(value, base, reg) sun_fdops.fd_outb(value, base, reg)
+#define fd_enable_dma()           sun_fdops.fd_enable_dma()
+#define fd_disable_dma()          sun_fdops.fd_disable_dma()
+#define fd_request_dma()          (0) /* nothing... */
+#define fd_free_dma()             /* nothing... */
+#define fd_clear_dma_ff()         /* nothing... */
+#define fd_set_dma_mode(mode)     sun_fdops.fd_set_dma_mode(mode)
+#define fd_set_dma_addr(addr)     sun_fdops.fd_set_dma_addr(addr)
+#define fd_set_dma_count(count)   sun_fdops.fd_set_dma_count(count)
+#define get_dma_residue(x)        sun_fdops.get_dma_residue()
+#define fd_request_irq()          sun_fdops.fd_request_irq()
+#define fd_free_irq()             sun_fdops.fd_free_irq()
+#define fd_eject(drive)           sun_fdops.fd_eject(drive)
+
+/* Super paranoid... */
+#undef HAVE_DISABLE_HLT
+
+static int sun_floppy_types[2] = { 0, 0 };
+
+/* Here is where we catch the floppy driver trying to initialize,
+ * therefore this is where we call the PROM device tree probing
+ * routine etc. on the Sparc.
+ */
+#define FLOPPY0_TYPE		sun_floppy_init()
+#define FLOPPY1_TYPE		sun_floppy_types[1]
+
+#define FDC1			((unsigned long)sun_fdc)
+
+#define N_FDC    1
+#define N_DRIVE  8
+
+/* No 64k boundary crossing problems on the Sparc. */
+#define CROSS_64KB(a,s) (0)
+
+static unsigned char sun_82077_fd_inb(unsigned long base, unsigned int reg)
+{
+	udelay(5);
+	switch (reg) {
+	default:
+		printk("floppy: Asked to read unknown port %x\n", reg);
+		panic("floppy: Port bolixed.");
+	case FD_STATUS:
+		return sbus_readb(&sun_fdc->status_82077) & ~STATUS_DMA;
+	case FD_DATA:
+		return sbus_readb(&sun_fdc->data_82077);
+	case FD_DIR:
+		/* XXX: Is DCL on 0x80 in sun4m? */
+		return sbus_readb(&sun_fdc->dir_82077);
+	}
+	panic("sun_82072_fd_inb: How did I get here?");
+}
+
+static void sun_82077_fd_outb(unsigned char value, unsigned long base,
+			      unsigned int reg)
+{
+	udelay(5);
+	switch (reg) {
+	default:
+		printk("floppy: Asked to write to unknown port %x\n", reg);
+		panic("floppy: Port bolixed.");
+	case FD_DOR:
+		/* Happily, the 82077 has a real DOR register. */
+		sbus_writeb(value, &sun_fdc->dor_82077);
+		break;
+	case FD_DATA:
+		sbus_writeb(value, &sun_fdc->data_82077);
+		break;
+	case FD_DCR:
+		sbus_writeb(value, &sun_fdc->dcr_82077);
+		break;
+	case FD_DSR:
+		sbus_writeb(value, &sun_fdc->status_82077);
+		break;
+	}
+	return;
+}
+
+/* For pseudo-dma (Sun floppy drives have no real DMA available to
+ * them so we must eat the data fifo bytes directly ourselves) we have
+ * three state variables.  doing_pdma tells our inline low-level
+ * assembly floppy interrupt entry point whether it should sit and eat
+ * bytes from the fifo or just transfer control up to the higher level
+ * floppy interrupt c-code.  I tried very hard but I could not get the
+ * pseudo-dma to work in c-code without getting many overruns and
+ * underruns.  If non-zero, doing_pdma encodes the direction of
+ * the transfer for debugging.  1=read 2=write
+ */
+unsigned char *pdma_vaddr;
+unsigned long pdma_size;
+volatile int doing_pdma = 0;
+
+/* This is software state */
+char *pdma_base = NULL;
+unsigned long pdma_areasize;
+
+/* Common routines to all controller types on the Sparc. */
+static void sun_fd_disable_dma(void)
+{
+	doing_pdma = 0;
+	pdma_base = NULL;
+}
+
+static void sun_fd_set_dma_mode(int mode)
+{
+	switch(mode) {
+	case DMA_MODE_READ:
+		doing_pdma = 1;
+		break;
+	case DMA_MODE_WRITE:
+		doing_pdma = 2;
+		break;
+	default:
+		printk("Unknown dma mode %d\n", mode);
+		panic("floppy: Giving up...");
+	}
+}
+
+static void sun_fd_set_dma_addr(char *buffer)
+{
+	pdma_vaddr = buffer;
+}
+
+static void sun_fd_set_dma_count(int length)
+{
+	pdma_size = length;
+}
+
+static void sun_fd_enable_dma(void)
+{
+	pdma_base = pdma_vaddr;
+	pdma_areasize = pdma_size;
+}
+
+irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie)
+{
+	if (likely(doing_pdma)) {
+		void __iomem *stat = (void __iomem *) fdc_status;
+		unsigned char *vaddr = pdma_vaddr;
+		unsigned long size = pdma_size;
+		u8 val;
+
+		while (size) {
+			val = readb(stat);
+			if (unlikely(!(val & 0x80))) {
+				pdma_vaddr = vaddr;
+				pdma_size = size;
+				return IRQ_HANDLED;
+			}
+			if (unlikely(!(val & 0x20))) {
+				pdma_vaddr = vaddr;
+				pdma_size = size;
+				doing_pdma = 0;
+				goto main_interrupt;
+			}
+			if (val & 0x40) {
+				/* read */
+				*vaddr++ = readb(stat + 1);
+			} else {
+				unsigned char data = *vaddr++;
+
+				/* write */
+				writeb(data, stat + 1);
+			}
+			size--;
+		}
+
+		pdma_vaddr = vaddr;
+		pdma_size = size;
+
+		/* Send Terminal Count pulse to floppy controller. */
+		val = readb(auxio_register);
+		val |= AUXIO_AUX1_FTCNT;
+		writeb(val, auxio_register);
+		val &= ~AUXIO_AUX1_FTCNT;
+		writeb(val, auxio_register);
+
+		doing_pdma = 0;
+	}
+
+main_interrupt:
+	return floppy_interrupt(irq, dev_cookie);
+}
+
+static int sun_fd_request_irq(void)
+{
+	static int once = 0;
+	int error;
+
+	if(!once) {
+		once = 1;
+
+		error = request_irq(FLOPPY_IRQ, sparc_floppy_irq,
+				    0, "floppy", NULL);
+
+		return ((error = 0) ? 0 : -1);
+	}
+	return 0;
+}
+
+static void sun_fd_free_irq(void)
+{
+}
+
+static unsigned int sun_get_dma_residue(void)
+{
+	/* XXX This isn't really correct. XXX */
+	return 0;
+}
+
+static int sun_fd_eject(int drive)
+{
+	set_dor(0x00, 0xff, 0x90);
+	udelay(500);
+	set_dor(0x00, 0x6f, 0x00);
+	udelay(500);
+	return 0;
+}
+
+#include <asm/ebus_dma.h>
+#include <asm/ns87303.h>
+
+static struct ebus_dma_info sun_pci_fd_ebus_dma;
+static struct device *sun_floppy_dev;
+static int sun_pci_broken_drive = -1;
+
+struct sun_pci_dma_op {
+	unsigned int 	addr;
+	int		len;
+	int		direction;
+	char		*buf;
+};
+static struct sun_pci_dma_op sun_pci_dma_current = { -1U, 0, 0, NULL};
+static struct sun_pci_dma_op sun_pci_dma_pending = { -1U, 0, 0, NULL};
+
+irqreturn_t floppy_interrupt(int irq, void *dev_id);
+
+static unsigned char sun_pci_fd_inb(unsigned long base, unsigned int reg)
+{
+	udelay(5);
+	return inb(base + reg);
+}
+
+static void sun_pci_fd_outb(unsigned char val, unsigned long base,
+			    unsigned int reg)
+{
+	udelay(5);
+	outb(val, base + reg);
+}
+
+static void sun_pci_fd_broken_outb(unsigned char val, unsigned long base,
+				   unsigned int reg)
+{
+	udelay(5);
+	/*
+	 * XXX: Due to SUN's broken floppy connector on AX and AXi
+	 *      we need to turn on MOTOR_0 also, if the floppy is
+	 *      jumpered to DS1 (like most PC floppies are). I hope
+	 *      this does not hurt correct hardware like the AXmp.
+	 *      (Eddie, Sep 12 1998).
+	 */
+	if (reg = FD_DOR) {
+		if (((val & 0x03) = sun_pci_broken_drive) && (val & 0x20)) {
+			val |= 0x10;
+		}
+	}
+	outb(val, base + reg);
+}
+
+#ifdef PCI_FDC_SWAP_DRIVES
+static void sun_pci_fd_lde_broken_outb(unsigned char val, unsigned long base,
+				       unsigned int reg)
+{
+	udelay(5);
+	/*
+	 * XXX: Due to SUN's broken floppy connector on AX and AXi
+	 *      we need to turn on MOTOR_0 also, if the floppy is
+	 *      jumpered to DS1 (like most PC floppies are). I hope
+	 *      this does not hurt correct hardware like the AXmp.
+	 *      (Eddie, Sep 12 1998).
+	 */
+	if (reg = FD_DOR) {
+		if (((val & 0x03) = sun_pci_broken_drive) && (val & 0x10)) {
+			val &= ~(0x03);
+			val |= 0x21;
+		}
+	}
+	outb(val, base + reg);
+}
+#endif /* PCI_FDC_SWAP_DRIVES */
+
+static void sun_pci_fd_enable_dma(void)
+{
+	BUG_ON((NULL = sun_pci_dma_pending.buf) 	||
+	    (0	  = sun_pci_dma_pending.len) 	||
+	    (0	  = sun_pci_dma_pending.direction));
+
+	sun_pci_dma_current.buf = sun_pci_dma_pending.buf;
+	sun_pci_dma_current.len = sun_pci_dma_pending.len;
+	sun_pci_dma_current.direction = sun_pci_dma_pending.direction;
+
+	sun_pci_dma_pending.buf  = NULL;
+	sun_pci_dma_pending.len  = 0;
+	sun_pci_dma_pending.direction = 0;
+	sun_pci_dma_pending.addr = -1U;
+
+	sun_pci_dma_current.addr +		dma_map_single(sun_floppy_dev,
+			       sun_pci_dma_current.buf,
+			       sun_pci_dma_current.len,
+			       sun_pci_dma_current.direction);
+
+	ebus_dma_enable(&sun_pci_fd_ebus_dma, 1);
+
+	if (ebus_dma_request(&sun_pci_fd_ebus_dma,
+			     sun_pci_dma_current.addr,
+			     sun_pci_dma_current.len))
+		BUG();
+}
+
+static void sun_pci_fd_disable_dma(void)
+{
+	ebus_dma_enable(&sun_pci_fd_ebus_dma, 0);
+	if (sun_pci_dma_current.addr != -1U)
+		dma_unmap_single(sun_floppy_dev,
+				 sun_pci_dma_current.addr,
+				 sun_pci_dma_current.len,
+				 sun_pci_dma_current.direction);
+	sun_pci_dma_current.addr = -1U;
+}
+
+static void sun_pci_fd_set_dma_mode(int mode)
+{
+	if (mode = DMA_MODE_WRITE)
+		sun_pci_dma_pending.direction = DMA_TO_DEVICE;
+	else
+		sun_pci_dma_pending.direction = DMA_FROM_DEVICE;
+
+	ebus_dma_prepare(&sun_pci_fd_ebus_dma, mode != DMA_MODE_WRITE);
+}
+
+static void sun_pci_fd_set_dma_count(int length)
+{
+	sun_pci_dma_pending.len = length;
+}
+
+static void sun_pci_fd_set_dma_addr(char *buffer)
+{
+	sun_pci_dma_pending.buf = buffer;
+}
+
+static unsigned int sun_pci_get_dma_residue(void)
+{
+	return ebus_dma_residue(&sun_pci_fd_ebus_dma);
+}
+
+static int sun_pci_fd_request_irq(void)
+{
+	return ebus_dma_irq_enable(&sun_pci_fd_ebus_dma, 1);
+}
+
+static void sun_pci_fd_free_irq(void)
+{
+	ebus_dma_irq_enable(&sun_pci_fd_ebus_dma, 0);
+}
+
+static int sun_pci_fd_eject(int drive)
+{
+	return -EINVAL;
+}
+
+void sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event, void *cookie)
+{
+	floppy_interrupt(0, NULL);
+}
+
+/*
+ * Floppy probing, we'd like to use /dev/fd0 for a single Floppy on PCI,
+ * even if this is configured using DS1, thus looks like /dev/fd1 with
+ * the cabling used in Ultras.
+ */
+#define DOR	(port + 2)
+#define MSR	(port + 4)
+#define FIFO	(port + 5)
+
+static void sun_pci_fd_out_byte(unsigned long port, unsigned char val,
+			        unsigned long reg)
+{
+	unsigned char status;
+	int timeout = 1000;
+
+	while (!((status = inb(MSR)) & 0x80) && --timeout)
+		udelay(100);
+	outb(val, reg);
+}
+
+static unsigned char sun_pci_fd_sensei(unsigned long port)
+{
+	unsigned char result[2] = { 0x70, 0x00 };
+	unsigned char status;
+	int i = 0;
+
+	sun_pci_fd_out_byte(port, 0x08, FIFO);
+	do {
+		int timeout = 1000;
+
+		while (!((status = inb(MSR)) & 0x80) && --timeout)
+			udelay(100);
+
+		if (!timeout)
+			break;
+
+		if ((status & 0xf0) = 0xd0)
+			result[i++] = inb(FIFO);
+		else
+			break;
+	} while (i < 2);
+
+	return result[0];
+}
+
+static void sun_pci_fd_reset(unsigned long port)
+{
+	unsigned char mask = 0x00;
+	unsigned char status;
+	int timeout = 10000;
+
+	outb(0x80, MSR);
+	do {
+		status = sun_pci_fd_sensei(port);
+		if ((status & 0xc0) = 0xc0)
+			mask |= 1 << (status & 0x03);
+		else
+			udelay(100);
+	} while ((mask != 0x0f) && --timeout);
+}
+
+static int sun_pci_fd_test_drive(unsigned long port, int drive)
+{
+	unsigned char status, data;
+	int timeout = 1000;
+	int ready;
+
+	sun_pci_fd_reset(port);
+
+	data = (0x10 << drive) | 0x0c | drive;
+	sun_pci_fd_out_byte(port, data, DOR);
+
+	sun_pci_fd_out_byte(port, 0x07, FIFO);
+	sun_pci_fd_out_byte(port, drive & 0x03, FIFO);
+
+	do {
+		udelay(100);
+		status = sun_pci_fd_sensei(port);
+	} while (((status & 0xc0) = 0x80) && --timeout);
+
+	if (!timeout)
+		ready = 0;
+	else
+		ready = (status & 0x10) ? 0 : 1;
+
+	sun_pci_fd_reset(port);
+	return ready;
+}
+#undef FIFO
+#undef MSR
+#undef DOR
+
+static int __init ebus_fdthree_p(struct device_node *dp)
+{
+	if (of_node_name_eq(dp, "fdthree"))
+		return 1;
+	if (of_node_name_eq(dp, "floppy")) {
+		const char *compat;
+
+		compat = of_get_property(dp, "compatible", NULL);
+		if (compat && !strcmp(compat, "fdthree"))
+			return 1;
+	}
+	return 0;
+}
+
+static unsigned long __init sun_floppy_init(void)
+{
+	static int initialized = 0;
+	struct device_node *dp;
+	struct platform_device *op;
+	const char *prop;
+	char state[128];
+
+	if (initialized)
+		return sun_floppy_types[0];
+	initialized = 1;
+
+	op = NULL;
+
+	for_each_node_by_name(dp, "SUNW,fdtwo") {
+		if (!of_node_name_eq(dp->parent, "sbus"))
+			continue;
+		op = of_find_device_by_node(dp);
+		if (op)
+			break;
+	}
+	if (op) {
+		floppy_op = op;
+		FLOPPY_IRQ = op->archdata.irqs[0];
+	} else {
+		struct device_node *ebus_dp;
+		void __iomem *auxio_reg;
+		const char *state_prop;
+		unsigned long config;
+
+		dp = NULL;
+		for_each_node_by_name(ebus_dp, "ebus") {
+			for (dp = ebus_dp->child; dp; dp = dp->sibling) {
+				if (ebus_fdthree_p(dp))
+					goto found_fdthree;
+			}
+		}
+	found_fdthree:
+		if (!dp)
+			return 0;
+
+		op = of_find_device_by_node(dp);
+		if (!op)
+			return 0;
+
+		state_prop = of_get_property(op->dev.of_node, "status", NULL);
+		if (state_prop && !strncmp(state_prop, "disabled", 8))
+			return 0;
+
+		FLOPPY_IRQ = op->archdata.irqs[0];
+
+		/* Make sure the high density bit is set, some systems
+		 * (most notably Ultra5/Ultra10) come up with it clear.
+		 */
+		auxio_reg = (void __iomem *) op->resource[2].start;
+		writel(readl(auxio_reg)|0x2, auxio_reg);
+
+		sun_floppy_dev = &op->dev;
+
+		spin_lock_init(&sun_pci_fd_ebus_dma.lock);
+
+		/* XXX ioremap */
+		sun_pci_fd_ebus_dma.regs = (void __iomem *)
+			op->resource[1].start;
+		if (!sun_pci_fd_ebus_dma.regs)
+			return 0;
+
+		sun_pci_fd_ebus_dma.flags = (EBUS_DMA_FLAG_USE_EBDMA_HANDLER |
+					     EBUS_DMA_FLAG_TCI_DISABLE);
+		sun_pci_fd_ebus_dma.callback = sun_pci_fd_dma_callback;
+		sun_pci_fd_ebus_dma.client_cookie = NULL;
+		sun_pci_fd_ebus_dma.irq = FLOPPY_IRQ;
+		strcpy(sun_pci_fd_ebus_dma.name, "floppy");
+		if (ebus_dma_register(&sun_pci_fd_ebus_dma))
+			return 0;
+
+		/* XXX ioremap */
+		sun_fdc = (struct sun_flpy_controller *) op->resource[0].start;
+
+		sun_fdops.fd_inb = sun_pci_fd_inb;
+		sun_fdops.fd_outb = sun_pci_fd_outb;
+
+		can_use_virtual_dma = use_virtual_dma = 0;
+		sun_fdops.fd_enable_dma = sun_pci_fd_enable_dma;
+		sun_fdops.fd_disable_dma = sun_pci_fd_disable_dma;
+		sun_fdops.fd_set_dma_mode = sun_pci_fd_set_dma_mode;
+		sun_fdops.fd_set_dma_addr = sun_pci_fd_set_dma_addr;
+		sun_fdops.fd_set_dma_count = sun_pci_fd_set_dma_count;
+		sun_fdops.get_dma_residue = sun_pci_get_dma_residue;
+
+		sun_fdops.fd_request_irq = sun_pci_fd_request_irq;
+		sun_fdops.fd_free_irq = sun_pci_fd_free_irq;
+
+		sun_fdops.fd_eject = sun_pci_fd_eject;
+
+		fdc_status = (unsigned long) &sun_fdc->status_82077;
+
+		/*
+		 * XXX: Find out on which machines this is really needed.
+		 */
+		if (1) {
+			sun_pci_broken_drive = 1;
+			sun_fdops.fd_outb = sun_pci_fd_broken_outb;
+		}
+
+		allowed_drive_mask = 0;
+		if (sun_pci_fd_test_drive((unsigned long)sun_fdc, 0))
+			sun_floppy_types[0] = 4;
+		if (sun_pci_fd_test_drive((unsigned long)sun_fdc, 1))
+			sun_floppy_types[1] = 4;
+
+		/*
+		 * Find NS87303 SuperIO config registers (through ecpp).
+		 */
+		config = 0;
+		for (dp = ebus_dp->child; dp; dp = dp->sibling) {
+			if (of_node_name_eq(dp, "ecpp")) {
+				struct platform_device *ecpp_op;
+
+				ecpp_op = of_find_device_by_node(dp);
+				if (ecpp_op)
+					config = ecpp_op->resource[1].start;
+				goto config_done;
+			}
+		}
+	config_done:
+
+		/*
+		 * Sanity check, is this really the NS87303?
+		 */
+		switch (config & 0x3ff) {
+		case 0x02e:
+		case 0x15c:
+		case 0x26e:
+		case 0x398:
+			break;
+		default:
+			config = 0;
+		}
+
+		if (!config)
+			return sun_floppy_types[0];
+
+		/* Enable PC-AT mode. */
+		ns87303_modify(config, ASC, 0, 0xc0);
+
+#ifdef PCI_FDC_SWAP_DRIVES
+		/*
+		 * If only Floppy 1 is present, swap drives.
+		 */
+		if (!sun_floppy_types[0] && sun_floppy_types[1]) {
+			/*
+			 * Set the drive exchange bit in FCR on NS87303,
+			 * make sure other bits are sane before doing so.
+			 */
+			ns87303_modify(config, FER, FER_EDM, 0);
+			ns87303_modify(config, ASC, ASC_DRV2_SEL, 0);
+			ns87303_modify(config, FCR, 0, FCR_LDE);
+
+			config = sun_floppy_types[0];
+			sun_floppy_types[0] = sun_floppy_types[1];
+			sun_floppy_types[1] = config;
+
+			if (sun_pci_broken_drive != -1) {
+				sun_pci_broken_drive = 1 - sun_pci_broken_drive;
+				sun_fdops.fd_outb = sun_pci_fd_lde_broken_outb;
+			}
+		}
+#endif /* PCI_FDC_SWAP_DRIVES */
+
+		return sun_floppy_types[0];
+	}
+	prop = of_get_property(op->dev.of_node, "status", NULL);
+	if (prop && !strncmp(state, "disabled", 8))
+		return 0;
+
+	/*
+	 * We cannot do of_ioremap here: it does request_region,
+	 * which the generic floppy driver tries to do once again.
+	 * But we must use the sdev resource values as they have
+	 * had parent ranges applied.
+	 */
+	sun_fdc = (struct sun_flpy_controller *)
+		(op->resource[0].start +
+		 ((op->resource[0].flags & 0x1ffUL) << 32UL));
+
+	/* Last minute sanity check... */
+	if (sbus_readb(&sun_fdc->status1_82077) = 0xff) {
+		sun_fdc = (struct sun_flpy_controller *)-1;
+		return 0;
+	}
+
+        sun_fdops.fd_inb = sun_82077_fd_inb;
+        sun_fdops.fd_outb = sun_82077_fd_outb;
+
+	can_use_virtual_dma = use_virtual_dma = 1;
+	sun_fdops.fd_enable_dma = sun_fd_enable_dma;
+	sun_fdops.fd_disable_dma = sun_fd_disable_dma;
+	sun_fdops.fd_set_dma_mode = sun_fd_set_dma_mode;
+	sun_fdops.fd_set_dma_addr = sun_fd_set_dma_addr;
+	sun_fdops.fd_set_dma_count = sun_fd_set_dma_count;
+	sun_fdops.get_dma_residue = sun_get_dma_residue;
+
+	sun_fdops.fd_request_irq = sun_fd_request_irq;
+	sun_fdops.fd_free_irq = sun_fd_free_irq;
+
+	sun_fdops.fd_eject = sun_fd_eject;
+
+        fdc_status = (unsigned long) &sun_fdc->status_82077;
+
+	/* Success... */
+	allowed_drive_mask = 0x01;
+	sun_floppy_types[0] = 4;
+	sun_floppy_types[1] = 0;
+
+	return sun_floppy_types[0];
+}
+
+#define EXTRA_FLOPPY_PARAMS
+
+static DEFINE_SPINLOCK(dma_spin_lock);
+
+#define claim_dma_lock() \
+({	unsigned long flags; \
+	spin_lock_irqsave(&dma_spin_lock, flags); \
+	flags; \
+})
+
+#define release_dma_lock(__flags) \
+	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+
+#endif /* !(__ASM_SPARC64_FLOPPY_H) */
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
deleted file mode 100644
index e10ab9ad3097..000000000000
--- a/arch/sparc/include/asm/floppy_32.h
+++ /dev/null
@@ -1,393 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* asm/floppy.h: Sparc specific parts of the Floppy driver.
- *
- * Copyright (C) 1995 David S. Miller (davem@davemloft.net)
- */
-
-#ifndef __ASM_SPARC_FLOPPY_H
-#define __ASM_SPARC_FLOPPY_H
-
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/pgtable.h>
-
-#include <asm/idprom.h>
-#include <asm/oplib.h>
-#include <asm/auxio.h>
-#include <asm/setup.h>
-#include <asm/page.h>
-#include <asm/irq.h>
-
-/* We don't need no stinkin' I/O port allocation crap. */
-#undef release_region
-#undef request_region
-#define release_region(X, Y)	do { } while(0)
-#define request_region(X, Y, Z)	(1)
-
-/* References:
- * 1) Netbsd Sun floppy driver.
- * 2) NCR 82077 controller manual
- * 3) Intel 82077 controller manual
- */
-struct sun_flpy_controller {
-	volatile unsigned char status_82072;  /* Main Status reg. */
-#define dcr_82072              status_82072   /* Digital Control reg. */
-#define status1_82077          status_82072   /* Auxiliary Status reg. 1 */
-
-	volatile unsigned char data_82072;    /* Data fifo. */
-#define status2_82077          data_82072     /* Auxiliary Status reg. 2 */
-
-	volatile unsigned char dor_82077;     /* Digital Output reg. */
-	volatile unsigned char tapectl_82077; /* What the? Tape control reg? */
-
-	volatile unsigned char status_82077;  /* Main Status Register. */
-#define drs_82077              status_82077   /* Digital Rate Select reg. */
-
-	volatile unsigned char data_82077;    /* Data fifo. */
-	volatile unsigned char ___unused;
-	volatile unsigned char dir_82077;     /* Digital Input reg. */
-#define dcr_82077              dir_82077      /* Config Control reg. */
-};
-
-/* You'll only ever find one controller on a SparcStation anyways. */
-static struct sun_flpy_controller *sun_fdc = NULL;
-
-struct sun_floppy_ops {
-	unsigned char (*fd_inb)(int port);
-	void (*fd_outb)(unsigned char value, int port);
-};
-
-static struct sun_floppy_ops sun_fdops;
-
-#define fd_inb(base, reg)         sun_fdops.fd_inb(reg)
-#define fd_outb(value, base, reg) sun_fdops.fd_outb(value, reg)
-#define fd_enable_dma()           sun_fd_enable_dma()
-#define fd_disable_dma()          sun_fd_disable_dma()
-#define fd_request_dma()          (0) /* nothing... */
-#define fd_free_dma()             /* nothing... */
-#define fd_clear_dma_ff()         /* nothing... */
-#define fd_set_dma_mode(mode)     sun_fd_set_dma_mode(mode)
-#define fd_set_dma_addr(addr)     sun_fd_set_dma_addr(addr)
-#define fd_set_dma_count(count)   sun_fd_set_dma_count(count)
-#define fd_enable_irq()           /* nothing... */
-#define fd_disable_irq()          /* nothing... */
-#define fd_request_irq()          sun_fd_request_irq()
-#define fd_free_irq()             /* nothing... */
-#if 0  /* P3: added by Alain, these cause a MMU corruption. 19960524 XXX */
-#define fd_dma_mem_alloc(size)    ((unsigned long) vmalloc(size))
-#define fd_dma_mem_free(addr,size) (vfree((void *)(addr)))
-#endif
-
-/* XXX This isn't really correct. XXX */
-#define get_dma_residue(x)        (0)
-
-#define FLOPPY0_TYPE  4
-#define FLOPPY1_TYPE  0
-
-/* Super paranoid... */
-#undef HAVE_DISABLE_HLT
-
-/* Here is where we catch the floppy driver trying to initialize,
- * therefore this is where we call the PROM device tree probing
- * routine etc. on the Sparc.
- */
-#define FDC1                      sun_floppy_init()
-
-#define N_FDC    1
-#define N_DRIVE  8
-
-/* No 64k boundary crossing problems on the Sparc. */
-#define CROSS_64KB(a,s) (0)
-
-/* Routines unique to each controller type on a Sun. */
-static void sun_set_dor(unsigned char value, int fdc_82077)
-{
-	if (fdc_82077)
-		sun_fdc->dor_82077 = value;
-}
-
-static unsigned char sun_read_dir(void)
-{
-	return sun_fdc->dir_82077;
-}
-
-static unsigned char sun_82072_fd_inb(int port)
-{
-	udelay(5);
-	switch (port) {
-	default:
-		printk("floppy: Asked to read unknown port %d\n", port);
-		panic("floppy: Port bolixed.");
-	case FD_STATUS:
-		return sun_fdc->status_82072 & ~STATUS_DMA;
-	case FD_DATA:
-		return sun_fdc->data_82072;
-	case FD_DIR:
-		return sun_read_dir();
-	}
-	panic("sun_82072_fd_inb: How did I get here?");
-}
-
-static void sun_82072_fd_outb(unsigned char value, int port)
-{
-	udelay(5);
-	switch (port) {
-	default:
-		printk("floppy: Asked to write to unknown port %d\n", port);
-		panic("floppy: Port bolixed.");
-	case FD_DOR:
-		sun_set_dor(value, 0);
-		break;
-	case FD_DATA:
-		sun_fdc->data_82072 = value;
-		break;
-	case FD_DCR:
-		sun_fdc->dcr_82072 = value;
-		break;
-	case FD_DSR:
-		sun_fdc->status_82072 = value;
-		break;
-	}
-	return;
-}
-
-static unsigned char sun_82077_fd_inb(int port)
-{
-	udelay(5);
-	switch (port) {
-	default:
-		printk("floppy: Asked to read unknown port %d\n", port);
-		panic("floppy: Port bolixed.");
-	case FD_SRA:
-		return sun_fdc->status1_82077;
-	case FD_SRB:
-		return sun_fdc->status2_82077;
-	case FD_DOR:
-		return sun_fdc->dor_82077;
-	case FD_TDR:
-		return sun_fdc->tapectl_82077;
-	case FD_STATUS:
-		return sun_fdc->status_82077 & ~STATUS_DMA;
-	case FD_DATA:
-		return sun_fdc->data_82077;
-	case FD_DIR:
-		return sun_read_dir();
-	}
-	panic("sun_82077_fd_inb: How did I get here?");
-}
-
-static void sun_82077_fd_outb(unsigned char value, int port)
-{
-	udelay(5);
-	switch (port) {
-	default:
-		printk("floppy: Asked to write to unknown port %d\n", port);
-		panic("floppy: Port bolixed.");
-	case FD_DOR:
-		sun_set_dor(value, 1);
-		break;
-	case FD_DATA:
-		sun_fdc->data_82077 = value;
-		break;
-	case FD_DCR:
-		sun_fdc->dcr_82077 = value;
-		break;
-	case FD_DSR:
-		sun_fdc->status_82077 = value;
-		break;
-	case FD_TDR:
-		sun_fdc->tapectl_82077 = value;
-		break;
-	}
-	return;
-}
-
-/* For pseudo-dma (Sun floppy drives have no real DMA available to
- * them so we must eat the data fifo bytes directly ourselves) we have
- * three state variables.  doing_pdma tells our inline low-level
- * assembly floppy interrupt entry point whether it should sit and eat
- * bytes from the fifo or just transfer control up to the higher level
- * floppy interrupt c-code.  I tried very hard but I could not get the
- * pseudo-dma to work in c-code without getting many overruns and
- * underruns.  If non-zero, doing_pdma encodes the direction of
- * the transfer for debugging.  1=read 2=write
- */
-
-/* Common routines to all controller types on the Sparc. */
-static inline void virtual_dma_init(void)
-{
-	/* nothing... */
-}
-
-static inline void sun_fd_disable_dma(void)
-{
-	doing_pdma = 0;
-	pdma_base = NULL;
-}
-
-static inline void sun_fd_set_dma_mode(int mode)
-{
-	switch(mode) {
-	case DMA_MODE_READ:
-		doing_pdma = 1;
-		break;
-	case DMA_MODE_WRITE:
-		doing_pdma = 2;
-		break;
-	default:
-		printk("Unknown dma mode %d\n", mode);
-		panic("floppy: Giving up...");
-	}
-}
-
-static inline void sun_fd_set_dma_addr(char *buffer)
-{
-	pdma_vaddr = buffer;
-}
-
-static inline void sun_fd_set_dma_count(int length)
-{
-	pdma_size = length;
-}
-
-static inline void sun_fd_enable_dma(void)
-{
-	pdma_base = pdma_vaddr;
-	pdma_areasize = pdma_size;
-}
-
-int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler);
-
-static int sun_fd_request_irq(void)
-{
-	static int once = 0;
-
-	if (!once) {
-		once = 1;
-		return sparc_floppy_request_irq(FLOPPY_IRQ, floppy_interrupt);
-	} else {
-		return 0;
-	}
-}
-
-static struct linux_prom_registers fd_regs[2];
-
-static int sun_floppy_init(void)
-{
-	struct platform_device *op;
-	struct device_node *dp;
-	struct resource r;
-	char state[128];
-	phandle fd_node;
-	phandle tnode;
-	int num_regs;
-
-	use_virtual_dma = 1;
-
-	/* Forget it if we aren't on a machine that could possibly
-	 * ever have a floppy drive.
-	 */
-	if (sparc_cpu_model != sun4m) {
-		/* We certainly don't have a floppy controller. */
-		goto no_sun_fdc;
-	}
-	/* Well, try to find one. */
-	tnode = prom_getchild(prom_root_node);
-	fd_node = prom_searchsiblings(tnode, "obio");
-	if (fd_node != 0) {
-		tnode = prom_getchild(fd_node);
-		fd_node = prom_searchsiblings(tnode, "SUNW,fdtwo");
-	} else {
-		fd_node = prom_searchsiblings(tnode, "fd");
-	}
-	if (fd_node = 0) {
-		goto no_sun_fdc;
-	}
-
-	/* The sun4m lets us know if the controller is actually usable. */
-	if (prom_getproperty(fd_node, "status", state, sizeof(state)) != -1) {
-		if(!strcmp(state, "disabled")) {
-			goto no_sun_fdc;
-		}
-	}
-	num_regs = prom_getproperty(fd_node, "reg", (char *) fd_regs, sizeof(fd_regs));
-	num_regs = (num_regs / sizeof(fd_regs[0]));
-	prom_apply_obio_ranges(fd_regs, num_regs);
-	memset(&r, 0, sizeof(r));
-	r.flags = fd_regs[0].which_io;
-	r.start = fd_regs[0].phys_addr;
-	sun_fdc = of_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");
-
-	/* Look up irq in platform_device.
-	 * We try "SUNW,fdtwo" and "fd"
-	 */
-	op = NULL;
-	for_each_node_by_name(dp, "SUNW,fdtwo") {
-		op = of_find_device_by_node(dp);
-		if (op)
-			break;
-	}
-	if (!op) {
-		for_each_node_by_name(dp, "fd") {
-			op = of_find_device_by_node(dp);
-			if (op)
-				break;
-		}
-	}
-	if (!op)
-		goto no_sun_fdc;
-
-	FLOPPY_IRQ = op->archdata.irqs[0];
-
-	/* Last minute sanity check... */
-	if (sun_fdc->status_82072 = 0xff) {
-		sun_fdc = NULL;
-		goto no_sun_fdc;
-	}
-
-	sun_fdops.fd_inb = sun_82077_fd_inb;
-	sun_fdops.fd_outb = sun_82077_fd_outb;
-	fdc_status = &sun_fdc->status_82077;
-
-	if (sun_fdc->dor_82077 = 0x80) {
-		sun_fdc->dor_82077 = 0x02;
-		if (sun_fdc->dor_82077 = 0x80) {
-			sun_fdops.fd_inb = sun_82072_fd_inb;
-			sun_fdops.fd_outb = sun_82072_fd_outb;
-			fdc_status = &sun_fdc->status_82072;
-		}
-	}
-
-	/* Success... */
-	allowed_drive_mask = 0x01;
-	return (int) sun_fdc;
-
-no_sun_fdc:
-	return -1;
-}
-
-static int sparc_eject(void)
-{
-	set_dor(0x00, 0xff, 0x90);
-	udelay(500);
-	set_dor(0x00, 0x6f, 0x00);
-	udelay(500);
-	return 0;
-}
-
-#define fd_eject(drive) sparc_eject()
-
-#define EXTRA_FLOPPY_PARAMS
-
-static DEFINE_SPINLOCK(dma_spin_lock);
-
-#define claim_dma_lock() \
-({	unsigned long flags; \
-	spin_lock_irqsave(&dma_spin_lock, flags); \
-	flags; \
-})
-
-#define release_dma_lock(__flags) \
-	spin_unlock_irqrestore(&dma_spin_lock, __flags);
-
-#endif /* !(__ASM_SPARC_FLOPPY_H) */
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
deleted file mode 100644
index 070c8c1f5c8f..000000000000
--- a/arch/sparc/include/asm/floppy_64.h
+++ /dev/null
@@ -1,779 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* floppy.h: Sparc specific parts of the Floppy driver.
- *
- * Copyright (C) 1996, 2007, 2008 David S. Miller (davem@davemloft.net)
- * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- *
- * Ultra/PCI support added: Sep 1997  Eddie C. Dost  (ecd@skynet.be)
- */
-
-#ifndef __ASM_SPARC64_FLOPPY_H
-#define __ASM_SPARC64_FLOPPY_H
-
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/auxio.h>
-
-/*
- * Define this to enable exchanging drive 0 and 1 if only drive 1 is
- * probed on PCI machines.
- */
-#undef PCI_FDC_SWAP_DRIVES
-
-
-/* References:
- * 1) Netbsd Sun floppy driver.
- * 2) NCR 82077 controller manual
- * 3) Intel 82077 controller manual
- */
-struct sun_flpy_controller {
-	volatile unsigned char status1_82077; /* Auxiliary Status reg. 1 */
-	volatile unsigned char status2_82077; /* Auxiliary Status reg. 2 */
-	volatile unsigned char dor_82077;     /* Digital Output reg. */
-	volatile unsigned char tapectl_82077; /* Tape Control reg */
-	volatile unsigned char status_82077;  /* Main Status Register. */
-#define drs_82077              status_82077   /* Digital Rate Select reg. */
-	volatile unsigned char data_82077;    /* Data fifo. */
-	volatile unsigned char ___unused;
-	volatile unsigned char dir_82077;     /* Digital Input reg. */
-#define dcr_82077              dir_82077      /* Config Control reg. */
-};
-
-/* You'll only ever find one controller on an Ultra anyways. */
-static struct sun_flpy_controller *sun_fdc = (struct sun_flpy_controller *)-1;
-unsigned long fdc_status;
-static struct platform_device *floppy_op = NULL;
-
-struct sun_floppy_ops {
-	unsigned char	(*fd_inb) (unsigned long port, unsigned int reg);
-	void		(*fd_outb) (unsigned char value, unsigned long base,
-				    unsigned int reg);
-	void		(*fd_enable_dma) (void);
-	void		(*fd_disable_dma) (void);
-	void		(*fd_set_dma_mode) (int);
-	void		(*fd_set_dma_addr) (char *);
-	void		(*fd_set_dma_count) (int);
-	unsigned int	(*get_dma_residue) (void);
-	int		(*fd_request_irq) (void);
-	void		(*fd_free_irq) (void);
-	int		(*fd_eject) (int);
-};
-
-static struct sun_floppy_ops sun_fdops;
-
-#define fd_inb(base, reg)         sun_fdops.fd_inb(base, reg)
-#define fd_outb(value, base, reg) sun_fdops.fd_outb(value, base, reg)
-#define fd_enable_dma()           sun_fdops.fd_enable_dma()
-#define fd_disable_dma()          sun_fdops.fd_disable_dma()
-#define fd_request_dma()          (0) /* nothing... */
-#define fd_free_dma()             /* nothing... */
-#define fd_clear_dma_ff()         /* nothing... */
-#define fd_set_dma_mode(mode)     sun_fdops.fd_set_dma_mode(mode)
-#define fd_set_dma_addr(addr)     sun_fdops.fd_set_dma_addr(addr)
-#define fd_set_dma_count(count)   sun_fdops.fd_set_dma_count(count)
-#define get_dma_residue(x)        sun_fdops.get_dma_residue()
-#define fd_request_irq()          sun_fdops.fd_request_irq()
-#define fd_free_irq()             sun_fdops.fd_free_irq()
-#define fd_eject(drive)           sun_fdops.fd_eject(drive)
-
-/* Super paranoid... */
-#undef HAVE_DISABLE_HLT
-
-static int sun_floppy_types[2] = { 0, 0 };
-
-/* Here is where we catch the floppy driver trying to initialize,
- * therefore this is where we call the PROM device tree probing
- * routine etc. on the Sparc.
- */
-#define FLOPPY0_TYPE		sun_floppy_init()
-#define FLOPPY1_TYPE		sun_floppy_types[1]
-
-#define FDC1			((unsigned long)sun_fdc)
-
-#define N_FDC    1
-#define N_DRIVE  8
-
-/* No 64k boundary crossing problems on the Sparc. */
-#define CROSS_64KB(a,s) (0)
-
-static unsigned char sun_82077_fd_inb(unsigned long base, unsigned int reg)
-{
-	udelay(5);
-	switch (reg) {
-	default:
-		printk("floppy: Asked to read unknown port %x\n", reg);
-		panic("floppy: Port bolixed.");
-	case FD_STATUS:
-		return sbus_readb(&sun_fdc->status_82077) & ~STATUS_DMA;
-	case FD_DATA:
-		return sbus_readb(&sun_fdc->data_82077);
-	case FD_DIR:
-		/* XXX: Is DCL on 0x80 in sun4m? */
-		return sbus_readb(&sun_fdc->dir_82077);
-	}
-	panic("sun_82072_fd_inb: How did I get here?");
-}
-
-static void sun_82077_fd_outb(unsigned char value, unsigned long base,
-			      unsigned int reg)
-{
-	udelay(5);
-	switch (reg) {
-	default:
-		printk("floppy: Asked to write to unknown port %x\n", reg);
-		panic("floppy: Port bolixed.");
-	case FD_DOR:
-		/* Happily, the 82077 has a real DOR register. */
-		sbus_writeb(value, &sun_fdc->dor_82077);
-		break;
-	case FD_DATA:
-		sbus_writeb(value, &sun_fdc->data_82077);
-		break;
-	case FD_DCR:
-		sbus_writeb(value, &sun_fdc->dcr_82077);
-		break;
-	case FD_DSR:
-		sbus_writeb(value, &sun_fdc->status_82077);
-		break;
-	}
-	return;
-}
-
-/* For pseudo-dma (Sun floppy drives have no real DMA available to
- * them so we must eat the data fifo bytes directly ourselves) we have
- * three state variables.  doing_pdma tells our inline low-level
- * assembly floppy interrupt entry point whether it should sit and eat
- * bytes from the fifo or just transfer control up to the higher level
- * floppy interrupt c-code.  I tried very hard but I could not get the
- * pseudo-dma to work in c-code without getting many overruns and
- * underruns.  If non-zero, doing_pdma encodes the direction of
- * the transfer for debugging.  1=read 2=write
- */
-unsigned char *pdma_vaddr;
-unsigned long pdma_size;
-volatile int doing_pdma = 0;
-
-/* This is software state */
-char *pdma_base = NULL;
-unsigned long pdma_areasize;
-
-/* Common routines to all controller types on the Sparc. */
-static void sun_fd_disable_dma(void)
-{
-	doing_pdma = 0;
-	pdma_base = NULL;
-}
-
-static void sun_fd_set_dma_mode(int mode)
-{
-	switch(mode) {
-	case DMA_MODE_READ:
-		doing_pdma = 1;
-		break;
-	case DMA_MODE_WRITE:
-		doing_pdma = 2;
-		break;
-	default:
-		printk("Unknown dma mode %d\n", mode);
-		panic("floppy: Giving up...");
-	}
-}
-
-static void sun_fd_set_dma_addr(char *buffer)
-{
-	pdma_vaddr = buffer;
-}
-
-static void sun_fd_set_dma_count(int length)
-{
-	pdma_size = length;
-}
-
-static void sun_fd_enable_dma(void)
-{
-	pdma_base = pdma_vaddr;
-	pdma_areasize = pdma_size;
-}
-
-irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie)
-{
-	if (likely(doing_pdma)) {
-		void __iomem *stat = (void __iomem *) fdc_status;
-		unsigned char *vaddr = pdma_vaddr;
-		unsigned long size = pdma_size;
-		u8 val;
-
-		while (size) {
-			val = readb(stat);
-			if (unlikely(!(val & 0x80))) {
-				pdma_vaddr = vaddr;
-				pdma_size = size;
-				return IRQ_HANDLED;
-			}
-			if (unlikely(!(val & 0x20))) {
-				pdma_vaddr = vaddr;
-				pdma_size = size;
-				doing_pdma = 0;
-				goto main_interrupt;
-			}
-			if (val & 0x40) {
-				/* read */
-				*vaddr++ = readb(stat + 1);
-			} else {
-				unsigned char data = *vaddr++;
-
-				/* write */
-				writeb(data, stat + 1);
-			}
-			size--;
-		}
-
-		pdma_vaddr = vaddr;
-		pdma_size = size;
-
-		/* Send Terminal Count pulse to floppy controller. */
-		val = readb(auxio_register);
-		val |= AUXIO_AUX1_FTCNT;
-		writeb(val, auxio_register);
-		val &= ~AUXIO_AUX1_FTCNT;
-		writeb(val, auxio_register);
-
-		doing_pdma = 0;
-	}
-
-main_interrupt:
-	return floppy_interrupt(irq, dev_cookie);
-}
-
-static int sun_fd_request_irq(void)
-{
-	static int once = 0;
-	int error;
-
-	if(!once) {
-		once = 1;
-
-		error = request_irq(FLOPPY_IRQ, sparc_floppy_irq,
-				    0, "floppy", NULL);
-
-		return ((error = 0) ? 0 : -1);
-	}
-	return 0;
-}
-
-static void sun_fd_free_irq(void)
-{
-}
-
-static unsigned int sun_get_dma_residue(void)
-{
-	/* XXX This isn't really correct. XXX */
-	return 0;
-}
-
-static int sun_fd_eject(int drive)
-{
-	set_dor(0x00, 0xff, 0x90);
-	udelay(500);
-	set_dor(0x00, 0x6f, 0x00);
-	udelay(500);
-	return 0;
-}
-
-#include <asm/ebus_dma.h>
-#include <asm/ns87303.h>
-
-static struct ebus_dma_info sun_pci_fd_ebus_dma;
-static struct device *sun_floppy_dev;
-static int sun_pci_broken_drive = -1;
-
-struct sun_pci_dma_op {
-	unsigned int 	addr;
-	int		len;
-	int		direction;
-	char		*buf;
-};
-static struct sun_pci_dma_op sun_pci_dma_current = { -1U, 0, 0, NULL};
-static struct sun_pci_dma_op sun_pci_dma_pending = { -1U, 0, 0, NULL};
-
-irqreturn_t floppy_interrupt(int irq, void *dev_id);
-
-static unsigned char sun_pci_fd_inb(unsigned long base, unsigned int reg)
-{
-	udelay(5);
-	return inb(base + reg);
-}
-
-static void sun_pci_fd_outb(unsigned char val, unsigned long base,
-			    unsigned int reg)
-{
-	udelay(5);
-	outb(val, base + reg);
-}
-
-static void sun_pci_fd_broken_outb(unsigned char val, unsigned long base,
-				   unsigned int reg)
-{
-	udelay(5);
-	/*
-	 * XXX: Due to SUN's broken floppy connector on AX and AXi
-	 *      we need to turn on MOTOR_0 also, if the floppy is
-	 *      jumpered to DS1 (like most PC floppies are). I hope
-	 *      this does not hurt correct hardware like the AXmp.
-	 *      (Eddie, Sep 12 1998).
-	 */
-	if (reg = FD_DOR) {
-		if (((val & 0x03) = sun_pci_broken_drive) && (val & 0x20)) {
-			val |= 0x10;
-		}
-	}
-	outb(val, base + reg);
-}
-
-#ifdef PCI_FDC_SWAP_DRIVES
-static void sun_pci_fd_lde_broken_outb(unsigned char val, unsigned long base,
-				       unsigned int reg)
-{
-	udelay(5);
-	/*
-	 * XXX: Due to SUN's broken floppy connector on AX and AXi
-	 *      we need to turn on MOTOR_0 also, if the floppy is
-	 *      jumpered to DS1 (like most PC floppies are). I hope
-	 *      this does not hurt correct hardware like the AXmp.
-	 *      (Eddie, Sep 12 1998).
-	 */
-	if (reg = FD_DOR) {
-		if (((val & 0x03) = sun_pci_broken_drive) && (val & 0x10)) {
-			val &= ~(0x03);
-			val |= 0x21;
-		}
-	}
-	outb(val, base + reg);
-}
-#endif /* PCI_FDC_SWAP_DRIVES */
-
-static void sun_pci_fd_enable_dma(void)
-{
-	BUG_ON((NULL = sun_pci_dma_pending.buf) 	||
-	    (0	  = sun_pci_dma_pending.len) 	||
-	    (0	  = sun_pci_dma_pending.direction));
-
-	sun_pci_dma_current.buf = sun_pci_dma_pending.buf;
-	sun_pci_dma_current.len = sun_pci_dma_pending.len;
-	sun_pci_dma_current.direction = sun_pci_dma_pending.direction;
-
-	sun_pci_dma_pending.buf  = NULL;
-	sun_pci_dma_pending.len  = 0;
-	sun_pci_dma_pending.direction = 0;
-	sun_pci_dma_pending.addr = -1U;
-
-	sun_pci_dma_current.addr -		dma_map_single(sun_floppy_dev,
-			       sun_pci_dma_current.buf,
-			       sun_pci_dma_current.len,
-			       sun_pci_dma_current.direction);
-
-	ebus_dma_enable(&sun_pci_fd_ebus_dma, 1);
-
-	if (ebus_dma_request(&sun_pci_fd_ebus_dma,
-			     sun_pci_dma_current.addr,
-			     sun_pci_dma_current.len))
-		BUG();
-}
-
-static void sun_pci_fd_disable_dma(void)
-{
-	ebus_dma_enable(&sun_pci_fd_ebus_dma, 0);
-	if (sun_pci_dma_current.addr != -1U)
-		dma_unmap_single(sun_floppy_dev,
-				 sun_pci_dma_current.addr,
-				 sun_pci_dma_current.len,
-				 sun_pci_dma_current.direction);
-	sun_pci_dma_current.addr = -1U;
-}
-
-static void sun_pci_fd_set_dma_mode(int mode)
-{
-	if (mode = DMA_MODE_WRITE)
-		sun_pci_dma_pending.direction = DMA_TO_DEVICE;
-	else
-		sun_pci_dma_pending.direction = DMA_FROM_DEVICE;
-
-	ebus_dma_prepare(&sun_pci_fd_ebus_dma, mode != DMA_MODE_WRITE);
-}
-
-static void sun_pci_fd_set_dma_count(int length)
-{
-	sun_pci_dma_pending.len = length;
-}
-
-static void sun_pci_fd_set_dma_addr(char *buffer)
-{
-	sun_pci_dma_pending.buf = buffer;
-}
-
-static unsigned int sun_pci_get_dma_residue(void)
-{
-	return ebus_dma_residue(&sun_pci_fd_ebus_dma);
-}
-
-static int sun_pci_fd_request_irq(void)
-{
-	return ebus_dma_irq_enable(&sun_pci_fd_ebus_dma, 1);
-}
-
-static void sun_pci_fd_free_irq(void)
-{
-	ebus_dma_irq_enable(&sun_pci_fd_ebus_dma, 0);
-}
-
-static int sun_pci_fd_eject(int drive)
-{
-	return -EINVAL;
-}
-
-void sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event, void *cookie)
-{
-	floppy_interrupt(0, NULL);
-}
-
-/*
- * Floppy probing, we'd like to use /dev/fd0 for a single Floppy on PCI,
- * even if this is configured using DS1, thus looks like /dev/fd1 with
- * the cabling used in Ultras.
- */
-#define DOR	(port + 2)
-#define MSR	(port + 4)
-#define FIFO	(port + 5)
-
-static void sun_pci_fd_out_byte(unsigned long port, unsigned char val,
-			        unsigned long reg)
-{
-	unsigned char status;
-	int timeout = 1000;
-
-	while (!((status = inb(MSR)) & 0x80) && --timeout)
-		udelay(100);
-	outb(val, reg);
-}
-
-static unsigned char sun_pci_fd_sensei(unsigned long port)
-{
-	unsigned char result[2] = { 0x70, 0x00 };
-	unsigned char status;
-	int i = 0;
-
-	sun_pci_fd_out_byte(port, 0x08, FIFO);
-	do {
-		int timeout = 1000;
-
-		while (!((status = inb(MSR)) & 0x80) && --timeout)
-			udelay(100);
-
-		if (!timeout)
-			break;
-
-		if ((status & 0xf0) = 0xd0)
-			result[i++] = inb(FIFO);
-		else
-			break;
-	} while (i < 2);
-
-	return result[0];
-}
-
-static void sun_pci_fd_reset(unsigned long port)
-{
-	unsigned char mask = 0x00;
-	unsigned char status;
-	int timeout = 10000;
-
-	outb(0x80, MSR);
-	do {
-		status = sun_pci_fd_sensei(port);
-		if ((status & 0xc0) = 0xc0)
-			mask |= 1 << (status & 0x03);
-		else
-			udelay(100);
-	} while ((mask != 0x0f) && --timeout);
-}
-
-static int sun_pci_fd_test_drive(unsigned long port, int drive)
-{
-	unsigned char status, data;
-	int timeout = 1000;
-	int ready;
-
-	sun_pci_fd_reset(port);
-
-	data = (0x10 << drive) | 0x0c | drive;
-	sun_pci_fd_out_byte(port, data, DOR);
-
-	sun_pci_fd_out_byte(port, 0x07, FIFO);
-	sun_pci_fd_out_byte(port, drive & 0x03, FIFO);
-
-	do {
-		udelay(100);
-		status = sun_pci_fd_sensei(port);
-	} while (((status & 0xc0) = 0x80) && --timeout);
-
-	if (!timeout)
-		ready = 0;
-	else
-		ready = (status & 0x10) ? 0 : 1;
-
-	sun_pci_fd_reset(port);
-	return ready;
-}
-#undef FIFO
-#undef MSR
-#undef DOR
-
-static int __init ebus_fdthree_p(struct device_node *dp)
-{
-	if (of_node_name_eq(dp, "fdthree"))
-		return 1;
-	if (of_node_name_eq(dp, "floppy")) {
-		const char *compat;
-
-		compat = of_get_property(dp, "compatible", NULL);
-		if (compat && !strcmp(compat, "fdthree"))
-			return 1;
-	}
-	return 0;
-}
-
-static unsigned long __init sun_floppy_init(void)
-{
-	static int initialized = 0;
-	struct device_node *dp;
-	struct platform_device *op;
-	const char *prop;
-	char state[128];
-
-	if (initialized)
-		return sun_floppy_types[0];
-	initialized = 1;
-
-	op = NULL;
-
-	for_each_node_by_name(dp, "SUNW,fdtwo") {
-		if (!of_node_name_eq(dp->parent, "sbus"))
-			continue;
-		op = of_find_device_by_node(dp);
-		if (op)
-			break;
-	}
-	if (op) {
-		floppy_op = op;
-		FLOPPY_IRQ = op->archdata.irqs[0];
-	} else {
-		struct device_node *ebus_dp;
-		void __iomem *auxio_reg;
-		const char *state_prop;
-		unsigned long config;
-
-		dp = NULL;
-		for_each_node_by_name(ebus_dp, "ebus") {
-			for (dp = ebus_dp->child; dp; dp = dp->sibling) {
-				if (ebus_fdthree_p(dp))
-					goto found_fdthree;
-			}
-		}
-	found_fdthree:
-		if (!dp)
-			return 0;
-
-		op = of_find_device_by_node(dp);
-		if (!op)
-			return 0;
-
-		state_prop = of_get_property(op->dev.of_node, "status", NULL);
-		if (state_prop && !strncmp(state_prop, "disabled", 8))
-			return 0;
-
-		FLOPPY_IRQ = op->archdata.irqs[0];
-
-		/* Make sure the high density bit is set, some systems
-		 * (most notably Ultra5/Ultra10) come up with it clear.
-		 */
-		auxio_reg = (void __iomem *) op->resource[2].start;
-		writel(readl(auxio_reg)|0x2, auxio_reg);
-
-		sun_floppy_dev = &op->dev;
-
-		spin_lock_init(&sun_pci_fd_ebus_dma.lock);
-
-		/* XXX ioremap */
-		sun_pci_fd_ebus_dma.regs = (void __iomem *)
-			op->resource[1].start;
-		if (!sun_pci_fd_ebus_dma.regs)
-			return 0;
-
-		sun_pci_fd_ebus_dma.flags = (EBUS_DMA_FLAG_USE_EBDMA_HANDLER |
-					     EBUS_DMA_FLAG_TCI_DISABLE);
-		sun_pci_fd_ebus_dma.callback = sun_pci_fd_dma_callback;
-		sun_pci_fd_ebus_dma.client_cookie = NULL;
-		sun_pci_fd_ebus_dma.irq = FLOPPY_IRQ;
-		strcpy(sun_pci_fd_ebus_dma.name, "floppy");
-		if (ebus_dma_register(&sun_pci_fd_ebus_dma))
-			return 0;
-
-		/* XXX ioremap */
-		sun_fdc = (struct sun_flpy_controller *) op->resource[0].start;
-
-		sun_fdops.fd_inb = sun_pci_fd_inb;
-		sun_fdops.fd_outb = sun_pci_fd_outb;
-
-		can_use_virtual_dma = use_virtual_dma = 0;
-		sun_fdops.fd_enable_dma = sun_pci_fd_enable_dma;
-		sun_fdops.fd_disable_dma = sun_pci_fd_disable_dma;
-		sun_fdops.fd_set_dma_mode = sun_pci_fd_set_dma_mode;
-		sun_fdops.fd_set_dma_addr = sun_pci_fd_set_dma_addr;
-		sun_fdops.fd_set_dma_count = sun_pci_fd_set_dma_count;
-		sun_fdops.get_dma_residue = sun_pci_get_dma_residue;
-
-		sun_fdops.fd_request_irq = sun_pci_fd_request_irq;
-		sun_fdops.fd_free_irq = sun_pci_fd_free_irq;
-
-		sun_fdops.fd_eject = sun_pci_fd_eject;
-
-		fdc_status = (unsigned long) &sun_fdc->status_82077;
-
-		/*
-		 * XXX: Find out on which machines this is really needed.
-		 */
-		if (1) {
-			sun_pci_broken_drive = 1;
-			sun_fdops.fd_outb = sun_pci_fd_broken_outb;
-		}
-
-		allowed_drive_mask = 0;
-		if (sun_pci_fd_test_drive((unsigned long)sun_fdc, 0))
-			sun_floppy_types[0] = 4;
-		if (sun_pci_fd_test_drive((unsigned long)sun_fdc, 1))
-			sun_floppy_types[1] = 4;
-
-		/*
-		 * Find NS87303 SuperIO config registers (through ecpp).
-		 */
-		config = 0;
-		for (dp = ebus_dp->child; dp; dp = dp->sibling) {
-			if (of_node_name_eq(dp, "ecpp")) {
-				struct platform_device *ecpp_op;
-
-				ecpp_op = of_find_device_by_node(dp);
-				if (ecpp_op)
-					config = ecpp_op->resource[1].start;
-				goto config_done;
-			}
-		}
-	config_done:
-
-		/*
-		 * Sanity check, is this really the NS87303?
-		 */
-		switch (config & 0x3ff) {
-		case 0x02e:
-		case 0x15c:
-		case 0x26e:
-		case 0x398:
-			break;
-		default:
-			config = 0;
-		}
-
-		if (!config)
-			return sun_floppy_types[0];
-
-		/* Enable PC-AT mode. */
-		ns87303_modify(config, ASC, 0, 0xc0);
-
-#ifdef PCI_FDC_SWAP_DRIVES
-		/*
-		 * If only Floppy 1 is present, swap drives.
-		 */
-		if (!sun_floppy_types[0] && sun_floppy_types[1]) {
-			/*
-			 * Set the drive exchange bit in FCR on NS87303,
-			 * make sure other bits are sane before doing so.
-			 */
-			ns87303_modify(config, FER, FER_EDM, 0);
-			ns87303_modify(config, ASC, ASC_DRV2_SEL, 0);
-			ns87303_modify(config, FCR, 0, FCR_LDE);
-
-			config = sun_floppy_types[0];
-			sun_floppy_types[0] = sun_floppy_types[1];
-			sun_floppy_types[1] = config;
-
-			if (sun_pci_broken_drive != -1) {
-				sun_pci_broken_drive = 1 - sun_pci_broken_drive;
-				sun_fdops.fd_outb = sun_pci_fd_lde_broken_outb;
-			}
-		}
-#endif /* PCI_FDC_SWAP_DRIVES */
-
-		return sun_floppy_types[0];
-	}
-	prop = of_get_property(op->dev.of_node, "status", NULL);
-	if (prop && !strncmp(state, "disabled", 8))
-		return 0;
-
-	/*
-	 * We cannot do of_ioremap here: it does request_region,
-	 * which the generic floppy driver tries to do once again.
-	 * But we must use the sdev resource values as they have
-	 * had parent ranges applied.
-	 */
-	sun_fdc = (struct sun_flpy_controller *)
-		(op->resource[0].start +
-		 ((op->resource[0].flags & 0x1ffUL) << 32UL));
-
-	/* Last minute sanity check... */
-	if (sbus_readb(&sun_fdc->status1_82077) = 0xff) {
-		sun_fdc = (struct sun_flpy_controller *)-1;
-		return 0;
-	}
-
-        sun_fdops.fd_inb = sun_82077_fd_inb;
-        sun_fdops.fd_outb = sun_82077_fd_outb;
-
-	can_use_virtual_dma = use_virtual_dma = 1;
-	sun_fdops.fd_enable_dma = sun_fd_enable_dma;
-	sun_fdops.fd_disable_dma = sun_fd_disable_dma;
-	sun_fdops.fd_set_dma_mode = sun_fd_set_dma_mode;
-	sun_fdops.fd_set_dma_addr = sun_fd_set_dma_addr;
-	sun_fdops.fd_set_dma_count = sun_fd_set_dma_count;
-	sun_fdops.get_dma_residue = sun_get_dma_residue;
-
-	sun_fdops.fd_request_irq = sun_fd_request_irq;
-	sun_fdops.fd_free_irq = sun_fd_free_irq;
-
-	sun_fdops.fd_eject = sun_fd_eject;
-
-        fdc_status = (unsigned long) &sun_fdc->status_82077;
-
-	/* Success... */
-	allowed_drive_mask = 0x01;
-	sun_floppy_types[0] = 4;
-	sun_floppy_types[1] = 0;
-
-	return sun_floppy_types[0];
-}
-
-#define EXTRA_FLOPPY_PARAMS
-
-static DEFINE_SPINLOCK(dma_spin_lock);
-
-#define claim_dma_lock() \
-({	unsigned long flags; \
-	spin_lock_irqsave(&dma_spin_lock, flags); \
-	flags; \
-})
-
-#define release_dma_lock(__flags) \
-	spin_unlock_irqrestore(&dma_spin_lock, __flags);
-
-#endif /* !(__ASM_SPARC64_FLOPPY_H) */
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index d58940280f8d..9985b08a3467 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -55,143 +55,6 @@ arch_kgdb_breakpoint:
 	.size		arch_kgdb_breakpoint,.-arch_kgdb_breakpoint
 #endif
 
-#if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
-	.align	4
-	.globl	floppy_hardint
-floppy_hardint:
-	/*
-	 * This code cannot touch registers %l0 %l1 and %l2
-	 * because SAVE_ALL depends on their values. It depends
-	 * on %l3 also, but we regenerate it before a call.
-	 * Other registers are:
-	 * %l3 -- base address of fdc registers
-	 * %l4 -- pdma_vaddr
-	 * %l5 -- scratch for ld/st address
-	 * %l6 -- pdma_size
-	 * %l7 -- scratch [floppy byte, ld/st address, aux. data]
-	 */
-
-	/* Do we have work to do? */
-	sethi	%hi(doing_pdma), %l7
-	ld	[%l7 + %lo(doing_pdma)], %l7
-	cmp	%l7, 0
-	be	floppy_dosoftint
-	 nop
-
-	/* Load fdc register base */
-	sethi	%hi(fdc_status), %l3
-	ld	[%l3 + %lo(fdc_status)], %l3
-
-	/* Setup register addresses */
-	sethi	%hi(pdma_vaddr), %l5	! transfer buffer
-	ld	[%l5 + %lo(pdma_vaddr)], %l4
-	sethi	%hi(pdma_size), %l5	! bytes to go
-	ld	[%l5 + %lo(pdma_size)], %l6
-next_byte:
-  	ldub	[%l3], %l7
-
-	andcc	%l7, 0x80, %g0		! Does fifo still have data
-	bz	floppy_fifo_emptied	! fifo has been emptied...
-	 andcc	%l7, 0x20, %g0		! in non-dma mode still?
-	bz	floppy_overrun		! nope, overrun
-	 andcc	%l7, 0x40, %g0		! 0=write 1=read
-	bz	floppy_write
-	 sub	%l6, 0x1, %l6
-
-	/* Ok, actually read this byte */
-	ldub	[%l3 + 1], %l7
-	orcc	%g0, %l6, %g0
-	stb	%l7, [%l4]
-	bne	next_byte
-	 add	%l4, 0x1, %l4
-
-	b	floppy_tdone
-	 nop
-
-floppy_write:
-	/* Ok, actually write this byte */
-	ldub	[%l4], %l7
-	orcc	%g0, %l6, %g0
-	stb	%l7, [%l3 + 1]
-	bne	next_byte
-	 add	%l4, 0x1, %l4
-
-	/* fall through... */
-floppy_tdone:
-	sethi	%hi(pdma_vaddr), %l5
-	st	%l4, [%l5 + %lo(pdma_vaddr)]
-	sethi	%hi(pdma_size), %l5
-	st	%l6, [%l5 + %lo(pdma_size)]
-	/* Flip terminal count pin */
-	set	auxio_register, %l7
-	ld	[%l7], %l7
-
-	ldub	[%l7], %l5
-
-	or	%l5, 0xc2, %l5
-	stb	%l5, [%l7]
-	andn    %l5, 0x02, %l5
-
-2:
-	/* Kill some time so the bits set */
-	WRITE_PAUSE
-	WRITE_PAUSE
-
-	stb     %l5, [%l7]
-
-	/* Prevent recursion */
-	sethi	%hi(doing_pdma), %l7
-	b	floppy_dosoftint
-	 st	%g0, [%l7 + %lo(doing_pdma)]
-
-	/* We emptied the FIFO, but we haven't read everything
-	 * as of yet.  Store the current transfer address and
-	 * bytes left to read so we can continue when the next
-	 * fast IRQ comes in.
-	 */
-floppy_fifo_emptied:
-	sethi	%hi(pdma_vaddr), %l5
-	st	%l4, [%l5 + %lo(pdma_vaddr)]
-	sethi	%hi(pdma_size), %l7
-	st	%l6, [%l7 + %lo(pdma_size)]
-
-	/* Restore condition codes */
-	wr	%l0, 0x0, %psr
-	WRITE_PAUSE
-
-	jmp	%l1
-	rett	%l2
-
-floppy_overrun:
-	sethi	%hi(pdma_vaddr), %l5
-	st	%l4, [%l5 + %lo(pdma_vaddr)]
-	sethi	%hi(pdma_size), %l5
-	st	%l6, [%l5 + %lo(pdma_size)]
-	/* Prevent recursion */
-	sethi	%hi(doing_pdma), %l7
-	st	%g0, [%l7 + %lo(doing_pdma)]
-
-	/* fall through... */
-floppy_dosoftint:
-	rd	%wim, %l3
-	SAVE_ALL
-
-	/* Set all IRQs off. */
-	or	%l0, PSR_PIL, %l4
-	wr	%l4, 0x0, %psr
-	WRITE_PAUSE
-	wr	%l4, PSR_ET, %psr
-	WRITE_PAUSE
-
-	mov	11, %o0			! floppy irq level (unused anyway)
-	mov	%g0, %o1		! devid is not used in fast interrupts
-	call	sparc_floppy_irq
-	 add	%sp, STACKFRAME_SZ, %o2	! struct pt_regs *regs
-
-	RESTORE_ALL
-	
-#endif /* (CONFIG_BLK_DEV_FD) */
-
 	/* Bad trap handler */
 	.globl	bad_trap_handler
 bad_trap_handler:
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index b02026ad6e34..0d9b740725b4 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -83,9 +83,6 @@ void handler_irq(unsigned int pil, struct pt_regs *regs);
 
 unsigned long leon_get_irqmask(unsigned int irq);
 
-/* irq_32.c */
-void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs);
-
 /* sun4m_irq.c */
 void sun4m_nmi(struct pt_regs *regs);
 
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index e8452be5123b..510184c3aa17 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -235,99 +235,6 @@ void handler_irq(unsigned int pil, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-#if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
-static unsigned int floppy_irq;
-
-int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler)
-{
-	unsigned int cpu_irq;
-	int err;
-
-
-	err = request_irq(irq, irq_handler, 0, "floppy", NULL);
-	if (err)
-		return -1;
-
-	/* Save for later use in floppy interrupt handler */
-	floppy_irq = irq;
-
-	cpu_irq = (irq & (NR_IRQS - 1));
-
-	/* Dork with trap table if we get this far. */
-#define INSTANTIATE(table) \
-	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_one = SPARC_RD_PSR_L0; \
-	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two = \
-		SPARC_BRANCH((unsigned long) floppy_hardint, \
-			     (unsigned long) &table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two);\
-	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_three = SPARC_RD_WIM_L3; \
-	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four = SPARC_NOP;
-
-	INSTANTIATE(sparc_ttable)
-
-#if defined CONFIG_SMP
-	if (sparc_cpu_model != sparc_leon) {
-		struct tt_entry *trap_table;
-
-		trap_table = &trapbase_cpu1;
-		INSTANTIATE(trap_table)
-		trap_table = &trapbase_cpu2;
-		INSTANTIATE(trap_table)
-		trap_table = &trapbase_cpu3;
-		INSTANTIATE(trap_table)
-	}
-#endif
-#undef INSTANTIATE
-	/*
-	 * XXX Correct thing whould be to flush only I- and D-cache lines
-	 * which contain the handler in question. But as of time of the
-	 * writing we have no CPU-neutral interface to fine-grained flushes.
-	 */
-	flush_cache_all();
-	return 0;
-}
-EXPORT_SYMBOL(sparc_floppy_request_irq);
-
-/*
- * These variables are used to access state from the assembler
- * interrupt handler, floppy_hardint, so we cannot put these in
- * the floppy driver image because that would not work in the
- * modular case.
- */
-volatile unsigned char *fdc_status;
-EXPORT_SYMBOL(fdc_status);
-
-char *pdma_vaddr;
-EXPORT_SYMBOL(pdma_vaddr);
-
-unsigned long pdma_size;
-EXPORT_SYMBOL(pdma_size);
-
-volatile int doing_pdma;
-EXPORT_SYMBOL(doing_pdma);
-
-char *pdma_base;
-EXPORT_SYMBOL(pdma_base);
-
-unsigned long pdma_areasize;
-EXPORT_SYMBOL(pdma_areasize);
-
-/* Use the generic irq support to call floppy_interrupt
- * which was setup using request_irq() in sparc_floppy_request_irq().
- * We only have one floppy interrupt so we do not need to check
- * for additional handlers being wired up by irq_link()
- */
-void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs;
-
-	old_regs = set_irq_regs(regs);
-	irq_enter();
-	generic_handle_irq(floppy_irq);
-	irq_exit();
-	set_irq_regs(old_regs);
-}
-#endif
-
 /* djhr
  * This could probably be made indirect too and assigned in the CPU
  * bits of the code. That would be much nicer I think and would also
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 9cd09a3ef35f..c76e49032273 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -152,8 +152,6 @@ extern unsigned int real_irq_entry[];
 extern unsigned int smp4d_ticker[];
 extern unsigned int patchme_maybe_smp_msg[];
 
-void floppy_hardint(void);
-
 /* trampoline_32.S */
 extern unsigned long sun4m_cpu_startup;
 extern unsigned long sun4d_cpu_startup;
-- 
2.27.0
