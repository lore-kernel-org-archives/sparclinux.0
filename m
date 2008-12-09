From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2008 23:35:47 +0000
Subject: [PATCH 2/4]: sparc: Add asm/asm.h
Message-Id: <20081209.153547.87182274.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Add asm/asm.h

This will contain macros that help share assembler code
between the 32-bit and 64-bit platform.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/asm.h |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/include/asm/asm.h

diff --git a/arch/sparc/include/asm/asm.h b/arch/sparc/include/asm/asm.h
new file mode 100644
index 0000000..e8e1d94
--- /dev/null
+++ b/arch/sparc/include/asm/asm.h
@@ -0,0 +1,40 @@
+#ifndef _SPARC_ASM_H
+#define _SPARC_ASM_H
+
+/* Macros to assist the sharing of assembler code between 32-bit and
+ * 64-bit sparc.
+ */
+
+#ifdef CONFIG_SPARC64
+#define BRANCH32(TYPE, PREDICT, DEST) \
+	TYPE,PREDICT	%icc, DEST
+#define BRANCH32_ANNUL(TYPE, PREDICT, DEST) \
+	TYPE,a,PREDICT	%icc, DEST
+#define BRANCH_REG_ZERO(PREDICT, REG, DEST) \
+	brz,PREDICT	REG, DEST
+#define BRANCH_REG_ZERO_ANNUL(PREDICT, REG, DEST) \
+	brz,a,PREDICT	REG, DEST
+#define BRANCH_REG_NOT_ZERO(PREDICT, REG, DEST) \
+	brnz,PREDICT	REG, DEST
+#define BRANCH_REG_NOT_ZERO_ANNUL(PREDICT, REG, DEST) \
+	brnz,a,PREDICT	REG, DEST
+#else
+#define BRANCH32(TYPE, PREDICT, DEST) \
+	TYPE		DEST
+#define BRANCH32_ANNUL(TYPE, PREDICT, DEST) \
+	TYPE,a		DEST
+#define BRANCH_REG_ZERO(PREDICT, REG, DEST) \
+	cmp		REG, 0; \
+	be		DEST
+#define BRANCH_REG_ZERO_ANNUL(PREDICT, REG, DEST) \
+	cmp		REG, 0; \
+	be,a		DEST
+#define BRANCH_REG_NOT_ZERO(PREDICT, REG, DEST) \
+	cmp		REG, 0; \
+	bne		DEST
+#define BRANCH_REG_NOT_ZERO_ANNUL(PREDICT, REG, DEST) \
+	cmp		REG, 0; \
+	bne,a		DEST
+#endif
+
+#endif /* _SPARC_ASM_H */
-- 
1.5.6.5

