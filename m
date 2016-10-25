From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 15:01:36 +0000
Subject: [PATCH 02/11] sparc64: Prepare to move to more saner user copy exception handling.
Message-Id: <20161025.110136.101780396838009793.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The fixup helper function mechanism for handling user copy fault
handling is not %100 accurrate, and can never be made so.

We are going to transition the code to return the running return
return length, which is always kept track in one or more registers
of each of these routines.

In order to convert them one by one, we have to allow the existing
behavior to continue functioning.

Therefore make all the copy code that wants the fixup helper to be
used return negative one.

After all of the user copy routines have been converted, this logic
and the fixup helpers themselves can be removed completely.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess_64.h | 21 +++++++++++++++------
 arch/sparc/kernel/head_64.S         | 23 +++++++++++------------
 arch/sparc/lib/GENcopy_from_user.S  |  2 +-
 arch/sparc/lib/GENcopy_to_user.S    |  2 +-
 arch/sparc/lib/NG2copy_from_user.S  |  4 ++--
 arch/sparc/lib/NG2copy_to_user.S    |  4 ++--
 arch/sparc/lib/NG4copy_from_user.S  |  4 ++--
 arch/sparc/lib/NG4copy_to_user.S    |  4 ++--
 arch/sparc/lib/NGcopy_from_user.S   |  2 +-
 arch/sparc/lib/NGcopy_to_user.S     |  2 +-
 arch/sparc/lib/U1copy_from_user.S   |  4 ++--
 arch/sparc/lib/U1copy_to_user.S     |  4 ++--
 arch/sparc/lib/U3copy_from_user.S   |  4 ++--
 arch/sparc/lib/U3copy_to_user.S     |  4 ++--
 arch/sparc/lib/copy_in_user.S       |  2 +-
 15 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index f8518df..0244012 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -198,8 +198,11 @@ copy_from_user(void *to, const void __user *from, unsigned long size)
 	check_object_size(to, size, false);
 
 	ret = ___copy_from_user(to, from, size);
-	if (unlikely(ret))
-		ret = copy_from_user_fixup(to, from, size);
+	if (unlikely(ret)) {
+		if ((long)ret < 0)
+			ret = copy_from_user_fixup(to, from, size);
+		return ret;
+	}
 
 	return ret;
 }
@@ -218,8 +221,11 @@ copy_to_user(void __user *to, const void *from, unsigned long size)
 	check_object_size(from, size, true);
 
 	ret = ___copy_to_user(to, from, size);
-	if (unlikely(ret))
-		ret = copy_to_user_fixup(to, from, size);
+	if (unlikely(ret)) {
+		if ((long)ret < 0)
+			ret = copy_to_user_fixup(to, from, size);
+		return ret;
+	}
 	return ret;
 }
 #define __copy_to_user copy_to_user
@@ -234,8 +240,11 @@ copy_in_user(void __user *to, void __user *from, unsigned long size)
 {
 	unsigned long ret = ___copy_in_user(to, from, size);
 
-	if (unlikely(ret))
-		ret = copy_in_user_fixup(to, from, size);
+	if (unlikely(ret)) {
+		if ((long)ret < 0)
+			ret = copy_in_user_fixup(to, from, size);
+		return ret;
+	}
 	return ret;
 }
 #define __copy_in_user copy_in_user
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 603d736..5f17de6 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -926,41 +926,40 @@ tlb_type:	.word	0	/* Must NOT end up in BSS */
 EXPORT_SYMBOL(tlb_type)
 	.section	".fixup",#alloc,#execinstr
 
-	.globl	__retl_efault, __ret_one, __retl_one
 ENTRY(__retl_efault)
 	retl
 	 mov	-EFAULT, %o0
 ENDPROC(__retl_efault)
 
-ENTRY(__retl_one)
+ENTRY(__retl_mone)
 	retl
-	 mov	1, %o0
-ENDPROC(__retl_one)
+	 mov	-1, %o0
+ENDPROC(__retl_mone)
 
-ENTRY(__retl_one_fp)
+ENTRY(__retl_mone_fp)
 	VISExitHalf
 	retl
 	 mov	1, %o0
-ENDPROC(__retl_one_fp)
+ENDPROC(__retl_mone_fp)
 
-ENTRY(__ret_one_asi)
+ENTRY(__ret_mone_asi)
 	wr	%g0, ASI_AIUS, %asi
 	ret
 	 restore %g0, 1, %o0
-ENDPROC(__ret_one_asi)
+ENDPROC(__ret_mone_asi)
 
-ENTRY(__retl_one_asi)
+ENTRY(__retl_mone_asi)
 	wr	%g0, ASI_AIUS, %asi
 	retl
 	 mov	1, %o0
-ENDPROC(__retl_one_asi)
+ENDPROC(__retl_mone_asi)
 
-ENTRY(__retl_one_asi_fp)
+ENTRY(__retl_mone_asi_fp)
 	wr	%g0, ASI_AIUS, %asi
 	VISExitHalf
 	retl
 	 mov	1, %o0
-ENDPROC(__retl_one_asi_fp)
+ENDPROC(__retl_mone_asi_fp)
 
 ENTRY(__retl_o1)
 	retl
diff --git a/arch/sparc/lib/GENcopy_from_user.S b/arch/sparc/lib/GENcopy_from_user.S
index b7d0bd6..5bce682 100644
--- a/arch/sparc/lib/GENcopy_from_user.S
+++ b/arch/sparc/lib/GENcopy_from_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, __retl_mone;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/GENcopy_to_user.S b/arch/sparc/lib/GENcopy_to_user.S
index 780550e..f663ce3 100644
--- a/arch/sparc/lib/GENcopy_to_user.S
+++ b/arch/sparc/lib/GENcopy_to_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, __retl_mone;	\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NG2copy_from_user.S b/arch/sparc/lib/NG2copy_from_user.S
index d5242b8..4d47fa5 100644
--- a/arch/sparc/lib/NG2copy_from_user.S
+++ b/arch/sparc/lib/NG2copy_from_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi;\
+	.word 98b, __retl_mone_asi;\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi_fp;\
+	.word 98b, __retl_mone_asi_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NG2copy_to_user.S b/arch/sparc/lib/NG2copy_to_user.S
index 4e962d9..2078d75 100644
--- a/arch/sparc/lib/NG2copy_to_user.S
+++ b/arch/sparc/lib/NG2copy_to_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi;\
+	.word 98b, __retl_mone_asi;\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi_fp;\
+	.word 98b, __retl_mone_asi_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NG4copy_from_user.S b/arch/sparc/lib/NG4copy_from_user.S
index 2e8ee7a..f9746e7 100644
--- a/arch/sparc/lib/NG4copy_from_user.S
+++ b/arch/sparc/lib/NG4copy_from_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi;\
+	.word 98b, __retl_mone_asi;\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi_fp;\
+	.word 98b, __retl_mone_asi_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NG4copy_to_user.S b/arch/sparc/lib/NG4copy_to_user.S
index be0bf45..5fa4434 100644
--- a/arch/sparc/lib/NG4copy_to_user.S
+++ b/arch/sparc/lib/NG4copy_to_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi;\
+	.word 98b, __retl_mone_asi;\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_asi_fp;\
+	.word 98b, __retl_mone_asi_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NGcopy_from_user.S b/arch/sparc/lib/NGcopy_from_user.S
index 5d1e4d1..e61694c 100644
--- a/arch/sparc/lib/NGcopy_from_user.S
+++ b/arch/sparc/lib/NGcopy_from_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __ret_one_asi;\
+	.word 98b, __ret_mone_asi;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NGcopy_to_user.S b/arch/sparc/lib/NGcopy_to_user.S
index ff630dc..2d6b33d 100644
--- a/arch/sparc/lib/NGcopy_to_user.S
+++ b/arch/sparc/lib/NGcopy_to_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __ret_one_asi;\
+	.word 98b, __ret_mone_asi;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U1copy_from_user.S b/arch/sparc/lib/U1copy_from_user.S
index ecc5692..1ad59fb 100644
--- a/arch/sparc/lib/U1copy_from_user.S
+++ b/arch/sparc/lib/U1copy_from_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, __retl_mone;	\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_fp;\
+	.word 98b, __retl_mone_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U1copy_to_user.S b/arch/sparc/lib/U1copy_to_user.S
index 9eea392..adcc3a5 100644
--- a/arch/sparc/lib/U1copy_to_user.S
+++ b/arch/sparc/lib/U1copy_to_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, __retl_mone;	\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_fp;\
+	.word 98b, __retl_mone_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U3copy_from_user.S b/arch/sparc/lib/U3copy_from_user.S
index 88ad73d..1046e2b 100644
--- a/arch/sparc/lib/U3copy_from_user.S
+++ b/arch/sparc/lib/U3copy_from_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, __retl_mone;	\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_fp;\
+	.word 98b, __retl_mone_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
index 845139d..032b0c5 100644
--- a/arch/sparc/lib/U3copy_to_user.S
+++ b/arch/sparc/lib/U3copy_to_user.S
@@ -7,7 +7,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, __retl_mone;	\
 	.text;			\
 	.align 4;
 
@@ -15,7 +15,7 @@
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one_fp;\
+	.word 98b, __retl_mone_fp;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
index 482de09..86e6663 100644
--- a/arch/sparc/lib/copy_in_user.S
+++ b/arch/sparc/lib/copy_in_user.S
@@ -13,7 +13,7 @@
 98:	x,y;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, __retl_mone;	\
 	.text;			\
 	.align 4;
 
-- 
2.1.2.532.g19b5d50

