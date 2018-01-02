From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 02 Jan 2018 20:05:41 +0000
Subject: [PATCH v7 02/10] module: allow symbol exports to be disabled
Message-Id: <20180102200549.22984-3-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

To allow existing C code to be incorporated into the decompressor or
the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
declarations into nops, and #define it in places where such exports
are undesirable. Note that this gets rid of a rather dodgy redefine
of linux/export.h's header guard.

Cc: matt@codeblueprint.co.uk
Cc: keescook@chromium.org
Cc: jeyu@kernel.org
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/kaslr.c      | 5 +----
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 include/linux/export.h                | 9 +++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8199a6187251..3a2a6d7049e4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -23,11 +23,8 @@
  * _ctype[] in lib/ctype.c is needed by isspace() of linux/ctype.h.
  * While both lib/ctype.c and lib/cmdline.c will bring EXPORT_SYMBOL
  * which is meaningless and will cause compiling error in some cases.
- * So do not include linux/export.h and define EXPORT_SYMBOL(sym)
- * as empty.
  */
-#define _LINUX_EXPORT_H
-#define EXPORT_SYMBOL(sym)
+#define __DISABLE_EXPORTS
 
 #include "misc.h"
 #include "error.h"
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index adaa4a964f0c..312bd0b64a61 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
diff --git a/include/linux/export.h b/include/linux/export.h
index 1a1dfdb2a5c6..6dba2fb08f77 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -83,6 +83,15 @@ extern struct module __this_module;
  */
 #define __EXPORT_SYMBOL(sym, sec)	== __KSYM_##sym = 
+#elif defined(__DISABLE_EXPORTS)
+
+/*
+ * Allow symbol exports to be disabled completely so that C code may
+ * be reused in other execution contexts such as the UEFI stub or the
+ * decompressor.
+ */
+#define __EXPORT_SYMBOL(sym, sec)
+
 #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
 
 #include <generated/autoksyms.h>
-- 
2.11.0

