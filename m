From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:24 +0000
Subject: [PATCH 3/49]: sparc: Kill SBUS DVMA layer.
Message-Id: <20080827.212324.125769960.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill SBUS DVMA layer.

This thing was completely pointless.

Just find the OF device in the parent of drivers that want to program
this device, and map the DMA regs inside such drivers too.

This also moves the dummy claim_dma_lock() and release_dma_lock()
implementation to floppy_32.h, which makes it handle this issue
just like floppy_64.h does.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h        |  141 ++++++++++++++++-
 arch/sparc/include/asm/dma_32.h     |  288 -----------------------------------
 arch/sparc/include/asm/dma_64.h     |  205 -------------------------
 arch/sparc/include/asm/floppy_32.h  |   11 ++
 arch/sparc/kernel/sparc_ksyms.c     |    1 -
 arch/sparc64/kernel/sparc64_ksyms.c |    1 -
 drivers/net/sunlance.c              |   51 ++++---
 drivers/sbus/Makefile               |    2 +-
 drivers/sbus/dvma.c                 |  136 ----------------
 drivers/sbus/sbus.c                 |    2 -
 drivers/scsi/esp_scsi.h             |    3 +-
 drivers/scsi/sun_esp.c              |  122 +++++++++-------
 12 files changed, 246 insertions(+), 717 deletions(-)
 delete mode 100644 arch/sparc/include/asm/dma_32.h
 delete mode 100644 arch/sparc/include/asm/dma_64.h
 delete mode 100644 drivers/sbus/dvma.c

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index aa1d90a..4935634 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -1,8 +1,139 @@
-#ifndef ___ASM_SPARC_DMA_H
-#define ___ASM_SPARC_DMA_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/dma_64.h>
+#ifndef _ASM_SPARC_DMA_H
+#define _ASM_SPARC_DMA_H
+
+/* These are irrelevant for Sparc DMA, but we leave it in so that
+ * things can compile.
+ */
+#define MAX_DMA_CHANNELS 8
+#define DMA_MODE_READ    1
+#define DMA_MODE_WRITE   2
+#define MAX_DMA_ADDRESS  (~0UL)
+
+/* Useful constants */
+#define SIZE_16MB      (16*1024*1024)
+#define SIZE_64K       (64*1024)
+
+/* SBUS DMA controller reg offsets */
+#define DMA_CSR		0x00UL		/* rw  DMA control/status register    0x00   */
+#define DMA_ADDR	0x04UL		/* rw  DMA transfer address register  0x04   */
+#define DMA_COUNT	0x08UL		/* rw  DMA transfer count register    0x08   */
+#define DMA_TEST	0x0cUL		/* rw  DMA test/debug register        0x0c   */
+
+/* Fields in the cond_reg register */
+/* First, the version identification bits */
+#define DMA_DEVICE_ID    0xf0000000        /* Device identification bits */
+#define DMA_VERS0        0x00000000        /* Sunray DMA version */
+#define DMA_ESCV1        0x40000000        /* DMA ESC Version 1 */
+#define DMA_VERS1        0x80000000        /* DMA rev 1 */
+#define DMA_VERS2        0xa0000000        /* DMA rev 2 */
+#define DMA_VERHME       0xb0000000        /* DMA hme gate array */
+#define DMA_VERSPLUS     0x90000000        /* DMA rev 1 PLUS */
+
+#define DMA_HNDL_INTR    0x00000001        /* An IRQ needs to be handled */
+#define DMA_HNDL_ERROR   0x00000002        /* We need to take an error */
+#define DMA_FIFO_ISDRAIN 0x0000000c        /* The DMA FIFO is draining */
+#define DMA_INT_ENAB     0x00000010        /* Turn on interrupts */
+#define DMA_FIFO_INV     0x00000020        /* Invalidate the FIFO */
+#define DMA_ACC_SZ_ERR   0x00000040        /* The access size was bad */
+#define DMA_FIFO_STDRAIN 0x00000040        /* DMA_VERS1 Drain the FIFO */
+#define DMA_RST_SCSI     0x00000080        /* Reset the SCSI controller */
+#define DMA_RST_ENET     DMA_RST_SCSI      /* Reset the ENET controller */
+#define DMA_ST_WRITE     0x00000100        /* write from device to memory */
+#define DMA_ENABLE       0x00000200        /* Fire up DMA, handle requests */
+#define DMA_PEND_READ    0x00000400        /* DMA_VERS1/0/PLUS Pending Read */
+#define DMA_ESC_BURST    0x00000800        /* 1byte 02byte */
+#define DMA_READ_AHEAD   0x00001800        /* DMA read ahead partial longword */
+#define DMA_DSBL_RD_DRN  0x00001000        /* No EC drain on slave reads */
+#define DMA_BCNT_ENAB    0x00002000        /* If on, use the byte counter */
+#define DMA_TERM_CNTR    0x00004000        /* Terminal counter */
+#define DMA_SCSI_SBUS64  0x00008000        /* HME: Enable 64-bit SBUS mode. */
+#define DMA_CSR_DISAB    0x00010000        /* No FIFO drains during csr */
+#define DMA_SCSI_DISAB   0x00020000        /* No FIFO drains during reg */
+#define DMA_DSBL_WR_INV  0x00020000        /* No EC inval. on slave writes */
+#define DMA_ADD_ENABLE   0x00040000        /* Special ESC DVMA optimization */
+#define DMA_E_BURSTS	 0x000c0000	   /* ENET: SBUS r/w burst mask */
+#define DMA_E_BURST32	 0x00040000	   /* ENET: SBUS 32 byte r/w burst */
+#define DMA_E_BURST16	 0x00000000	   /* ENET: SBUS 16 byte r/w burst */
+#define DMA_BRST_SZ      0x000c0000        /* SCSI: SBUS r/w burst size */
+#define DMA_BRST64       0x000c0000        /* SCSI: 64byte bursts (HME on UltraSparc only) */
+#define DMA_BRST32       0x00040000        /* SCSI: 32byte bursts */
+#define DMA_BRST16       0x00000000        /* SCSI: 16byte bursts */
+#define DMA_BRST0        0x00080000        /* SCSI: no bursts (non-HME gate arrays) */
+#define DMA_ADDR_DISAB   0x00100000        /* No FIFO drains during addr */
+#define DMA_2CLKS        0x00200000        /* Each transfer = 2 clock ticks */
+#define DMA_3CLKS        0x00400000        /* Each transfer = 3 clock ticks */
+#define DMA_EN_ENETAUI   DMA_3CLKS         /* Put lance into AUI-cable mode */
+#define DMA_CNTR_DISAB   0x00800000        /* No IRQ when DMA_TERM_CNTR set */
+#define DMA_AUTO_NADDR   0x01000000        /* Use "auto nxt addr" feature */
+#define DMA_SCSI_ON      0x02000000        /* Enable SCSI dma */
+#define DMA_PARITY_OFF   0x02000000        /* HME: disable parity checking */
+#define DMA_LOADED_ADDR  0x04000000        /* Address has been loaded */
+#define DMA_LOADED_NADDR 0x08000000        /* Next address has been loaded */
+#define DMA_RESET_FAS366 0x08000000        /* HME: Assert RESET to FAS366 */
+
+/* Values describing the burst-size property from the PROM */
+#define DMA_BURST1       0x01
+#define DMA_BURST2       0x02
+#define DMA_BURST4       0x04
+#define DMA_BURST8       0x08
+#define DMA_BURST16      0x10
+#define DMA_BURST32      0x20
+#define DMA_BURST64      0x40
+#define DMA_BURSTBITS    0x7f
+
+/* From PCI */
+
+#ifdef CONFIG_PCI
+extern int isa_dma_bridge_buggy;
 #else
-#include <asm/dma_32.h>
+#define isa_dma_bridge_buggy 	(0)
 #endif
+
+#ifdef CONFIG_SPARC32
+
+#include <asm/sbus.h>
+
+/* Routines for data transfer buffers. */
+BTFIXUPDEF_CALL(char *, mmu_lockarea, char *, unsigned long)
+BTFIXUPDEF_CALL(void,   mmu_unlockarea, char *, unsigned long)
+
+#define mmu_lockarea(vaddr,len) BTFIXUP_CALL(mmu_lockarea)(vaddr,len)
+#define mmu_unlockarea(vaddr,len) BTFIXUP_CALL(mmu_unlockarea)(vaddr,len)
+
+/* These are implementations for sbus_map_sg/sbus_unmap_sg... collapse later */
+BTFIXUPDEF_CALL(__u32, mmu_get_scsi_one, char *, unsigned long, struct sbus_bus *sbus)
+BTFIXUPDEF_CALL(void,  mmu_get_scsi_sgl, struct scatterlist *, int, struct sbus_bus *sbus)
+BTFIXUPDEF_CALL(void,  mmu_release_scsi_one, __u32, unsigned long, struct sbus_bus *sbus)
+BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct scatterlist *, int, struct sbus_bus *sbus)
+
+#define mmu_get_scsi_one(vaddr,len,sbus) BTFIXUP_CALL(mmu_get_scsi_one)(vaddr,len,sbus)
+#define mmu_get_scsi_sgl(sg,sz,sbus) BTFIXUP_CALL(mmu_get_scsi_sgl)(sg,sz,sbus)
+#define mmu_release_scsi_one(vaddr,len,sbus) BTFIXUP_CALL(mmu_release_scsi_one)(vaddr,len,sbus)
+#define mmu_release_scsi_sgl(sg,sz,sbus) BTFIXUP_CALL(mmu_release_scsi_sgl)(sg,sz,sbus)
+
+/*
+ * mmu_map/unmap are provided by iommu/iounit; Invalid to call on IIep.
+ *
+ * The mmu_map_dma_area establishes two mappings in one go.
+ * These mappings point to pages normally mapped at 'va' (linear address).
+ * First mapping is for CPU visible address at 'a', uncached.
+ * This is an alias, but it works because it is an uncached mapping.
+ * Second mapping is for device visible address, or "bus" address.
+ * The bus address is returned at '*pba'.
+ *
+ * These functions seem distinct, but are hard to split. On sun4c,
+ * at least for now, 'a' is equal to bus address, and retured in *pba.
+ * On sun4m, page attributes depend on the CPU type, so we have to
+ * know if we are mapping RAM or I/O, so it has to be an additional argument
+ * to a separate mapping function for CPU visible mappings.
+ */
+BTFIXUPDEF_CALL(int,  mmu_map_dma_area, dma_addr_t *, unsigned long, unsigned long, int len)
+BTFIXUPDEF_CALL(struct page *, mmu_translate_dvma, unsigned long busa)
+BTFIXUPDEF_CALL(void,  mmu_unmap_dma_area, unsigned long busa, int len)
+
+#define mmu_map_dma_area(pba,va,a,len) BTFIXUP_CALL(mmu_map_dma_area)(pba,va,a,len)
+#define mmu_unmap_dma_area(ba,len) BTFIXUP_CALL(mmu_unmap_dma_area)(ba,len)
+#define mmu_translate_dvma(ba)     BTFIXUP_CALL(mmu_translate_dvma)(ba)
 #endif
+
+#endif /* !(_ASM_SPARC_DMA_H) */
diff --git a/arch/sparc/include/asm/dma_32.h b/arch/sparc/include/asm/dma_32.h
deleted file mode 100644
index cf7189c..0000000
--- a/arch/sparc/include/asm/dma_32.h
+++ /dev/null
@@ -1,288 +0,0 @@
-/* include/asm/dma.h
- *
- * Copyright 1995 (C) David S. Miller (davem@davemloft.net)
- */
-
-#ifndef _ASM_SPARC_DMA_H
-#define _ASM_SPARC_DMA_H
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include <asm/vac-ops.h>  /* for invalidate's, etc. */
-#include <asm/sbus.h>
-#include <asm/delay.h>
-#include <asm/oplib.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <linux/spinlock.h>
-
-struct page;
-extern spinlock_t  dma_spin_lock;
-
-static inline unsigned long claim_dma_lock(void)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&dma_spin_lock, flags);
-	return flags;
-}
-
-static inline void release_dma_lock(unsigned long flags)
-{
-	spin_unlock_irqrestore(&dma_spin_lock, flags);
-}
-
-/* These are irrelevant for Sparc DMA, but we leave it in so that
- * things can compile.
- */
-#define MAX_DMA_CHANNELS 8
-#define MAX_DMA_ADDRESS  (~0UL)
-#define DMA_MODE_READ    1
-#define DMA_MODE_WRITE   2
-
-/* Useful constants */
-#define SIZE_16MB      (16*1024*1024)
-#define SIZE_64K       (64*1024)
-
-/* SBUS DMA controller reg offsets */
-#define DMA_CSR		0x00UL		/* rw  DMA control/status register    0x00   */
-#define DMA_ADDR	0x04UL		/* rw  DMA transfer address register  0x04   */
-#define DMA_COUNT	0x08UL		/* rw  DMA transfer count register    0x08   */
-#define DMA_TEST	0x0cUL		/* rw  DMA test/debug register        0x0c   */
-
-/* DVMA chip revisions */
-enum dvma_rev {
-	dvmarev0,
-	dvmaesc1,
-	dvmarev1,
-	dvmarev2,
-	dvmarev3,
-	dvmarevplus,
-	dvmahme
-};
-
-#define DMA_HASCOUNT(rev)  ((rev)=dvmaesc1)
-
-/* Linux DMA information structure, filled during probe. */
-struct sbus_dma {
-	struct sbus_dma *next;
-	struct sbus_dev *sdev;
-	void __iomem *regs;
-
-	/* Status, misc info */
-	int node;                /* Prom node for this DMA device */
-	int running;             /* Are we doing DMA now? */
-	int allocated;           /* Are we "owned" by anyone yet? */
-
-	/* Transfer information. */
-	unsigned long addr;      /* Start address of current transfer */
-	int nbytes;              /* Size of current transfer */
-	int realbytes;           /* For splitting up large transfers, etc. */
-
-	/* DMA revision */
-	enum dvma_rev revision;
-};
-
-extern struct sbus_dma *dma_chain;
-
-/* Broken hardware... */
-#ifdef CONFIG_SUN4
-/* Have to sort this out. Does rev0 work fine on sun4[cmd] without isbroken?
- * Or is rev0 present only on sun4 boxes? -jj */
-#define DMA_ISBROKEN(dma)    ((dma)->revision = dvmarev0 || (dma)->revision = dvmarev1)
-#else
-#define DMA_ISBROKEN(dma)    ((dma)->revision = dvmarev1)
-#endif
-#define DMA_ISESC1(dma)      ((dma)->revision = dvmaesc1)
-
-/* Main routines in dma.c */
-extern void dvma_init(struct sbus_bus *);
-
-/* Fields in the cond_reg register */
-/* First, the version identification bits */
-#define DMA_DEVICE_ID    0xf0000000        /* Device identification bits */
-#define DMA_VERS0        0x00000000        /* Sunray DMA version */
-#define DMA_ESCV1        0x40000000        /* DMA ESC Version 1 */
-#define DMA_VERS1        0x80000000        /* DMA rev 1 */
-#define DMA_VERS2        0xa0000000        /* DMA rev 2 */
-#define DMA_VERHME       0xb0000000        /* DMA hme gate array */
-#define DMA_VERSPLUS     0x90000000        /* DMA rev 1 PLUS */
-
-#define DMA_HNDL_INTR    0x00000001        /* An IRQ needs to be handled */
-#define DMA_HNDL_ERROR   0x00000002        /* We need to take an error */
-#define DMA_FIFO_ISDRAIN 0x0000000c        /* The DMA FIFO is draining */
-#define DMA_INT_ENAB     0x00000010        /* Turn on interrupts */
-#define DMA_FIFO_INV     0x00000020        /* Invalidate the FIFO */
-#define DMA_ACC_SZ_ERR   0x00000040        /* The access size was bad */
-#define DMA_FIFO_STDRAIN 0x00000040        /* DMA_VERS1 Drain the FIFO */
-#define DMA_RST_SCSI     0x00000080        /* Reset the SCSI controller */
-#define DMA_RST_ENET     DMA_RST_SCSI      /* Reset the ENET controller */
-#define DMA_RST_BPP      DMA_RST_SCSI      /* Reset the BPP controller */
-#define DMA_ST_WRITE     0x00000100        /* write from device to memory */
-#define DMA_ENABLE       0x00000200        /* Fire up DMA, handle requests */
-#define DMA_PEND_READ    0x00000400        /* DMA_VERS1/0/PLUS Pending Read */
-#define DMA_ESC_BURST    0x00000800        /* 1byte 02byte */
-#define DMA_READ_AHEAD   0x00001800        /* DMA read ahead partial longword */
-#define DMA_DSBL_RD_DRN  0x00001000        /* No EC drain on slave reads */
-#define DMA_BCNT_ENAB    0x00002000        /* If on, use the byte counter */
-#define DMA_TERM_CNTR    0x00004000        /* Terminal counter */
-#define DMA_SCSI_SBUS64  0x00008000        /* HME: Enable 64-bit SBUS mode. */
-#define DMA_CSR_DISAB    0x00010000        /* No FIFO drains during csr */
-#define DMA_SCSI_DISAB   0x00020000        /* No FIFO drains during reg */
-#define DMA_DSBL_WR_INV  0x00020000        /* No EC inval. on slave writes */
-#define DMA_ADD_ENABLE   0x00040000        /* Special ESC DVMA optimization */
-#define DMA_E_BURSTS	 0x000c0000	   /* ENET: SBUS r/w burst mask */
-#define DMA_E_BURST32	 0x00040000	   /* ENET: SBUS 32 byte r/w burst */
-#define DMA_E_BURST16	 0x00000000	   /* ENET: SBUS 16 byte r/w burst */
-#define DMA_BRST_SZ      0x000c0000        /* SCSI: SBUS r/w burst size */
-#define DMA_BRST64       0x00080000        /* SCSI: 64byte bursts (HME on UltraSparc only) */
-#define DMA_BRST32       0x00040000        /* SCSI/BPP: 32byte bursts */
-#define DMA_BRST16       0x00000000        /* SCSI/BPP: 16byte bursts */
-#define DMA_BRST0        0x00080000        /* SCSI: no bursts (non-HME gate arrays) */
-#define DMA_ADDR_DISAB   0x00100000        /* No FIFO drains during addr */
-#define DMA_2CLKS        0x00200000        /* Each transfer = 2 clock ticks */
-#define DMA_3CLKS        0x00400000        /* Each transfer = 3 clock ticks */
-#define DMA_EN_ENETAUI   DMA_3CLKS         /* Put lance into AUI-cable mode */
-#define DMA_CNTR_DISAB   0x00800000        /* No IRQ when DMA_TERM_CNTR set */
-#define DMA_AUTO_NADDR   0x01000000        /* Use "auto nxt addr" feature */
-#define DMA_SCSI_ON      0x02000000        /* Enable SCSI dma */
-#define DMA_BPP_ON       DMA_SCSI_ON       /* Enable BPP dma */
-#define DMA_PARITY_OFF   0x02000000        /* HME: disable parity checking */
-#define DMA_LOADED_ADDR  0x04000000        /* Address has been loaded */
-#define DMA_LOADED_NADDR 0x08000000        /* Next address has been loaded */
-#define DMA_RESET_FAS366 0x08000000        /* HME: Assert RESET to FAS366 */
-
-/* Values describing the burst-size property from the PROM */
-#define DMA_BURST1       0x01
-#define DMA_BURST2       0x02
-#define DMA_BURST4       0x04
-#define DMA_BURST8       0x08
-#define DMA_BURST16      0x10
-#define DMA_BURST32      0x20
-#define DMA_BURST64      0x40
-#define DMA_BURSTBITS    0x7f
-
-/* Determine highest possible final transfer address given a base */
-#define DMA_MAXEND(addr) (0x01000000UL-(((unsigned long)(addr))&0x00ffffffUL))
-
-/* Yes, I hack a lot of elisp in my spare time... */
-#define DMA_ERROR_P(regs)  ((((regs)->cond_reg) & DMA_HNDL_ERROR))
-#define DMA_IRQ_P(regs)    ((((regs)->cond_reg) & (DMA_HNDL_INTR | DMA_HNDL_ERROR)))
-#define DMA_WRITE_P(regs)  ((((regs)->cond_reg) & DMA_ST_WRITE))
-#define DMA_OFF(regs)      ((((regs)->cond_reg) &= (~DMA_ENABLE)))
-#define DMA_INTSOFF(regs)  ((((regs)->cond_reg) &= (~DMA_INT_ENAB)))
-#define DMA_INTSON(regs)   ((((regs)->cond_reg) |= (DMA_INT_ENAB)))
-#define DMA_PUNTFIFO(regs) ((((regs)->cond_reg) |= DMA_FIFO_INV))
-#define DMA_SETSTART(regs, addr)  ((((regs)->st_addr) = (char *) addr))
-#define DMA_BEGINDMA_W(regs) \
-        ((((regs)->cond_reg |= (DMA_ST_WRITE|DMA_ENABLE|DMA_INT_ENAB))))
-#define DMA_BEGINDMA_R(regs) \
-        ((((regs)->cond_reg |= ((DMA_ENABLE|DMA_INT_ENAB)&(~DMA_ST_WRITE)))))
-
-/* For certain DMA chips, we need to disable ints upon irq entry
- * and turn them back on when we are done.  So in any ESP interrupt
- * handler you *must* call DMA_IRQ_ENTRY upon entry and DMA_IRQ_EXIT
- * when leaving the handler.  You have been warned...
- */
-#define DMA_IRQ_ENTRY(dma, dregs) do { \
-        if(DMA_ISBROKEN(dma)) DMA_INTSOFF(dregs); \
-   } while (0)
-
-#define DMA_IRQ_EXIT(dma, dregs) do { \
-	if(DMA_ISBROKEN(dma)) DMA_INTSON(dregs); \
-   } while(0)
-
-#if 0	/* P3 this stuff is inline in ledma.c:init_restart_ledma() */
-/* Pause until counter runs out or BIT isn't set in the DMA condition
- * register.
- */
-static inline void sparc_dma_pause(struct sparc_dma_registers *regs,
-				       unsigned long bit)
-{
-	int ctr = 50000;   /* Let's find some bugs ;) */
-
-	/* Busy wait until the bit is not set any more */
-	while((regs->cond_reg&bit) && (ctr>0)) {
-		ctr--;
-		__delay(5);
-	}
-
-	/* Check for bogus outcome. */
-	if(!ctr)
-		panic("DMA timeout");
-}
-
-/* Reset the friggin' thing... */
-#define DMA_RESET(dma) do { \
-	struct sparc_dma_registers *regs = dma->regs;                      \
-	/* Let the current FIFO drain itself */                            \
-	sparc_dma_pause(regs, (DMA_FIFO_ISDRAIN));                         \
-	/* Reset the logic */                                              \
-	regs->cond_reg |= (DMA_RST_SCSI);     /* assert */                 \
-	__delay(400);                         /* let the bits set ;) */    \
-	regs->cond_reg &= ~(DMA_RST_SCSI);    /* de-assert */              \
-	sparc_dma_enable_interrupts(regs);    /* Re-enable interrupts */   \
-	/* Enable FAST transfers if available */                           \
-	if(dma->revision>dvmarev1) regs->cond_reg |= DMA_3CLKS;            \
-	dma->running = 0;                                                  \
-} while(0)
-#endif
-
-#define for_each_dvma(dma) \
-        for((dma) = dma_chain; (dma); (dma) = (dma)->next)
-
-extern int get_dma_list(char *);
-extern int request_dma(unsigned int, __const__ char *);
-extern void free_dma(unsigned int);
-
-/* From PCI */
-
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy	(0)
-#endif
-
-/* Routines for data transfer buffers. */
-BTFIXUPDEF_CALL(char *, mmu_lockarea, char *, unsigned long)
-BTFIXUPDEF_CALL(void,   mmu_unlockarea, char *, unsigned long)
-
-#define mmu_lockarea(vaddr,len) BTFIXUP_CALL(mmu_lockarea)(vaddr,len)
-#define mmu_unlockarea(vaddr,len) BTFIXUP_CALL(mmu_unlockarea)(vaddr,len)
-
-/* These are implementations for sbus_map_sg/sbus_unmap_sg... collapse later */
-BTFIXUPDEF_CALL(__u32, mmu_get_scsi_one, char *, unsigned long, struct sbus_bus *sbus)
-BTFIXUPDEF_CALL(void,  mmu_get_scsi_sgl, struct scatterlist *, int, struct sbus_bus *sbus)
-BTFIXUPDEF_CALL(void,  mmu_release_scsi_one, __u32, unsigned long, struct sbus_bus *sbus)
-BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct scatterlist *, int, struct sbus_bus *sbus)
-
-#define mmu_get_scsi_one(vaddr,len,sbus) BTFIXUP_CALL(mmu_get_scsi_one)(vaddr,len,sbus)
-#define mmu_get_scsi_sgl(sg,sz,sbus) BTFIXUP_CALL(mmu_get_scsi_sgl)(sg,sz,sbus)
-#define mmu_release_scsi_one(vaddr,len,sbus) BTFIXUP_CALL(mmu_release_scsi_one)(vaddr,len,sbus)
-#define mmu_release_scsi_sgl(sg,sz,sbus) BTFIXUP_CALL(mmu_release_scsi_sgl)(sg,sz,sbus)
-
-/*
- * mmu_map/unmap are provided by iommu/iounit; Invalid to call on IIep.
- *
- * The mmu_map_dma_area establishes two mappings in one go.
- * These mappings point to pages normally mapped at 'va' (linear address).
- * First mapping is for CPU visible address at 'a', uncached.
- * This is an alias, but it works because it is an uncached mapping.
- * Second mapping is for device visible address, or "bus" address.
- * The bus address is returned at '*pba'.
- *
- * These functions seem distinct, but are hard to split. On sun4c,
- * at least for now, 'a' is equal to bus address, and retured in *pba.
- * On sun4m, page attributes depend on the CPU type, so we have to
- * know if we are mapping RAM or I/O, so it has to be an additional argument
- * to a separate mapping function for CPU visible mappings.
- */
-BTFIXUPDEF_CALL(int,  mmu_map_dma_area, dma_addr_t *, unsigned long, unsigned long, int len)
-BTFIXUPDEF_CALL(struct page *, mmu_translate_dvma, unsigned long busa)
-BTFIXUPDEF_CALL(void,  mmu_unmap_dma_area, unsigned long busa, int len)
-
-#define mmu_map_dma_area(pba,va,a,len) BTFIXUP_CALL(mmu_map_dma_area)(pba,va,a,len)
-#define mmu_unmap_dma_area(ba,len) BTFIXUP_CALL(mmu_unmap_dma_area)(ba,len)
-#define mmu_translate_dvma(ba)     BTFIXUP_CALL(mmu_translate_dvma)(ba)
-
-#endif /* !(_ASM_SPARC_DMA_H) */
diff --git a/arch/sparc/include/asm/dma_64.h b/arch/sparc/include/asm/dma_64.h
deleted file mode 100644
index 46a8aec..0000000
--- a/arch/sparc/include/asm/dma_64.h
+++ /dev/null
@@ -1,205 +0,0 @@
-/*
- * include/asm/dma.h
- *
- * Copyright 1996 (C) David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef _ASM_SPARC64_DMA_H
-#define _ASM_SPARC64_DMA_H
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/spinlock.h>
-
-#include <asm/sbus.h>
-#include <asm/delay.h>
-#include <asm/oplib.h>
-
-/* These are irrelevant for Sparc DMA, but we leave it in so that
- * things can compile.
- */
-#define MAX_DMA_CHANNELS 8
-#define DMA_MODE_READ    1
-#define DMA_MODE_WRITE   2
-#define MAX_DMA_ADDRESS  (~0UL)
-
-/* Useful constants */
-#define SIZE_16MB      (16*1024*1024)
-#define SIZE_64K       (64*1024)
-
-/* SBUS DMA controller reg offsets */
-#define DMA_CSR		0x00UL		/* rw  DMA control/status register    0x00   */
-#define DMA_ADDR	0x04UL		/* rw  DMA transfer address register  0x04   */
-#define DMA_COUNT	0x08UL		/* rw  DMA transfer count register    0x08   */
-#define DMA_TEST	0x0cUL		/* rw  DMA test/debug register        0x0c   */
-
-/* DVMA chip revisions */
-enum dvma_rev {
-	dvmarev0,
-	dvmaesc1,
-	dvmarev1,
-	dvmarev2,
-	dvmarev3,
-	dvmarevplus,
-	dvmahme
-};
-
-#define DMA_HASCOUNT(rev)  ((rev)=dvmaesc1)
-
-/* Linux DMA information structure, filled during probe. */
-struct sbus_dma {
-	struct sbus_dma *next;
-	struct sbus_dev *sdev;
-	void __iomem *regs;
-
-	/* Status, misc info */
-	int node;                /* Prom node for this DMA device */
-	int running;             /* Are we doing DMA now? */
-	int allocated;           /* Are we "owned" by anyone yet? */
-
-	/* Transfer information. */
-	u32 addr;                /* Start address of current transfer */
-	int nbytes;              /* Size of current transfer */
-	int realbytes;           /* For splitting up large transfers, etc. */
-
-	/* DMA revision */
-	enum dvma_rev revision;
-};
-
-extern struct sbus_dma *dma_chain;
-
-/* Broken hardware... */
-#define DMA_ISBROKEN(dma)    ((dma)->revision = dvmarev1)
-#define DMA_ISESC1(dma)      ((dma)->revision = dvmaesc1)
-
-/* Main routines in dma.c */
-extern void dvma_init(struct sbus_bus *);
-
-/* Fields in the cond_reg register */
-/* First, the version identification bits */
-#define DMA_DEVICE_ID    0xf0000000        /* Device identification bits */
-#define DMA_VERS0        0x00000000        /* Sunray DMA version */
-#define DMA_ESCV1        0x40000000        /* DMA ESC Version 1 */
-#define DMA_VERS1        0x80000000        /* DMA rev 1 */
-#define DMA_VERS2        0xa0000000        /* DMA rev 2 */
-#define DMA_VERHME       0xb0000000        /* DMA hme gate array */
-#define DMA_VERSPLUS     0x90000000        /* DMA rev 1 PLUS */
-
-#define DMA_HNDL_INTR    0x00000001        /* An IRQ needs to be handled */
-#define DMA_HNDL_ERROR   0x00000002        /* We need to take an error */
-#define DMA_FIFO_ISDRAIN 0x0000000c        /* The DMA FIFO is draining */
-#define DMA_INT_ENAB     0x00000010        /* Turn on interrupts */
-#define DMA_FIFO_INV     0x00000020        /* Invalidate the FIFO */
-#define DMA_ACC_SZ_ERR   0x00000040        /* The access size was bad */
-#define DMA_FIFO_STDRAIN 0x00000040        /* DMA_VERS1 Drain the FIFO */
-#define DMA_RST_SCSI     0x00000080        /* Reset the SCSI controller */
-#define DMA_RST_ENET     DMA_RST_SCSI      /* Reset the ENET controller */
-#define DMA_ST_WRITE     0x00000100        /* write from device to memory */
-#define DMA_ENABLE       0x00000200        /* Fire up DMA, handle requests */
-#define DMA_PEND_READ    0x00000400        /* DMA_VERS1/0/PLUS Pending Read */
-#define DMA_ESC_BURST    0x00000800        /* 1byte 02byte */
-#define DMA_READ_AHEAD   0x00001800        /* DMA read ahead partial longword */
-#define DMA_DSBL_RD_DRN  0x00001000        /* No EC drain on slave reads */
-#define DMA_BCNT_ENAB    0x00002000        /* If on, use the byte counter */
-#define DMA_TERM_CNTR    0x00004000        /* Terminal counter */
-#define DMA_SCSI_SBUS64  0x00008000        /* HME: Enable 64-bit SBUS mode. */
-#define DMA_CSR_DISAB    0x00010000        /* No FIFO drains during csr */
-#define DMA_SCSI_DISAB   0x00020000        /* No FIFO drains during reg */
-#define DMA_DSBL_WR_INV  0x00020000        /* No EC inval. on slave writes */
-#define DMA_ADD_ENABLE   0x00040000        /* Special ESC DVMA optimization */
-#define DMA_E_BURSTS	 0x000c0000	   /* ENET: SBUS r/w burst mask */
-#define DMA_E_BURST32	 0x00040000	   /* ENET: SBUS 32 byte r/w burst */
-#define DMA_E_BURST16	 0x00000000	   /* ENET: SBUS 16 byte r/w burst */
-#define DMA_BRST_SZ      0x000c0000        /* SCSI: SBUS r/w burst size */
-#define DMA_BRST64       0x000c0000        /* SCSI: 64byte bursts (HME on UltraSparc only) */
-#define DMA_BRST32       0x00040000        /* SCSI: 32byte bursts */
-#define DMA_BRST16       0x00000000        /* SCSI: 16byte bursts */
-#define DMA_BRST0        0x00080000        /* SCSI: no bursts (non-HME gate arrays) */
-#define DMA_ADDR_DISAB   0x00100000        /* No FIFO drains during addr */
-#define DMA_2CLKS        0x00200000        /* Each transfer = 2 clock ticks */
-#define DMA_3CLKS        0x00400000        /* Each transfer = 3 clock ticks */
-#define DMA_EN_ENETAUI   DMA_3CLKS         /* Put lance into AUI-cable mode */
-#define DMA_CNTR_DISAB   0x00800000        /* No IRQ when DMA_TERM_CNTR set */
-#define DMA_AUTO_NADDR   0x01000000        /* Use "auto nxt addr" feature */
-#define DMA_SCSI_ON      0x02000000        /* Enable SCSI dma */
-#define DMA_PARITY_OFF   0x02000000        /* HME: disable parity checking */
-#define DMA_LOADED_ADDR  0x04000000        /* Address has been loaded */
-#define DMA_LOADED_NADDR 0x08000000        /* Next address has been loaded */
-#define DMA_RESET_FAS366 0x08000000        /* HME: Assert RESET to FAS366 */
-
-/* Values describing the burst-size property from the PROM */
-#define DMA_BURST1       0x01
-#define DMA_BURST2       0x02
-#define DMA_BURST4       0x04
-#define DMA_BURST8       0x08
-#define DMA_BURST16      0x10
-#define DMA_BURST32      0x20
-#define DMA_BURST64      0x40
-#define DMA_BURSTBITS    0x7f
-
-/* Determine highest possible final transfer address given a base */
-#define DMA_MAXEND(addr) (0x01000000UL-(((unsigned long)(addr))&0x00ffffffUL))
-
-/* Yes, I hack a lot of elisp in my spare time... */
-#define DMA_ERROR_P(regs)  ((sbus_readl((regs) + DMA_CSR) & DMA_HNDL_ERROR))
-#define DMA_IRQ_P(regs)    ((sbus_readl((regs) + DMA_CSR)) & (DMA_HNDL_INTR | DMA_HNDL_ERROR))
-#define DMA_WRITE_P(regs)  ((sbus_readl((regs) + DMA_CSR) & DMA_ST_WRITE))
-#define DMA_OFF(__regs)		\
-do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
-	tmp &= ~DMA_ENABLE; \
-	sbus_writel(tmp, (__regs) + DMA_CSR); \
-} while(0)
-#define DMA_INTSOFF(__regs)	\
-do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
-	tmp &= ~DMA_INT_ENAB; \
-	sbus_writel(tmp, (__regs) + DMA_CSR); \
-} while(0)
-#define DMA_INTSON(__regs)	\
-do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
-	tmp |= DMA_INT_ENAB; \
-	sbus_writel(tmp, (__regs) + DMA_CSR); \
-} while(0)
-#define DMA_PUNTFIFO(__regs)	\
-do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
-	tmp |= DMA_FIFO_INV; \
-	sbus_writel(tmp, (__regs) + DMA_CSR); \
-} while(0)
-#define DMA_SETSTART(__regs, __addr)	\
-	sbus_writel((u32)(__addr), (__regs) + DMA_ADDR);
-#define DMA_BEGINDMA_W(__regs)	\
-do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
-	tmp |= (DMA_ST_WRITE|DMA_ENABLE|DMA_INT_ENAB); \
-	sbus_writel(tmp, (__regs) + DMA_CSR); \
-} while(0)
-#define DMA_BEGINDMA_R(__regs)	\
-do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
-	tmp |= (DMA_ENABLE|DMA_INT_ENAB); \
-	tmp &= ~DMA_ST_WRITE; \
-	sbus_writel(tmp, (__regs) + DMA_CSR); \
-} while(0)
-
-/* For certain DMA chips, we need to disable ints upon irq entry
- * and turn them back on when we are done.  So in any ESP interrupt
- * handler you *must* call DMA_IRQ_ENTRY upon entry and DMA_IRQ_EXIT
- * when leaving the handler.  You have been warned...
- */
-#define DMA_IRQ_ENTRY(dma, dregs) do { \
-        if(DMA_ISBROKEN(dma)) DMA_INTSOFF(dregs); \
-   } while (0)
-
-#define DMA_IRQ_EXIT(dma, dregs) do { \
-	if(DMA_ISBROKEN(dma)) DMA_INTSON(dregs); \
-   } while(0)
-
-#define for_each_dvma(dma) \
-        for((dma) = dma_chain; (dma); (dma) = (dma)->next)
-
-/* From PCI */
-
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy 	(0)
-#endif
-
-#endif /* !(_ASM_SPARC64_DMA_H) */
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index ae3f00b..ff2b91c 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -385,4 +385,15 @@ static int sparc_eject(void)
 
 #define EXTRA_FLOPPY_PARAMS
 
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
 #endif /* !(__ASM_SPARC_FLOPPY_H) */
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index b23cea5..8a392d3 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -154,7 +154,6 @@ EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
 
 #ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_root);
-EXPORT_SYMBOL(dma_chain);
 EXPORT_SYMBOL(sbus_set_sbus64);
 EXPORT_SYMBOL(sbus_alloc_consistent);
 EXPORT_SYMBOL(sbus_free_consistent);
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 3b2890c..8e6ac5c 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -161,7 +161,6 @@ EXPORT_SYMBOL(auxio_set_lte);
 #endif
 #ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_root);
-EXPORT_SYMBOL(dma_chain);
 EXPORT_SYMBOL(sbus_set_sbus64);
 EXPORT_SYMBOL(sbus_alloc_consistent);
 EXPORT_SYMBOL(sbus_free_consistent);
diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 4e994f8..24ffecb 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -248,7 +248,7 @@ struct lance_private {
 	int		rx_new, tx_new;
 	int		rx_old, tx_old;
 
-	struct sbus_dma *ledma;	/* If set this points to ledma	*/
+	struct of_device *ledma;	/* If set this points to ledma	*/
 	char		tpe;		/* cable-selection is TPE	*/
 	char		auto_select;	/* cable-selection by carrier	*/
 	char		burst_sizes;	/* ledma SBus burst sizes	*/
@@ -1273,6 +1273,12 @@ static void lance_free_hwresources(struct lance_private *lp)
 {
 	if (lp->lregs)
 		sbus_iounmap(lp->lregs, LANCE_REG_SIZE);
+	if (lp->dregs) {
+		struct of_device *ledma = lp->ledma;
+
+		of_iounmap(&ledma->resource[0], lp->dregs,
+			   resource_size(&ledma->resource[0]));
+	}
 	if (lp->init_block_iomem) {
 		sbus_iounmap(lp->init_block_iomem,
 			     sizeof(struct lance_init_block));
@@ -1309,7 +1315,7 @@ static const struct ethtool_ops sparc_lance_ethtool_ops = {
 };
 
 static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
-					   struct sbus_dma *ledma,
+					   struct of_device *ledma,
 					   struct sbus_dev *lebuffer)
 {
 	static unsigned version_printed;
@@ -1345,6 +1351,18 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 		goto fail;
 	}
 
+	lp->ledma = ledma;
+	if (lp->ledma) {
+		lp->dregs = of_ioremap(&ledma->resource[0], 0,
+				       resource_size(&ledma->resource[0]),
+				       "ledma");
+		if (!lp->dregs) {
+			printk(KERN_ERR "SunLance: Cannot map "
+			       "ledma registers.\n");
+			goto fail;
+		}
+	}
+
 	lp->sdev = sdev;
 	if (lebuffer) {
 		/* sanity check */
@@ -1383,11 +1401,10 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 						      LE_C3_BCON));
 
 	lp->name = lancestr;
-	lp->ledma = ledma;
 
 	lp->burst_sizes = 0;
 	if (lp->ledma) {
-		struct device_node *ledma_dp = ledma->sdev->ofdev.node;
+		struct device_node *ledma_dp = ledma->node;
 		const char *prop;
 		unsigned int sbmask;
 		u32 csr;
@@ -1435,8 +1452,6 @@ no_link_test:
 			lp->tpe = 1;
 		}
 
-		lp->dregs = ledma->regs;
-
 		/* Reset ledma */
 		csr = sbus_readl(lp->dregs + DMA_CSR);
 		sbus_writel(csr | DMA_RST_ENET, lp->dregs + DMA_CSR);
@@ -1486,18 +1501,6 @@ fail:
 	return -ENODEV;
 }
 
-/* On 4m, find the associated dma for the lance chip */
-static struct sbus_dma * __devinit find_ledma(struct sbus_dev *sdev)
-{
-	struct sbus_dma *p;
-
-	for_each_dvma(p) {
-		if (p->sdev = sdev)
-			return p;
-	}
-	return NULL;
-}
-
 #ifdef CONFIG_SUN4
 
 #include <asm/sun4paddr.h>
@@ -1541,13 +1544,13 @@ static int __devinit sunlance_sbus_probe(struct of_device *dev, const struct of_
 	int err;
 
 	if (sdev->parent) {
-		struct of_device *parent = &sdev->parent->ofdev;
-
-		if (!strcmp(parent->node->name, "ledma")) {
-			struct sbus_dma *ledma = find_ledma(to_sbus_device(&parent->dev));
+		struct device_node *parent_node = sdev->parent->ofdev.node;
+		struct of_device *parent;
 
-			err = sparc_lance_probe_one(sdev, ledma, NULL);
-		} else if (!strcmp(parent->node->name, "lebuffer")) {
+		parent = of_find_device_by_node(parent_node);
+		if (parent && !strcmp(parent->node->name, "ledma")) {
+			err = sparc_lance_probe_one(sdev, parent, NULL);
+		} else if (parent && !strcmp(parent->node->name, "lebuffer")) {
 			err = sparc_lance_probe_one(sdev, NULL, to_sbus_device(&parent->dev));
 		} else
 			err = sparc_lance_probe_one(sdev, NULL, NULL);
diff --git a/drivers/sbus/Makefile b/drivers/sbus/Makefile
index 7b1d24d..56f7331 100644
--- a/drivers/sbus/Makefile
+++ b/drivers/sbus/Makefile
@@ -3,7 +3,7 @@
 #
 
 ifneq ($(ARCH),m68k)
-obj-y    := sbus.o dvma.o
+obj-y    := sbus.o
 endif
 
 obj-$(CONFIG_SBUSCHAR) += char/
diff --git a/drivers/sbus/dvma.c b/drivers/sbus/dvma.c
deleted file mode 100644
index ab0d2de..0000000
--- a/drivers/sbus/dvma.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/* dvma.c:  Routines that are used to access DMA on the Sparc SBus.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-
-#include <asm/oplib.h>
-#include <asm/io.h>
-#include <asm/dma.h>
-#include <asm/sbus.h>
-
-struct sbus_dma *dma_chain;
-
-static void __init init_one_dvma(struct sbus_dma *dma, int num_dma)
-{
-	printk("dma%d: ", num_dma);
-	
-	dma->next = NULL;
-	dma->running = 0;      /* No transfers going on as of yet */
-	dma->allocated = 0;    /* No one has allocated us yet */
-	switch(sbus_readl(dma->regs + DMA_CSR)&DMA_DEVICE_ID) {
-	case DMA_VERS0:
-		dma->revision = dvmarev0;
-		printk("Revision 0 ");
-		break;
-	case DMA_ESCV1:
-		dma->revision = dvmaesc1;
-		printk("ESC Revision 1 ");
-		break;
-	case DMA_VERS1:
-		dma->revision = dvmarev1;
-		printk("Revision 1 ");
-		break;
-	case DMA_VERS2:
-		dma->revision = dvmarev2;
-		printk("Revision 2 ");
-		break;
-	case DMA_VERHME:
-		dma->revision = dvmahme;
-		printk("HME DVMA gate array ");
-		break;
-	case DMA_VERSPLUS:
-		dma->revision = dvmarevplus;
-		printk("Revision 1 PLUS ");
-		break;
-	default:
-		printk("unknown dma version %08x",
-		       sbus_readl(dma->regs + DMA_CSR) & DMA_DEVICE_ID);
-		dma->allocated = 1;
-		break;
-	}
-	printk("\n");
-}
-
-/* Probe this SBus DMA module(s) */
-void __init dvma_init(struct sbus_bus *sbus)
-{
-	struct sbus_dev *this_dev;
-	struct sbus_dma *dma;
-	struct sbus_dma *dchain;
-	static int num_dma = 0;
-
-	for_each_sbusdev(this_dev, sbus) {
-		char *name = this_dev->prom_name;
-		int hme = 0;
-
-		if(!strcmp(name, "SUNW,fas"))
-			hme = 1;
-		else if(strcmp(name, "dma") &&
-			strcmp(name, "ledma") &&
-			strcmp(name, "espdma"))
-			continue;
-
-		/* Found one... */
-		dma = kmalloc(sizeof(struct sbus_dma), GFP_ATOMIC);
-
-		dma->sdev = this_dev;
-
-		/* Put at end of dma chain */
-		dchain = dma_chain;
-		if(dchain) {
-			while(dchain->next)
-				dchain = dchain->next;
-			dchain->next = dma;
-		} else {
-			/* We're the first in line */
-			dma_chain = dma;
-		}
-
-		dma->regs = sbus_ioremap(&dma->sdev->resource[0], 0,
-					 dma->sdev->resource[0].end - dma->sdev->resource[0].start + 1,
-					 "dma");
-
-		dma->node = dma->sdev->prom_node;
-		
-		init_one_dvma(dma, num_dma++);
-	}
-}
-
-#ifdef CONFIG_SUN4
-
-#include <asm/sun4paddr.h>
-
-void __init sun4_dvma_init(void)
-{
-	struct sbus_dma *dma;
-	struct resource r;
-
-	if(sun4_dma_physaddr) {
-		dma = kmalloc(sizeof(struct sbus_dma), GFP_ATOMIC);
-
-		/* No SBUS */
-		dma->sdev = NULL;
-
-		/* Only one DMA device */
-		dma_chain = dma;
-
-		memset(&r, 0, sizeof(r));
-		r.start = sun4_dma_physaddr;
-		dma->regs = sbus_ioremap(&r, 0, PAGE_SIZE, "dma");
-
-		/* No prom node */
-		dma->node = 0x0;
-
-		init_one_dvma(dma, 0);
-	} else {
-	  	dma_chain = NULL;
-	}
-}
-
-#endif
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 53e5e7b..6949162 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -285,8 +285,6 @@ static void __init build_one_sbus(struct device_node *dp, int num_sbus)
 	}
 
 	sbus_fixup_all_regs(sbus->devices);
-
-	dvma_init(sbus);
 }
 
 static int __init sbus_init(void)
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index bb43a13..28e22ac 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -521,7 +521,8 @@ struct esp {
 
 	struct completion	*eh_reset;
 
-	struct sbus_dma		*dma;
+	void			*dma;
+	int			dmarev;
 };
 
 /* A front-end driver for the ESP chip should do the following in
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index f9cf701..d110b94 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -1,6 +1,6 @@
 /* sun_esp.c: ESP front-end for Sparc SBUS systems.
  *
- * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 2007, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/kernel.h>
@@ -30,39 +30,48 @@
 #define dma_write32(VAL, REG) \
 	sbus_writel((VAL), esp->dma_regs + (REG))
 
-static int __devinit esp_sbus_find_dma(struct esp *esp, struct sbus_dev *dma_sdev)
-{
-	struct sbus_dev *sdev = esp->dev;
-	struct sbus_dma *dma;
+/* DVMA chip revisions */
+enum dvma_rev {
+	dvmarev0,
+	dvmaesc1,
+	dvmarev1,
+	dvmarev2,
+	dvmarev3,
+	dvmarevplus,
+	dvmahme
+};
 
-	if (dma_sdev != NULL) {
-		for_each_dvma(dma) {
-			if (dma->sdev = dma_sdev)
-				break;
-		}
-	} else {
-		for_each_dvma(dma) {
-			if (dma->sdev = NULL)
-				break;
+static int __devinit esp_sbus_setup_dma(struct esp *esp,
+					struct of_device *dma_of)
+{
+	esp->dma = dma_of;
 
-			/* If bus + slot are the same and it has the
-			 * correct OBP name, it's ours.
-			 */
-			if (sdev->bus = dma->sdev->bus &&
-			    sdev->slot = dma->sdev->slot &&
-			    (!strcmp(dma->sdev->prom_name, "dma") ||
-			     !strcmp(dma->sdev->prom_name, "espdma")))
-				break;
-		}
-	}
+	esp->dma_regs = of_ioremap(&dma_of->resource[0], 0,
+				   resource_size(&dma_of->resource[0]),
+				   "espdma");
+	if (!esp->dma_regs)
+		return -ENOMEM;
 
-	if (dma = NULL) {
-		printk(KERN_ERR PFX "[%s] Cannot find dma.\n",
-		       sdev->ofdev.node->full_name);
-		return -ENODEV;
+	switch (dma_read32(DMA_CSR) & DMA_DEVICE_ID) {
+	case DMA_VERS0:
+		esp->dmarev = dvmarev0;
+		break;
+	case DMA_ESCV1:
+		esp->dmarev = dvmaesc1;
+		break;
+	case DMA_VERS1:
+		esp->dmarev = dvmarev1;
+		break;
+	case DMA_VERS2:
+		esp->dmarev = dvmarev2;
+		break;
+	case DMA_VERHME:
+		esp->dmarev = dvmahme;
+		break;
+	case DMA_VERSPLUS:
+		esp->dmarev = dvmarevplus;
+		break;
 	}
-	esp->dma = dma;
-	esp->dma_regs = dma->regs;
 
 	return 0;
 
@@ -165,19 +174,18 @@ static void __devinit esp_get_clock_params(struct esp *esp)
 	esp->cfreq = fmhz;
 }
 
-static void __devinit esp_get_bursts(struct esp *esp, struct sbus_dev *dma)
+static void __devinit esp_get_bursts(struct esp *esp, struct of_device *dma_of)
 {
+	struct device_node *dma_dp = dma_of->node;
 	struct sbus_dev *sdev = esp->dev;
-	struct device_node *dp = sdev->ofdev.node;
-	u8 bursts;
+	struct device_node *dp;
+	u8 bursts, val;
 
+	dp = sdev->ofdev.node;
 	bursts = of_getintprop_default(dp, "burst-sizes", 0xff);
-	if (dma) {
-		struct device_node *dma_dp = dma->ofdev.node;
-		u8 val = of_getintprop_default(dma_dp, "burst-sizes", 0xff);
-		if (val != 0xff)
-			bursts &= val;
-	}
+	val = of_getintprop_default(dma_dp, "burst-sizes", 0xff);
+	if (val != 0xff)
+		bursts &= val;
 
 	if (sdev->bus) {
 		u8 val = of_getintprop_default(sdev->bus->ofdev.node,
@@ -194,7 +202,7 @@ static void __devinit esp_get_bursts(struct esp *esp, struct sbus_dev *dma)
 	esp->bursts = bursts;
 }
 
-static void __devinit esp_sbus_get_props(struct esp *esp, struct sbus_dev *espdma)
+static void __devinit esp_sbus_get_props(struct esp *esp, struct of_device *espdma)
 {
 	esp_get_scsi_id(esp);
 	esp_get_differential(esp);
@@ -259,12 +267,12 @@ static void sbus_esp_reset_dma(struct esp *esp)
 		can_do_burst64 = (esp->bursts & DMA_BURST64) != 0;
 
 	/* Put the DVMA into a known state. */
-	if (esp->dma->revision != dvmahme) {
+	if (esp->dmarev != dvmahme) {
 		val = dma_read32(DMA_CSR);
 		dma_write32(val | DMA_RST_SCSI, DMA_CSR);
 		dma_write32(val & ~DMA_RST_SCSI, DMA_CSR);
 	}
-	switch (esp->dma->revision) {
+	switch (esp->dmarev) {
 	case dvmahme:
 		dma_write32(DMA_RESET_FAS366, DMA_CSR);
 		dma_write32(DMA_RST_SCSI, DMA_CSR);
@@ -346,14 +354,14 @@ static void sbus_esp_dma_drain(struct esp *esp)
 	u32 csr;
 	int lim;
 
-	if (esp->dma->revision = dvmahme)
+	if (esp->dmarev = dvmahme)
 		return;
 
 	csr = dma_read32(DMA_CSR);
 	if (!(csr & DMA_FIFO_ISDRAIN))
 		return;
 
-	if (esp->dma->revision != dvmarev3 && esp->dma->revision != dvmaesc1)
+	if (esp->dmarev != dvmarev3 && esp->dmarev != dvmaesc1)
 		dma_write32(csr | DMA_FIFO_STDRAIN, DMA_CSR);
 
 	lim = 1000;
@@ -369,7 +377,7 @@ static void sbus_esp_dma_drain(struct esp *esp)
 
 static void sbus_esp_dma_invalidate(struct esp *esp)
 {
-	if (esp->dma->revision = dvmahme) {
+	if (esp->dmarev = dvmahme) {
 		dma_write32(DMA_RST_SCSI, DMA_CSR);
 
 		esp->prev_hme_dmacsr = ((esp->prev_hme_dmacsr |
@@ -440,7 +448,7 @@ static void sbus_esp_send_dma_cmd(struct esp *esp, u32 addr, u32 esp_count,
 		else
 			csr &= ~DMA_ST_WRITE;
 		dma_write32(csr, DMA_CSR);
-		if (esp->dma->revision = dvmaesc1) {
+		if (esp->dmarev = dvmaesc1) {
 			u32 end = PAGE_ALIGN(addr + dma_count + 16U);
 			dma_write32(end - addr, DMA_COUNT);
 		}
@@ -478,7 +486,7 @@ static const struct esp_driver_ops sbus_esp_ops = {
 
 static int __devinit esp_sbus_probe_one(struct device *dev,
 					struct sbus_dev *esp_dev,
-					struct sbus_dev *espdma,
+					struct of_device *espdma,
 					struct sbus_bus *sbus,
 					int hme)
 {
@@ -503,7 +511,7 @@ static int __devinit esp_sbus_probe_one(struct device *dev,
 	if (hme)
 		esp->flags |= ESP_FLAG_WIDE_CAPABLE;
 
-	err = esp_sbus_find_dma(esp, espdma);
+	err = esp_sbus_setup_dma(esp, espdma);
 	if (err < 0)
 		goto fail_unlink;
 
@@ -525,7 +533,7 @@ static int __devinit esp_sbus_probe_one(struct device *dev,
 	 * come up with the reset bit set, so make sure that
 	 * is clear first.
 	 */
-	if (esp->dma->revision = dvmaesc1) {
+	if (esp->dmarev = dvmaesc1) {
 		u32 val = dma_read32(DMA_CSR);
 
 		dma_write32(val & ~DMA_RST_SCSI, DMA_CSR);
@@ -556,26 +564,32 @@ fail:
 static int __devinit esp_sbus_probe(struct of_device *dev, const struct of_device_id *match)
 {
 	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
+	struct device_node *dma_node = NULL;
 	struct device_node *dp = dev->node;
-	struct sbus_dev *dma_sdev = NULL;
+	struct of_device *dma_of = NULL;
 	int hme = 0;
 
 	if (dp->parent &&
 	    (!strcmp(dp->parent->name, "espdma") ||
 	     !strcmp(dp->parent->name, "dma")))
-		dma_sdev = sdev->parent;
+		dma_node = dp->parent;
 	else if (!strcmp(dp->name, "SUNW,fas")) {
-		dma_sdev = sdev;
+		dma_node = sdev->ofdev.node;
 		hme = 1;
 	}
+	if (dma_node)
+		dma_of = of_find_device_by_node(dma_node);
+	if (!dma_of)
+		return -ENODEV;
 
-	return esp_sbus_probe_one(&dev->dev, sdev, dma_sdev,
+	return esp_sbus_probe_one(&dev->dev, sdev, dma_of,
 				  sdev->bus, hme);
 }
 
 static int __devexit esp_sbus_remove(struct of_device *dev)
 {
 	struct esp *esp = dev_get_drvdata(&dev->dev);
+	struct of_device *dma_of = esp->dma;
 	unsigned int irq = esp->host->irq;
 	u32 val;
 
@@ -590,6 +604,8 @@ static int __devexit esp_sbus_remove(struct of_device *dev)
 			     esp->command_block,
 			     esp->command_block_dma);
 	sbus_iounmap(esp->regs, SBUS_ESP_REG_SIZE);
+	of_iounmap(&dma_of->resource[0], esp->dma_regs,
+		   resource_size(&dma_of->resource[0]));
 
 	scsi_host_put(esp->host);
 
-- 
1.5.6.5.GIT

