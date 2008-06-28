From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Jun 2008 22:04:56 +0000
Subject: [PATCH 24/25] sparc: merge header files with trivial differences
Message-Id: <1214690697-4631-24-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A manual inspection revealed that the following headerfiles
contained only trivial differences:
hw_irq.h idprom.h kmap_types.h kvm.h spinlock_types.h sunbpp.h unaligned.h

The only noteworthy change are that sparc64 had a volatile
qualifer that sparc missed in spinlock_types.h.

In addition a few comments were updated.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/idprom.h           |    2 +-
 include/asm-sparc/kmap_types.h       |    4 ++
 include/asm-sparc/spinlock_types.h   |    2 +-
 include/asm-sparc64/hw_irq.h         |    5 +--
 include/asm-sparc64/idprom.h         |   26 +----------
 include/asm-sparc64/kmap_types.h     |   26 +----------
 include/asm-sparc64/kvm.h            |    7 +---
 include/asm-sparc64/spinlock_types.h |   21 +--------
 include/asm-sparc64/sunbpp.h         |   81 +---------------------------------
 include/asm-sparc64/unaligned.h      |   11 +----
 10 files changed, 13 insertions(+), 172 deletions(-)

diff --git a/include/asm-sparc/idprom.h b/include/asm-sparc/idprom.h
index 41adb41..6976aa2 100644
--- a/include/asm-sparc/idprom.h
+++ b/include/asm-sparc/idprom.h
@@ -1,7 +1,7 @@
 /*
  * idprom.h: Macros and defines for idprom routines
  *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1995,1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
 #ifndef _SPARC_IDPROM_H
diff --git a/include/asm-sparc/kmap_types.h b/include/asm-sparc/kmap_types.h
index e215f71..602f5e0 100644
--- a/include/asm-sparc/kmap_types.h
+++ b/include/asm-sparc/kmap_types.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_KMAP_TYPES_H
 #define _ASM_KMAP_TYPES_H
 
+/* Dummy header just to define km_type.  None of this
+ * is actually used on sparc.  -DaveM
+ */
+
 enum km_type {
 	KM_BOUNCE_READ,
 	KM_SKB_SUNRPC_DATA,
diff --git a/include/asm-sparc/spinlock_types.h b/include/asm-sparc/spinlock_types.h
index 0a0fb11..37cbe01 100644
--- a/include/asm-sparc/spinlock_types.h
+++ b/include/asm-sparc/spinlock_types.h
@@ -6,7 +6,7 @@
 #endif
 
 typedef struct {
-	unsigned char lock;
+	volatile unsigned char lock;
 } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
diff --git a/include/asm-sparc64/hw_irq.h b/include/asm-sparc64/hw_irq.h
index 8e44a83..16920a2 100644
--- a/include/asm-sparc64/hw_irq.h
+++ b/include/asm-sparc64/hw_irq.h
@@ -1,4 +1 @@
-#ifndef __ASM_SPARC64_HW_IRQ_H
-#define __ASM_SPARC64_HW_IRQ_H
-
-#endif
+#include <asm-sparc/hw_irq.h>
diff --git a/include/asm-sparc64/idprom.h b/include/asm-sparc64/idprom.h
index a363fa0..c22f9c3 100644
--- a/include/asm-sparc64/idprom.h
+++ b/include/asm-sparc64/idprom.h
@@ -1,25 +1 @@
-/*
- * idprom.h: Macros and defines for idprom routines
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef _SPARC64_IDPROM_H
-#define _SPARC64_IDPROM_H
-
-#include <linux/types.h>
-
-struct idprom {
-	u8		id_format;	/* Format identifier (always 0x01) */
-	u8		id_machtype;	/* Machine type */
-	u8		id_ethaddr[6];	/* Hardware ethernet address */
-	s32		id_date;	/* Date of manufacture */
-	u32		id_sernum:24;	/* Unique serial number */
-	u8		id_cksum;	/* Checksum - xor of the data bytes */
-	u8		reserved[16];
-};
-
-extern struct idprom *idprom;
-extern void idprom_init(void);
-
-#endif /* !(_SPARC_IDPROM_H) */
+#include <asm-sparc/idprom.h>
diff --git a/include/asm-sparc64/kmap_types.h b/include/asm-sparc64/kmap_types.h
index 34c1d3d..276530c 100644
--- a/include/asm-sparc64/kmap_types.h
+++ b/include/asm-sparc64/kmap_types.h
@@ -1,25 +1 @@
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type.  None of this
- * is actually used on sparc64.  -DaveM
- */
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BIO_SRC_IRQ,
-	KM_BIO_DST_IRQ,
-	KM_PTE0,
-	KM_PTE1,
-	KM_IRQ0,
-	KM_IRQ1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
+#include <asm-sparc/kmap_types.h>
diff --git a/include/asm-sparc64/kvm.h b/include/asm-sparc64/kvm.h
index 380537a..53564ad 100644
--- a/include/asm-sparc64/kvm.h
+++ b/include/asm-sparc64/kvm.h
@@ -1,6 +1 @@
-#ifndef __LINUX_KVM_SPARC64_H
-#define __LINUX_KVM_SPARC64_H
-
-/* sparc64 does not support KVM */
-
-#endif
+#include <asm-sparc/kvm.h>
diff --git a/include/asm-sparc64/spinlock_types.h b/include/asm-sparc64/spinlock_types.h
index e128112..48d81c8 100644
--- a/include/asm-sparc64/spinlock_types.h
+++ b/include/asm-sparc64/spinlock_types.h
@@ -1,20 +1 @@
-#ifndef __SPARC64_SPINLOCK_TYPES_H
-#define __SPARC64_SPINLOCK_TYPES_H
-
-#ifndef __LINUX_SPINLOCK_TYPES_H
-# error "please don't include this file directly"
-#endif
-
-typedef struct {
-	volatile unsigned char lock;
-} raw_spinlock_t;
-
-#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
-
-typedef struct {
-	volatile unsigned int lock;
-} raw_rwlock_t;
-
-#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
-
-#endif
+#include <asm-sparc/spinlock_types.h>
diff --git a/include/asm-sparc64/sunbpp.h b/include/asm-sparc64/sunbpp.h
index 8e171b7..9632be2 100644
--- a/include/asm-sparc64/sunbpp.h
+++ b/include/asm-sparc64/sunbpp.h
@@ -1,80 +1 @@
-/*
- * include/asm-sparc64/sunbpp.h
- */
-
-#ifndef _ASM_SPARC64_SUNBPP_H
-#define _ASM_SPARC64_SUNBPP_H
-
-struct bpp_regs {
-  /* DMA registers */
-  __volatile__ __u32 p_csr;		/* DMA Control/Status Register */
-  __volatile__ __u32 p_addr;		/* Address Register */
-  __volatile__ __u32 p_bcnt;		/* Byte Count Register */
-  __volatile__ __u32 p_tst_csr;		/* Test Control/Status (DMA2 only) */
-  /* Parallel Port registers */
-  __volatile__ __u16 p_hcr;		/* Hardware Configuration Register */
-  __volatile__ __u16 p_ocr;		/* Operation Configuration Register */
-  __volatile__ __u8 p_dr;		/* Parallel Data Register */
-  __volatile__ __u8 p_tcr;		/* Transfer Control Register */
-  __volatile__ __u8 p_or;		/* Output Register */
-  __volatile__ __u8 p_ir;		/* Input Register */
-  __volatile__ __u16 p_icr;		/* Interrupt Control Register */
-};
-
-/* P_HCR. Time is in increments of SBus clock. */
-#define P_HCR_TEST      0x8000      /* Allows buried counters to be read */
-#define P_HCR_DSW       0x7f00      /* Data strobe width (in ticks) */
-#define P_HCR_DDS       0x007f      /* Data setup before strobe (in ticks) */
-
-/* P_OCR. */
-#define P_OCR_MEM_CLR   0x8000
-#define P_OCR_DATA_SRC  0x4000      /* )                  */
-#define P_OCR_DS_DSEL   0x2000      /* )  Bidirectional      */
-#define P_OCR_BUSY_DSEL 0x1000      /* )    selects            */
-#define P_OCR_ACK_DSEL  0x0800      /* )                  */
-#define P_OCR_EN_DIAG   0x0400
-#define P_OCR_BUSY_OP   0x0200      /* Busy operation */
-#define P_OCR_ACK_OP    0x0100      /* Ack operation */
-#define P_OCR_SRST      0x0080      /* Reset state machines. Not selfcleaning. */
-#define P_OCR_IDLE      0x0008      /* PP data transfer state machine is idle */
-#define P_OCR_V_ILCK    0x0002      /* Versatec faded. Zebra only. */
-#define P_OCR_EN_VER    0x0001      /* Enable Versatec (0 - enable). Zebra only. */
-
-/* P_TCR */
-#define P_TCR_DIR       0x08
-#define P_TCR_BUSY      0x04
-#define P_TCR_ACK       0x02
-#define P_TCR_DS        0x01        /* Strobe */
-
-/* P_OR */
-#define P_OR_V3         0x20        /* )                 */
-#define P_OR_V2         0x10        /* ) on Zebra only   */
-#define P_OR_V1         0x08        /* )                 */
-#define P_OR_INIT       0x04
-#define P_OR_AFXN       0x02        /* Auto Feed */
-#define P_OR_SLCT_IN    0x01
-
-/* P_IR */
-#define P_IR_PE         0x04
-#define P_IR_SLCT       0x02
-#define P_IR_ERR        0x01
-
-/* P_ICR */
-#define P_DS_IRQ        0x8000      /* RW1  */
-#define P_ACK_IRQ       0x4000      /* RW1  */
-#define P_BUSY_IRQ      0x2000      /* RW1  */
-#define P_PE_IRQ        0x1000      /* RW1  */
-#define P_SLCT_IRQ      0x0800      /* RW1  */
-#define P_ERR_IRQ       0x0400      /* RW1  */
-#define P_DS_IRQ_EN     0x0200      /* RW   Always on rising edge */
-#define P_ACK_IRQ_EN    0x0100      /* RW   Always on rising edge */
-#define P_BUSY_IRP      0x0080      /* RW   1= rising edge */
-#define P_BUSY_IRQ_EN   0x0040      /* RW   */
-#define P_PE_IRP        0x0020      /* RW   1= rising edge */
-#define P_PE_IRQ_EN     0x0010      /* RW   */
-#define P_SLCT_IRP      0x0008      /* RW   1= rising edge */
-#define P_SLCT_IRQ_EN   0x0004      /* RW   */
-#define P_ERR_IRP       0x0002      /* RW1  1= rising edge */
-#define P_ERR_IRQ_EN    0x0001      /* RW   */
-
-#endif /* !(_ASM_SPARC64_SUNBPP_H) */
+#include <asm-sparc/sunbpp.h>
diff --git a/include/asm-sparc64/unaligned.h b/include/asm-sparc64/unaligned.h
index edcebb0..19fbf95 100644
--- a/include/asm-sparc64/unaligned.h
+++ b/include/asm-sparc64/unaligned.h
@@ -1,10 +1 @@
-#ifndef _ASM_SPARC64_UNALIGNED_H
-#define _ASM_SPARC64_UNALIGNED_H
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#endif /* _ASM_SPARC64_UNALIGNED_H */
+#include <asm-sparc/unaligned.h>
-- 
1.5.4.1.143.ge7e51

