From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 06 Oct 2017 16:54:51 +0000
Subject: [PATCH v3 3/5] sparc64: SPARC optimised fls function
Message-Id: <1507308893-9218-4-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com, sam@ravnborg.org

Defined SPARC optimised fls using lzcnt opcode.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/lib/Makefile |    1 +
 arch/sparc/lib/NG4fls.S |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 5380c59..2823b8e 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -18,6 +18,7 @@ lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 lib-$(CONFIG_SPARC64) += multi3.o
 lib-$(CONFIG_SPARC64) += fls.o
 lib-$(CONFIG_SPARC64) += fls64.o
+obj-$(CONFIG_SPARC64) += NG4fls.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
diff --git a/arch/sparc/lib/NG4fls.S b/arch/sparc/lib/NG4fls.S
new file mode 100644
index 0000000..5ed7da9
--- /dev/null
+++ b/arch/sparc/lib/NG4fls.S
@@ -0,0 +1,20 @@
+/* NG4fls.S: SPARC optimized fls and __fls for T4 and above.
+ *
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ */
+
+#include <linux/linkage.h>
+
+#define LXCNT_O0_G2	\
+	.word	0x85b002e8
+
+	.text
+	.register	%g2, #scratch
+	.register	%g3, #scratch
+
+ENTRY(NG4fls)
+	LXCNT_O0_G2	!lzcnt	%o0, %g2
+	mov	64, %g3
+	retl
+	 sub	%g3, %g2, %o0
+ENDPROC(NG4fls)
-- 
1.7.1

