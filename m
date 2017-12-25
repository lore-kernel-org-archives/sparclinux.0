From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 25 Dec 2017 20:54:34 +0000
Subject: [PATCH v5 2/8] module: use relative references for __ksymtab entries
Message-Id: <20171225205440.14575-3-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
entries, each consisting of two 64-bit fields containing absolute
references, to the symbol itself and to a char array containing
its name, respectively.

When we build the same configuration with KASLR enabled, we end
up with an additional ~192 KB of relocations in the .init section,
i.e., one 24 byte entry for each absolute reference, which all need
to be processed at boot time.

Given how the struct kernel_symbol that describes each entry is
completely local to module.c (except for the references emitted
by EXPORT_SYMBOL() itself), we can easily modify it to contain
two 32-bit relative references instead. This reduces the size of
the __ksymtab section by 50% for all 64-bit architectures, and
gets rid of the runtime relocations entirely for architectures
implementing KASLR, either via standard PIE linking (arm64) or
using custom host tools (x86).

Note that the binary search involving __ksymtab contents relies
on each section being sorted by symbol name. This is implemented
based on the input section names, not the names in the ksymtab
entries, so this patch does not interfere with that.

Given that the use of place-relative relocations requires support
both in the toolchain and in the module loader, we cannot enable
this feature for all architectures. So make it dependent on whether
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is defined.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Nicolas Pitre <nico@linaro.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/Kbuild   |  1 +
 arch/x86/include/asm/export.h |  5 ---
 include/asm-generic/export.h  | 12 ++++-
 include/linux/compiler.h      | 11 +++++
 include/linux/export.h        | 46 +++++++++++++++-----
 kernel/module.c               | 33 +++++++++++---
 6 files changed, 84 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 5d6a53fd7521..3e8a88dcaa1d 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -9,5 +9,6 @@ generated-y += xen-hypercalls.h
 generic-y += clkdev.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
+generic-y += export.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/x86/include/asm/export.h b/arch/x86/include/asm/export.h
deleted file mode 100644
index 2a51d66689c5..000000000000
--- a/arch/x86/include/asm/export.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifdef CONFIG_64BIT
-#define KSYM_ALIGN 16
-#endif
-#include <asm-generic/export.h>
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 719db1968d81..97ce606459ae 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -5,12 +5,10 @@
 #define KSYM_FUNC(x) x
 #endif
 #ifdef CONFIG_64BIT
-#define __put .quad
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 8
 #endif
 #else
-#define __put .long
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 4
 #endif
@@ -25,6 +23,16 @@
 #define KSYM(name) name
 #endif
 
+.macro __put, val, name
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	.long	\val - ., \name - .
+#elif defined(CONFIG_64BIT)
+	.quad	\val, \name
+#else
+	.long	\val, \name
+#endif
+.endm
+
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 52e611ab9a6c..fe752d365334 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -327,4 +327,15 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
+/*
+ * Force the compiler to emit 'sym' as a symbol, so that we can reference
+ * it from inline assembler. Necessary in case 'sym' could be inlined
+ * otherwise, or eliminated entirely due to lack of references that are
+ * visibile to the compiler.
+ */
+#define __ADDRESSABLE(sym) \
+	static void *__attribute__((section(".discard.text"), used))	\
+		__PASTE(__discard_##sym, __LINE__)(void)		\
+			{ return (void *)&sym; }			\
+
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/export.h b/include/linux/export.h
index 1a1dfdb2a5c6..5112d0c41512 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -24,12 +24,6 @@
 #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
 
 #ifndef __ASSEMBLY__
-struct kernel_symbol
-{
-	unsigned long value;
-	const char *name;
-};
-
 #ifdef MODULE
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
@@ -60,17 +54,47 @@ extern struct module __this_module;
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#include <linux/compiler.h>
+/*
+ * Emit the ksymtab entry as a pair of relative references: this reduces
+ * the size by half on 64-bit architectures, and eliminates the need for
+ * absolute relocations that require runtime processing on relocatable
+ * kernels.
+ */
+#define __KSYMTAB_ENTRY(sym, sec)					\
+	__ADDRESSABLE(sym)						\
+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.balign	8					\n"	\
+	    VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(sym) "- .		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"	\
+	    "	.previous					\n")
+
+struct kernel_symbol {
+	signed int value_offset;
+	signed int name_offset;
+};
+#else
+#define __KSYMTAB_ENTRY(sym, sec)					\
+	static const struct kernel_symbol __ksymtab_##sym		\
+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
+	= { (unsigned long)&sym, __kstrtab_##sym }
+
+struct kernel_symbol {
+	unsigned long value;
+	const char *name;
+};
+#endif
+
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define ___EXPORT_SYMBOL(sym, sec)					\
 	extern typeof(sym) sym;						\
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
-	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
 	= VMLINUX_SYMBOL_STR(sym);					\
-	static const struct kernel_symbol __ksymtab_##sym		\
-	__used								\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+	__KSYMTAB_ENTRY(sym, sec)
 
 #if defined(__KSYM_DEPS__)
 
diff --git a/kernel/module.c b/kernel/module.c
index dea01ac9cb74..d3a908ffc42c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -549,12 +549,31 @@ static bool check_symbol(const struct symsearch *syms,
 	return true;
 }
 
+static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return (unsigned long)&sym->value_offset + sym->value_offset;
+#else
+	return sym->value;
+#endif
+}
+
+static const char *kernel_symbol_name(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return (const char *)((unsigned long)&sym->name_offset +
+			      sym->name_offset);
+#else
+	return sym->name;
+#endif
+}
+
 static int cmp_name(const void *va, const void *vb)
 {
 	const char *a;
 	const struct kernel_symbol *b;
 	a = va; b = vb;
-	return strcmp(a, b->name);
+	return strcmp(a, kernel_symbol_name(b));
 }
 
 static bool find_symbol_in_section(const struct symsearch *syms,
@@ -2198,7 +2217,7 @@ void *__symbol_get(const char *symbol)
 		sym = NULL;
 	preempt_enable();
 
-	return sym ? (void *)sym->value : NULL;
+	return sym ? (void *)kernel_symbol_value(sym) : NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
@@ -2228,10 +2247,12 @@ static int verify_export_symbols(struct module *mod)
 
 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
-			if (find_symbol(s->name, &owner, NULL, true, false)) {
+			if (find_symbol(kernel_symbol_name(s), &owner, NULL,
+					true, false)) {
 				pr_err("%s: exports duplicate symbol %s"
 				       " (owned by %s)\n",
-				       mod->name, s->name, module_name(owner));
+				       mod->name, kernel_symbol_name(s),
+				       module_name(owner));
 				return -ENOEXEC;
 			}
 		}
@@ -2280,7 +2301,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 			ksym = resolve_symbol_wait(mod, info, name);
 			/* Ok if resolved.  */
 			if (ksym && !IS_ERR(ksym)) {
-				sym[i].st_value = ksym->value;
+				sym[i].st_value = kernel_symbol_value(ksym);
 				break;
 			}
 
@@ -2540,7 +2561,7 @@ static int is_exported(const char *name, unsigned long value,
 		ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
 	else
 		ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
-	return ks != NULL && ks->value = value;
+	return ks != NULL && kernel_symbol_value(ks) = value;
 }
 
 /* As per nm */
-- 
2.11.0

