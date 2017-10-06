From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 06 Oct 2017 16:54:49 +0000
Subject: [PATCH v3 1/5] sparc64: Define SPARC default fls function
Message-Id: <1507308893-9218-2-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com, sam@ravnborg.org

fls will now require a boot time patching on T4 and above.
Redefining it under arch/sparc/lib.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/include/asm/bitops_64.h |    3 +-
 arch/sparc/lib/Makefile            |    1 +
 arch/sparc/lib/fls.S               |   67 ++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index 2d52240..30aea56 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -22,9 +22,10 @@
 void clear_bit(unsigned long nr, volatile unsigned long *addr);
 void change_bit(unsigned long nr, volatile unsigned long *addr);
 
+int fls(unsigned int word);
+
 #include <asm-generic/bitops/non-atomic.h>
 
-#include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index a1a2d39..3b9f5e0 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -16,6 +16,7 @@ lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 lib-$(CONFIG_SPARC64) += multi3.o
+lib-$(CONFIG_SPARC64) += fls.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
diff --git a/arch/sparc/lib/fls.S b/arch/sparc/lib/fls.S
new file mode 100644
index 0000000..06b8d30
--- /dev/null
+++ b/arch/sparc/lib/fls.S
@@ -0,0 +1,67 @@
+/* fls.S: SPARC default fls definition.
+ *
+ * SPARC default fls definition, which follows the same algorithm as
+ * in generic fls(). This function will be boot time patched on T4
+ * and onward.
+ */
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+	.text
+	.register	%g2, #scratch
+	.register	%g3, #scratch
+ENTRY(fls)
+	brz,pn	%o0, 6f
+	 mov	0, %o1
+	sethi	%hi(0xffff0000), %g3
+	mov	%o0, %g2
+	andcc	%o0, %g3, %g0
+	be,pt	%icc, 8f
+	 mov	32, %o1
+	sethi	%hi(0xff000000), %g3
+	andcc	%g2, %g3, %g0
+	bne,pt	%icc, 3f
+	 sethi	%hi(0xf0000000), %g3
+	sll	%o0, 8, %o0
+1:
+	add	%o1, -8, %o1
+	sra	%o0, 0, %o0
+	mov	%o0, %g2
+2:
+	sethi	%hi(0xf0000000), %g3
+3:
+	andcc	%g2, %g3, %g0
+	bne,pt	%icc, 4f
+	 sethi	%hi(0xc0000000), %g3
+	sll	%o0, 4, %o0
+	add	%o1, -4, %o1
+	sra	%o0, 0, %o0
+	mov	%o0, %g2
+4:
+	andcc	%g2, %g3, %g0
+	be,a,pt	%icc, 7f
+	 sll	%o0, 2, %o0
+5:
+	xnor	%g0, %o0, %o0
+	srl	%o0, 31, %o0
+	sub	%o1, %o0, %o1
+6:
+	jmp	%o7 + 8
+	 sra	%o1, 0, %o0
+7:
+	add	%o1, -2, %o1
+	ba,pt	%xcc, 5b
+	 sra	%o0, 0, %o0
+8:
+	sll	%o0, 16, %o0
+	sethi	%hi(0xff000000), %g3
+	sra	%o0, 0, %o0
+	mov	%o0, %g2
+	andcc	%g2, %g3, %g0
+	bne,pt	%icc, 2b
+	 mov	16, %o1
+	ba,pt	%xcc, 1b
+	 sll	%o0, 8, %o0
+ENDPROC(fls)
+EXPORT_SYMBOL(fls)
-- 
1.7.1

