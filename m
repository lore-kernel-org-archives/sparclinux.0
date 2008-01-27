From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 Jan 2008 12:56:23 +0000
Subject: [PATCH][SPARC64] fix inconsistent .section usage in lib/
Message-Id: <20080127125623.GA19268@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A few places missed the "a" specifier for
the __ex_table section. Add these
so we avoid generation an additional
section at link time.

Latest modpost would otherwise complain
like this:

WARNING: vmlinux.o (__ex_table.2): section name inconsistency.
(.[number]+) following section name.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.
WARNING: vmlinux.o (__ex_table.4): section name inconsistency.
(.[number]+) following section name.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
diff --git a/arch/sparc64/lib/GENbzero.S b/arch/sparc64/lib/GENbzero.S
index f9c71d6..6a4f956 100644
--- a/arch/sparc64/lib/GENbzero.S
+++ b/arch/sparc64/lib/GENbzero.S
@@ -10,7 +10,7 @@
 	.align 4;		\
 99:	retl;			\
 	 mov	%o1, %o0;	\
-	.section __ex_table;	\
+	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
 	.text;			\
diff --git a/arch/sparc64/lib/NGbzero.S b/arch/sparc64/lib/NGbzero.S
index f10e452..814d5f7 100644
--- a/arch/sparc64/lib/NGbzero.S
+++ b/arch/sparc64/lib/NGbzero.S
@@ -10,7 +10,7 @@
 	.align 4;		\
 99:	retl;			\
 	 mov	%o1, %o0;	\
-	.section __ex_table;	\
+	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
 	.text;			\
