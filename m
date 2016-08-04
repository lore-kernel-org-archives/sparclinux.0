From: David Miller <davem@davemloft.net>
Date: Thu, 04 Aug 2016 00:21:04 +0000
Subject: Re: [PATCH 1/2] sparc: fix incorrect value returned by copy_from_user_fixup
Message-Id: <20160803.172104.1929607070680809818.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160801.213312.1130341044241125265.davem@davemloft.net>
	<alpine.LRH.2.02.1608020806450.8555@file01.intranet.prod.int.rdu2.redhat.com>
	<20160802.104752.527337990768683986.davem@davemloft.net>
In-Reply-To: <20160802.104752.527337990768683986.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 02 Aug 2016 10:47:52 -0700 (PDT)

> That's very interesting, let me do some research into this, as I was
> pretty sure something like futexes or similar had some requirement in
> this area.

Mikulas, just wanted to let you know where I am with this.

I looked over how this stuff works and what other architectures do
and determined that I was very wrong long ago to implement this
fixup mechanism as-coded.

The whole copy_in_user() ambiguity is a symptom of this poor design.

The best the fixup routine can do is guess and make a safe estimate,
and even with the prefetch adjustment, a future mempcy implementation
with a different max prefetch would require a change to this code all
over again.

The fact of the matter is that the code itself knows always how much
was successfully copied, in the loop iterator.

So what I'm trying to do is convert the various copy routines back to
something that uses to loop counter to (precisely) compute the return
value.

I've converted copy_in_user() and the GENmemcpy family, see below.
I'll try to do the rest over the next few days.

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index e9a51d6..1833236 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -235,20 +235,8 @@ copy_to_user(void __user *to, const void *from, unsigned long size)
 }
 #define __copy_to_user copy_to_user
 
-unsigned long __must_check ___copy_in_user(void __user *to,
-					   const void __user *from,
-					   unsigned long size);
-unsigned long copy_in_user_fixup(void __user *to, void __user *from,
-				 unsigned long size);
-static inline unsigned long __must_check
-copy_in_user(void __user *to, void __user *from, unsigned long size)
-{
-	unsigned long ret = ___copy_in_user(to, from, size);
-
-	if (unlikely(ret))
-		ret = copy_in_user_fixup(to, from, size);
-	return ret;
-}
+unsigned long __must_check copy_in_user(void __user *to, void __user *from,
+					unsigned long size);
 #define __copy_in_user copy_in_user
 
 unsigned long __must_check __clear_user(void __user *, unsigned long);
diff --git a/arch/sparc/lib/GENcopy_from_user.S b/arch/sparc/lib/GENcopy_from_user.S
index b7d0bd6..2556828 100644
--- a/arch/sparc/lib/GENcopy_from_user.S
+++ b/arch/sparc/lib/GENcopy_from_user.S
@@ -3,11 +3,11 @@
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
  */
 
-#define EX_LD(x)		\
+#define EX_LD(x,y)		\
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, y;		\
 	.text;			\
 	.align 4;
 
@@ -23,7 +23,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, ___copy_in_user;		\
+	bne,pn		%icc, copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/GENcopy_to_user.S b/arch/sparc/lib/GENcopy_to_user.S
index 780550e..1416917 100644
--- a/arch/sparc/lib/GENcopy_to_user.S
+++ b/arch/sparc/lib/GENcopy_to_user.S
@@ -3,11 +3,11 @@
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
  */
 
-#define EX_ST(x)		\
+#define EX_ST(x,y)		\
 98:	x;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, y;		\
 	.text;			\
 	.align 4;
 
@@ -27,7 +27,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, ___copy_in_user;		\
+	bne,pn		%icc, copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/GENmemcpy.S b/arch/sparc/lib/GENmemcpy.S
index 89358ee..c7ac25b 100644
--- a/arch/sparc/lib/GENmemcpy.S
+++ b/arch/sparc/lib/GENmemcpy.S
@@ -10,11 +10,11 @@
 #endif
 
 #ifndef EX_LD
-#define EX_LD(x)	x
+#define EX_LD(x,y)	x
 #endif
 
 #ifndef EX_ST
-#define EX_ST(x)	x
+#define EX_ST(x,y)	x
 #endif
 
 #ifndef EX_RETVAL
@@ -45,6 +45,21 @@
 	.register	%g3,#scratch
 
 	.text
+__retl_o4_1:
+	add	%o4, %o2, %o4
+	retl
+	 add	%o4, 1, %o0
+__retl_g1_8:
+	add	%g1, %o2, %g1
+	retl
+	 add	%g1, 8, %o0
+__retl_o2_4:
+	retl
+	 add	%o2, 4, %o0
+__retl_o2_1:
+	retl
+	 add	%o2, 1, %o0
+
 	.align		64
 
 	.globl	FUNC_NAME
@@ -73,8 +88,8 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	sub		%g0, %o4, %o4
 	sub		%o2, %o4, %o2
 1:	subcc		%o4, 1, %o4
-	EX_LD(LOAD(ldub, %o1, %g1))
-	EX_ST(STORE(stb, %g1, %o0))
+	EX_LD(LOAD(ldub, %o1, %g1),__retl_o4_1)
+	EX_ST(STORE(stb, %g1, %o0),__retl_o4_1)
 	add		%o1, 1, %o1
 	bne,pt		%XCC, 1b
 	add		%o0, 1, %o0
@@ -82,8 +97,8 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	andn		%o2, 0x7, %g1
 	sub		%o2, %g1, %o2
 1:	subcc		%g1, 0x8, %g1
-	EX_LD(LOAD(ldx, %o1, %g2))
-	EX_ST(STORE(stx, %g2, %o0))
+	EX_LD(LOAD(ldx, %o1, %g2),__retl_g1_8)
+	EX_ST(STORE(stx, %g2, %o0),__retl_g1_8)
 	add		%o1, 0x8, %o1
 	bne,pt		%XCC, 1b
 	 add		%o0, 0x8, %o0
@@ -100,8 +115,8 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 1:
 	subcc		%o2, 4, %o2
-	EX_LD(LOAD(lduw, %o1, %g1))
-	EX_ST(STORE(stw, %g1, %o1 + %o3))
+	EX_LD(LOAD(lduw, %o1, %g1),__retl_o2_4)
+	EX_ST(STORE(stw, %g1, %o1 + %o3),__retl_o2_4)
 	bgu,pt		%XCC, 1b
 	 add		%o1, 4, %o1
 
@@ -111,8 +126,8 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	.align		32
 90:
 	subcc		%o2, 1, %o2
-	EX_LD(LOAD(ldub, %o1, %g1))
-	EX_ST(STORE(stb, %g1, %o1 + %o3))
+	EX_LD(LOAD(ldub, %o1, %g1),__retl_o2_1)
+	EX_ST(STORE(stb, %g1, %o1 + %o3),__retl_o2_1)
 	bgu,pt		%XCC, 90b
 	 add		%o1, 1, %o1
 	retl
diff --git a/arch/sparc/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
index 302c0e6..6c39812 100644
--- a/arch/sparc/lib/copy_in_user.S
+++ b/arch/sparc/lib/copy_in_user.S
@@ -8,18 +8,33 @@
 
 #define XCC xcc
 
-#define EX(x,y)			\
+#define EX(x,y,z)		\
 98:	x,y;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_one;	\
+	.word 98b, z;		\
 	.text;			\
 	.align 4;
 
+#define EX_O4(x,y) EX(x,y,__retl_o4_plus_8)
+#define EX_O2_4(x,y) EX(x,y,__retl_o2_plus_4)
+#define EX_O2_1(x,y) EX(x,y,__retl_o2_plus_1)
+
 	.register	%g2,#scratch
 	.register	%g3,#scratch
 
 	.text
+__retl_o4_plus_8:
+	add	%o4, %o2, %o4
+	retl
+	 add	%o4, 8, %o0
+__retl_o2_plus_4:
+	retl
+	 add	%o2, 4, %o0
+__retl_o2_plus_1:
+	retl
+	 add	%o2, 1, %o0
+
 	.align	32
 
 	/* Don't try to get too fancy here, just nice and
@@ -28,7 +43,7 @@
 	 * to copy register windows around during thread cloning.
 	 */
 
-ENTRY(___copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
+ENTRY(copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
 	cmp		%o2, 0
 	be,pn		%XCC, 85f
 	 or		%o0, %o1, %o3
@@ -44,8 +59,8 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
 	andn		%o2, 0x7, %o4
 	and		%o2, 0x7, %o2
 1:	subcc		%o4, 0x8, %o4
-	EX(ldxa [%o1] %asi, %o5)
-	EX(stxa %o5, [%o0] %asi)
+	EX_O4(ldxa [%o1] %asi, %o5)
+	EX_O4(stxa %o5, [%o0] %asi)
 	add		%o1, 0x8, %o1
 	bgu,pt		%XCC, 1b
 	 add		%o0, 0x8, %o0
@@ -53,8 +68,8 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
 	be,pt		%XCC, 1f
 	 nop
 	sub		%o2, 0x4, %o2
-	EX(lduwa [%o1] %asi, %o5)
-	EX(stwa %o5, [%o0] %asi)
+	EX_O2_4(lduwa [%o1] %asi, %o5)
+	EX_O2_4(stwa %o5, [%o0] %asi)
 	add		%o1, 0x4, %o1
 	add		%o0, 0x4, %o0
 1:	cmp		%o2, 0
@@ -70,8 +85,8 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
 
 82:
 	subcc		%o2, 4, %o2
-	EX(lduwa [%o1] %asi, %g1)
-	EX(stwa %g1, [%o0] %asi)
+	EX_O2_4(lduwa [%o1] %asi, %g1)
+	EX_O2_4(stwa %g1, [%o0] %asi)
 	add		%o1, 4, %o1
 	bgu,pt		%XCC, 82b
 	 add		%o0, 4, %o0
@@ -82,11 +97,11 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
 	.align	32
 90:
 	subcc		%o2, 1, %o2
-	EX(lduba [%o1] %asi, %g1)
-	EX(stba %g1, [%o0] %asi)
+	EX_O2_1(lduba [%o1] %asi, %g1)
+	EX_O2_1(stba %g1, [%o0] %asi)
 	add		%o1, 1, %o1
 	bgu,pt		%XCC, 90b
 	 add		%o0, 1, %o0
 	retl
 	 clr		%o0
-ENDPROC(___copy_in_user)
+ENDPROC(copy_in_user)
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index de5e978..a6674f4 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -95,7 +95,6 @@ EXPORT_SYMBOL(ip_fast_csum);
 /* Moving data to/from/in userspace. */
 EXPORT_SYMBOL(___copy_to_user);
 EXPORT_SYMBOL(___copy_from_user);
-EXPORT_SYMBOL(___copy_in_user);
 EXPORT_SYMBOL(__clear_user);
 
 /* Atomic counter implementation. */
diff --git a/arch/sparc/lib/user_fixup.c b/arch/sparc/lib/user_fixup.c
index ac96ae2..49737d9 100644
--- a/arch/sparc/lib/user_fixup.c
+++ b/arch/sparc/lib/user_fixup.c
@@ -51,21 +51,3 @@ unsigned long copy_to_user_fixup(void __user *to, const void *from, unsigned lon
 	return compute_size((unsigned long) to, size, &offset);
 }
 EXPORT_SYMBOL(copy_to_user_fixup);
-
-unsigned long copy_in_user_fixup(void __user *to, void __user *from, unsigned long size)
-{
-	unsigned long fault_addr = current_thread_info()->fault_address;
-	unsigned long start = (unsigned long) to;
-	unsigned long end = start + size;
-
-	if (fault_addr >= start && fault_addr < end)
-		return end - fault_addr;
-
-	start = (unsigned long) from;
-	end = start + size;
-	if (fault_addr >= start && fault_addr < end)
-		return end - fault_addr;
-
-	return size;
-}
-EXPORT_SYMBOL(copy_in_user_fixup);
