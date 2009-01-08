From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 08 Jan 2009 13:15:28 +0000
Subject: [PATCH v3 1/5] sparc: Create a new file lib/ksyms.c and add export
Message-Id: <4965FC70.9010609@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

sparc: Create a new file lib/ksyms.c and add export of all symbols
defined in assembler in lib/ to this file.

Remove the duplicate entries from kernel/sparc_ksyms_*.c

The rationale behind this is that the EXPORT_SYMBOL() should be close to
their definition and we cannot add designate a symbol to be exported in
assembler so at least put it in a file in the same directory.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Additions by Julian Calaby:
* Rebased over sparc-2.6.git HEAD

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---

This is to replace version 2 of this patch as it failed a allmodconfig build.

I won't re-submit patches 2-5 unless they also have bugs in them.

Thanks,

Julian Calaby

 arch/sparc/kernel/sparc_ksyms_32.c |   86 ----------------
 arch/sparc/kernel/sparc_ksyms_64.c |  100 ------------------
 arch/sparc/lib/Makefile            |    1 +
 arch/sparc/lib/ksyms.c             |  196 ++++++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+), 186 deletions(-)
 create mode 100644 arch/sparc/lib/ksyms.c

diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index e1e9763..f4ee14d 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -5,15 +5,12 @@
  * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
  */
 
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
 #define PROMLIB_INTERNAL
 
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/types.h>
-#include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/in6.h>
@@ -55,57 +52,14 @@ struct poll {
 	short revents;
 };
 
-extern void (*__copy_1page)(void *, const void *);
-extern void __memmove(void *, const void *, __kernel_size_t);
-extern void (*bzero_1page)(void *);
-extern void *__bzero(void *, size_t);
-extern void *__memscan_zero(void *, size_t);
-extern void *__memscan_generic(void *, int, size_t);
-extern int __strncmp(const char *, const char *, __kernel_size_t);
-
-extern int __ashrdi3(int, int);
-extern int __ashldi3(int, int);
-extern int __lshrdi3(int, int);
-extern int __muldi3(int, int);
-extern int __divdi3(int, int);
-
-/* Private functions with odd calling conventions. */
-extern void ___atomic24_add(void);
-extern void ___atomic24_sub(void);
-extern void ___rw_read_enter(void);
-extern void ___rw_read_try(void);
-extern void ___rw_read_exit(void);
-extern void ___rw_write_enter(void);
-
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
-#ifdef CONFIG_SMP
-// XXX find what uses (or used) these.   AV: see asm/spinlock.h
-EXPORT_SYMBOL(___rw_read_enter);
-EXPORT_SYMBOL(___rw_read_try);
-EXPORT_SYMBOL(___rw_read_exit);
-EXPORT_SYMBOL(___rw_write_enter);
-#endif
 
 EXPORT_SYMBOL(sparc_valid_addr_bitmap);
 EXPORT_SYMBOL(phys_base);
 EXPORT_SYMBOL(pfn_base);
 
-/* Atomic operations. */
-EXPORT_SYMBOL(___atomic24_add);
-EXPORT_SYMBOL(___atomic24_sub);
-
 /* Per-CPU information table */
 EXPORT_PER_CPU_SYMBOL(__cpu_data);
 
@@ -193,31 +147,8 @@ EXPORT_SYMBOL(__prom_getchild);
 EXPORT_SYMBOL(__prom_getsibling);
 
 /* sparc library symbols */
-EXPORT_SYMBOL(memscan);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(page_kernel);
 
-/* Special internal versions of library functions. */
-EXPORT_SYMBOL(__copy_1page);
-EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(bzero_1page);
-EXPORT_SYMBOL(__bzero);
-EXPORT_SYMBOL(__memscan_zero);
-EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(__strncmp);
-EXPORT_SYMBOL(__memmove);
-
-/* Moving data to/from userspace. */
-EXPORT_SYMBOL(__copy_user);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(__strnlen_user);
-
-/* Networking helper routines. */
-EXPORT_SYMBOL(__csum_partial_copy_sparc_generic);
-EXPORT_SYMBOL(csum_partial);
-
 /* Cache flushing.  */
 EXPORT_SYMBOL(sparc_flush_page_to_ram);
 
@@ -226,23 +157,6 @@ EXPORT_SYMBOL(sun_do_break);
 
 EXPORT_SYMBOL(__ret_efault);
 
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(__muldi3);
-EXPORT_SYMBOL(__divdi3);
-
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
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index 0133211..09874ea 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -5,13 +5,10 @@
  * Copyright (C) 1999 Jakub Jelinek (jj@ultra.linux.cz)
  */
 
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
 #define PROMLIB_INTERNAL
 
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/in6.h>
 #include <linux/pci.h>
@@ -59,10 +56,6 @@ struct poll {
 
 extern void die_if_kernel(char *str, struct pt_regs *regs);
 extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
-extern void *__bzero(void *, size_t);
-extern void *__memscan_zero(void *, size_t);
-extern void *__memscan_generic(void *, int, size_t);
-extern __kernel_size_t strlen(const char *);
 extern void sys_sigsuspend(void);
 extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
@@ -74,22 +67,6 @@ extern int __ashrdi3(int, int);
 
 extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
 
-extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *);
-extern void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *, unsigned long *);
-extern void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *, unsigned long *, unsigned long *);
-
-extern void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *);
-extern void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *, unsigned long *);
-extern void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *, unsigned long *, unsigned long *);
-
 /* Per-CPU information table */
 EXPORT_PER_CPU_SYMBOL(__cpu_data);
 
@@ -103,39 +80,8 @@ EXPORT_SYMBOL(__write_unlock);
 EXPORT_SYMBOL(__write_trylock);
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_MCOUNT
-EXPORT_SYMBOL(_mcount);
-#endif
-
 EXPORT_SYMBOL(sparc64_get_clock_tick);
 
-/* RW semaphores */
-EXPORT_SYMBOL(__down_read);
-EXPORT_SYMBOL(__down_read_trylock);
-EXPORT_SYMBOL(__down_write);
-EXPORT_SYMBOL(__down_write_trylock);
-EXPORT_SYMBOL(__up_read);
-EXPORT_SYMBOL(__up_write);
-EXPORT_SYMBOL(__downgrade_write);
-
-/* Atomic counter implementation. */
-EXPORT_SYMBOL(atomic_add);
-EXPORT_SYMBOL(atomic_add_ret);
-EXPORT_SYMBOL(atomic_sub);
-EXPORT_SYMBOL(atomic_sub_ret);
-EXPORT_SYMBOL(atomic64_add);
-EXPORT_SYMBOL(atomic64_add_ret);
-EXPORT_SYMBOL(atomic64_sub);
-EXPORT_SYMBOL(atomic64_sub_ret);
-
-/* Atomic bit operations. */
-EXPORT_SYMBOL(test_and_set_bit);
-EXPORT_SYMBOL(test_and_clear_bit);
-EXPORT_SYMBOL(test_and_change_bit);
-EXPORT_SYMBOL(set_bit);
-EXPORT_SYMBOL(clear_bit);
-EXPORT_SYMBOL(change_bit);
-
 EXPORT_SYMBOL(__flushw_user);
 
 EXPORT_SYMBOL(tlb_type);
@@ -209,35 +155,10 @@ EXPORT_SYMBOL(prom_getintdefault);
 EXPORT_SYMBOL(__prom_getchild);
 EXPORT_SYMBOL(__prom_getsibling);
 
-/* sparc library symbols */
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(__strlen_user);
-EXPORT_SYMBOL(__strnlen_user);
-
-/* Special internal versions of library functions. */
-EXPORT_SYMBOL(_clear_page);
-EXPORT_SYMBOL(clear_user_page);
-EXPORT_SYMBOL(copy_user_page);
-EXPORT_SYMBOL(__bzero);
-EXPORT_SYMBOL(__memscan_zero);
-EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(__memset);
-
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
-EXPORT_SYMBOL(__csum_partial_copy_from_user);
-EXPORT_SYMBOL(__csum_partial_copy_to_user);
-EXPORT_SYMBOL(ip_fast_csum);
-
 /* Moving data to/from/in userspace. */
-EXPORT_SYMBOL(___copy_to_user);
-EXPORT_SYMBOL(___copy_from_user);
-EXPORT_SYMBOL(___copy_in_user);
 EXPORT_SYMBOL(copy_to_user_fixup);
 EXPORT_SYMBOL(copy_from_user_fixup);
 EXPORT_SYMBOL(copy_in_user_fixup);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(__clear_user);
 
 /* Various address conversion macros use this. */
 EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
@@ -247,17 +168,6 @@ EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
  */
 EXPORT_SYMBOL(__ret_efault);
 
-/* No version information on these, as gcc produces such symbols. */
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strncmp);
-
-void VISenter(void);
-/* RAID code needs this */
-EXPORT_SYMBOL(VISenter);
-
 /* for input/keybdev */
 EXPORT_SYMBOL(sun_do_break);
 EXPORT_SYMBOL(stop_a_enabled);
@@ -271,14 +181,4 @@ EXPORT_SYMBOL(ns87303_lock);
 
 EXPORT_SYMBOL(tick_ops);
 
-EXPORT_SYMBOL(xor_vis_2);
-EXPORT_SYMBOL(xor_vis_3);
-EXPORT_SYMBOL(xor_vis_4);
-EXPORT_SYMBOL(xor_vis_5);
-
-EXPORT_SYMBOL(xor_niagara_2);
-EXPORT_SYMBOL(xor_niagara_3);
-EXPORT_SYMBOL(xor_niagara_4);
-EXPORT_SYMBOL(xor_niagara_5);
-
 EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 375016e..273fc85 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -42,3 +42,4 @@ lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o
 
 obj-y                 += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o
+obj-y                 += ksyms.o
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
new file mode 100644
index 0000000..704b126
--- /dev/null
+++ b/arch/sparc/lib/ksyms.c
@@ -0,0 +1,196 @@
+/*
+ * Export of symbols defined in assembler
+ */
+
+/* Tell string.h we don't want memcpy etc. as cpp defines */
+#define EXPORT_SYMTAB_STROPS
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/checksum.h>
+#include <asm/uaccess.h>
+#include <asm/ftrace.h>
+
+/* string functions */
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(__strlen_user);
+EXPORT_SYMBOL(__strnlen_user);
+EXPORT_SYMBOL(strncmp);
+
+/* mem* functions */
+extern void *__memscan_zero(void *, size_t);
+extern void *__memscan_generic(void *, int, size_t);
+extern void *__bzero(void *, size_t);
+
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(__memscan_zero);
+EXPORT_SYMBOL(__memscan_generic);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(__memset);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(__bzero);
+
+/* Moving data to/from/in userspace. */
+EXPORT_SYMBOL(__strncpy_from_user);
+
+/* Networking helper routines. */
+EXPORT_SYMBOL(csum_partial);
+
+#ifdef CONFIG_MCOUNT
+EXPORT_SYMBOL(_mcount);
+#endif
+
+/*
+ * sparc
+ */
+#ifdef CONFIG_SPARC32
+extern int __ashrdi3(int, int);
+extern int __ashldi3(int, int);
+extern int __lshrdi3(int, int);
+extern int __muldi3(int, int);
+extern int __divdi3(int, int);
+
+extern void (*__copy_1page)(void *, const void *);
+extern void (*bzero_1page)(void *);
+
+extern int __strncmp(const char *, const char *, __kernel_size_t);
+
+extern void ___rw_read_enter(void);
+extern void ___rw_read_try(void);
+extern void ___rw_read_exit(void);
+extern void ___rw_write_enter(void);
+extern void ___atomic24_add(void);
+extern void ___atomic24_sub(void);
+
+/* Alias functions whose names begin with "." and export the aliases.
+ * The module references will be fixed up by module_frob_arch_sections.
+ */
+extern int _Div(int, int);
+extern int _Mul(int, int);
+extern int _Rem(int, int);
+extern unsigned _Udiv(unsigned, unsigned);
+extern unsigned _Umul(unsigned, unsigned);
+extern unsigned _Urem(unsigned, unsigned);
+
+/* Networking helper routines. */
+EXPORT_SYMBOL(__csum_partial_copy_sparc_generic);
+
+/* Special internal versions of library functions. */
+EXPORT_SYMBOL(__copy_1page);
+EXPORT_SYMBOL(__memcpy);
+EXPORT_SYMBOL(__memmove);
+EXPORT_SYMBOL(bzero_1page);
+
+/* string functions */
+EXPORT_SYMBOL(__strncmp);
+
+/* Moving data to/from/in userspace. */
+EXPORT_SYMBOL(__copy_user);
+
+/* Used by asm/spinlock.h */
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(___rw_read_enter);
+EXPORT_SYMBOL(___rw_read_try);
+EXPORT_SYMBOL(___rw_read_exit);
+EXPORT_SYMBOL(___rw_write_enter);
+#endif
+
+/* Atomic operations. */
+EXPORT_SYMBOL(___atomic24_add);
+EXPORT_SYMBOL(___atomic24_sub);
+
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__divdi3);
+
+EXPORT_SYMBOL(_Rem);
+EXPORT_SYMBOL(_Urem);
+EXPORT_SYMBOL(_Mul);
+EXPORT_SYMBOL(_Umul);
+EXPORT_SYMBOL(_Div);
+EXPORT_SYMBOL(_Udiv);
+#endif
+
+/*
+ * sparc64
+ */
+#ifdef CONFIG_SPARC64
+/* Networking helper routines. */
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
+EXPORT_SYMBOL(__csum_partial_copy_from_user);
+EXPORT_SYMBOL(__csum_partial_copy_to_user);
+EXPORT_SYMBOL(ip_fast_csum);
+
+/* Moving data to/from/in userspace. */
+EXPORT_SYMBOL(___copy_to_user);
+EXPORT_SYMBOL(___copy_from_user);
+EXPORT_SYMBOL(___copy_in_user);
+EXPORT_SYMBOL(__clear_user);
+
+/* RW semaphores */
+EXPORT_SYMBOL(__down_read);
+EXPORT_SYMBOL(__down_read_trylock);
+EXPORT_SYMBOL(__down_write);
+EXPORT_SYMBOL(__down_write_trylock);
+EXPORT_SYMBOL(__up_read);
+EXPORT_SYMBOL(__up_write);
+EXPORT_SYMBOL(__downgrade_write);
+
+/* Atomic counter implementation. */
+EXPORT_SYMBOL(atomic_add);
+EXPORT_SYMBOL(atomic_add_ret);
+EXPORT_SYMBOL(atomic_sub);
+EXPORT_SYMBOL(atomic_sub_ret);
+EXPORT_SYMBOL(atomic64_add);
+EXPORT_SYMBOL(atomic64_add_ret);
+EXPORT_SYMBOL(atomic64_sub);
+EXPORT_SYMBOL(atomic64_sub_ret);
+
+/* Atomic bit operations. */
+EXPORT_SYMBOL(test_and_set_bit);
+EXPORT_SYMBOL(test_and_clear_bit);
+EXPORT_SYMBOL(test_and_change_bit);
+EXPORT_SYMBOL(set_bit);
+EXPORT_SYMBOL(clear_bit);
+EXPORT_SYMBOL(change_bit);
+
+/* Special internal versions of library functions. */
+EXPORT_SYMBOL(_clear_page);
+EXPORT_SYMBOL(clear_user_page);
+EXPORT_SYMBOL(copy_user_page);
+
+/* RAID code needs this */
+void VISenter(void);
+EXPORT_SYMBOL(VISenter);
+
+extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
+		unsigned long *);
+extern void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
+		unsigned long *, unsigned long *);
+extern void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
+		unsigned long *, unsigned long *, unsigned long *);
+EXPORT_SYMBOL(xor_vis_2);
+EXPORT_SYMBOL(xor_vis_3);
+EXPORT_SYMBOL(xor_vis_4);
+EXPORT_SYMBOL(xor_vis_5);
+
+extern void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
+		unsigned long *);
+extern void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
+		unsigned long *, unsigned long *);
+extern void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
+		unsigned long *, unsigned long *, unsigned long *);
+
+EXPORT_SYMBOL(xor_niagara_2);
+EXPORT_SYMBOL(xor_niagara_3);
+EXPORT_SYMBOL(xor_niagara_4);
+EXPORT_SYMBOL(xor_niagara_5);
+#endif
