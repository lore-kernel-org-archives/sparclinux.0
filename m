From: David Miller <davem@davemloft.net>
Date: Mon, 09 Feb 2009 06:46:40 +0000
Subject: [PATCH 1/2]: sparc64: Kill .fixup section bloat.
Message-Id: <20090208.224640.168410936.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is an implementation of a suggestion made by Chris Torek:
--------------------
Something else I noticed in passing: the EX and EX_LD/EX_ST macros
scattered throughout the various .S files make a fair bit of .fixup
code, all of which does the same thing.  At the cost of one symbol
in copy_in_user.S, you could just have one common two-instruction
retl-and-mov-1 fixup that they all share.
--------------------

The following is with a defconfig build:

   text	   data	    bss	    dec	    hex	filename
3972767	 344024	 584449	4901240	 4ac978	vmlinux.orig
3968887	 344024	 584449	4897360	 4aba50	vmlinux

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/head_64.S        |   31 ++++++++++++++++++++++++++++---
 arch/sparc/lib/GENbzero.S          |    6 +-----
 arch/sparc/lib/GENcopy_from_user.S |    6 +-----
 arch/sparc/lib/GENcopy_to_user.S   |    6 +-----
 arch/sparc/lib/NG2copy_from_user.S |    7 +------
 arch/sparc/lib/NG2copy_to_user.S   |    7 +------
 arch/sparc/lib/NGbzero.S           |    6 +-----
 arch/sparc/lib/NGcopy_from_user.S  |    7 +------
 arch/sparc/lib/NGcopy_to_user.S    |    7 +------
 arch/sparc/lib/U1copy_from_user.S  |    6 +-----
 arch/sparc/lib/U1copy_to_user.S    |    6 +-----
 arch/sparc/lib/U3copy_from_user.S  |    6 +-----
 arch/sparc/lib/U3copy_to_user.S    |    6 +-----
 arch/sparc/lib/bzero.S             |    6 +-----
 arch/sparc/lib/copy_in_user.S      |    6 +-----
 15 files changed, 42 insertions(+), 77 deletions(-)

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 8ffee71..a46c3a2 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -891,10 +891,35 @@ prom_tba:	.xword	0
 tlb_type:	.word	0	/* Must NOT end up in BSS */
 	.section	".fixup",#alloc,#execinstr
 
-	.globl	__ret_efault, __retl_efault
-__ret_efault:
+	.globl	__ret_efault, __retl_efault, __ret_one, __retl_one
+ENTRY(__ret_efault)
 	ret
 	 restore %g0, -EFAULT, %o0
-__retl_efault:
+ENDPROC(__ret_efault)
+
+ENTRY(__retl_efault)
 	retl
 	 mov	-EFAULT, %o0
+ENDPROC(__retl_efault)
+
+ENTRY(__retl_one)
+	retl
+	 mov	1, %o0
+ENDPROC(__retl_one)
+
+ENTRY(__ret_one_asi)
+	wr	%g0, ASI_AIUS, %asi
+	ret
+	 restore %g0, 1, %o0
+ENDPROC(__ret_one_asi)
+
+ENTRY(__retl_one_asi)
+	wr	%g0, ASI_AIUS, %asi
+	retl
+	 mov	1, %o0
+ENDPROC(__retl_one_asi)
+
+ENTRY(__retl_o1)
+	retl
+	 mov	%o1, %o0
+ENDPROC(__retl_o1)
diff --git a/arch/sparc/lib/GENbzero.S b/arch/sparc/lib/GENbzero.S
index 6a4f956..8e7a843 100644
--- a/arch/sparc/lib/GENbzero.S
+++ b/arch/sparc/lib/GENbzero.S
@@ -6,13 +6,9 @@
 
 #define EX_ST(x,y)		\
 98:	x,y;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	%o1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_o1;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/GENcopy_from_user.S b/arch/sparc/lib/GENcopy_from_user.S
index 2b9df99..9b0e58f 100644
--- a/arch/sparc/lib/GENcopy_from_user.S
+++ b/arch/sparc/lib/GENcopy_from_user.S
@@ -5,13 +5,9 @@
 
 #define EX_LD(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/GENcopy_to_user.S b/arch/sparc/lib/GENcopy_to_user.S
index bb3f708..ce79b49 100644
--- a/arch/sparc/lib/GENcopy_to_user.S
+++ b/arch/sparc/lib/GENcopy_to_user.S
@@ -5,13 +5,9 @@
 
 #define EX_ST(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NG2copy_from_user.S b/arch/sparc/lib/NG2copy_from_user.S
index c77ef5f..01ac546 100644
--- a/arch/sparc/lib/NG2copy_from_user.S
+++ b/arch/sparc/lib/NG2copy_from_user.S
@@ -5,14 +5,9 @@
 
 #define EX_LD(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	wr	%g0, ASI_AIUS, %asi;\
-	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one_asi;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NG2copy_to_user.S b/arch/sparc/lib/NG2copy_to_user.S
index 4bd4093..c477e15 100644
--- a/arch/sparc/lib/NG2copy_to_user.S
+++ b/arch/sparc/lib/NG2copy_to_user.S
@@ -5,14 +5,9 @@
 
 #define EX_ST(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	wr	%g0, ASI_AIUS, %asi;\
-	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one_asi;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NGbzero.S b/arch/sparc/lib/NGbzero.S
index 814d5f7..beab29b 100644
--- a/arch/sparc/lib/NGbzero.S
+++ b/arch/sparc/lib/NGbzero.S
@@ -6,13 +6,9 @@
 
 #define EX_ST(x,y)		\
 98:	x,y;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	%o1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_o1;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NGcopy_from_user.S b/arch/sparc/lib/NGcopy_from_user.S
index e7f433f..39bb891 100644
--- a/arch/sparc/lib/NGcopy_from_user.S
+++ b/arch/sparc/lib/NGcopy_from_user.S
@@ -5,14 +5,9 @@
 
 #define EX_LD(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	wr	%g0, ASI_AIUS, %asi;\
-	ret;			\
-	 restore %g0, 1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __ret_one_asi;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NGcopy_to_user.S b/arch/sparc/lib/NGcopy_to_user.S
index 6ea01c5..bf62fc1 100644
--- a/arch/sparc/lib/NGcopy_to_user.S
+++ b/arch/sparc/lib/NGcopy_to_user.S
@@ -5,14 +5,9 @@
 
 #define EX_ST(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	wr	%g0, ASI_AIUS, %asi;\
-	ret;			\
-	 restore %g0, 1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __ret_one_asi;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U1copy_from_user.S b/arch/sparc/lib/U1copy_from_user.S
index 3192b0b..f14efdd 100644
--- a/arch/sparc/lib/U1copy_from_user.S
+++ b/arch/sparc/lib/U1copy_from_user.S
@@ -5,13 +5,9 @@
 
 #define EX_LD(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U1copy_to_user.S b/arch/sparc/lib/U1copy_to_user.S
index d1210ff..59d531b 100644
--- a/arch/sparc/lib/U1copy_to_user.S
+++ b/arch/sparc/lib/U1copy_to_user.S
@@ -5,13 +5,9 @@
 
 #define EX_ST(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U3copy_from_user.S b/arch/sparc/lib/U3copy_from_user.S
index f5bfc8d..b1acd13 100644
--- a/arch/sparc/lib/U3copy_from_user.S
+++ b/arch/sparc/lib/U3copy_from_user.S
@@ -5,13 +5,9 @@
 
 #define EX_LD(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
index 2334f11..b4cbfe5 100644
--- a/arch/sparc/lib/U3copy_to_user.S
+++ b/arch/sparc/lib/U3copy_to_user.S
@@ -5,13 +5,9 @@
 
 #define EX_ST(x)		\
 98:	x;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/bzero.S b/arch/sparc/lib/bzero.S
index c7bbae8..b655729 100644
--- a/arch/sparc/lib/bzero.S
+++ b/arch/sparc/lib/bzero.S
@@ -88,13 +88,9 @@ __bzero_done:
 
 #define EX_ST(x,y)		\
 98:	x,y;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov	%o1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_o1;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
index 650af3f..884f464 100644
--- a/arch/sparc/lib/copy_in_user.S
+++ b/arch/sparc/lib/copy_in_user.S
@@ -9,13 +9,9 @@
 
 #define EX(x,y)			\
 98:	x,y;			\
-	.section .fixup;	\
-	.align 4;		\
-99:	retl;			\
-	 mov 1, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, 99b;		\
+	.word 98b, __retl_one;	\
 	.text;			\
 	.align 4;
 
-- 
1.6.1.2.253.ga34a

