From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 15 Oct 2009 01:01:44 +0000
Subject: [PATCH 1/2] of: create asm/of.h
Message-Id: <20091015120144.73ef384c.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091015120007.3780c59b.sfr@canb.auug.org.au>
In-Reply-To: <20091015120007.3780c59b.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

This creates asm/of.h for powerpc and sparc and includes it
from linux/of.h, it also moves the first trivial stuff there from
asm/prom.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/of.h   |   23 +++++++++++++++++++++++
 arch/powerpc/include/asm/prom.h |    7 -------
 arch/sparc/include/asm/of.h     |   24 ++++++++++++++++++++++++
 arch/sparc/include/asm/prom.h   |    7 -------
 include/linux/of.h              |    1 +
 5 files changed, 48 insertions(+), 14 deletions(-)
 create mode 100644 arch/powerpc/include/asm/of.h
 create mode 100644 arch/sparc/include/asm/of.h

diff --git a/arch/powerpc/include/asm/of.h b/arch/powerpc/include/asm/of.h
new file mode 100644
index 0000000..1c1089a
--- /dev/null
+++ b/arch/powerpc/include/asm/of.h
@@ -0,0 +1,23 @@
+#ifndef _POWERPC_OF_H
+#define _POWERPC_OF_H
+/*
+ * Definitions for accessing the in memory device tree.
+ *
+ * Extracted from prom.h
+ *	Copyright (C) 1996-2005 Paul Mackerras.
+ *	Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
+#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
+
+#endif /* _POWERPC_OF_H */
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 6ff0418..07aef9f 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -21,13 +21,6 @@
 #include <asm/irq.h>
 #include <asm/atomic.h>
 
-#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
-#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
-
-#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
-#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
-#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
-
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
diff --git a/arch/sparc/include/asm/of.h b/arch/sparc/include/asm/of.h
new file mode 100644
index 0000000..57ab8f9
--- /dev/null
+++ b/arch/sparc/include/asm/of.h
@@ -0,0 +1,24 @@
+#ifndef _SPARC_OF_H
+#define _SPARC_OF_H
+/*
+ * Definitions for accessing the in memory device tree.
+ *
+ * Extracted from prom.h
+ *	Copyright (C) 1996-2005 Paul Mackerras.
+ *	Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
+ *	Updates for SPARC by David S. Miller
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
+#define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
+#define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcmp((s1), (s2))
+
+#endif /* _SPARC_OF_H */
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 82a190d..4b6ec43 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -21,13 +21,6 @@
 #include <linux/mutex.h>
 #include <asm/atomic.h>
 
-#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
-#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
-
-#define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
-#define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
-#define of_node_cmp(s1, s2)		strcmp((s1), (s2))
-
 typedef u32 phandle;
 typedef u32 ihandle;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 7be2d10..3bfdaec 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/mod_devicetable.h>
 
+#include <asm/of.h>
 #include <asm/prom.h>
 
 /* flag descriptions */
-- 
1.6.4.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
