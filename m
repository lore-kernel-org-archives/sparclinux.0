From: Rusty Russell <rusty@rustcorp.com.au>
Date: Sat, 11 Feb 2006 23:54:37 +0000
Subject: Re: [PATCH] sparc32: Fix div, udiv, mul, umul, rem, urem breakage
Message-Id: <1139702078.22363.106.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20060211113817.GA25564@palantir8>
In-Reply-To: <20060211113817.GA25564@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2006-02-11 at 11:38 +0000, Martin Habets wrote:
> Rusty,
> 
> Thanks for explaining. As far as I remember this all started with
> the cleanup of an ugly #define, but I could be wrong there.

It seems so, as Al so comprehensively explained.  It was binutils
breakage.  You might find something like this (note: untested!)
preferable.  Other archs may well want EXPORT_SYMBOL_AS for special
effects anyway.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Make sparc use the same "remove the dot" mangling as other archs, which
depmod already understands.  Avoid namespace pollution (not really a
problem, but ugly) by using an __export_ alias: it needs to be a global
symbol as attempts to craft an alias in the sparc_ksyms.c was rejected
by various recent binutils versions:

 http://marc.theaimsgroup.com/?l=linux-sparc&m2102634105866&w=2
 http://marc.theaimsgroup.com/?l=linux-sparc&m2630905813914&w=2

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/arch/sparc/kernel/module.c working-2.6.16-rc2-git6-sparcsyms/arch/sparc/kernel/module.c
--- linux-2.6.16-rc2-git6/arch/sparc/kernel/module.c	2005-10-31 12:20:31.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/arch/sparc/kernel/module.c	2006-02-12 10:31:08.000000000 +1100
@@ -65,10 +65,8 @@ int module_frob_arch_sections(Elf_Ehdr *
 				sym[i].st_shndx = SHN_ABS;
 			else {
 				char *name = strtab + sym[i].st_name;
-				if (name[0] = '.') {
-					name[0] = '_';
-					name[1] = toupper(name[1]);
-				}
+				if (name[0] = '.')
+					memmove(name, name+1, strlen(name));
 			}
 		}
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/arch/sparc/kernel/sparc_ksyms.c working-2.6.16-rc2-git6-sparcsyms/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.16-rc2-git6/arch/sparc/kernel/sparc_ksyms.c	2006-02-09 12:14:34.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/arch/sparc/kernel/sparc_ksyms.c	2006-02-12 10:43:52.000000000 +1100
@@ -91,15 +91,23 @@ extern void ___rw_read_enter(void);
 extern void ___rw_read_exit(void);
 extern void ___rw_write_enter(void);
 
-/* Alias functions whose names begin with "." and export the aliases.
- * The module references will be fixed up by module_frob_arch_sections.
- */
-extern int _Div(int, int);
-extern int _Mul(int, int);
-extern int _Rem(int, int);
-extern unsigned _Udiv(unsigned, unsigned);
-extern unsigned _Umul(unsigned, unsigned);
-extern unsigned _Urem(unsigned, unsigned);
+/* depmod already trims "." from names to do name matches (for PPC
+ * etc), so we want to use the same scheme.  But simply aliasing div
+ * to .div here breaks on some binutils versions (eg. 2.16.91.0.3).
+ * Putting a global "div" in the asm files works, but we don't want to
+ * pollute the namespace.  So we export "div" via "__export_div". */
+extern int __export_div(int, int);
+extern int __export_mul(int, int);
+extern int __export_rem(int, int);
+extern unsigned __export_udiv(unsigned, unsigned);
+extern unsigned __export_umul(unsigned, unsigned);
+extern unsigned __export_urem(unsigned, unsigned);
+__EXPORT_SYMBOL_AS(__export_div, "div", "");
+__EXPORT_SYMBOL_AS(__export_mul, "mul", "");
+__EXPORT_SYMBOL_AS(__export_rem, "rem", "");
+__EXPORT_SYMBOL_AS(__export_udiv, "udiv", "");
+__EXPORT_SYMBOL_AS(__export_umul, "umul", "");
+__EXPORT_SYMBOL_AS(__export_urem, "urem", "");
 
 /* used by various drivers */
 EXPORT_SYMBOL(sparc_cpu_model);
@@ -309,13 +317,6 @@ EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__muldi3);
 EXPORT_SYMBOL(__divdi3);
 
-EXPORT_SYMBOL(_Rem);
-EXPORT_SYMBOL(_Urem);
-EXPORT_SYMBOL(_Mul);
-EXPORT_SYMBOL(_Umul);
-EXPORT_SYMBOL(_Div);
-EXPORT_SYMBOL(_Udiv);
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 EXPORT_SYMBOL(do_BUG);
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/arch/sparc/lib/mul.S working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/mul.S
--- linux-2.6.16-rc2-git6/arch/sparc/lib/mul.S	2005-10-31 12:20:31.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/mul.S	2006-02-12 10:33:52.000000000 +1100
@@ -16,9 +16,9 @@
  */
 
 	.globl .mul
-	.globl _Mul
+	.globl __export_mul
 .mul:
-_Mul:	/* needed for export */
+__export_mul:
 	mov	%o0, %y		! multiplier -> Y
 	andncc	%o0, 0xfff, %g0	! test bits 12..31
 	be	Lmul_shortway	! if zero, can do it the short way
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/arch/sparc/lib/rem.S working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/rem.S
--- linux-2.6.16-rc2-git6/arch/sparc/lib/rem.S	2005-10-31 12:20:31.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/rem.S	2006-02-12 10:34:06.000000000 +1100
@@ -43,9 +43,9 @@
 
 
 	.globl .rem
-	.globl _Rem
+	.globl __export_rem
 .rem:
-_Rem:	/* needed for export */
+__export_rem:
 	! compute sign of result; if neither is negative, no problem
 	orcc	%o1, %o0, %g0	! either negative?
 	bge	2f			! no, go do the divide
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/arch/sparc/lib/sdiv.S working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/sdiv.S
--- linux-2.6.16-rc2-git6/arch/sparc/lib/sdiv.S	2005-10-31 12:20:31.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/sdiv.S	2006-02-12 10:34:13.000000000 +1100
@@ -43,9 +43,9 @@
 
 
 	.globl .div
-	.globl _Div
+	.globl __export_div
 .div:
-_Div:	/* needed for export */
+__export_div:
 	! compute sign of result; if neither is negative, no problem
 	orcc	%o1, %o0, %g0	! either negative?
 	bge	2f			! no, go do the divide
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/arch/sparc/lib/umul.S working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/umul.S
--- linux-2.6.16-rc2-git6/arch/sparc/lib/umul.S	2005-10-31 12:20:31.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/umul.S	2006-02-12 10:34:32.000000000 +1100
@@ -21,9 +21,9 @@
  */
 
 	.globl .umul
-	.globl _Umul
+	.globl __export_umul
 .umul:
-_Umul:	/* needed for export */
+__export_umul:
 	or	%o0, %o1, %o4
 	mov	%o0, %y		! multiplier -> Y
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/arch/sparc/lib/urem.S working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/urem.S
--- linux-2.6.16-rc2-git6/arch/sparc/lib/urem.S	2005-10-31 12:20:31.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/arch/sparc/lib/urem.S	2006-02-12 10:34:43.000000000 +1100
@@ -41,9 +41,9 @@
  */
 
 	.globl .urem
-	.globl _Urem
+	.globl __export_urem
 .urem:
-_Urem:	/* needed for export */
+__export_urem:
 
 	! Ready to divide.  Compute size of quotient; scale comparand.
 	orcc	%o1, %g0, %o5
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc2-git6/include/linux/module.h working-2.6.16-rc2-git6-sparcsyms/include/linux/module.h
--- linux-2.6.16-rc2-git6/include/linux/module.h	2006-01-10 15:19:50.000000000 +1100
+++ working-2.6.16-rc2-git6-sparcsyms/include/linux/module.h	2006-02-12 10:32:40.000000000 +1100
@@ -182,21 +182,21 @@ void *__symbol_get_gpl(const char *symbo
 #endif
 
 /* For every exported symbol, place a struct in the __ksymtab section */
-#define __EXPORT_SYMBOL(sym, sec)				\
+#define __EXPORT_SYMBOL_AS(sym, name, sec)			\
 	__CRC_SYMBOL(sym, sec)					\
 	static const char __kstrtab_##sym[]			\
 	__attribute__((section("__ksymtab_strings")))		\
-	= MODULE_SYMBOL_PREFIX #sym;                    	\
+	= MODULE_SYMBOL_PREFIX name;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
 	__attribute_used__					\
 	__attribute__((section("__ksymtab" sec), unused))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #define EXPORT_SYMBOL(sym)					\
-	__EXPORT_SYMBOL(sym, "")
+	__EXPORT_SYMBOL_AS(sym, __stringify(sym), "")
 
 #define EXPORT_SYMBOL_GPL(sym)					\
-	__EXPORT_SYMBOL(sym, "_gpl")
+	__EXPORT_SYMBOL_AS(sym, __stringify(sym), "_gpl")
 
 #endif
 

-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

