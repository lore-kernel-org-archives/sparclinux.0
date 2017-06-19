From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Mon, 19 Jun 2017 17:08:48 +0000
Subject: [PATCH 1/3] Adding asm-prototypes.h for genksyms to generate crc
Message-Id: <1497892130-875525-2-git-send-email-nagarathnam.muthusamy@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds the prototypes of assembly defined functions to asm-prototypes.h.
Some prototypes are directly added as they are not present in any existing header
files.

Signed-off-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>

---
 arch/sparc/include/asm/asm-prototypes.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/include/asm/asm-prototypes.h

diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
new file mode 100644
index 0000000..d381e11
--- /dev/null
+++ b/arch/sparc/include/asm/asm-prototypes.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
+ */
+
+#include <asm/xor.h>
+#include <asm/checksum.h>
+#include <asm/trap_block.h>
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+#include <asm/ftrace.h>
+#include <asm/cacheflush.h>
+#include <asm/oplib.h>
+#include <linux/atomic.h>
+
+void *__memscan_zero(void *, size_t);
+void *__memscan_generic(void *, int, size_t);
+void *__bzero(void *, size_t);
+void VISenter(void); /* Dummy prototype to supress warning */
+#undef memcpy
+#undef memset
+void *memcpy(void *dest, const void *src, size_t n);
+void *memset(void *s, int c, size_t n);
+typedef int TItype __attribute__((mode(TI)));
+TItype __multi3(TItype a, TItype b);
-- 
1.7.1

