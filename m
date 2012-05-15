From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 18:37:48 +0000
Subject: [PATCH 2/2] sparc32: Kill off software 32-bit multiply/divide routines.
Message-Id: <20120515.143748.225092224634923633.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


For the explicit calls to .udiv/.umul in assembler, I made a
mechanical (read as: safe) transformation.  I didn't attempt
to make any simplifications.

In particular, __ndelay and __udelay can be simplified significantly.
Some of the %y reads are unnecessary and these routines have no need
any longer for allocating a register window, they can be leaf
functions.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S    |   27 +--
 arch/sparc/kernel/head_32.S  |   45 -----
 arch/sparc/kernel/kernel.h   |    3 -
 arch/sparc/kernel/module.c   |   21 +--
 arch/sparc/kernel/muldiv.c   |  238 --------------------------
 arch/sparc/kernel/traps_32.c |    2 -
 arch/sparc/lib/Makefile      |    2 +-
 arch/sparc/lib/divdi3.S      |    4 +-
 arch/sparc/lib/ksyms.c       |   17 --
 arch/sparc/lib/mul.S         |  137 ---------------
 arch/sparc/lib/muldi3.S      |    4 +-
 arch/sparc/lib/rem.S         |  384 --------------------------------------=
----
 arch/sparc/lib/sdiv.S        |  381 --------------------------------------=
---
 arch/sparc/lib/udiv.S        |  357 ---------------------------------------
 arch/sparc/lib/udivdi3.S     |    3 +-
 arch/sparc/lib/umul.S        |  171 -------------------
 arch/sparc/lib/urem.S        |  357 ---------------------------------------
 17 files changed, 24 insertions(+), 2129 deletions(-)
 delete mode 100644 arch/sparc/kernel/muldiv.c
 delete mode 100644 arch/sparc/lib/mul.S
 delete mode 100644 arch/sparc/lib/rem.S
 delete mode 100644 arch/sparc/lib/sdiv.S
 delete mode 100644 arch/sparc/lib/udiv.S
 delete mode 100644 arch/sparc/lib/umul.S
 delete mode 100644 arch/sparc/lib/urem.S

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 773f3f0..3f3976e 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1161,11 +1161,13 @@ fpload:
 	.globl	__ndelay
 __ndelay:
 	save	%sp, -STACKFRAME_SZ, %sp
-	mov	%i0, %o0
-	call	.umul			! round multiplier up so large ns ok
-	 mov	0x1ae, %o1		! 2**32 / (1 000 000 000 / HZ)
-	call	.umul
-	 mov	%i1, %o1		! udelay_val
+	mov	%i0, %o0		! round multiplier up so large ns ok
+	mov	0x1ae, %o1		! 2**32 / (1 000 000 000 / HZ)
+	umul	%o0, %o1, %o0
+	rd	%y, %o1
+	mov	%i1, %o1		! udelay_val
+	umul	%o0, %o1, %o0
+	rd	%y, %o1
 	ba	delay_continue
 	 mov	%o1, %o0		! >>32 later for better resolution
=20
@@ -1174,18 +1176,21 @@ __udelay:
 	save	%sp, -STACKFRAME_SZ, %sp
 	mov	%i0, %o0
 	sethi	%hi(0x10c7), %o1	! round multiplier up so large us ok
-	call	.umul
-	 or	%o1, %lo(0x10c7), %o1	! 2**32 / 1 000 000
-	call	.umul
-	 mov	%i1, %o1		! udelay_val
+	or	%o1, %lo(0x10c7), %o1	! 2**32 / 1 000 000
+	umul	%o0, %o1, %o0
+	rd	%y, %o1
+	mov	%i1, %o1		! udelay_val
+	umul	%o0, %o1, %o0
+	rd	%y, %o1
 	sethi	%hi(0x028f4b62), %l0	! Add in rounding constant * 2**32,
 	or	%g0, %lo(0x028f4b62), %l0
 	addcc	%o0, %l0, %o0		! 2**32 * 0.009 999
 	bcs,a	3f
 	 add	%o1, 0x01, %o1
 3:
-	call	.umul
-	 mov	HZ, %o0			! >>32 earlier for wider range
+	mov	HZ, %o0			! >>32 earlier for wider range
+	umul	%o0, %o1, %o0
+	rd	%y, %o1
=20
 delay_continue:
 	cmp	%o0, 0x0
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 6c95e9f..69645ca 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -746,51 +746,6 @@ sun4d_init:
 	/* Fall through to sun4m_init */
=20
 sun4m_init:
-
-#define PATCH_IT(dst, src)	\
-	set	(dst), %g5;	\
-	set	(src), %g4;	\
-	ld	[%g4], %g3;	\
-	st	%g3, [%g5];	\
-	ld	[%g4+0x4], %g3;	\
-	st	%g3, [%g5+0x4];
-
-	/* Signed multiply. */
-	PATCH_IT(.mul, .mul_patch)
-	PATCH_IT(.mul+0x08, .mul_patch+0x08)
-
-	/* Signed remainder. */
-	PATCH_IT(.rem, .rem_patch)
-	PATCH_IT(.rem+0x08, .rem_patch+0x08)
-	PATCH_IT(.rem+0x10, .rem_patch+0x10)
-	PATCH_IT(.rem+0x18, .rem_patch+0x18)
-	PATCH_IT(.rem+0x20, .rem_patch+0x20)
-	PATCH_IT(.rem+0x28, .rem_patch+0x28)
-
-	/* Signed division. */
-	PATCH_IT(.div, .div_patch)
-	PATCH_IT(.div+0x08, .div_patch+0x08)
-	PATCH_IT(.div+0x10, .div_patch+0x10)
-	PATCH_IT(.div+0x18, .div_patch+0x18)
-	PATCH_IT(.div+0x20, .div_patch+0x20)
-
-	/* Unsigned multiply. */
-	PATCH_IT(.umul, .umul_patch)
-	PATCH_IT(.umul+0x08, .umul_patch+0x08)
-
-	/* Unsigned remainder. */
-	PATCH_IT(.urem, .urem_patch)
-	PATCH_IT(.urem+0x08, .urem_patch+0x08)
-	PATCH_IT(.urem+0x10, .urem_patch+0x10)
-	PATCH_IT(.urem+0x18, .urem_patch+0x18)
-
-	/* Unsigned division. */
-	PATCH_IT(.udiv, .udiv_patch)
-	PATCH_IT(.udiv+0x08, .udiv_patch+0x08)
-	PATCH_IT(.udiv+0x10, .udiv_patch+0x10)
-
-#undef PATCH_IT
-
 /* Ok, the PROM could have done funny things and apple cider could still
  * be sitting in the fault status/address registers.  Read them all to
  * clear them so we don't get magic faults later on.
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 1c1a7d3..a86372d 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -32,9 +32,6 @@ extern void cpu_probe(void);
 /* traps_32.c */
 extern void handle_hw_divzero(struct pt_regs *regs, unsigned long pc,
                               unsigned long npc, unsigned long psr);
-/* muldiv.c */
-extern int do_user_muldiv (struct pt_regs *, unsigned long);
-
 /* irq_32.c */
 extern struct irqaction static_irqaction[];
 extern int static_irq_count;
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 276359e..15e0a16 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -32,26 +32,11 @@ static void *module_map(unsigned long size)
 				GFP_KERNEL, PAGE_KERNEL, -1,
 				__builtin_return_address(0));
 }
-
-static char *dot2underscore(char *name)
-{
-	return name;
-}
 #else
 static void *module_map(unsigned long size)
 {
 	return vmalloc(size);
 }
-
-/* Replace references to .func with _Func */
-static char *dot2underscore(char *name)
-{
-	if (name[0] =3D '.') {
-		name[0] =3D '_';
-                name[1] =3D toupper(name[1]);
-	}
-	return name;
-}
 #endif /* CONFIG_SPARC64 */
=20
 void *module_alloc(unsigned long size)
@@ -93,12 +78,8 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
=20
 	for (i =3D 1; i < sechdrs[symidx].sh_size / sizeof(Elf_Sym); i++) {
 		if (sym[i].st_shndx =3D SHN_UNDEF) {
-			if (ELF_ST_TYPE(sym[i].st_info) =3D STT_REGISTER) {
+			if (ELF_ST_TYPE(sym[i].st_info) =3D STT_REGISTER)
 				sym[i].st_shndx =3D SHN_ABS;
-			} else {
-				char *name =3D strtab + sym[i].st_name;
-				dot2underscore(name);
-			}
 		}
 	}
 	return 0;
diff --git a/arch/sparc/kernel/muldiv.c b/arch/sparc/kernel/muldiv.c
deleted file mode 100644
index f7db516..0000000
--- a/arch/sparc/kernel/muldiv.c
+++ /dev/null
@@ -1,238 +0,0 @@
-/*
- * muldiv.c: Hardware multiply/division illegal instruction trap
- *		for sun4c/sun4 (which do not have those instructions)
- *
- * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- *
- * 2004-12-25	Krzysztof Helt (krzysztof.h1@wp.pl)=20
- *		- fixed registers constrains in inline assembly declarations
- */
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-#include <asm/uaccess.h>
-
-#include "kernel.h"
-
-/* #define DEBUG_MULDIV */
-
-static inline int has_imm13(int insn)
-{
-	return (insn & 0x2000);
-}
-
-static inline int is_foocc(int insn)
-{
-	return (insn & 0x800000);
-}
-
-static inline int sign_extend_imm13(int imm)
-{
-	return imm << 19 >> 19;
-}
-
-static inline void advance(struct pt_regs *regs)
-{
-	regs->pc   =3D regs->npc;
-	regs->npc +=3D 4;
-}
-
-static inline void maybe_flush_windows(unsigned int rs1, unsigned int rs2,
-				       unsigned int rd)
-{
-	if(rs2 >=3D 16 || rs1 >=3D 16 || rd >=3D 16) {
-		/* Wheee... */
-		__asm__ __volatile__("save %sp, -0x40, %sp\n\t"
-				     "save %sp, -0x40, %sp\n\t"
-				     "save %sp, -0x40, %sp\n\t"
-				     "save %sp, -0x40, %sp\n\t"
-				     "save %sp, -0x40, %sp\n\t"
-				     "save %sp, -0x40, %sp\n\t"
-				     "save %sp, -0x40, %sp\n\t"
-				     "restore; restore; restore; restore;\n\t"
-				     "restore; restore; restore;\n\t");
-	}
-}
-
-#define fetch_reg(reg, regs) ({						\
-	struct reg_window32 __user *win;					\
-	register unsigned long ret;					\
-									\
-	if (!(reg)) ret =3D 0;						\
-	else if ((reg) < 16) {						\
-		ret =3D regs->u_regs[(reg)];				\
-	} else {							\
-		/* Ho hum, the slightly complicated case. */		\
-		win =3D (struct reg_window32 __user *)regs->u_regs[UREG_FP];\
-		if (get_user (ret, &win->locals[(reg) - 16])) return -1;\
-	}								\
-	ret;								\
-})
-
-static inline int
-store_reg(unsigned int result, unsigned int reg, struct pt_regs *regs)
-{
-	struct reg_window32 __user *win;
-
-	if (!reg)
-		return 0;
-	if (reg < 16) {
-		regs->u_regs[reg] =3D result;
-		return 0;
-	} else {
-		/* need to use put_user() in this case: */
-		win =3D (struct reg_window32 __user *) regs->u_regs[UREG_FP];
-		return (put_user(result, &win->locals[reg - 16]));
-	}
-}
-
-/* Should return 0 if mul/div emulation succeeded and SIGILL should
- * not be issued.
- */
-int do_user_muldiv(struct pt_regs *regs, unsigned long pc)
-{
-	unsigned int insn;
-	int inst;
-	unsigned int rs1, rs2, rdv;
-
-	if (!pc)
-		return -1; /* This happens to often, I think */
-	if (get_user (insn, (unsigned int __user *)pc))
-		return -1;
-	if ((insn & 0xc1400000) !=3D 0x80400000)
-		return -1;
-	inst =3D ((insn >> 19) & 0xf);
-	if ((inst & 0xe) !=3D 10 && (inst & 0xe) !=3D 14)
-		return -1;
-
-	/* Now we know we have to do something with umul, smul, udiv or sdiv */
-	rs1 =3D (insn >> 14) & 0x1f;
-	rs2 =3D insn & 0x1f;
-	rdv =3D (insn >> 25) & 0x1f;
-	if (has_imm13(insn)) {
-		maybe_flush_windows(rs1, 0, rdv);
-		rs2 =3D sign_extend_imm13(insn);
-	} else {
-		maybe_flush_windows(rs1, rs2, rdv);
-		rs2 =3D fetch_reg(rs2, regs);
-	}
-	rs1 =3D fetch_reg(rs1, regs);
-	switch (inst) {
-	case 10: /* umul */
-#ifdef DEBUG_MULDIV=09
-		printk ("unsigned muldiv: 0x%x * 0x%x =3D ", rs1, rs2);
-#endif	=09
-		__asm__ __volatile__ ("\n\t"
-			"mov	%0, %%o0\n\t"
-			"call	.umul\n\t"
-			" mov	%1, %%o1\n\t"
-			"mov	%%o0, %0\n\t"
-			"mov	%%o1, %1\n\t"
-			: "=3Dr" (rs1), "=3Dr" (rs2)
-		        : "0" (rs1), "1" (rs2)
-			: "o0", "o1", "o2", "o3", "o4", "o5", "o7", "cc");
-#ifdef DEBUG_MULDIV
-		printk ("0x%x%08x\n", rs2, rs1);
-#endif
-		if (store_reg(rs1, rdv, regs))
-			return -1;
-		regs->y =3D rs2;
-		break;
-	case 11: /* smul */
-#ifdef DEBUG_MULDIV
-		printk ("signed muldiv: 0x%x * 0x%x =3D ", rs1, rs2);
-#endif
-		__asm__ __volatile__ ("\n\t"
-			"mov	%0, %%o0\n\t"
-			"call	.mul\n\t"
-			" mov	%1, %%o1\n\t"
-			"mov	%%o0, %0\n\t"
-			"mov	%%o1, %1\n\t"
-			: "=3Dr" (rs1), "=3Dr" (rs2)
-		        : "0" (rs1), "1" (rs2)
-			: "o0", "o1", "o2", "o3", "o4", "o5", "o7", "cc");
-#ifdef DEBUG_MULDIV
-		printk ("0x%x%08x\n", rs2, rs1);
-#endif
-		if (store_reg(rs1, rdv, regs))
-			return -1;
-		regs->y =3D rs2;
-		break;
-	case 14: /* udiv */
-#ifdef DEBUG_MULDIV
-		printk ("unsigned muldiv: 0x%x%08x / 0x%x =3D ", regs->y, rs1, rs2);
-#endif
-		if (!rs2) {
-#ifdef DEBUG_MULDIV
-			printk ("DIVISION BY ZERO\n");
-#endif
-			handle_hw_divzero (regs, pc, regs->npc, regs->psr);
-			return 0;
-		}
-		__asm__ __volatile__ ("\n\t"
-			"mov	%2, %%o0\n\t"
-			"mov	%0, %%o1\n\t"
-			"mov	%%g0, %%o2\n\t"
-			"call	__udivdi3\n\t"
-			" mov	%1, %%o3\n\t"
-			"mov	%%o1, %0\n\t"
-			"mov	%%o0, %1\n\t"
-			: "=3Dr" (rs1), "=3Dr" (rs2)
-			: "r" (regs->y), "0" (rs1), "1" (rs2)
-			: "o0", "o1", "o2", "o3", "o4", "o5", "o7",
-			  "g1", "g2", "g3", "cc");
-#ifdef DEBUG_MULDIV
-		printk ("0x%x\n", rs1);
-#endif
-		if (store_reg(rs1, rdv, regs))
-			return -1;
-		break;
-	case 15: /* sdiv */
-#ifdef DEBUG_MULDIV
-		printk ("signed muldiv: 0x%x%08x / 0x%x =3D ", regs->y, rs1, rs2);
-#endif
-		if (!rs2) {
-#ifdef DEBUG_MULDIV
-			printk ("DIVISION BY ZERO\n");
-#endif
-			handle_hw_divzero (regs, pc, regs->npc, regs->psr);
-			return 0;
-		}
-		__asm__ __volatile__ ("\n\t"
-			"mov	%2, %%o0\n\t"
-			"mov	%0, %%o1\n\t"
-			"mov	%%g0, %%o2\n\t"
-			"call	__divdi3\n\t"
-			" mov	%1, %%o3\n\t"
-			"mov	%%o1, %0\n\t"
-			"mov	%%o0, %1\n\t"
-			: "=3Dr" (rs1), "=3Dr" (rs2)
-			: "r" (regs->y), "0" (rs1), "1" (rs2)
-			: "o0", "o1", "o2", "o3", "o4", "o5", "o7",
-			  "g1", "g2", "g3", "cc");
-#ifdef DEBUG_MULDIV
-		printk ("0x%x\n", rs1);
-#endif
-		if (store_reg(rs1, rdv, regs))
-			return -1;
-		break;
-	}
-	if (is_foocc (insn)) {
-		regs->psr &=3D ~PSR_ICC;
-		if ((inst & 0xe) =3D 14) {
-			/* ?div */
-			if (rs2) regs->psr |=3D PSR_V;
-		}
-		if (!rs1) regs->psr |=3D PSR_Z;
-		if (((int)rs1) < 0) regs->psr |=3D PSR_N;
-#ifdef DEBUG_MULDIV
-		printk ("psr muldiv: %08x\n", regs->psr);
-#endif
-	}
-	advance(regs);
-	return 0;
-}
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index d2de213..a5785ea 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -120,8 +120,6 @@ void do_illegal_instruction(struct pt_regs *regs, unsig=
ned long pc, unsigned lon
 	printk("Ill instr. at pc=3D%08lx instruction is %08lx\n",
 	       regs->pc, *(unsigned long *)regs->pc);
 #endif
-	if (!do_user_muldiv (regs, pc))
-		return;
=20
 	info.si_signo =3D SIGILL;
 	info.si_errno =3D 0;
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 33d8d85..ead6df2 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -4,7 +4,7 @@
 asflags-y :=3D -ansi -DST_DIV0=3D0x02
 ccflags-y :=3D -Werror
=20
-lib-$(CONFIG_SPARC32) +=3D mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3=
.o
+lib-$(CONFIG_SPARC32) +=3D ashrdi3.o
 lib-$(CONFIG_SPARC32) +=3D memcpy.o memset.o
 lib-y                 +=3D strlen.o
 lib-y                 +=3D checksum_$(BITS).o
diff --git a/arch/sparc/lib/divdi3.S b/arch/sparc/lib/divdi3.S
index d74bc09..9614b48 100644
--- a/arch/sparc/lib/divdi3.S
+++ b/arch/sparc/lib/divdi3.S
@@ -19,7 +19,6 @@ Boston, MA 02111-1307, USA.  */
=20
 	.text
 	.align 4
-	.global .udiv
 	.globl __divdi3
 __divdi3:
 	save %sp,-104,%sp
@@ -83,8 +82,9 @@ __divdi3:
 	bne .LL85
 	mov %i0,%o2
 	mov 1,%o0
-	call .udiv,0
 	mov 0,%o1
+	wr %g0, 0, %y
+	udiv %o0, %o1, %o0
 	mov %o0,%o4
 	mov %i0,%o2
 .LL85:
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index 1bc8972..2dc3087 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -61,16 +61,6 @@ extern void ___rw_read_try(void);
 extern void ___rw_read_exit(void);
 extern void ___rw_write_enter(void);
=20
-/* Alias functions whose names begin with "." and export the aliases.
- * The module references will be fixed up by module_frob_arch_sections.
- */
-extern int _Div(int, int);
-extern int _Mul(int, int);
-extern int _Rem(int, int);
-extern unsigned _Udiv(unsigned, unsigned);
-extern unsigned _Umul(unsigned, unsigned);
-extern unsigned _Urem(unsigned, unsigned);
-
 /* Networking helper routines. */
 EXPORT_SYMBOL(__csum_partial_copy_sparc_generic);
=20
@@ -95,13 +85,6 @@ EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__muldi3);
 EXPORT_SYMBOL(__divdi3);
-
-EXPORT_SYMBOL(_Rem);
-EXPORT_SYMBOL(_Urem);
-EXPORT_SYMBOL(_Mul);
-EXPORT_SYMBOL(_Umul);
-EXPORT_SYMBOL(_Div);
-EXPORT_SYMBOL(_Udiv);
 #endif
=20
 /*
diff --git a/arch/sparc/lib/mul.S b/arch/sparc/lib/mul.S
deleted file mode 100644
index c45470d..0000000
--- a/arch/sparc/lib/mul.S
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * mul.S:       This routine was taken from glibc-1.09 and is covered
- *              by the GNU Library General Public License Version 2.
- */
-
-/*
- * Signed multiply, from Appendix E of the Sparc Version 8
- * Architecture Manual.
- */
-
-/*
- * Returns %o0 * %o1 in %o1%o0 (i.e., %o1 holds the upper 32 bits of
- * the 64-bit product).
- *
- * This code optimizes short (less than 13-bit) multiplies.
- */
-
-	.globl .mul
-	.globl _Mul
-.mul:
-_Mul:	/* needed for export */
-	mov	%o0, %y		! multiplier -> Y
-	andncc	%o0, 0xfff, %g0	! test bits 12..31
-	be	Lmul_shortway	! if zero, can do it the short way
-	 andcc	%g0, %g0, %o4	! zero the partial product and clear N and V
-
-	/*
-	 * Long multiply.  32 steps, followed by a final shift step.
-	 */
-	mulscc	%o4, %o1, %o4	! 1
-	mulscc	%o4, %o1, %o4	! 2
-	mulscc	%o4, %o1, %o4	! 3
-	mulscc	%o4, %o1, %o4	! 4
-	mulscc	%o4, %o1, %o4	! 5
-	mulscc	%o4, %o1, %o4	! 6
-	mulscc	%o4, %o1, %o4	! 7
-	mulscc	%o4, %o1, %o4	! 8
-	mulscc	%o4, %o1, %o4	! 9
-	mulscc	%o4, %o1, %o4	! 10
-	mulscc	%o4, %o1, %o4	! 11
-	mulscc	%o4, %o1, %o4	! 12
-	mulscc	%o4, %o1, %o4	! 13
-	mulscc	%o4, %o1, %o4	! 14
-	mulscc	%o4, %o1, %o4	! 15
-	mulscc	%o4, %o1, %o4	! 16
-	mulscc	%o4, %o1, %o4	! 17
-	mulscc	%o4, %o1, %o4	! 18
-	mulscc	%o4, %o1, %o4	! 19
-	mulscc	%o4, %o1, %o4	! 20
-	mulscc	%o4, %o1, %o4	! 21
-	mulscc	%o4, %o1, %o4	! 22
-	mulscc	%o4, %o1, %o4	! 23
-	mulscc	%o4, %o1, %o4	! 24
-	mulscc	%o4, %o1, %o4	! 25
-	mulscc	%o4, %o1, %o4	! 26
-	mulscc	%o4, %o1, %o4	! 27
-	mulscc	%o4, %o1, %o4	! 28
-	mulscc	%o4, %o1, %o4	! 29
-	mulscc	%o4, %o1, %o4	! 30
-	mulscc	%o4, %o1, %o4	! 31
-	mulscc	%o4, %o1, %o4	! 32
-	mulscc	%o4, %g0, %o4	! final shift
-
-	! If %o0 was negative, the result is
-	!	(%o0 * %o1) + (%o1 << 32))
-	! We fix that here.
-
-#if 0
-	tst	%o0
-	bge	1f
-	 rd	%y, %o0
-
-	! %o0 was indeed negative; fix upper 32 bits of result by subtracting=20
-	! %o1 (i.e., return %o4 - %o1 in %o1).
-	retl
-	 sub	%o4, %o1, %o1
-
-1:
-	retl
-	 mov	%o4, %o1
-#else
-	/* Faster code adapted from tege@sics.se's code for umul.S.  */
-	sra	%o0, 31, %o2	! make mask from sign bit
-	and	%o1, %o2, %o2	! %o2 =3D 0 or %o1, depending on sign of %o0
-	rd	%y, %o0		! get lower half of product
-	retl
-	 sub	%o4, %o2, %o1	! subtract compensation=20
-				!  and put upper half in place
-#endif
-
-Lmul_shortway:
-	/*
-	 * Short multiply.  12 steps, followed by a final shift step.
-	 * The resulting bits are off by 12 and (32-12) =3D 20 bit positions,
-	 * but there is no problem with %o0 being negative (unlike above).
-	 */
-	mulscc	%o4, %o1, %o4	! 1
-	mulscc	%o4, %o1, %o4	! 2
-	mulscc	%o4, %o1, %o4	! 3
-	mulscc	%o4, %o1, %o4	! 4
-	mulscc	%o4, %o1, %o4	! 5
-	mulscc	%o4, %o1, %o4	! 6
-	mulscc	%o4, %o1, %o4	! 7
-	mulscc	%o4, %o1, %o4	! 8
-	mulscc	%o4, %o1, %o4	! 9
-	mulscc	%o4, %o1, %o4	! 10
-	mulscc	%o4, %o1, %o4	! 11
-	mulscc	%o4, %o1, %o4	! 12
-	mulscc	%o4, %g0, %o4	! final shift
-
-	/*
-	 *  %o4 has 20 of the bits that should be in the low part of the
-	 * result; %y has the bottom 12 (as %y's top 12).  That is:
-	 *
-	 *	  %o4		    %y
-	 * +----------------+----------------+
-	 * | -12- |   -20-  | -12- |   -20-  |
-	 * +------(---------+------)---------+
-	 *  --hi-- ----low-part----
-	 *
-	 * The upper 12 bits of %o4 should be sign-extended to form the
-	 * high part of the product (i.e., highpart =3D %o4 >> 20).
-	 */
-
-	rd	%y, %o5
-	sll	%o4, 12, %o0	! shift middle bits left 12
-	srl	%o5, 20, %o5	! shift low bits right 20, zero fill at left
-	or	%o5, %o0, %o0	! construct low part of result
-	retl
-	 sra	%o4, 20, %o1	! ... and extract high part of result
-
-	.globl	.mul_patch
-.mul_patch:
-	smul	%o0, %o1, %o0
-	retl
-	 rd	%y, %o1
-	nop
diff --git a/arch/sparc/lib/muldi3.S b/arch/sparc/lib/muldi3.S
index 7f17872..9794939 100644
--- a/arch/sparc/lib/muldi3.S
+++ b/arch/sparc/lib/muldi3.S
@@ -63,12 +63,12 @@ __muldi3:
 	rd  %y, %o1
 	mov  %o1, %l3
 	mov  %i1, %o0
-	call  .umul
 	mov  %i2, %o1
+	umul %o0, %o1, %o0
 	mov  %o0, %l0
 	mov  %i0, %o0
-	call  .umul
 	mov  %i3, %o1
+	umul %o0, %o1, %o0
 	add  %l0, %o0, %l0
 	mov  %l2, %i0
 	add  %l2, %l0, %i0
diff --git a/arch/sparc/lib/rem.S b/arch/sparc/lib/rem.S
deleted file mode 100644
index 42fb862..0000000
--- a/arch/sparc/lib/rem.S
+++ /dev/null
@@ -1,384 +0,0 @@
-/*
- * rem.S:       This routine was taken from glibc-1.09 and is covered
- *              by the GNU Library General Public License Version 2.
- */
-
-
-/* This file is generated from divrem.m4; DO NOT EDIT! */
-/*
- * Division and remainder, from Appendix E of the Sparc Version 8
- * Architecture Manual, with fixes from Gordon Irlam.
- */
-
-/*
- * Input: dividend and divisor in %o0 and %o1 respectively.
- *
- * m4 parameters:
- *  .rem	name of function to generate
- *  rem		rem=3Ddiv =3D> %o0 / %o1; rem=3Drem =3D> %o0 % %o1
- *  true		true=3Dtrue =3D> signed; true=FAlse =3D> unsigned
- *
- * Algorithm parameters:
- *  N		how many bits per iteration we try to get (4)
- *  WORDSIZE	total number of bits (32)
- *
- * Derived constants:
- *  TOPBITS	number of bits in the top decade of a number
- *
- * Important variables:
- *  Q		the partial quotient under development (initially 0)
- *  R		the remainder so far, initially the dividend
- *  ITER	number of main division loop iterations required;
- *		equal to ceil(log2(quotient) / N).  Note that this
- *		is the log base (2^N) of the quotient.
- *  V		the current comparand, initially divisor*2^(ITER*N-1)
- *
- * Cost:
- *  Current estimate for non-large dividend is
- *	ceil(log2(quotient) / N) * (10 + 7N/2) + C
- *  A large dividend is one greater than 2^(31-TOPBITS) and takes a
- *  different path, as the upper bits of the quotient must be developed
- *  one bit at a time.
- */
-
-
-	.globl .rem
-	.globl _Rem
-.rem:
-_Rem:	/* needed for export */
-	! compute sign of result; if neither is negative, no problem
-	orcc	%o1, %o0, %g0	! either negative?
-	bge	2f			! no, go do the divide
-	 mov	%o0, %g2	! compute sign in any case
-
-	tst	%o1
-	bge	1f
-	 tst	%o0
-	! %o1 is definitely negative; %o0 might also be negative
-	bge	2f			! if %o0 not negative...
-	 sub	%g0, %o1, %o1	! in any case, make %o1 nonneg
-1:	! %o0 is negative, %o1 is nonnegative
-	sub	%g0, %o0, %o0	! make %o0 nonnegative
-2:
-
-	! Ready to divide.  Compute size of quotient; scale comparand.
-	orcc	%o1, %g0, %o5
-	bne	1f
-	 mov	%o0, %o3
-
-		! Divide by zero trap.  If it returns, return 0 (about as
-		! wrong as possible, but that is what SunOS does...).
-		ta	ST_DIV0
-		retl
-		 clr	%o0
-
-1:
-	cmp	%o3, %o5			! if %o1 exceeds %o0, done
-	blu	Lgot_result		! (and algorithm fails otherwise)
-	 clr	%o2
-
-	sethi	%hi(1 << (32 - 4 - 1)), %g1
-
-	cmp	%o3, %g1
-	blu	Lnot_really_big
-	 clr	%o4
-
-	! Here the dividend is >=3D 2**(31-N) or so.  We must be careful here,
-	! as our usual N-at-a-shot divide step will cause overflow and havoc.
-	! The number of bits in the result here is N*ITER+SC, where SC <=3D N.
-	! Compute ITER in an unorthodox manner: know we need to shift V into
-	! the top decade: so do not even bother to compare to R.
-	1:
-		cmp	%o5, %g1
-		bgeu	3f
-		 mov	1, %g7
-
-		sll	%o5, 4, %o5
-
-		b	1b
-		 add	%o4, 1, %o4
-
-	! Now compute %g7.
-	2:
-		addcc	%o5, %o5, %o5
-
-		bcc	Lnot_too_big
-		 add	%g7, 1, %g7
-
-		! We get here if the %o1 overflowed while shifting.
-		! This means that %o3 has the high-order bit set.
-		! Restore %o5 and subtract from %o3.
-		sll	%g1, 4, %g1	! high order bit
-		srl	%o5, 1, %o5		! rest of %o5
-		add	%o5, %g1, %o5
-
-		b	Ldo_single_div
-		 sub	%g7, 1, %g7
-
-	Lnot_too_big:
-	3:
-		cmp	%o5, %o3
-		blu	2b
-		 nop
-
-		be	Ldo_single_div
-		 nop
-	/* NB: these are commented out in the V8-Sparc manual as well */
-	/* (I do not understand this) */
-	! %o5 > %o3: went too far: back up 1 step
-	!	srl	%o5, 1, %o5
-	!	dec	%g7
-	! do single-bit divide steps
-	!
-	! We have to be careful here.  We know that %o3 >=3D %o5, so we can do the
-	! first divide step without thinking.  BUT, the others are conditional,
-	! and are only done if %o3 >=3D 0.  Because both %o3 and %o5 may have the=
 high-
-	! order bit set in the first step, just falling into the regular
-	! division loop will mess up the first time around.
-	! So we unroll slightly...
-	Ldo_single_div:
-		subcc	%g7, 1, %g7
-		bl	Lend_regular_divide
-		 nop
-
-		sub	%o3, %o5, %o3
-		mov	1, %o2
-
-		b	Lend_single_divloop
-		 nop
-	Lsingle_divloop:
-		sll	%o2, 1, %o2
-
-		bl	1f
-		 srl	%o5, 1, %o5
-		! %o3 >=3D 0
-		sub	%o3, %o5, %o3
-
-		b	2f
-		 add	%o2, 1, %o2
-	1:	! %o3 < 0
-		add	%o3, %o5, %o3
-		sub	%o2, 1, %o2
-	2:
-	Lend_single_divloop:
-		subcc	%g7, 1, %g7
-		bge	Lsingle_divloop
-		 tst	%o3
-
-		b,a	Lend_regular_divide
-
-Lnot_really_big:
-1:
-	sll	%o5, 4, %o5
-	cmp	%o5, %o3
-	bleu	1b
-	 addcc	%o4, 1, %o4
-	be	Lgot_result
-	 sub	%o4, 1, %o4
-
-	tst	%o3	! set up for initial iteration
-Ldivloop:
-	sll	%o2, 4, %o2
-		! depth 1, accumulated bits 0
-	bl	L.1.16
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 2, accumulated bits 1
-	bl	L.2.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 3
-	bl	L.3.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 7
-	bl	L.4.23
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-
-	b	9f
-	 add	%o2, (7*2+1), %o2
-=09
-L.4.23:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (7*2-1), %o2
-=09
-L.3.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 5
-	bl	L.4.21
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2+1), %o2
-=09
-L.4.21:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2-1), %o2
-=09
-L.2.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 1
-	bl	L.3.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 3
-	bl	L.4.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2+1), %o2
-
-L.4.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2-1), %o2
-
-L.3.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 1
-	bl	L.4.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2+1), %o2
-
-L.4.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2-1), %o2
-
-L.1.16:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 2, accumulated bits -1
-	bl	L.2.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -1
-	bl	L.3.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -1
-	bl	L.4.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2+1), %o2
-
-L.4.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2-1), %o2
-
-L.3.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -3
-	bl	L.4.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2+1), %o2
-
-L.4.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2-1), %o2
-
-L.2.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -3
-	bl	L.3.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -5
-	bl	L.4.11
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2+1), %o2
-
-L.4.11:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2-1), %o2
-
-
-L.3.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -7
-	bl	L.4.9
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2+1), %o2
-
-L.4.9:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2-1), %o2
-
-	9:
-Lend_regular_divide:
-	subcc	%o4, 1, %o4
-	bge	Ldivloop
-	 tst	%o3
-
-	bl,a	Lgot_result
-	! non-restoring fixup here (one instruction only!)
-	add	%o3, %o1, %o3
-
-Lgot_result:
-	! check to see if answer should be < 0
-	tst	%g2
-	bl,a	1f
-	 sub %g0, %o3, %o3
-1:
-	retl
-	 mov %o3, %o0
-
-	.globl	.rem_patch
-.rem_patch:
-	sra	%o0, 0x1f, %o4
-	wr	%o4, 0x0, %y
-	nop
-	nop
-	nop
-	sdivcc	%o0, %o1, %o2
-	bvs,a	1f
-	 xnor	%o2, %g0, %o2
-1:	smul	%o2, %o1, %o2
-	retl
-	 sub	%o0, %o2, %o0
-	nop
diff --git a/arch/sparc/lib/sdiv.S b/arch/sparc/lib/sdiv.S
deleted file mode 100644
index f0a0d4e..0000000
--- a/arch/sparc/lib/sdiv.S
+++ /dev/null
@@ -1,381 +0,0 @@
-/*
- * sdiv.S:      This routine was taken from glibc-1.09 and is covered
- *              by the GNU Library General Public License Version 2.
- */
-
-
-/* This file is generated from divrem.m4; DO NOT EDIT! */
-/*
- * Division and remainder, from Appendix E of the Sparc Version 8
- * Architecture Manual, with fixes from Gordon Irlam.
- */
-
-/*
- * Input: dividend and divisor in %o0 and %o1 respectively.
- *
- * m4 parameters:
- *  .div	name of function to generate
- *  div		div=3Ddiv =3D> %o0 / %o1; div=3Drem =3D> %o0 % %o1
- *  true		true=3Dtrue =3D> signed; true=FAlse =3D> unsigned
- *
- * Algorithm parameters:
- *  N		how many bits per iteration we try to get (4)
- *  WORDSIZE	total number of bits (32)
- *
- * Derived constants:
- *  TOPBITS	number of bits in the top decade of a number
- *
- * Important variables:
- *  Q		the partial quotient under development (initially 0)
- *  R		the remainder so far, initially the dividend
- *  ITER	number of main division loop iterations required;
- *		equal to ceil(log2(quotient) / N).  Note that this
- *		is the log base (2^N) of the quotient.
- *  V		the current comparand, initially divisor*2^(ITER*N-1)
- *
- * Cost:
- *  Current estimate for non-large dividend is
- *	ceil(log2(quotient) / N) * (10 + 7N/2) + C
- *  A large dividend is one greater than 2^(31-TOPBITS) and takes a
- *  different path, as the upper bits of the quotient must be developed
- *  one bit at a time.
- */
-
-
-	.globl .div
-	.globl _Div
-.div:
-_Div:	/* needed for export */
-	! compute sign of result; if neither is negative, no problem
-	orcc	%o1, %o0, %g0	! either negative?
-	bge	2f			! no, go do the divide
-	 xor	%o1, %o0, %g2	! compute sign in any case
-
-	tst	%o1
-	bge	1f
-	 tst	%o0
-	! %o1 is definitely negative; %o0 might also be negative
-	bge	2f			! if %o0 not negative...
-	 sub	%g0, %o1, %o1	! in any case, make %o1 nonneg
-1:	! %o0 is negative, %o1 is nonnegative
-	sub	%g0, %o0, %o0	! make %o0 nonnegative
-2:
-
-	! Ready to divide.  Compute size of quotient; scale comparand.
-	orcc	%o1, %g0, %o5
-	bne	1f
-	 mov	%o0, %o3
-
-		! Divide by zero trap.  If it returns, return 0 (about as
-		! wrong as possible, but that is what SunOS does...).
-		ta	ST_DIV0
-		retl
-		 clr	%o0
-
-1:
-	cmp	%o3, %o5			! if %o1 exceeds %o0, done
-	blu	Lgot_result		! (and algorithm fails otherwise)
-	 clr	%o2
-
-	sethi	%hi(1 << (32 - 4 - 1)), %g1
-
-	cmp	%o3, %g1
-	blu	Lnot_really_big
-	 clr	%o4
-
-	! Here the dividend is >=3D 2**(31-N) or so.  We must be careful here,
-	! as our usual N-at-a-shot divide step will cause overflow and havoc.
-	! The number of bits in the result here is N*ITER+SC, where SC <=3D N.
-	! Compute ITER in an unorthodox manner: know we need to shift V into
-	! the top decade: so do not even bother to compare to R.
-	1:
-		cmp	%o5, %g1
-		bgeu	3f
-		 mov	1, %g7
-
-		sll	%o5, 4, %o5
-
-		b	1b
-		 add	%o4, 1, %o4
-
-	! Now compute %g7.
-	2:
-		addcc	%o5, %o5, %o5
-		bcc	Lnot_too_big
-		 add	%g7, 1, %g7
-
-		! We get here if the %o1 overflowed while shifting.
-		! This means that %o3 has the high-order bit set.
-		! Restore %o5 and subtract from %o3.
-		sll	%g1, 4, %g1	! high order bit
-		srl	%o5, 1, %o5		! rest of %o5
-		add	%o5, %g1, %o5
-
-		b	Ldo_single_div
-		 sub	%g7, 1, %g7
-
-	Lnot_too_big:
-	3:
-		cmp	%o5, %o3
-		blu	2b
-		 nop
-
-		be	Ldo_single_div
-		 nop
-	/* NB: these are commented out in the V8-Sparc manual as well */
-	/* (I do not understand this) */
-	! %o5 > %o3: went too far: back up 1 step
-	!	srl	%o5, 1, %o5
-	!	dec	%g7
-	! do single-bit divide steps
-	!
-	! We have to be careful here.  We know that %o3 >=3D %o5, so we can do the
-	! first divide step without thinking.  BUT, the others are conditional,
-	! and are only done if %o3 >=3D 0.  Because both %o3 and %o5 may have the=
 high-
-	! order bit set in the first step, just falling into the regular
-	! division loop will mess up the first time around.
-	! So we unroll slightly...
-	Ldo_single_div:
-		subcc	%g7, 1, %g7
-		bl	Lend_regular_divide
-		 nop
-
-		sub	%o3, %o5, %o3
-		mov	1, %o2
-
-		b	Lend_single_divloop
-		 nop
-	Lsingle_divloop:
-		sll	%o2, 1, %o2
-
-		bl	1f
-		 srl	%o5, 1, %o5
-		! %o3 >=3D 0
-		sub	%o3, %o5, %o3
-
-		b	2f
-		 add	%o2, 1, %o2
-	1:	! %o3 < 0
-		add	%o3, %o5, %o3
-		sub	%o2, 1, %o2
-	2:
-	Lend_single_divloop:
-		subcc	%g7, 1, %g7
-		bge	Lsingle_divloop
-		 tst	%o3
-
-		b,a	Lend_regular_divide
-
-Lnot_really_big:
-1:
-	sll	%o5, 4, %o5
-	cmp	%o5, %o3
-	bleu	1b
-	 addcc	%o4, 1, %o4
-
-	be	Lgot_result
-	 sub	%o4, 1, %o4
-
-	tst	%o3	! set up for initial iteration
-Ldivloop:
-	sll	%o2, 4, %o2
-		! depth 1, accumulated bits 0
-	bl	L.1.16
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 2, accumulated bits 1
-	bl	L.2.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 3
-	bl	L.3.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 7
-	bl	L.4.23
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (7*2+1), %o2
-
-L.4.23:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (7*2-1), %o2
-
-L.3.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 5
-	bl	L.4.21
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2+1), %o2
-
-L.4.21:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2-1), %o2
-
-L.2.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 1
-	bl	L.3.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 3
-	bl	L.4.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2+1), %o2
-
-L.4.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2-1), %o2
-=09
-=09
-L.3.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 1
-	bl	L.4.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2+1), %o2
-
-L.4.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2-1), %o2
-
-L.1.16:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 2, accumulated bits -1
-	bl	L.2.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -1
-	bl	L.3.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -1
-	bl	L.4.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2+1), %o2
-
-L.4.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2-1), %o2
-
-L.3.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -3
-	bl	L.4.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2+1), %o2
-
-L.4.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2-1), %o2
-
-L.2.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -3
-	bl	L.3.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -5
-	bl	L.4.11
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2+1), %o2
-
-L.4.11:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2-1), %o2
-
-L.3.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -7
-	bl	L.4.9
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2+1), %o2
-
-L.4.9:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2-1), %o2
-
-	9:
-Lend_regular_divide:
-	subcc	%o4, 1, %o4
-	bge	Ldivloop
-	 tst	%o3
-
-	bl,a	Lgot_result
-	! non-restoring fixup here (one instruction only!)
-	sub	%o2, 1, %o2
-
-Lgot_result:
-	! check to see if answer should be < 0
-	tst	%g2
-	bl,a	1f
-	 sub %g0, %o2, %o2
-1:
-	retl
-	 mov %o2, %o0
-
-	.globl	.div_patch
-.div_patch:
-	sra	%o0, 0x1f, %o2
-	wr	%o2, 0x0, %y
-	nop
-	nop
-	nop
-	sdivcc	%o0, %o1, %o0
-	bvs,a	1f
-	 xnor	%o0, %g0, %o0
-1:	retl
-	 nop
diff --git a/arch/sparc/lib/udiv.S b/arch/sparc/lib/udiv.S
deleted file mode 100644
index 2101405..0000000
--- a/arch/sparc/lib/udiv.S
+++ /dev/null
@@ -1,357 +0,0 @@
-/*
- * udiv.S:      This routine was taken from glibc-1.09 and is covered
- *              by the GNU Library General Public License Version 2.
- */
-
-
-/* This file is generated from divrem.m4; DO NOT EDIT! */
-/*
- * Division and remainder, from Appendix E of the Sparc Version 8
- * Architecture Manual, with fixes from Gordon Irlam.
- */
-
-/*
- * Input: dividend and divisor in %o0 and %o1 respectively.
- *
- * m4 parameters:
- *  .udiv	name of function to generate
- *  div		div=3Ddiv =3D> %o0 / %o1; div=3Drem =3D> %o0 % %o1
- *  false		false=3Dtrue =3D> signed; false=FAlse =3D> unsigned
- *
- * Algorithm parameters:
- *  N		how many bits per iteration we try to get (4)
- *  WORDSIZE	total number of bits (32)
- *
- * Derived constants:
- *  TOPBITS	number of bits in the top decade of a number
- *
- * Important variables:
- *  Q		the partial quotient under development (initially 0)
- *  R		the remainder so far, initially the dividend
- *  ITER	number of main division loop iterations required;
- *		equal to ceil(log2(quotient) / N).  Note that this
- *		is the log base (2^N) of the quotient.
- *  V		the current comparand, initially divisor*2^(ITER*N-1)
- *
- * Cost:
- *  Current estimate for non-large dividend is
- *	ceil(log2(quotient) / N) * (10 + 7N/2) + C
- *  A large dividend is one greater than 2^(31-TOPBITS) and takes a
- *  different path, as the upper bits of the quotient must be developed
- *  one bit at a time.
- */
-
-
-	.globl .udiv
-	.globl _Udiv
-.udiv:
-_Udiv:	/* needed for export */
-
-	! Ready to divide.  Compute size of quotient; scale comparand.
-	orcc	%o1, %g0, %o5
-	bne	1f
-	 mov	%o0, %o3
-
-		! Divide by zero trap.  If it returns, return 0 (about as
-		! wrong as possible, but that is what SunOS does...).
-		ta	ST_DIV0
-		retl
-		 clr	%o0
-
-1:
-	cmp	%o3, %o5			! if %o1 exceeds %o0, done
-	blu	Lgot_result		! (and algorithm fails otherwise)
-	 clr	%o2
-
-	sethi	%hi(1 << (32 - 4 - 1)), %g1
-
-	cmp	%o3, %g1
-	blu	Lnot_really_big
-	 clr	%o4
-
-	! Here the dividend is >=3D 2**(31-N) or so.  We must be careful here,
-	! as our usual N-at-a-shot divide step will cause overflow and havoc.
-	! The number of bits in the result here is N*ITER+SC, where SC <=3D N.
-	! Compute ITER in an unorthodox manner: know we need to shift V into
-	! the top decade: so do not even bother to compare to R.
-	1:
-		cmp	%o5, %g1
-		bgeu	3f
-		 mov	1, %g7
-
-		sll	%o5, 4, %o5
-
-		b	1b
-		 add	%o4, 1, %o4
-
-	! Now compute %g7.
-	2:
-		addcc	%o5, %o5, %o5
-		bcc	Lnot_too_big
-		 add	%g7, 1, %g7
-
-		! We get here if the %o1 overflowed while shifting.
-		! This means that %o3 has the high-order bit set.
-		! Restore %o5 and subtract from %o3.
-		sll	%g1, 4, %g1	! high order bit
-		srl	%o5, 1, %o5		! rest of %o5
-		add	%o5, %g1, %o5
-
-		b	Ldo_single_div
-		 sub	%g7, 1, %g7
-
-	Lnot_too_big:
-	3:
-		cmp	%o5, %o3
-		blu	2b
-		 nop
-
-		be	Ldo_single_div
-		 nop
-	/* NB: these are commented out in the V8-Sparc manual as well */
-	/* (I do not understand this) */
-	! %o5 > %o3: went too far: back up 1 step
-	!	srl	%o5, 1, %o5
-	!	dec	%g7
-	! do single-bit divide steps
-	!
-	! We have to be careful here.  We know that %o3 >=3D %o5, so we can do the
-	! first divide step without thinking.  BUT, the others are conditional,
-	! and are only done if %o3 >=3D 0.  Because both %o3 and %o5 may have the=
 high-
-	! order bit set in the first step, just falling into the regular
-	! division loop will mess up the first time around.
-	! So we unroll slightly...
-	Ldo_single_div:
-		subcc	%g7, 1, %g7
-		bl	Lend_regular_divide
-		 nop
-
-		sub	%o3, %o5, %o3
-		mov	1, %o2
-
-		b	Lend_single_divloop
-		 nop
-	Lsingle_divloop:
-		sll	%o2, 1, %o2
-		bl	1f
-		 srl	%o5, 1, %o5
-		! %o3 >=3D 0
-		sub	%o3, %o5, %o3
-		b	2f
-		 add	%o2, 1, %o2
-	1:	! %o3 < 0
-		add	%o3, %o5, %o3
-		sub	%o2, 1, %o2
-	2:
-	Lend_single_divloop:
-		subcc	%g7, 1, %g7
-		bge	Lsingle_divloop
-		 tst	%o3
-
-		b,a	Lend_regular_divide
-
-Lnot_really_big:
-1:
-	sll	%o5, 4, %o5
-
-	cmp	%o5, %o3
-	bleu	1b
-	 addcc	%o4, 1, %o4
-
-	be	Lgot_result
-	 sub	%o4, 1, %o4
-
-	tst	%o3	! set up for initial iteration
-Ldivloop:
-	sll	%o2, 4, %o2
-		! depth 1, accumulated bits 0
-	bl	L.1.16
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 2, accumulated bits 1
-	bl	L.2.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 3
-	bl	L.3.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 7
-	bl	L.4.23
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (7*2+1), %o2
-
-L.4.23:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (7*2-1), %o2
-
-L.3.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 5
-	bl	L.4.21
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2+1), %o2
-
-L.4.21:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2-1), %o2
-
-L.2.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 1
-	bl	L.3.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 3
-	bl	L.4.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2+1), %o2
-
-L.4.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2-1), %o2
-
-L.3.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 1
-	bl	L.4.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2+1), %o2
-
-L.4.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2-1), %o2
-
-L.1.16:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 2, accumulated bits -1
-	bl	L.2.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -1
-	bl	L.3.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -1
-	bl	L.4.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2+1), %o2
-
-L.4.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2-1), %o2
-
-L.3.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -3
-	bl	L.4.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2+1), %o2
-
-L.4.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2-1), %o2
-
-L.2.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -3
-	bl	L.3.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -5
-	bl	L.4.11
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2+1), %o2
-
-L.4.11:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2-1), %o2
-
-L.3.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -7
-	bl	L.4.9
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2+1), %o2
-
-L.4.9:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2-1), %o2
-
-	9:
-Lend_regular_divide:
-	subcc	%o4, 1, %o4
-	bge	Ldivloop
-	 tst	%o3
-
-	bl,a	Lgot_result
-	! non-restoring fixup here (one instruction only!)
-	sub	%o2, 1, %o2
-
-Lgot_result:
-
-	retl
-	 mov %o2, %o0
-
-	.globl	.udiv_patch
-.udiv_patch:
-	wr	%g0, 0x0, %y
-	nop
-	nop
-	retl
-	 udiv	%o0, %o1, %o0
-	nop
diff --git a/arch/sparc/lib/udivdi3.S b/arch/sparc/lib/udivdi3.S
index b430f1f..24e0a35 100644
--- a/arch/sparc/lib/udivdi3.S
+++ b/arch/sparc/lib/udivdi3.S
@@ -60,8 +60,9 @@ __udivdi3:
 	bne .LL77
 	mov %i0,%o2
 	mov 1,%o0
-	call .udiv,0
 	mov 0,%o1
+	wr %g0, 0, %y
+	udiv %o0, %o1, %o0
 	mov %o0,%o3
 	mov %i0,%o2
 .LL77:
diff --git a/arch/sparc/lib/umul.S b/arch/sparc/lib/umul.S
deleted file mode 100644
index 1f36ae6..0000000
--- a/arch/sparc/lib/umul.S
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
- * umul.S:      This routine was taken from glibc-1.09 and is covered
- *              by the GNU Library General Public License Version 2.
- */
-
-
-/*
- * Unsigned multiply.  Returns %o0 * %o1 in %o1%o0 (i.e., %o1 holds the
- * upper 32 bits of the 64-bit product).
- *
- * This code optimizes short (less than 13-bit) multiplies.  Short
- * multiplies require 25 instruction cycles, and long ones require
- * 45 instruction cycles.
- *
- * On return, overflow has occurred (%o1 is not zero) if and only if
- * the Z condition code is clear, allowing, e.g., the following:
- *
- *	call	.umul
- *	nop
- *	bnz	overflow	(or tnz)
- */
-
-	.globl .umul
-	.globl _Umul
-.umul:
-_Umul:	/* needed for export */
-	or	%o0, %o1, %o4
-	mov	%o0, %y		! multiplier -> Y
-
-	andncc	%o4, 0xfff, %g0	! test bits 12..31 of *both* args
-	be	Lmul_shortway	! if zero, can do it the short way
-	 andcc	%g0, %g0, %o4	! zero the partial product and clear N and V
-
-	/*
-	 * Long multiply.  32 steps, followed by a final shift step.
-	 */
-	mulscc	%o4, %o1, %o4	! 1
-	mulscc	%o4, %o1, %o4	! 2
-	mulscc	%o4, %o1, %o4	! 3
-	mulscc	%o4, %o1, %o4	! 4
-	mulscc	%o4, %o1, %o4	! 5
-	mulscc	%o4, %o1, %o4	! 6
-	mulscc	%o4, %o1, %o4	! 7
-	mulscc	%o4, %o1, %o4	! 8
-	mulscc	%o4, %o1, %o4	! 9
-	mulscc	%o4, %o1, %o4	! 10
-	mulscc	%o4, %o1, %o4	! 11
-	mulscc	%o4, %o1, %o4	! 12
-	mulscc	%o4, %o1, %o4	! 13
-	mulscc	%o4, %o1, %o4	! 14
-	mulscc	%o4, %o1, %o4	! 15
-	mulscc	%o4, %o1, %o4	! 16
-	mulscc	%o4, %o1, %o4	! 17
-	mulscc	%o4, %o1, %o4	! 18
-	mulscc	%o4, %o1, %o4	! 19
-	mulscc	%o4, %o1, %o4	! 20
-	mulscc	%o4, %o1, %o4	! 21
-	mulscc	%o4, %o1, %o4	! 22
-	mulscc	%o4, %o1, %o4	! 23
-	mulscc	%o4, %o1, %o4	! 24
-	mulscc	%o4, %o1, %o4	! 25
-	mulscc	%o4, %o1, %o4	! 26
-	mulscc	%o4, %o1, %o4	! 27
-	mulscc	%o4, %o1, %o4	! 28
-	mulscc	%o4, %o1, %o4	! 29
-	mulscc	%o4, %o1, %o4	! 30
-	mulscc	%o4, %o1, %o4	! 31
-	mulscc	%o4, %o1, %o4	! 32
-	mulscc	%o4, %g0, %o4	! final shift
-
-
-	/*
-	 * Normally, with the shift-and-add approach, if both numbers are
-	 * positive you get the correct result.  With 32-bit two's-complement
-	 * numbers, -x is represented as
-	 *
-	 *		  x		    32
-	 *	( 2  -  ------ ) mod 2  *  2
-	 *		   32
-	 *		  2
-	 *
-	 * (the `mod 2' subtracts 1 from 1.bbbb).  To avoid lots of 2^32s,
-	 * we can treat this as if the radix point were just to the left
-	 * of the sign bit (multiply by 2^32), and get
-	 *
-	 *	-x  =3D  (2 - x) mod 2
-	 *
-	 * Then, ignoring the `mod 2's for convenience:
-	 *
-	 *   x *  y	=3D xy
-	 *  -x *  y	=3D 2y - xy
-	 *   x * -y	=3D 2x - xy
-	 *  -x * -y	=3D 4 - 2x - 2y + xy
-	 *
-	 * For signed multiplies, we subtract (x << 32) from the partial
-	 * product to fix this problem for negative multipliers (see mul.s).
-	 * Because of the way the shift into the partial product is calculated
-	 * (N xor V), this term is automatically removed for the multiplicand,
-	 * so we don't have to adjust.
-	 *
-	 * But for unsigned multiplies, the high order bit wasn't a sign bit,
-	 * and the correction is wrong.  So for unsigned multiplies where the
-	 * high order bit is one, we end up with xy - (y << 32).  To fix it
-	 * we add y << 32.
-	 */
-#if 0
-	tst	%o1
-	bl,a	1f		! if %o1 < 0 (high order bit =3D 1),
-	 add	%o4, %o0, %o4	! %o4 +=3D %o0 (add y to upper half)
-
-1:
-	rd	%y, %o0		! get lower half of product
-	retl
-	 addcc	%o4, %g0, %o1	! put upper half in place and set Z for %o1=3D0
-#else
-	/* Faster code from tege@sics.se.  */
-	sra	%o1, 31, %o2	! make mask from sign bit
-	and	%o0, %o2, %o2	! %o2 =3D 0 or %o0, depending on sign of %o1
-	rd	%y, %o0		! get lower half of product
-	retl
-	 addcc	%o4, %o2, %o1	! add compensation and put upper half in place
-#endif
-
-Lmul_shortway:
-	/*
-	 * Short multiply.  12 steps, followed by a final shift step.
-	 * The resulting bits are off by 12 and (32-12) =3D 20 bit positions,
-	 * but there is no problem with %o0 being negative (unlike above),
-	 * and overflow is impossible (the answer is at most 24 bits long).
-	 */
-	mulscc	%o4, %o1, %o4	! 1
-	mulscc	%o4, %o1, %o4	! 2
-	mulscc	%o4, %o1, %o4	! 3
-	mulscc	%o4, %o1, %o4	! 4
-	mulscc	%o4, %o1, %o4	! 5
-	mulscc	%o4, %o1, %o4	! 6
-	mulscc	%o4, %o1, %o4	! 7
-	mulscc	%o4, %o1, %o4	! 8
-	mulscc	%o4, %o1, %o4	! 9
-	mulscc	%o4, %o1, %o4	! 10
-	mulscc	%o4, %o1, %o4	! 11
-	mulscc	%o4, %o1, %o4	! 12
-	mulscc	%o4, %g0, %o4	! final shift
-
-	/*
-	 * %o4 has 20 of the bits that should be in the result; %y has
-	 * the bottom 12 (as %y's top 12).  That is:
-	 *
-	 *	  %o4		    %y
-	 * +----------------+----------------+
-	 * | -12- |   -20-  | -12- |   -20-  |
-	 * +------(---------+------)---------+
-	 *	   -----result-----
-	 *
-	 * The 12 bits of %o4 left of the `result' area are all zero;
-	 * in fact, all top 20 bits of %o4 are zero.
-	 */
-
-	rd	%y, %o5
-	sll	%o4, 12, %o0	! shift middle bits left 12
-	srl	%o5, 20, %o5	! shift low bits right 20
-	or	%o5, %o0, %o0
-	retl
-	 addcc	%g0, %g0, %o1	! %o1 =3D zero, and set Z
-
-	.globl	.umul_patch
-.umul_patch:
-	umul	%o0, %o1, %o0
-	retl
-	 rd	%y, %o1
-	nop
diff --git a/arch/sparc/lib/urem.S b/arch/sparc/lib/urem.S
deleted file mode 100644
index 77123eb..0000000
--- a/arch/sparc/lib/urem.S
+++ /dev/null
@@ -1,357 +0,0 @@
-/*
- * urem.S:      This routine was taken from glibc-1.09 and is covered
- *              by the GNU Library General Public License Version 2.
- */
-
-/* This file is generated from divrem.m4; DO NOT EDIT! */
-/*
- * Division and remainder, from Appendix E of the Sparc Version 8
- * Architecture Manual, with fixes from Gordon Irlam.
- */
-
-/*
- * Input: dividend and divisor in %o0 and %o1 respectively.
- *
- * m4 parameters:
- *  .urem	name of function to generate
- *  rem		rem=3Ddiv =3D> %o0 / %o1; rem=3Drem =3D> %o0 % %o1
- *  false		false=3Dtrue =3D> signed; false=FAlse =3D> unsigned
- *
- * Algorithm parameters:
- *  N		how many bits per iteration we try to get (4)
- *  WORDSIZE	total number of bits (32)
- *
- * Derived constants:
- *  TOPBITS	number of bits in the top decade of a number
- *
- * Important variables:
- *  Q		the partial quotient under development (initially 0)
- *  R		the remainder so far, initially the dividend
- *  ITER	number of main division loop iterations required;
- *		equal to ceil(log2(quotient) / N).  Note that this
- *		is the log base (2^N) of the quotient.
- *  V		the current comparand, initially divisor*2^(ITER*N-1)
- *
- * Cost:
- *  Current estimate for non-large dividend is
- *	ceil(log2(quotient) / N) * (10 + 7N/2) + C
- *  A large dividend is one greater than 2^(31-TOPBITS) and takes a
- *  different path, as the upper bits of the quotient must be developed
- *  one bit at a time.
- */
-
-	.globl .urem
-	.globl _Urem
-.urem:
-_Urem:	/* needed for export */
-
-	! Ready to divide.  Compute size of quotient; scale comparand.
-	orcc	%o1, %g0, %o5
-	bne	1f
-	 mov	%o0, %o3
-
-		! Divide by zero trap.  If it returns, return 0 (about as
-		! wrong as possible, but that is what SunOS does...).
-		ta	ST_DIV0
-		retl
-		 clr	%o0
-
-1:
-	cmp	%o3, %o5			! if %o1 exceeds %o0, done
-	blu	Lgot_result		! (and algorithm fails otherwise)
-	 clr	%o2
-
-	sethi	%hi(1 << (32 - 4 - 1)), %g1
-
-	cmp	%o3, %g1
-	blu	Lnot_really_big
-	 clr	%o4
-
-	! Here the dividend is >=3D 2**(31-N) or so.  We must be careful here,
-	! as our usual N-at-a-shot divide step will cause overflow and havoc.
-	! The number of bits in the result here is N*ITER+SC, where SC <=3D N.
-	! Compute ITER in an unorthodox manner: know we need to shift V into
-	! the top decade: so do not even bother to compare to R.
-	1:
-		cmp	%o5, %g1
-		bgeu	3f
-		 mov	1, %g7
-
-		sll	%o5, 4, %o5
-
-		b	1b
-		 add	%o4, 1, %o4
-
-	! Now compute %g7.
-	2:
-		addcc	%o5, %o5, %o5
-		bcc	Lnot_too_big
-		 add	%g7, 1, %g7
-
-		! We get here if the %o1 overflowed while shifting.
-		! This means that %o3 has the high-order bit set.
-		! Restore %o5 and subtract from %o3.
-		sll	%g1, 4, %g1	! high order bit
-		srl	%o5, 1, %o5		! rest of %o5
-		add	%o5, %g1, %o5
-
-		b	Ldo_single_div
-		 sub	%g7, 1, %g7
-
-	Lnot_too_big:
-	3:
-		cmp	%o5, %o3
-		blu	2b
-		 nop
-
-		be	Ldo_single_div
-		 nop
-	/* NB: these are commented out in the V8-Sparc manual as well */
-	/* (I do not understand this) */
-	! %o5 > %o3: went too far: back up 1 step
-	!	srl	%o5, 1, %o5
-	!	dec	%g7
-	! do single-bit divide steps
-	!
-	! We have to be careful here.  We know that %o3 >=3D %o5, so we can do the
-	! first divide step without thinking.  BUT, the others are conditional,
-	! and are only done if %o3 >=3D 0.  Because both %o3 and %o5 may have the=
 high-
-	! order bit set in the first step, just falling into the regular
-	! division loop will mess up the first time around.
-	! So we unroll slightly...
-	Ldo_single_div:
-		subcc	%g7, 1, %g7
-		bl	Lend_regular_divide
-		 nop
-
-		sub	%o3, %o5, %o3
-		mov	1, %o2
-
-		b	Lend_single_divloop
-		 nop
-	Lsingle_divloop:
-		sll	%o2, 1, %o2
-		bl	1f
-		 srl	%o5, 1, %o5
-		! %o3 >=3D 0
-		sub	%o3, %o5, %o3
-		b	2f
-		 add	%o2, 1, %o2
-	1:	! %o3 < 0
-		add	%o3, %o5, %o3
-		sub	%o2, 1, %o2
-	2:
-	Lend_single_divloop:
-		subcc	%g7, 1, %g7
-		bge	Lsingle_divloop
-		 tst	%o3
-
-		b,a	Lend_regular_divide
-
-Lnot_really_big:
-1:
-	sll	%o5, 4, %o5
-
-	cmp	%o5, %o3
-	bleu	1b
-	 addcc	%o4, 1, %o4
-
-	be	Lgot_result
-	 sub	%o4, 1, %o4
-
-	tst	%o3	! set up for initial iteration
-Ldivloop:
-	sll	%o2, 4, %o2
-		! depth 1, accumulated bits 0
-	bl	L.1.16
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 2, accumulated bits 1
-	bl	L.2.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 3
-	bl	L.3.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 7
-	bl	L.4.23
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (7*2+1), %o2
-
-L.4.23:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (7*2-1), %o2
-
-L.3.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 5
-	bl	L.4.21
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2+1), %o2
-
-L.4.21:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (5*2-1), %o2
-
-L.2.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits 1
-	bl	L.3.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 3
-	bl	L.4.19
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2+1), %o2
-
-L.4.19:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (3*2-1), %o2
-
-L.3.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits 1
-	bl	L.4.17
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2+1), %o2
-=09
-L.4.17:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (1*2-1), %o2
-
-L.1.16:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 2, accumulated bits -1
-	bl	L.2.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -1
-	bl	L.3.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -1
-	bl	L.4.15
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2+1), %o2
-
-L.4.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-1*2-1), %o2
-
-L.3.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -3
-	bl	L.4.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2+1), %o2
-
-L.4.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-3*2-1), %o2
-
-L.2.15:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 3, accumulated bits -3
-	bl	L.3.13
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -5
-	bl	L.4.11
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2+1), %o2
-=09
-L.4.11:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-5*2-1), %o2
-
-L.3.13:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-			! depth 4, accumulated bits -7
-	bl	L.4.9
-	 srl	%o5,1,%o5
-	! remainder is positive
-	subcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2+1), %o2
-
-L.4.9:
-	! remainder is negative
-	addcc	%o3,%o5,%o3
-	b	9f
-	 add	%o2, (-7*2-1), %o2
-
-	9:
-Lend_regular_divide:
-	subcc	%o4, 1, %o4
-	bge	Ldivloop
-	 tst	%o3
-
-	bl,a	Lgot_result
-	! non-restoring fixup here (one instruction only!)
-	add	%o3, %o1, %o3
-
-Lgot_result:
-
-	retl
-	 mov %o3, %o0
-
-	.globl	.urem_patch
-.urem_patch:
-	wr	%g0, 0x0, %y
-	nop
-	nop
-	nop
-	udiv	%o0, %o1, %o2
-	umul	%o2, %o1, %o2
-	retl
-	 sub	%o0, %o2, %o0
--=20
1.7.10

