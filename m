From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 09 Aug 2017 21:25:59 +0000
Subject: [PATCH v7 6/9] sparc64: Add auxiliary vectors to report platform ADI properties
Message-Id: <a2c7a8537de2e4671795a3fb501a1727ac19721e.1502219353.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1502219353.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1502219353.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, viro@zeniv.linux.org.uk, eric.saint.etienne@oracle.com, allen.pais@oracle.com, chris.hyser@oracle.com, atish.patra@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

ADI feature on M7 and newer processors has two important properties
relevant to userspace apps using ADI capabilities - (1) Size of
block of memory an ADI version tag applies to, and (2) Number of
uppermost bits in virtual address used to encode ADI tag. Kernel can
retrieve these properties for a platform through machine description
provided by the firmware. This patch adds code to retrieve these
properties and report them to userspace through auxiliary vectors.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
v7:
	- new patch split off from patch 4/4 in v6

 arch/sparc/include/asm/adi.h         |  6 +++
 arch/sparc/include/asm/adi_64.h      | 45 ++++++++++++++++++
 arch/sparc/include/asm/elf_64.h      |  8 ++++
 arch/sparc/include/uapi/asm/auxvec.h | 10 ++++
 arch/sparc/kernel/Makefile           |  1 +
 arch/sparc/kernel/adi_64.c           | 90 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/mdesc.c            |  2 +
 7 files changed, 162 insertions(+)
 create mode 100644 arch/sparc/include/asm/adi.h
 create mode 100644 arch/sparc/include/asm/adi_64.h
 create mode 100644 arch/sparc/kernel/adi_64.c

diff --git a/arch/sparc/include/asm/adi.h b/arch/sparc/include/asm/adi.h
new file mode 100644
index 000000000000..acad0d04e4c6
--- /dev/null
+++ b/arch/sparc/include/asm/adi.h
@@ -0,0 +1,6 @@
+#ifndef ___ASM_SPARC_ADI_H
+#define ___ASM_SPARC_ADI_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm/adi_64.h>
+#endif
+#endif
diff --git a/arch/sparc/include/asm/adi_64.h b/arch/sparc/include/asm/adi_64.h
new file mode 100644
index 000000000000..03e99bd2ebbf
--- /dev/null
+++ b/arch/sparc/include/asm/adi_64.h
@@ -0,0 +1,45 @@
+/* adi_64.h: ADI related data structures
+ *
+ * Copyright (C) 2016 Khalid Aziz (khalid.aziz@oracle.com)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+#ifndef __ASM_SPARC64_ADI_H
+#define __ASM_SPARC64_ADI_H
+
+#include <linux/types.h>
+
+#ifndef __ASSEMBLY__
+
+struct adi_caps {
+	__u64 blksz;
+	__u64 nbits;
+};
+
+struct adi_config {
+	bool enabled;
+	struct adi_caps caps;
+};
+
+extern struct adi_config adi_state;
+
+extern void mdesc_adi_init(void);
+
+static inline bool adi_capable(void)
+{
+	return adi_state.enabled;
+}
+
+static inline unsigned long adi_blksize(void)
+{
+	return adi_state.caps.blksz;
+}
+
+static inline unsigned long adi_nbits(void)
+{
+	return adi_state.caps.nbits;
+}
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* !(__ASM_SPARC64_ADI_H) */
diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 3f2d403873bd..bcfa580db29e 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/extable_64.h>
 #include <asm/spitfire.h>
+#include <asm/adi.h>
 
 /*
  * Sparc section types
@@ -210,4 +211,11 @@ do {	if ((ex).e_ident[EI_CLASS] = ELFCLASS32)	\
 			(current->personality & (~PER_MASK)));	\
 } while (0)
 
+#define ARCH_DLINFO						\
+do {								\
+	extern struct adi_config adi_state;			\
+	NEW_AUX_ENT(AT_ADI_BLKSZ, adi_state.caps.blksz);	\
+	NEW_AUX_ENT(AT_ADI_NBITS, adi_state.caps.nbits);	\
+} while (0)
+
 #endif /* !(__ASM_SPARC64_ELF_H) */
diff --git a/arch/sparc/include/uapi/asm/auxvec.h b/arch/sparc/include/uapi/asm/auxvec.h
index ad6f360261f6..c8064dd2bb94 100644
--- a/arch/sparc/include/uapi/asm/auxvec.h
+++ b/arch/sparc/include/uapi/asm/auxvec.h
@@ -1,4 +1,14 @@
 #ifndef __ASMSPARC_AUXVEC_H
 #define __ASMSPARC_AUXVEC_H
 
+#ifdef CONFIG_SPARC64
+/* Avoid overlap with other AT_* values since they are consolidated in
+ * glibc and any overlaps can cause problems
+ */
+#define AT_ADI_BLKSZ	48
+#define AT_ADI_NBITS	49
+
+#define AT_VECTOR_SIZE_ARCH	2
+#endif
+
 #endif /* !(__ASMSPARC_AUXVEC_H) */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index aac609889ee4..8149e175e899 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_SPARC64)   += visemul.o
 obj-$(CONFIG_SPARC64)   += hvapi.o
 obj-$(CONFIG_SPARC64)   += sstate.o
 obj-$(CONFIG_SPARC64)   += mdesc.o
+obj-$(CONFIG_SPARC64)   += adi_64.o
 obj-$(CONFIG_SPARC64)	+= pcr.o
 obj-$(CONFIG_SPARC64)	+= nmi.o
 obj-$(CONFIG_SPARC64_SMP) += cpumap.o
diff --git a/arch/sparc/kernel/adi_64.c b/arch/sparc/kernel/adi_64.c
new file mode 100644
index 000000000000..9fbb5dd4a7bf
--- /dev/null
+++ b/arch/sparc/kernel/adi_64.c
@@ -0,0 +1,90 @@
+/* adi_64.c: support for ADI (Application Data Integrity) feature on
+ * sparc m7 and newer processors. This feature is also known as
+ * SSM (Silicon Secured Memory).
+ *
+ * Copyright (C) 2016 Khalid Aziz (khalid.aziz@oracle.com)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+#include <linux/init.h>
+#include <asm/mdesc.h>
+#include <asm/adi_64.h>
+
+struct adi_config adi_state;
+
+/* mdesc_adi_init() : Parse machine description provided by the
+ *	hypervisor to detect ADI capabilities
+ *
+ * Hypervisor reports ADI capabilities of platform in "hwcap-list" property
+ * for "cpu" node. If the platform supports ADI, "hwcap-list" property
+ * contains the keyword "adp". If the platform supports ADI, "platform"
+ * node will contain "adp-blksz", "adp-nbits" and "ue-on-adp" properties
+ * to describe the ADI capabilities.
+ */
+void __init mdesc_adi_init(void)
+{
+	struct mdesc_handle *hp = mdesc_grab();
+	const char *prop;
+	u64 pn, *val;
+	int len;
+
+	if (!hp)
+		goto adi_not_found;
+
+	pn = mdesc_node_by_name(hp, MDESC_NODE_NULL, "cpu");
+	if (pn = MDESC_NODE_NULL)
+		goto adi_not_found;
+
+	prop = mdesc_get_property(hp, pn, "hwcap-list", &len);
+	if (!prop)
+		goto adi_not_found;
+
+	/*
+	 * Look for "adp" keyword in hwcap-list which would indicate
+	 * ADI support
+	 */
+	adi_state.enabled = false;
+	while (len) {
+		int plen;
+
+		if (!strcmp(prop, "adp")) {
+			adi_state.enabled = true;
+			break;
+		}
+
+		plen = strlen(prop) + 1;
+		prop += plen;
+		len -= plen;
+	}
+
+	if (!adi_state.enabled)
+		goto adi_not_found;
+
+	/* Find the ADI properties in "platform" node. If all ADI
+	 * properties are not found, ADI support is incomplete and
+	 * do not enable ADI in the kernel.
+	 */
+	pn = mdesc_node_by_name(hp, MDESC_NODE_NULL, "platform");
+	if (pn = MDESC_NODE_NULL)
+		goto adi_not_found;
+
+	val = (u64 *) mdesc_get_property(hp, pn, "adp-blksz", &len);
+	if (!val)
+		goto adi_not_found;
+	adi_state.caps.blksz = *val;
+
+	val = (u64 *) mdesc_get_property(hp, pn, "adp-nbits", &len);
+	if (!val)
+		goto adi_not_found;
+	adi_state.caps.nbits = *val;
+
+	mdesc_release(hp);
+	return;
+
+adi_not_found:
+	adi_state.enabled = false;
+	adi_state.caps.blksz = 0;
+	adi_state.caps.nbits = 0;
+	if (hp)
+		mdesc_release(hp);
+}
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index c0765bbf60ea..50b8bfb37530 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <asm/oplib.h>
 #include <asm/smp.h>
+#include <asm/adi.h>
 
 /* Unlike the OBP device tree, the machine description is a full-on
  * DAG.  An arbitrary number of ARCs are possible from one
@@ -1104,5 +1105,6 @@ void __init sun4v_mdesc_init(void)
 
 	cur_mdesc = hp;
 
+	mdesc_adi_init();
 	report_platform_properties();
 }
-- 
2.11.0

