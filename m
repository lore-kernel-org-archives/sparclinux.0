From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:24 +0000
Subject: [PATCH 09/29] sparc32: fix sparse warnings in irq_32.c
Message-Id: <1398109184-3283-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
irq_32.c:239:5: warning: symbol 'sparc_floppy_request_irq' was not declared. Should it be static?
irq_32.c:294:24: warning: symbol 'fdc_status' was not declared. Should it be static?
irq_32.c:297:6: warning: symbol 'pdma_vaddr' was not declared. Should it be static?
irq_32.c:300:15: warning: symbol 'pdma_size' was not declared. Should it be static?
irq_32.c:303:14: warning: symbol 'doing_pdma' was not declared. Should it be static?
irq_32.c:306:6: warning: symbol 'pdma_base' was not declared. Should it be static?
irq_32.c:309:15: warning: symbol 'pdma_areasize' was not declared. Should it be static?
irq_32.c:317:6: warning: symbol 'sparc_floppy_irq' was not declared. Should it be static?

The floppy parts were all added to iasm/setup.h - no other header files looked obvious.
floppy_32.h was not an option as this file can only be included once from the
floppy driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/floppy_32.h | 11 ++---------
 arch/sparc/include/asm/setup.h     | 16 +++++++++++++++-
 arch/sparc/kernel/irq.h            |  3 +++
 arch/sparc/kernel/irq_32.c         |  1 +
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index fb3f169..a8af6f0 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -9,11 +9,12 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/idprom.h>
 #include <asm/oplib.h>
 #include <asm/auxio.h>
+#include <asm/setup.h>
+#include <asm/page.h>
 #include <asm/irq.h>
 
 /* We don't need no stinkin' I/O port allocation crap. */
@@ -49,7 +50,6 @@ struct sun_flpy_controller {
 
 /* You'll only ever find one controller on a SparcStation anyways. */
 static struct sun_flpy_controller *sun_fdc = NULL;
-extern volatile unsigned char *fdc_status;
 
 struct sun_floppy_ops {
 	unsigned char (*fd_inb)(int port);
@@ -212,13 +212,6 @@ static void sun_82077_fd_outb(unsigned char value, int port)
  * underruns.  If non-zero, doing_pdma encodes the direction of
  * the transfer for debugging.  1=read 2=write
  */
-extern char *pdma_vaddr;
-extern unsigned long pdma_size;
-extern volatile int doing_pdma;
-
-/* This is software state */
-extern char *pdma_base;
-extern unsigned long pdma_areasize;
 
 /* Common routines to all controller types on the Sparc. */
 static inline void virtual_dma_init(void)
diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 5e35e05..4b7465a 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -4,8 +4,9 @@
 #ifndef _SPARC_SETUP_H
 #define _SPARC_SETUP_H
 
-#include <uapi/asm/setup.h>
+#include <linux/interrupt.h>
 
+#include <uapi/asm/setup.h>
 
 extern char reboot_command[];
 
@@ -22,6 +23,19 @@ static inline int con_is_present(void)
 {
 	return serial_console ? 0 : 1;
 }
+
+/* from irq_32.c */
+extern volatile unsigned char *fdc_status;
+extern char *pdma_vaddr;
+extern unsigned long pdma_size;
+extern volatile int doing_pdma;
+
+/* This is software state */
+extern char *pdma_base;
+extern unsigned long pdma_areasize;
+
+int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler);
+
 #endif
 
 extern void sun_do_break(void);
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 3306e42..7c7540a 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -82,6 +82,9 @@ void handler_irq(unsigned int pil, struct pt_regs *regs);
 
 unsigned long leon_get_irqmask(unsigned int irq);
 
+/* irq_32.c */
+void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs);
+
 /* sun4m_irq.c */
 void sun4m_nmi(struct pt_regs *regs);
 
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index c145f6f..a979e99 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -17,6 +17,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpudata.h>
+#include <asm/setup.h>
 #include <asm/pcic.h>
 #include <asm/leon.h>
 
-- 
1.8.3.1

