From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 20:03:05 +0000
Subject: [PATCH 2/7] sparc: unify siginfo.h
Message-Id: <1230840190-31884-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Trivial unification where the sparc64 specific
parts are protected using a signle ifdef/endif pair.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild       |    3 --
 arch/sparc/include/asm/siginfo.h    |   43 +++++++++++++++++++++++++++++-----
 arch/sparc/include/asm/siginfo_32.h |   17 -------------
 arch/sparc/include/asm/siginfo_64.h |   32 --------------------------
 4 files changed, 36 insertions(+), 59 deletions(-)
 delete mode 100644 arch/sparc/include/asm/siginfo_32.h
 delete mode 100644 arch/sparc/include/asm/siginfo_64.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 1209485..2eb9450 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,9 +1,6 @@
 # User exported sparc header files
 include include/asm-generic/Kbuild.asm
 
-header-y += siginfo_32.h
-header-y += siginfo_64.h
-
 header-y += apc.h
 header-y += asi.h
 header-y += display7seg.h
diff --git a/arch/sparc/include/asm/siginfo.h b/arch/sparc/include/asm/siginfo.h
index bd81f8d..988e5d8 100644
--- a/arch/sparc/include/asm/siginfo.h
+++ b/arch/sparc/include/asm/siginfo.h
@@ -1,8 +1,37 @@
-#ifndef ___ASM_SPARC_SIGINFO_H
-#define ___ASM_SPARC_SIGINFO_H
+#ifndef __SPARC_SIGINFO_H
+#define __SPARC_SIGINFO_H
+
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm/siginfo_64.h>
-#else
-#include <asm/siginfo_32.h>
-#endif
-#endif
+
+#define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#define __ARCH_SI_BAND_T int
+
+#endif /* defined(__sparc__) && defined(__arch64__) */
+
+
+#define __ARCH_SI_TRAPNO
+
+#include <asm-generic/siginfo.h>
+
+#ifdef __KERNEL__
+
+#include <linux/compat.h>
+
+#ifdef CONFIG_COMPAT
+
+struct compat_siginfo;
+
+#endif /* CONFIG_COMPAT */
+
+#endif /* __KERNEL__ */
+
+#define SI_NOINFO	32767		/* no information in siginfo_t */
+
+/*
+ * SIGEMT si_codes
+ */
+#define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
+#define NSIGEMT		1
+
+#endif /* !(__SPARC_SIGINFO_H) */
diff --git a/arch/sparc/include/asm/siginfo_32.h b/arch/sparc/include/asm/siginfo_32.h
deleted file mode 100644
index 3c71af1..0000000
--- a/arch/sparc/include/asm/siginfo_32.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef _SPARC_SIGINFO_H
-#define _SPARC_SIGINFO_H
-
-#define __ARCH_SI_UID_T		unsigned int
-#define __ARCH_SI_TRAPNO
-
-#include <asm-generic/siginfo.h>
-
-#define SI_NOINFO	32767		/* no information in siginfo_t */
-
-/*
- * SIGEMT si_codes
- */
-#define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
-#define NSIGEMT		1
-
-#endif /* !(_SPARC_SIGINFO_H) */
diff --git a/arch/sparc/include/asm/siginfo_64.h b/arch/sparc/include/asm/siginfo_64.h
deleted file mode 100644
index c96e6c3..0000000
--- a/arch/sparc/include/asm/siginfo_64.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef _SPARC64_SIGINFO_H
-#define _SPARC64_SIGINFO_H
-
-#define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
-
-#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
-#define __ARCH_SI_TRAPNO
-#define __ARCH_SI_BAND_T int
-
-#include <asm-generic/siginfo.h>
-
-#ifdef __KERNEL__
-
-#include <linux/compat.h>
-
-#ifdef CONFIG_COMPAT
-
-struct compat_siginfo;
-
-#endif /* CONFIG_COMPAT */
-
-#endif /* __KERNEL__ */
-
-#define SI_NOINFO	32767		/* no information in siginfo_t */
-
-/*
- * SIGEMT si_codes
- */
-#define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
-#define NSIGEMT		1
-
-#endif
-- 
1.6.0.2.GIT

