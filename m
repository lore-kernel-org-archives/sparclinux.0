From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 27 Jul 2017 21:57:27 +0000
Subject: [PATCH RFC 1/4] arch/sparc: Separate the exception handlers from NG4memcpy
Message-Id: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@oracle.com

Separate the exception handlers from NG4memcpy so that it can be
used with new memcpy routines. Make a separate file for all these handlers.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/lib/Makefile       |    2 +
 arch/sparc/lib/Memcpy_utils.S |  163 +++++++++++++++++++++++++++++++++++++++++
 arch/sparc/lib/NG4memcpy.S    |  149 -------------------------------------
 3 files changed, 165 insertions(+), 149 deletions(-)
 create mode 100644 arch/sparc/lib/Memcpy_utils.S

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 07c03e7..37930c0 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -36,6 +36,8 @@ lib-$(CONFIG_SPARC64) +=  NG2patch.o
 lib-$(CONFIG_SPARC64) += NG4memcpy.o NG4copy_from_user.o NG4copy_to_user.o
 lib-$(CONFIG_SPARC64) +=  NG4patch.o NG4copy_page.o NG4clear_page.o NG4memset.o
 
+lib-$(CONFIG_SPARC64) += Memcpy_utils.o
+
 lib-$(CONFIG_SPARC64) += GENmemcpy.o GENcopy_from_user.o GENcopy_to_user.o
 lib-$(CONFIG_SPARC64) += GENpatch.o GENpage.o GENbzero.o
 
diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.S
new file mode 100644
index 0000000..f7a26e0
--- /dev/null
+++ b/arch/sparc/lib/Memcpy_utils.S
@@ -0,0 +1,163 @@
+#ifndef __ASM_MEMCPY_UTILS
+#define __ASM_MEMCPY_UTILS
+
+#include <linux/linkage.h>
+#include <asm/asi.h>
+#include <asm/visasm.h>
+
+ENTRY(__restore_asi_fp)
+	VISExitHalf
+	retl
+	 wr	%g0, ASI_AIUS, %asi
+ENDPROC(__restore_asi_fp)
+
+ENTRY(__restore_asi)
+	retl
+	 wr	%g0, ASI_AIUS, %asi
+ENDPROC(__restore_asi)
+
+ENTRY(NG4_retl_o2)
+	ba,pt	%xcc, __restore_asi
+	 mov	%o2, %o0
+ENDPROC(NG4_retl_o2)
+ENTRY(NG4_retl_o2_plus_1)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 1, %o0
+ENDPROC(NG4_retl_o2_plus_1)
+ENTRY(NG4_retl_o2_plus_4)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 4, %o0
+ENDPROC(NG4_retl_o2_plus_4)
+ENTRY(NG4_retl_o2_plus_o5)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(NG4_retl_o2_plus_o5)
+ENTRY(NG4_retl_o2_plus_o5_plus_4)
+	add	%o5, 4, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(NG4_retl_o2_plus_o5_plus_4)
+ENTRY(NG4_retl_o2_plus_o5_plus_8)
+	add	%o5, 8, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(NG4_retl_o2_plus_o5_plus_8)
+ENTRY(NG4_retl_o2_plus_o5_plus_16)
+	add	%o5, 16, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(NG4_retl_o2_plus_o5_plus_16)
+ENTRY(NG4_retl_o2_plus_o5_plus_24)
+	add	%o5, 24, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(NG4_retl_o2_plus_o5_plus_24)
+ENTRY(NG4_retl_o2_plus_o5_plus_32)
+	add	%o5, 32, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(NG4_retl_o2_plus_o5_plus_32)
+ENTRY(NG4_retl_o2_plus_g1)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %g1, %o0
+ENDPROC(NG4_retl_o2_plus_g1)
+ENTRY(NG4_retl_o2_plus_g1_plus_1)
+	add	%g1, 1, %g1
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %g1, %o0
+ENDPROC(NG4_retl_o2_plus_g1_plus_1)
+ENTRY(NG4_retl_o2_plus_g1_plus_8)
+	add	%g1, 8, %g1
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %g1, %o0
+ENDPROC(NG4_retl_o2_plus_g1_plus_8)
+ENTRY(NG4_retl_o2_plus_o4)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4)
+ENTRY(NG4_retl_o2_plus_o4_plus_8)
+	add	%o4, 8, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_8)
+ENTRY(NG4_retl_o2_plus_o4_plus_16)
+	add	%o4, 16, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_16)
+ENTRY(NG4_retl_o2_plus_o4_plus_24)
+	add	%o4, 24, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_24)
+ENTRY(NG4_retl_o2_plus_o4_plus_32)
+	add	%o4, 32, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_32)
+ENTRY(NG4_retl_o2_plus_o4_plus_40)
+	add	%o4, 40, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_40)
+ENTRY(NG4_retl_o2_plus_o4_plus_48)
+	add	%o4, 48, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_48)
+ENTRY(NG4_retl_o2_plus_o4_plus_56)
+	add	%o4, 56, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_56)
+ENTRY(NG4_retl_o2_plus_o4_plus_64)
+	add	%o4, 64, %o4
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_64)
+ENTRY(NG4_retl_o2_plus_o4_fp)
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_8_fp)
+	add	%o4, 8, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_8_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_16_fp)
+	add	%o4, 16, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_16_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_24_fp)
+	add	%o4, 24, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_24_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_32_fp)
+	add	%o4, 32, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_32_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_40_fp)
+	add	%o4, 40, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_40_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_48_fp)
+	add	%o4, 48, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_48_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_56_fp)
+	add	%o4, 56, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_56_fp)
+ENTRY(NG4_retl_o2_plus_o4_plus_64_fp)
+	add	%o4, 64, %o4
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o4, %o0
+ENDPROC(NG4_retl_o2_plus_o4_plus_64_fp)
+
+#endif
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 78ea962..e20d654 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -94,155 +94,6 @@
 	.text
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
-__restore_asi_fp:
-	VISExitHalf
-__restore_asi:
-	retl
-	 wr	%g0, ASI_AIUS, %asi
-
-ENTRY(NG4_retl_o2)
-	ba,pt	%xcc, __restore_asi
-	 mov	%o2, %o0
-ENDPROC(NG4_retl_o2)
-ENTRY(NG4_retl_o2_plus_1)
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, 1, %o0
-ENDPROC(NG4_retl_o2_plus_1)
-ENTRY(NG4_retl_o2_plus_4)
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, 4, %o0
-ENDPROC(NG4_retl_o2_plus_4)
-ENTRY(NG4_retl_o2_plus_o5)
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5)
-ENTRY(NG4_retl_o2_plus_o5_plus_4)
-	add	%o5, 4, %o5
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_4)
-ENTRY(NG4_retl_o2_plus_o5_plus_8)
-	add	%o5, 8, %o5
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_8)
-ENTRY(NG4_retl_o2_plus_o5_plus_16)
-	add	%o5, 16, %o5
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_16)
-ENTRY(NG4_retl_o2_plus_o5_plus_24)
-	add	%o5, 24, %o5
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_24)
-ENTRY(NG4_retl_o2_plus_o5_plus_32)
-	add	%o5, 32, %o5
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_32)
-ENTRY(NG4_retl_o2_plus_g1)
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %g1, %o0
-ENDPROC(NG4_retl_o2_plus_g1)
-ENTRY(NG4_retl_o2_plus_g1_plus_1)
-	add	%g1, 1, %g1
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %g1, %o0
-ENDPROC(NG4_retl_o2_plus_g1_plus_1)
-ENTRY(NG4_retl_o2_plus_g1_plus_8)
-	add	%g1, 8, %g1
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %g1, %o0
-ENDPROC(NG4_retl_o2_plus_g1_plus_8)
-ENTRY(NG4_retl_o2_plus_o4)
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4)
-ENTRY(NG4_retl_o2_plus_o4_plus_8)
-	add	%o4, 8, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_8)
-ENTRY(NG4_retl_o2_plus_o4_plus_16)
-	add	%o4, 16, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_16)
-ENTRY(NG4_retl_o2_plus_o4_plus_24)
-	add	%o4, 24, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_24)
-ENTRY(NG4_retl_o2_plus_o4_plus_32)
-	add	%o4, 32, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_32)
-ENTRY(NG4_retl_o2_plus_o4_plus_40)
-	add	%o4, 40, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_40)
-ENTRY(NG4_retl_o2_plus_o4_plus_48)
-	add	%o4, 48, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_48)
-ENTRY(NG4_retl_o2_plus_o4_plus_56)
-	add	%o4, 56, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_56)
-ENTRY(NG4_retl_o2_plus_o4_plus_64)
-	add	%o4, 64, %o4
-	ba,pt	%xcc, __restore_asi
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_64)
-ENTRY(NG4_retl_o2_plus_o4_fp)
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_8_fp)
-	add	%o4, 8, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_8_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_16_fp)
-	add	%o4, 16, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_16_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_24_fp)
-	add	%o4, 24, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_24_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_32_fp)
-	add	%o4, 32, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_32_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_40_fp)
-	add	%o4, 40, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_40_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_48_fp)
-	add	%o4, 48, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_48_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_56_fp)
-	add	%o4, 56, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_56_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_64_fp)
-	add	%o4, 64, %o4
-	ba,pt	%xcc, __restore_asi_fp
-	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_64_fp)
 #endif
 	.align		64
 
-- 
1.7.1

