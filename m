From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 12 Jun 2008 22:11:04 +0000
Subject: [patch] sparc: merge openprom_64.h into openprom.h
Message-Id: <20080612221104.GK17231@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc/openprom.h    |   76 ++++++++++++++++++++++++++++++-
 include/asm-sparc/openprom_64.h |   78 --------------------------------
 2 files changed, 75 insertions(+), 79 deletions(-)

c60a3680bbc0407a5e39f5d699831ac5f157fd09 diff --git a/include/asm-sparc/openprom.h b/include/asm-sparc/openprom.h
index 1575116..e7a926a 100644
--- a/include/asm-sparc/openprom.h
+++ b/include/asm-sparc/openprom.h
@@ -10,7 +10,81 @@
 
 
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm-sparc/openprom_64.h>
+
+#ifndef __ASSEMBLY__
+struct linux_mlist_v0 {
+	struct linux_mlist_v0 *theres_more;
+	unsigned start_adr;
+	unsigned num_bytes;
+};
+
+/* More fun PROM structures for device probing. */
+#define PROMREG_MAX     24
+#define PROMVADDR_MAX   16
+#define PROMINTR_MAX    32
+
+struct linux_prom_registers {
+	unsigned which_io;	/* hi part of physical address			*/
+	unsigned phys_addr;	/* The physical address of this register	*/
+	int reg_size;		/* How many bytes does this register take up?	*/
+};
+
+struct linux_prom64_registers {
+	unsigned long phys_addr;
+	unsigned long reg_size;
+};
+
+struct linux_prom64_ranges {
+	unsigned long ot_child_base;		/* Bus feels this */
+	unsigned long ot_parent_base;		/* CPU looks from here */
+	unsigned long or_size;
+};
+
+/* Ranges and reg properties are a bit different for PCI. */
+struct linux_prom_pci_registers {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_pci_intmap {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+
+	unsigned int interrupt;
+
+	int          cnode;
+	unsigned int cinterrupt;
+};
+
+struct linux_prom_pci_intmask {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+	unsigned int interrupt;
+};
+
+struct linux_prom_ebus_intmap {
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+
+	unsigned int interrupt;
+
+	int          cnode;
+	unsigned int cinterrupt;
+};
+
+struct linux_prom_ebus_intmask {
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+	unsigned int interrupt;
+};
+#endif /* !(__ASSEMBLY__) */
+
 #else
 
 #include <asm/vaddrs.h>
diff --git a/include/asm-sparc/openprom_64.h b/include/asm-sparc/openprom_64.h
deleted file mode 100644
index 0727e66..0000000
--- a/include/asm-sparc/openprom_64.h
+++ /dev/null
@@ -1,78 +0,0 @@
-#ifndef __SPARC64_OPENPROM_H
-#define __SPARC64_OPENPROM_H
-
-#ifndef __ASSEMBLY__
-struct linux_mlist_v0 {
-	struct linux_mlist_v0 *theres_more;
-	unsigned start_adr;
-	unsigned num_bytes;
-};
-
-/* More fun PROM structures for device probing. */
-#define PROMREG_MAX     24
-#define PROMVADDR_MAX   16
-#define PROMINTR_MAX    32
-
-struct linux_prom_registers {
-	unsigned which_io;	/* hi part of physical address			*/
-	unsigned phys_addr;	/* The physical address of this register	*/
-	int reg_size;		/* How many bytes does this register take up?	*/
-};
-
-struct linux_prom64_registers {
-	unsigned long phys_addr;
-	unsigned long reg_size;
-};
-
-struct linux_prom64_ranges {
-	unsigned long ot_child_base;		/* Bus feels this */
-	unsigned long ot_parent_base;		/* CPU looks from here */
-	unsigned long or_size;
-};
-
-/* Ranges and reg properties are a bit different for PCI. */
-struct linux_prom_pci_registers {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_intmap {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-
-	unsigned int interrupt;
-
-	int          cnode;
-	unsigned int cinterrupt;
-};
-
-struct linux_prom_pci_intmask {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-	unsigned int interrupt;
-};
-
-struct linux_prom_ebus_intmap {
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int interrupt;
-
-	int          cnode;
-	unsigned int cinterrupt;
-};
-
-struct linux_prom_ebus_intmask {
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-	unsigned int interrupt;
-};
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC64_OPENPROM_H) */

