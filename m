From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 06 Oct 2017 16:54:50 +0000
Subject: [PATCH v3 2/5] sparc64: Define SPARC default __fls function
Message-Id: <1507308893-9218-3-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com, sam@ravnborg.org

__fls will now require a boot time patching on T4 and above.
Redefining it under arch/sparc/lib.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/include/asm/bitops_64.h |    2 +-
 arch/sparc/lib/Makefile            |    1 +
 arch/sparc/lib/fls64.S             |   61 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index 30aea56..d7a46e2 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -23,10 +23,10 @@
 void change_bit(unsigned long nr, volatile unsigned long *addr);
 
 int fls(unsigned int word);
+int __fls(unsigned long word);
 
 #include <asm-generic/bitops/non-atomic.h>
 
-#include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 
 #ifdef __KERNEL__
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 3b9f5e0..5380c59 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -17,6 +17,7 @@ lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 lib-$(CONFIG_SPARC64) += multi3.o
 lib-$(CONFIG_SPARC64) += fls.o
+lib-$(CONFIG_SPARC64) += fls64.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
diff --git a/arch/sparc/lib/fls64.S b/arch/sparc/lib/fls64.S
new file mode 100644
index 0000000..c83e22a
--- /dev/null
+++ b/arch/sparc/lib/fls64.S
@@ -0,0 +1,61 @@
+/* fls64.S: SPARC default __fls definition.
+ *
+ * SPARC default __fls definition, which follows the same algorithm as
+ * in generic __fls(). This function will be boot time patched on T4
+ * and onward.
+ */
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+	.text
+	.register	%g2, #scratch
+	.register	%g3, #scratch
+ENTRY(__fls)
+	mov	-1, %g2
+	sllx	%g2, 32, %g2
+	and	%o0, %g2, %g2
+	brnz,pt	%g2, 1f
+	 mov	63, %g1
+	sllx	%o0, 32, %o0
+	mov	31, %g1
+1:
+	mov	-1, %g2
+	sllx	%g2, 48, %g2
+	and	%o0, %g2, %g2
+	brnz,pt	%g2, 2f
+	 mov	-1, %g2
+	sllx	%o0, 16, %o0
+	add	%g1, -16, %g1
+2:
+	mov	-1, %g2
+	sllx	%g2, 56, %g2
+	and	%o0, %g2, %g2
+	brnz,pt	%g2, 3f
+	 mov	-1, %g2
+	sllx	%o0, 8, %o0
+	add	%g1, -8, %g1
+3:
+	sllx	%g2, 60, %g2
+	and	%o0, %g2, %g2
+	brnz,pt	%g2, 4f
+	 mov	-1, %g2
+	sllx	%o0, 4, %o0
+	add	%g1, -4, %g1
+4:
+	sllx	%g2, 62, %g2
+	and	%o0, %g2, %g2
+	brnz,pt	%g2, 5f
+	 mov	-1, %g3
+	sllx	%o0, 2, %o0
+	add	%g1, -2, %g1
+5:
+	mov	0, %g2
+	sllx	%g3, 63, %g3
+	and	%o0, %g3, %o0
+	movre	%o0, 1, %g2
+	sub	%g1, %g2, %g1
+	jmp	%o7+8
+	 sra	%g1, 0, %o0
+ENDPROC(__fls)
+EXPORT_SYMBOL(__fls)
-- 
1.7.1

