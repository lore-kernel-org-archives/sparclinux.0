From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 11 Feb 2006 11:38:17 +0000
Subject: [PATCH] sparc32: Fix div, udiv, mul, umul, rem, urem breakage
Message-Id: <20060211113817.GA25564@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Rusty,

Thanks for explaining. As far as I remember this all started with
the cleanup of an ugly #define, but I could be wrong there.

Dave,

The following patch changes the use of "_Div" to "div", etc, to resolve
the following kind of warnings from depmod:
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol div

The patch eliminates the need for another-special-case in modpost and depmod.
Do you remember why this approach wasn't taken immediately?
Please apply.

On Thu, Feb 09, 2006 at 12:29:48PM +1100, Rusty Russell wrote:
> (1) it's just a warning, and it doesn't actually effect anything.
> (2) Someone decided to be clever in arch/sparc/kernel/sparc_ksyms.c
> between 2.6.13 and 2.6.14.  Rather than mangle ".div" to "div", they
> decided to mangle it to "_Div".  The problem is that depmod knows about
> skipping the ".": it's done for other architectures.  It has no idea
> about this new mangling.
> 
> 2.6.12 did it the obvious way, 2.6.13 used asm, and 2.6.14 the new
> scheme.  One wonders what was wrong with 2.6.12, but I haven't been
> following closely.
> 
> Now, possibly there was a legitimate reason not to pollute the namespace
> with these symbols, but they could probably have been made static
> without great concern.
> 
> Hope that clarifies,
> Rusty.

Best regards,
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
--- 2.6.15/arch/sparc/kernel/sparc_ksyms.c.orig	2006-02-09 11:06:57.000000000 +0000
+++ 2.6.15/arch/sparc/kernel/sparc_ksyms.c	2006-02-09 22:47:40.000000000 +0000
@@ -94,12 +94,12 @@
 /* Alias functions whose names begin with "." and export the aliases.
  * The module references will be fixed up by module_frob_arch_sections.
  */
-extern int _Div(int, int);
-extern int _Mul(int, int);
-extern int _Rem(int, int);
-extern unsigned _Udiv(unsigned, unsigned);
-extern unsigned _Umul(unsigned, unsigned);
-extern unsigned _Urem(unsigned, unsigned);
+extern int div(int, int);
+extern int mul(int, int);
+extern int rem(int, int);
+extern unsigned udiv(unsigned, unsigned);
+extern unsigned umul(unsigned, unsigned);
+extern unsigned urem(unsigned, unsigned);
 
 /* used by various drivers */
 EXPORT_SYMBOL(sparc_cpu_model);
@@ -309,12 +309,12 @@
 EXPORT_SYMBOL(__muldi3);
 EXPORT_SYMBOL(__divdi3);
 
-EXPORT_SYMBOL(_Rem);
-EXPORT_SYMBOL(_Urem);
-EXPORT_SYMBOL(_Mul);
-EXPORT_SYMBOL(_Umul);
-EXPORT_SYMBOL(_Div);
-EXPORT_SYMBOL(_Udiv);
+EXPORT_SYMBOL(rem);
+EXPORT_SYMBOL(urem);
+EXPORT_SYMBOL(mul);
+EXPORT_SYMBOL(umul);
+EXPORT_SYMBOL(div);
+EXPORT_SYMBOL(udiv);
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 EXPORT_SYMBOL(do_BUG);
--- 2.6.15/scripts/mod/modpost.c.orig	2006-02-10 11:09:04.000000000 +0000
+++ 2.6.15/scripts/mod/modpost.c	2006-02-10 11:09:09.000000000 +0000
@@ -370,12 +370,6 @@
 			/* Ignore register directives. */
 			if (ELF_ST_TYPE(sym->st_info) = STT_SPARC_REGISTER)
 				break;
- 			if (symname[0] = '.') {
- 				char *munged = strdup(symname);
- 				munged[0] = '_';
- 				munged[1] = toupper(munged[1]);
- 				symname = munged;
- 			}
 		}
 #endif
 		
--- 2.6.15/arch/sparc/kernel/module.c.orig	2006-02-09 11:35:47.000000000 +0000
+++ 2.6.15/arch/sparc/kernel/module.c	2006-02-09 11:37:00.000000000 +0000
@@ -66,8 +66,7 @@
 			else {
 				char *name = strtab + sym[i].st_name;
 				if (name[0] = '.') {
-					name[0] = '_';
-					name[1] = toupper(name[1]);
+					memmove(name, name+1, strlen(name));
 				}
 			}
 		}
--- 2.6.15/arch/sparc/lib/mul.S.orig	2006-02-09 23:27:32.000000000 +0000
+++ 2.6.15/arch/sparc/lib/mul.S	2006-02-09 23:28:53.000000000 +0000
@@ -16,9 +16,9 @@
  */
 
 	.globl .mul
-	.globl _Mul
+	.globl mul
 .mul:
-_Mul:	/* needed for export */
+mul:	/* needed for export */
 	mov	%o0, %y		! multiplier -> Y
 	andncc	%o0, 0xfff, %g0	! test bits 12..31
 	be	Lmul_shortway	! if zero, can do it the short way
--- 2.6.15/arch/sparc/lib/rem.S.orig	2006-02-09 23:22:37.000000000 +0000
+++ 2.6.15/arch/sparc/lib/rem.S	2006-02-09 23:20:26.000000000 +0000
@@ -43,9 +43,9 @@
 
 
 	.globl .rem
-	.globl _Rem
+	.globl rem
 .rem:
-_Rem:	/* needed for export */
+rem:	/* needed for export */
 	! compute sign of result; if neither is negative, no problem
 	orcc	%o1, %o0, %g0	! either negative?
 	bge	2f			! no, go do the divide
--- 2.6.15/arch/sparc/lib/sdiv.S.orig	2006-02-09 23:28:05.000000000 +0000
+++ 2.6.15/arch/sparc/lib/sdiv.S	2006-02-09 23:29:18.000000000 +0000
@@ -43,9 +43,9 @@
 
 
 	.globl .div
-	.globl _Div
+	.globl div
 .div:
-_Div:	/* needed for export */
+div:	/* needed for export */
 	! compute sign of result; if neither is negative, no problem
 	orcc	%o1, %o0, %g0	! either negative?
 	bge	2f			! no, go do the divide
--- 2.6.15/arch/sparc/lib/udiv.S.orig	2006-02-09 23:28:14.000000000 +0000
+++ 2.6.15/arch/sparc/lib/udiv.S	2006-02-09 23:29:32.000000000 +0000
@@ -43,9 +43,9 @@
 
 
 	.globl .udiv
-	.globl _Udiv
+	.globl udiv
 .udiv:
-_Udiv:	/* needed for export */
+udiv:	/* needed for export */
 
 	! Ready to divide.  Compute size of quotient; scale comparand.
 	orcc	%o1, %g0, %o5
--- 2.6.15/arch/sparc/lib/umul.S.orig	2006-02-09 23:27:40.000000000 +0000
+++ 2.6.15/arch/sparc/lib/umul.S	2006-02-09 23:29:06.000000000 +0000
@@ -21,9 +21,9 @@
  */
 
 	.globl .umul
-	.globl _Umul
+	.globl umul
 .umul:
-_Umul:	/* needed for export */
+umul:	/* needed for export */
 	or	%o0, %o1, %o4
 	mov	%o0, %y		! multiplier -> Y
 
--- 2.6.15/arch/sparc/lib/urem.S.orig	2006-02-09 23:26:50.000000000 +0000
+++ 2.6.15/arch/sparc/lib/urem.S	2006-02-09 23:37:55.000000000 +0000
@@ -41,9 +41,9 @@
  */
 
 	.globl .urem
-	.globl _Urem
+	.globl urem
 .urem:
-_Urem:	/* needed for export */
+urem:	/* needed for export */
 
 	! Ready to divide.  Compute size of quotient; scale comparand.
 	orcc	%o1, %g0, %o5
