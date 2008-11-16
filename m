From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 08:56:59 +0000
Subject: [PATCH] sparc: cleanup math-emu
Message-Id: <1226825821-10125-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- Drop unused assignment from Makefile
- Replace EXTRA_CFLAGS with ccflags-y
- Delete unused file

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/math-emu/Makefile  |    6 +++---
 arch/sparc/math-emu/ashldi3.S |   36 ------------------------------------
 2 files changed, 3 insertions(+), 39 deletions(-)
 delete mode 100644 arch/sparc/math-emu/ashldi3.S

diff --git a/arch/sparc/math-emu/Makefile b/arch/sparc/math-emu/Makefile
index 8136987..86995d6 100644
--- a/arch/sparc/math-emu/Makefile
+++ b/arch/sparc/math-emu/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the FPU instruction emulation.
 #
 
-obj-y    := math.o
+# supress all warnings - as math.c produces a lot!
+ccflags-y := -w
 
-EXTRA_AFLAGS := -ansi
-EXTRA_CFLAGS = -I. -Iinclude/math-emu -w
+obj-y    := math.o
diff --git a/arch/sparc/math-emu/ashldi3.S b/arch/sparc/math-emu/ashldi3.S
deleted file mode 100644
index 7230ff5..0000000
--- a/arch/sparc/math-emu/ashldi3.S
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * ashldi3.S:	Math-emu code creates all kinds of references to
- *              this little routine on the sparc with gcc.
- *
- * Copyright (C) 1998 Jakub Jelinek(jj@ultra.linux.cz)
- */
-
-#include <asm/cprefix.h>
-
-	.globl C_LABEL(__ashldi3)
-C_LABEL(__ashldi3):
-	tst	%o2
-	be	3f
-	 mov	32, %g2
-
-	sub	%g2, %o2, %g2
-
-	tst	%g2
-	bg	1f
-	 srl	%o1, %g2, %g3
-
-	clr	%o5
-	neg	%g2
-	ba	2f
-	 sll	%o1, %g2, %o4
-
-1:
-	sll	%o1, %o2, %o5
-	srl	%o0, %o2, %g2
-	or	%g2, %g3, %o4
-2:
-	mov	%o4, %o0
-	mov	%o5, %o1
-3:
-	jmpl	%o7 + 8, %g0
-	 nop
-- 
1.5.6.GIT

