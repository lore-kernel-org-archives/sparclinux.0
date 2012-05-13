From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 11:20:21 +0000
Subject: [PATCH] sparc32: drop unused btfixup features
Message-Id: <20120513112021.GA15625@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From d855682558cd176f326bf07e705331d72040083e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 13:17:16 +0200
Subject: [PATCH] sparc32: drop unused btfixup features

We no longer use any of the const replacement features.
Also drop the support code in btfixupprep

Boot tested up+smp on my ss5.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/btfixupprep.c    |   44 -----------
 arch/sparc/include/asm/btfixup.h |  151 +-------------------------------------
 arch/sparc/mm/btfixup.c          |   93 -----------------------
 3 files changed, 1 insertions(+), 287 deletions(-)

diff --git a/arch/sparc/boot/btfixupprep.c b/arch/sparc/boot/btfixupprep.c
index da03115..7d2b92b 100644
--- a/arch/sparc/boot/btfixupprep.c
+++ b/arch/sparc/boot/btfixupprep.c
@@ -148,10 +148,6 @@ main1:
 		switch (buffer[nbase+3]) {
 			case 'f':	/* CALL */
 			case 'b':	/* BLACKBOX */
-			case 's':	/* SIMM13 */
-			case 'a':	/* HALF */
-			case 'h':	/* SETHI */
-			case 'i':	/* INT */
 				break;
 			default:
 				continue;
@@ -241,46 +237,6 @@ main1:
 				exit(1);
 			}
 			break;
-		case 's':
-			if (initval + 0x1000 >= 0x2000) {
-				fprintf(stderr, "Wrong initializer for SIMM13. Has to be from $fffff000 to $00000fff\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "13        ", 10)) {
-				fprintf(stderr, "BTFIXUP_SIMM13 results in relocation other than R_SPARC_13\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 'a':
-			if (initval + 0x1000 >= 0x2000 && (initval & 0x3ff)) {
-				fprintf(stderr, "Wrong initializer for HALF.\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "13        ", 10)) {
-				fprintf(stderr, "BTFIXUP_HALF results in relocation other than R_SPARC_13\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 'h':
-			if (initval & 0x3ff) {
-				fprintf(stderr, "Wrong initializer for SETHI. Cannot have set low 10 bits\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "HI22      ", 10)) {
-				fprintf(stderr, "BTFIXUP_SETHI results in relocation other than R_SPARC_HI22\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 'i':
-			if (initval) {
-				fprintf(stderr, "Cannot use pre-initialized fixups for INT\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "HI22      ", 10) && strncmp (buffer + mode+9, "LO10      ", 10)) {
-				fprintf(stderr, "BTFIXUP_INT results in relocation other than R_SPARC_HI22 and R_SPARC_LO10\n%s\n", buffer);
-				exit(1);
-			}
-			break;
 		}
 		if (!f->setinitval) {
 			f->initval = initval;
diff --git a/arch/sparc/include/asm/btfixup.h b/arch/sparc/include/asm/btfixup.h
index 48b0141..234ffa2 100644
--- a/arch/sparc/include/asm/btfixup.h
+++ b/arch/sparc/include/asm/btfixup.h
@@ -11,117 +11,21 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef MODULE
-extern unsigned int ___illegal_use_of_BTFIXUP_SIMM13_in_module(void);
-extern unsigned int ___illegal_use_of_BTFIXUP_SETHI_in_module(void);
-extern unsigned int ___illegal_use_of_BTFIXUP_HALF_in_module(void);
-extern unsigned int ___illegal_use_of_BTFIXUP_INT_in_module(void);
-
-#define BTFIXUP_SIMM13(__name) ___illegal_use_of_BTFIXUP_SIMM13_in_module()
-#define BTFIXUP_HALF(__name) ___illegal_use_of_BTFIXUP_HALF_in_module()
-#define BTFIXUP_SETHI(__name) ___illegal_use_of_BTFIXUP_SETHI_in_module()
-#define BTFIXUP_INT(__name) ___illegal_use_of_BTFIXUP_INT_in_module()
-#define BTFIXUP_BLACKBOX(__name) ___illegal_use_of_BTFIXUP_BLACKBOX_in_module
-
-#else
-
-#define BTFIXUP_SIMM13(__name) ___sf_##__name()
-#define BTFIXUP_HALF(__name) ___af_##__name()
-#define BTFIXUP_SETHI(__name) ___hf_##__name()
-#define BTFIXUP_INT(__name) ((unsigned int)&___i_##__name)
-/* This must be written in assembly and present in a sethi */
-#define BTFIXUP_BLACKBOX(__name) ___b_##__name
-#endif /* MODULE */
-
 /* Fixup call xx */
-
 #define BTFIXUPDEF_CALL(__type, __name, __args...) 					\
 	extern __type ___f_##__name(__args);						\
 	extern unsigned ___fs_##__name[3];
-#define BTFIXUPDEF_CALL_CONST(__type, __name, __args...) 				\
-	extern __type ___f_##__name(__args) __attribute_const__;			\
-	extern unsigned ___fs_##__name[3];
 #define BTFIXUP_CALL(__name) ___f_##__name
 
 #define BTFIXUPDEF_BLACKBOX(__name)							\
 	extern unsigned ___bs_##__name[2];
 
-/* Put bottom 13bits into some register variable */
-
-#define BTFIXUPDEF_SIMM13(__name)							\
-	static inline unsigned int ___sf_##__name(void) __attribute_const__;		\
-	extern unsigned ___ss_##__name[2];						\
-	static inline unsigned int ___sf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___s_" #__name ", %0" : "=r"(ret));			\
-		return ret;								\
-	}
-#define BTFIXUPDEF_SIMM13_INIT(__name,__val)						\
-	static inline unsigned int ___sf_##__name(void) __attribute_const__;		\
-	extern unsigned ___ss_##__name[2];						\
-	static inline unsigned int ___sf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___s_" #__name "__btset_" #__val ", %0" : "=r"(ret));\
-		return ret;								\
-	}
-
-/* Put either bottom 13 bits, or upper 22 bits into some register variable
- * (depending on the value, this will lead into sethi FIX, reg; or
- * mov FIX, reg; )
- */
-
-#define BTFIXUPDEF_HALF(__name)								\
-	static inline unsigned int ___af_##__name(void) __attribute_const__;		\
-	extern unsigned ___as_##__name[2];						\
-	static inline unsigned int ___af_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___a_" #__name ", %0" : "=r"(ret));			\
-		return ret;								\
-	}
-#define BTFIXUPDEF_HALF_INIT(__name,__val)						\
-	static inline unsigned int ___af_##__name(void) __attribute_const__;		\
-	extern unsigned ___as_##__name[2];						\
-	static inline unsigned int ___af_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___a_" #__name "__btset_" #__val ", %0" : "=r"(ret));\
-		return ret;								\
-	}
-
-/* Put upper 22 bits into some register variable */
-
-#define BTFIXUPDEF_SETHI(__name)							\
-	static inline unsigned int ___hf_##__name(void) __attribute_const__;		\
-	extern unsigned ___hs_##__name[2];						\
-	static inline unsigned int ___hf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("sethi %%hi(___h_" #__name "), %0" : "=r"(ret));		\
-		return ret;								\
-	}
-#define BTFIXUPDEF_SETHI_INIT(__name,__val)						\
-	static inline unsigned int ___hf_##__name(void) __attribute_const__;		\
-	extern unsigned ___hs_##__name[2];						\
-	static inline unsigned int ___hf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("sethi %%hi(___h_" #__name "__btset_" #__val "), %0" : 	\
-			 "=r"(ret));							\
-		return ret;								\
-	}
-
-/* Put a full 32bit integer into some register variable */
-
-#define BTFIXUPDEF_INT(__name)								\
-	extern unsigned char ___i_##__name;						\
-	extern unsigned ___is_##__name[2];
-
 #define BTFIXUPCALL_NORM	0x00000000			/* Always call */
 #define BTFIXUPCALL_NOP		0x01000000			/* Possibly optimize to nop */
 #define BTFIXUPCALL_RETINT(i)	(0x90102000|((i) & 0x1fff))	/* Possibly optimize to mov i, %o0 */
-#define BTFIXUPCALL_ORINT(i)	(0x90122000|((i) & 0x1fff))	/* Possibly optimize to or %o0, i, %o0 */
 #define BTFIXUPCALL_RETO0	0x01000000			/* Return first parameter, actually a nop */
-#define BTFIXUPCALL_ANDNINT(i)	(0x902a2000|((i) & 0x1fff))	/* Possibly optimize to andn %o0, i, %o0 */
 #define BTFIXUPCALL_SWAPO0O1	0xd27a0000			/* Possibly optimize to swap [%o0],%o1 */
 #define BTFIXUPCALL_SWAPG1G2	0xc4784000			/* Possibly optimize to swap [%g1],%g2 */
-#define BTFIXUPCALL_STG0O0	0xc0220000			/* Possibly optimize to st %g0,[%o0] */
 #define BTFIXUPCALL_STO1O0	0xd2220000			/* Possibly optimize to st %o1,[%o0] */
 
 #define BTFIXUPSET_CALL(__name, __addr, __insn)						\
@@ -144,64 +48,11 @@ extern unsigned int ___illegal_use_of_BTFIXUP_INT_in_module(void);
 		___fs_##__name[2] = ___fs_##__from[2];					\
 	} while (0)
 		
-#define BTFIXUPSET_SIMM13(__name, __val)						\
-	do {										\
-		___ss_##__name[0] |= 1;							\
-		___ss_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_SIMM13(__name, __from)						\
-	do {										\
-		___ss_##__name[0] |= 1;							\
-		___ss_##__name[1] = ___ss_##__from[1];					\
-	} while (0)
-		
-#define BTFIXUPSET_HALF(__name, __val)							\
-	do {										\
-		___as_##__name[0] |= 1;							\
-		___as_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_HALF(__name, __from)						\
-	do {										\
-		___as_##__name[0] |= 1;							\
-		___as_##__name[1] = ___as_##__from[1];					\
-	} while (0)
-		
-#define BTFIXUPSET_SETHI(__name, __val)							\
-	do {										\
-		___hs_##__name[0] |= 1;							\
-		___hs_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_SETHI(__name, __from)						\
-	do {										\
-		___hs_##__name[0] |= 1;							\
-		___hs_##__name[1] = ___hs_##__from[1];					\
-	} while (0)
-		
-#define BTFIXUPSET_INT(__name, __val)							\
-	do {										\
-		___is_##__name[0] |= 1;							\
-		___is_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_INT(__name, __from)							\
-	do {										\
-		___is_##__name[0] |= 1;							\
-		___is_##__name[1] = ___is_##__from[1];					\
-	} while (0)
-	
+
 #define BTFIXUPVAL_CALL(__name)								\
 	((unsigned long)___fs_##__name[1])
 	
 extern void btfixup(void);
 
-#else /* __ASSEMBLY__ */
-
-#define BTFIXUP_SETHI(__name)			%hi(___h_ ## __name)
-#define BTFIXUP_SETHI_INIT(__name,__val)	%hi(___h_ ## __name ## __btset_ ## __val)
-
 #endif /* __ASSEMBLY__ */
-	
 #endif /* !(_SPARC_BTFIXUP_H) */
diff --git a/arch/sparc/mm/btfixup.c b/arch/sparc/mm/btfixup.c
index 1b7aa56..aba8575 100644
--- a/arch/sparc/mm/btfixup.c
+++ b/arch/sparc/mm/btfixup.c
@@ -28,45 +28,10 @@ extern unsigned int ___btfixup_start[], ___btfixup_end[], __init_begin[], __init
 extern unsigned int _stext[], _end[], __start___ksymtab[], __stop___ksymtab[];
 static char wrong_f[] __initdata = "Trying to set f fixup %p to invalid function %08x\n";
 static char wrong_b[] __initdata = "Trying to set b fixup %p to invalid function %08x\n";
-static char wrong_s[] __initdata = "Trying to set s fixup %p to invalid value %08x\n";
-static char wrong_h[] __initdata = "Trying to set h fixup %p to invalid value %08x\n";
-static char wrong_a[] __initdata = "Trying to set a fixup %p to invalid value %08x\n";
 static char wrong[] __initdata = "Wrong address for %c fixup %p\n";
 static char insn_f[] __initdata = "Fixup f %p refers to weird instructions at %p[%08x,%08x]\n";
 static char insn_b[] __initdata = "Fixup b %p doesn't refer to a SETHI at %p[%08x]\n";
-static char insn_s[] __initdata = "Fixup s %p doesn't refer to an OR at %p[%08x]\n";
-static char insn_h[] __initdata = "Fixup h %p doesn't refer to a SETHI at %p[%08x]\n";
-static char insn_a[] __initdata = "Fixup a %p doesn't refer to a SETHI nor OR at %p[%08x]\n";
-static char insn_i[] __initdata = "Fixup i %p doesn't refer to a valid instruction at %p[%08x]\n";
 static char fca_und[] __initdata = "flush_cache_all undefined in btfixup()\n";
-static char wrong_setaddr[] __initdata = "Garbled CALL/INT patch at %p[%08x,%08x,%08x]=%08x\n";
-
-#ifdef BTFIXUP_OPTIMIZE_OTHER
-static void __init set_addr(unsigned int *addr, unsigned int q1, int fmangled, unsigned int value)
-{
-	if (!fmangled)
-		*addr = value;
-	else {
-		unsigned int *q = (unsigned int *)q1;
-		if (*addr = 0x01000000) {
-			/* Noped */
-			*q = value;
-		} else if (addr[-1] = *q) {
-			/* Moved */
-			addr[-1] = value;
-			*q = value;
-		} else {
-			prom_printf(wrong_setaddr, addr-1, addr[-1], *addr, *q, value);
-			prom_halt();
-		}
-	}
-}
-#else
-static inline void set_addr(unsigned int *addr, unsigned int q1, int fmangled, unsigned int value)
-{
-	*addr = value;
-}
-#endif
 
 void __init btfixup(void)
 {
@@ -105,24 +70,6 @@ void __init btfixup(void)
 				prom_halt();
 			}
 			break;
-		case 's':
-			if (p[1] + 0x1000 >= 0x2000) {
-				prom_printf(wrong_s, p, p[1]);
-				prom_halt();
-			}
-			break;
-		case 'h':
-			if (p[1] & 0x3ff) {
-				prom_printf(wrong_h, p, p[1]);
-				prom_halt();
-			}
-			break;
-		case 'a':
-			if (p[1] + 0x1000 >= 0x2000 && (p[1] & 0x3ff)) {
-				prom_printf(wrong_a, p, p[1]);
-				prom_halt();
-			}
-			break;
 		}
 		if (p[0] & 1) {
 			p[0] &= ~1;
@@ -263,46 +210,6 @@ void __init btfixup(void)
 						do_fixup(addr);
 					}
 					break;
-				case 's':	/* SIMM13 */
-					/* Has to be or %g0, i, xx */
-					if ((insn & 0xc1ffe000) != 0x80102000) {
-						prom_printf(insn_s, p, addr, insn);
-						prom_halt();
-					}
-					set_addr(addr, q[1], fmangled, (insn & 0xffffe000) | (p[1] & 0x1fff));
-					break;
-				case 'h':	/* SETHI */
-					/* Has to be sethi i, xx */
-					if ((insn & 0xc1c00000) != 0x01000000) {
-						prom_printf(insn_h, p, addr, insn);
-						prom_halt();
-					}
-					set_addr(addr, q[1], fmangled, (insn & 0xffc00000) | (p[1] >> 10));
-					break;
-				case 'a':	/* HALF */
-					/* Has to be sethi i, xx or or %g0, i, xx */
-					if ((insn & 0xc1c00000) != 0x01000000 &&
-					    (insn & 0xc1ffe000) != 0x80102000) {
-						prom_printf(insn_a, p, addr, insn);
-						prom_halt();
-					}
-					if (p[1] & 0x3ff)
-						set_addr(addr, q[1], fmangled, 
-							(insn & 0x3e000000) | 0x80102000 | (p[1] & 0x1fff));
-					else
-						set_addr(addr, q[1], fmangled, 
-							(insn & 0x3e000000) | 0x01000000 | (p[1] >> 10));
-					break;
-				case 'i':	/* INT */
-					if ((insn & 0xc1c00000) = 0x01000000) /* %HI */
-						set_addr(addr, q[1], fmangled, (insn & 0xffc00000) | (p[1] >> 10));
-					else if ((insn & 0x80002000) = 0x80002000) /* %LO */
-						set_addr(addr, q[1], fmangled, (insn & 0xffffe000) | (p[1] & 0x3ff));
-					else {
-						prom_printf(insn_i, p, addr, insn);
-						prom_halt();
-					}
-					break;
 				}
 				count -= 2;
 				q += 2;
-- 
1.6.0.6

