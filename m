From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 22:14:16 +0000
Subject: [PATCH 2/5] sparc: unify module.h
Message-Id: <1229984059-3743-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use some preprocessor magic in combination with the
newly introduced CONFIG_BITS to unify module.h.

A few additional symbols are added as they are needed in a follow-up patch

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/module.h    |   32 ++++++++++++++++++++++++--------
 arch/sparc/include/asm/module_32.h |    7 -------
 arch/sparc/include/asm/module_64.h |    7 -------
 3 files changed, 24 insertions(+), 22 deletions(-)
 rewrite arch/sparc/include/asm/module.h (100%)
 delete mode 100644 arch/sparc/include/asm/module_32.h
 delete mode 100644 arch/sparc/include/asm/module_64.h

diff --git a/arch/sparc/include/asm/module.h b/arch/sparc/include/asm/module.h
dissimilarity index 100%
index e82cf9a..ff8e02d 100644
--- a/arch/sparc/include/asm/module.h
+++ b/arch/sparc/include/asm/module.h
@@ -1,8 +1,24 @@
-#ifndef ___ASM_SPARC_MODULE_H
-#define ___ASM_SPARC_MODULE_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/module_64.h>
-#else
-#include <asm/module_32.h>
-#endif
-#endif
+#ifndef __SPARC_MODULE_H
+#define __SPARC_MODULE_H
+struct mod_arch_specific { };
+
+/*
+ * Use some preprocessor magic to define the correct symbol
+ * for sparc32 and sparc64.
+ * Elf_Addr becomes Elf32_Addr for sparc32 and Elf64_Addr for sparc64
+ */
+#define ___ELF(a, b, c) a##b##c
+#define __ELF(a, b, c)  ___ELF(a, b, c)
+#define  _Elf(t)        __ELF(Elf, CONFIG_BITS, t)
+#define  _ELF(t)        __ELF(ELF, CONFIG_BITS, t)
+
+#define Elf_Shdr     _Elf(_Shdr)
+#define Elf_Sym      _Elf(_Sym)
+#define Elf_Ehdr     _Elf(_Ehdr)
+#define Elf_Rela     _Elf(_Rela)
+#define Elf_Addr     _Elf(_Addr)
+
+#define ELF_R_SYM    _ELF(_R_SYM)
+#define ELF_R_TYPE   _ELF(_R_TYPE)
+
+#endif /* __SPARC_MODULE_H */
diff --git a/arch/sparc/include/asm/module_32.h b/arch/sparc/include/asm/module_32.h
deleted file mode 100644
index cbd9e67..0000000
--- a/arch/sparc/include/asm/module_32.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _ASM_SPARC_MODULE_H
-#define _ASM_SPARC_MODULE_H
-struct mod_arch_specific { };
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-#endif /* _ASM_SPARC_MODULE_H */
diff --git a/arch/sparc/include/asm/module_64.h b/arch/sparc/include/asm/module_64.h
deleted file mode 100644
index 3d77ba4..0000000
--- a/arch/sparc/include/asm/module_64.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _ASM_SPARC64_MODULE_H
-#define _ASM_SPARC64_MODULE_H
-struct mod_arch_specific { };
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-#endif /* _ASM_SPARC64_MODULE_H */
-- 
1.6.0.2.GIT

