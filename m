From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 06 Nov 2005 00:40:38 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <20051105.164038.39866257.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 11 Oct 2005 20:03:36 +1000

> > > #define __EXPORT_SPECIAL_SYMBOL(name, sym) \
> > > 	static const char __kstrtab_##name[]			\
> > > 	__attribute__((section("__ksymtab_strings")))		\
> > > 	= MODULE_SYMBOL_PREFIX #name;    			\
> > > 	static const struct kernel_symbol __ksymtab_##name	\
> > > 	__attribute_used__					\
> > > 	__attribute__((section("__ksymtab"), unused))	\
> > > 	= { (unsigned long)&sym, __kstrtab_##name }
> > > 
> > > Note, PPC64 still needs the dot hack because it changes the name of
> > > *every* function symbol.

How is this special export macro supposed to work?

I think I missed the idea whilst trying to implement
your suggestion, as below, but it will not compile:

  CC      arch/sparc/kernel/sparc_ksyms.o
arch/sparc/kernel/sparc_ksyms.c:306: error: parse error before '.' token
arch/sparc/kernel/sparc_ksyms.c:307: error: initializer element is not constant
 ... etc. etc.

diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 787d5f1..122ec88 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -10,7 +10,6 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/string.h>
-#include <linux/ctype.h>
 
 void *module_alloc(unsigned long size)
 {
@@ -37,9 +36,7 @@ void module_free(struct module *mod, voi
            table entries. */
 }
 
-/* Make generic code ignore STT_REGISTER dummy undefined symbols,
- * and replace references to .func with _Func
- */
+/* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
 			      char *secstrings,
@@ -63,13 +60,6 @@ int module_frob_arch_sections(Elf_Ehdr *
 		if (sym[i].st_shndx = SHN_UNDEF) {
 			if (ELF32_ST_TYPE(sym[i].st_info) = STT_REGISTER)
 				sym[i].st_shndx = SHN_ABS;
-			else {
-				char *name = strtab + sym[i].st_name;
-				if (name[0] = '.') {
-					name[0] = '_';
-					name[1] = toupper(name[1]);
-				}
-			}
 		}
 	}
 	return 0;
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 1c8fd0f..ec42853 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -94,16 +94,6 @@ extern void ___rw_read_enter(void);
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
-
 /* used by various drivers */
 EXPORT_SYMBOL(sparc_cpu_model);
 EXPORT_SYMBOL(kernel_thread);
@@ -313,12 +303,12 @@ EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__muldi3);
 EXPORT_SYMBOL(__divdi3);
 
-EXPORT_SYMBOL(_Rem);
-EXPORT_SYMBOL(_Urem);
-EXPORT_SYMBOL(_Mul);
-EXPORT_SYMBOL(_Umul);
-EXPORT_SYMBOL(_Div);
-EXPORT_SYMBOL(_Udiv);
+__EXPORT_SPECIAL_SYMBOL(rem, .rem);
+__EXPORT_SPECIAL_SYMBOL(urem, urem);
+__EXPORT_SPECIAL_SYMBOL(mul, .mul);
+__EXPORT_SPECIAL_SYMBOL(umul, .umul);
+__EXPORT_SPECIAL_SYMBOL(div, .div);
+__EXPORT_SPECIAL_SYMBOL(udiv, .udiv);
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 EXPORT_SYMBOL(do_BUG);
diff --git a/arch/sparc/lib/mul.S b/arch/sparc/lib/mul.S
index da69356..83dffbc 100644
--- a/arch/sparc/lib/mul.S
+++ b/arch/sparc/lib/mul.S
@@ -16,9 +16,7 @@
  */
 
 	.globl .mul
-	.globl _Mul
 .mul:
-_Mul:	/* needed for export */
 	mov	%o0, %y		! multiplier -> Y
 	andncc	%o0, 0xfff, %g0	! test bits 12..31
 	be	Lmul_shortway	! if zero, can do it the short way
diff --git a/arch/sparc/lib/rem.S b/arch/sparc/lib/rem.S
index bf015a9..4450814 100644
--- a/arch/sparc/lib/rem.S
+++ b/arch/sparc/lib/rem.S
@@ -43,9 +43,7 @@
 
 
 	.globl .rem
-	.globl _Rem
 .rem:
-_Rem:	/* needed for export */
 	! compute sign of result; if neither is negative, no problem
 	orcc	%o1, %o0, %g0	! either negative?
 	bge	2f			! no, go do the divide
diff --git a/arch/sparc/lib/sdiv.S b/arch/sparc/lib/sdiv.S
index af94516..e0ad80b 100644
--- a/arch/sparc/lib/sdiv.S
+++ b/arch/sparc/lib/sdiv.S
@@ -43,9 +43,7 @@
 
 
 	.globl .div
-	.globl _Div
 .div:
-_Div:	/* needed for export */
 	! compute sign of result; if neither is negative, no problem
 	orcc	%o1, %o0, %g0	! either negative?
 	bge	2f			! no, go do the divide
diff --git a/arch/sparc/lib/udiv.S b/arch/sparc/lib/udiv.S
index 169e01d..2abfc6b 100644
--- a/arch/sparc/lib/udiv.S
+++ b/arch/sparc/lib/udiv.S
@@ -43,9 +43,7 @@
 
 
 	.globl .udiv
-	.globl _Udiv
 .udiv:
-_Udiv:	/* needed for export */
 
 	! Ready to divide.  Compute size of quotient; scale comparand.
 	orcc	%o1, %g0, %o5
diff --git a/arch/sparc/lib/umul.S b/arch/sparc/lib/umul.S
index f0e5b20..a784720 100644
--- a/arch/sparc/lib/umul.S
+++ b/arch/sparc/lib/umul.S
@@ -21,9 +21,7 @@
  */
 
 	.globl .umul
-	.globl _Umul
 .umul:
-_Umul:	/* needed for export */
 	or	%o0, %o1, %o4
 	mov	%o0, %y		! multiplier -> Y
 
diff --git a/arch/sparc/lib/urem.S b/arch/sparc/lib/urem.S
index 6b92bdc..ec7f0c5 100644
--- a/arch/sparc/lib/urem.S
+++ b/arch/sparc/lib/urem.S
@@ -41,9 +41,7 @@
  */
 
 	.globl .urem
-	.globl _Urem
 .urem:
-_Urem:	/* needed for export */
 
 	! Ready to divide.  Compute size of quotient; scale comparand.
 	orcc	%o1, %g0, %o5
diff --git a/include/linux/module.h b/include/linux/module.h
index 84d75f3..2ef36d1 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -198,6 +198,15 @@ void *__symbol_get_gpl(const char *symbo
 #define EXPORT_SYMBOL_GPL(sym)					\
 	__EXPORT_SYMBOL(sym, "_gpl")
 
+#define __EXPORT_SPECIAL_SYMBOL(name, sym) 			\
+	static const char __kstrtab_##name[]			\
+	__attribute__((section("__ksymtab_strings")))		\
+	= MODULE_SYMBOL_PREFIX #name;    			\
+	static const struct kernel_symbol __ksymtab_##name	\
+	__attribute_used__					\
+	__attribute__((section("__ksymtab"), unused))		\
+	= { (unsigned long)&sym, __kstrtab_##name }
+
 #endif
 
 struct module_ref
@@ -441,6 +450,7 @@ void module_remove_driver(struct device_
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
+#define __EXPORT_SPECIAL_SYMBOL(name, sym)
 
 /* Given an address, look for it in the exception tables. */
 static inline const struct exception_table_entry *
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3bed09e..09ffca5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -370,12 +370,6 @@ handle_modversions(struct module *mod, s
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
 		

