From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 12 Jun 2008 22:10:56 +0000
Subject: [patch] sparc: merge openprom_32.h into openprom.h
Message-Id: <20080612221056.GJ17231@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc/openprom.h    |   52 +++++++++++++++++++++++++++++-
 include/asm-sparc/openprom_32.h |   55 --------------------------------
 2 files changed, 51 insertions(+), 56 deletions(-)

e180663a8300879d1aeb2b6ed448b9b608148476 diff --git a/include/asm-sparc/openprom.h b/include/asm-sparc/openprom.h
index de837f1..1575116 100644
--- a/include/asm-sparc/openprom.h
+++ b/include/asm-sparc/openprom.h
@@ -12,7 +12,57 @@
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm-sparc/openprom_64.h>
 #else
-#include <asm-sparc/openprom_32.h>
+
+#include <asm/vaddrs.h>
+
+/* Empirical constants... */
+#define	LINUX_OPPROM_MAGIC      0x10010407
+
+#ifndef __ASSEMBLY__
+struct linux_mlist_v0 {
+	struct linux_mlist_v0 *theres_more;
+	char *start_adr;
+	unsigned num_bytes;
+};
+
+/* More fun PROM structures for device probing. */
+#define PROMREG_MAX     16
+#define PROMVADDR_MAX   16
+#define PROMINTR_MAX    15
+
+struct linux_prom_registers {
+	unsigned int which_io;         /* is this in OBIO space? */
+	unsigned int phys_addr;        /* The physical address of this register */
+	unsigned int reg_size;         /* How many bytes does this register take up? */
+};
+
+/* Ranges and reg properties are a bit different for PCI. */
+struct linux_prom_pci_registers {
+	/* 
+	 * We don't know what information this field contain.
+	 * We guess, PCI device function is in bits 15:8
+	 * So, ...
+	 */
+	unsigned int which_io;  /* Let it be which_io */
+
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_pci_assigned_addresses {
+	unsigned int which_io;
+
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+#endif /* !(__ASSEMBLY__) */
+
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/include/asm-sparc/openprom_32.h b/include/asm-sparc/openprom_32.h
deleted file mode 100644
index 0955de4..0000000
--- a/include/asm-sparc/openprom_32.h
+++ /dev/null
@@ -1,55 +0,0 @@
-#ifndef __SPARC_OPENPROM_H
-#define __SPARC_OPENPROM_H
-
-#include <asm/vaddrs.h>
-
-/* Empirical constants... */
-#define	LINUX_OPPROM_MAGIC      0x10010407
-
-#ifndef __ASSEMBLY__
-struct linux_mlist_v0 {
-	struct linux_mlist_v0 *theres_more;
-	char *start_adr;
-	unsigned num_bytes;
-};
-
-/* More fun PROM structures for device probing. */
-#define PROMREG_MAX     16
-#define PROMVADDR_MAX   16
-#define PROMINTR_MAX    15
-
-struct linux_prom_registers {
-	unsigned int which_io;         /* is this in OBIO space? */
-	unsigned int phys_addr;        /* The physical address of this register */
-	unsigned int reg_size;         /* How many bytes does this register take up? */
-};
-
-/* Ranges and reg properties are a bit different for PCI. */
-struct linux_prom_pci_registers {
-	/* 
-	 * We don't know what information this field contain.
-	 * We guess, PCI device function is in bits 15:8
-	 * So, ...
-	 */
-	unsigned int which_io;  /* Let it be which_io */
-
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_assigned_addresses {
-	unsigned int which_io;
-
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC_OPENPROM_H) */

