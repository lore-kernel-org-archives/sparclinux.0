From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Thu, 05 Feb 2004 06:46:30 +0000
Subject: Re: sparc32 module status
Message-Id: <20040205064629.GA18340@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040202095005.GD22498@foobazco.org>
In-Reply-To: <20040202095005.GD22498@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 02, 2004 at 01:22:40PM -0800, David S. Miller wrote:

> Keith, why not just "obj-$(CONFIG_MODULES) += sparc_ksyms.o" then
> remove sparc_ksyms.o from the obj-y in arch/sparc/kernel/Makefile?

I was about to do this, and saw that i386 and sparc64 don't.  It works
fine however.

> Let me know when you have a version of this patch you'd like me to apply.

Will you consider this?

=== arch/sparc/kernel/Makefile 1.17 vs edited ==--- 1.17/arch/sparc/kernel/Makefile	Mon Aug  4 20:55:21 2003
+++ edited/arch/sparc/kernel/Makefile	Tue Feb  3 18:45:25 2004
@@ -12,7 +12,7 @@
 	    sys_sparc.o sunos_asm.o systbls.o \
 	    time.o windows.o cpu.o devices.o sclow.o \
 	    tadpole.o tick14.o ptrace.o sys_solaris.o \
-	    unaligned.o muldiv.o semaphore.o sparc_ksyms.o
+	    unaligned.o muldiv.o semaphore.o
 
 obj-$(CONFIG_PCI) += pcic.o
 obj-$(CONFIG_SUN4) += sun4setup.o
@@ -20,7 +20,7 @@
 obj-$(CONFIG_SUN_AUXIO) += auxio.o
 obj-$(CONFIG_PCI) += ebus.o
 obj-$(CONFIG_SUN_PM) += apc.o pmc.o
-obj-$(CONFIG_MODULES) += module.o
+obj-$(CONFIG_MODULES) += module.o sparc_ksyms.o
 
 ifdef CONFIG_SUNOS_EMUL
 obj-y += sys_sunos.o sunos_ioctl.o
=== arch/sparc/kernel/sparc_ksyms.c 1.22 vs edited ==--- 1.22/arch/sparc/kernel/sparc_ksyms.c	Sat Dec 27 01:38:21 2003
+++ edited/arch/sparc/kernel/sparc_ksyms.c	Wed Feb  4 22:19:15 2004
@@ -85,22 +85,38 @@
 
 extern void dump_thread(struct pt_regs *, struct user *);
 
+/* Private functions with odd calling conventions. */
+extern void ___atomic_add(void);
+extern void ___atomic_sub(void);
+extern void ___set_bit(void);
+extern void ___clear_bit(void);
+extern void ___change_bit(void);
+
 /* One thing to note is that the way the symbols of the mul/div
  * support routines are named is a mess, they all start with
  * a '.' which makes it a bitch to export, here is the trick:
  */
 
-#define EXPORT_SYMBOL_DOT(sym)					\
-extern int __sparc_dot_ ## sym (int) __asm__("." #sym);		\
-const struct kernel_symbol __ksymtab___sparc_dot_##sym		\
-__attribute__((section("__ksymtab")))				\
-= { (unsigned long)&__sparc_dot_##sym , "." #sym }
-
-#define EXPORT_SYMBOL_PRIVATE(sym)				\
-extern int __sparc_priv_ ## sym (int) __asm__("__" #sym);	\
-const struct kernel_symbol __export_priv_##sym			\
-__attribute__((section("__ksymtab"))) =				\
-{ (unsigned long) &__sparc_priv_ ## sym, "__" #sym }
+/* If the interface of any of these special functions does ever
+ * change in an incompatible way, you must modify this.
+ */
+#define DOT_PROTO(sym) extern int __dot_##sym(int, int)
+
+#ifdef __GENKSYMS__
+#define EXPORT_SYMBOL_DOT(sym)						\
+	DOT_PROTO(sym);							\
+	EXPORT_SYMBOL(__dot_ ## sym)
+#else /* !__GENKSYMS__ */
+#define EXPORT_SYMBOL_DOT(sym)						\
+	DOT_PROTO(sym) __asm__("." # sym);				\
+	__CRC_SYMBOL(__dot_##sym, "")					\
+	static const char __kstrtab___dot_##sym[]			\
+	__attribute__((section("__ksymtab_strings")))			\
+	= "." #sym;							\
+	static const struct kernel_symbol __ksymtab___dot_##sym		\
+	__attribute__((section("__ksymtab")))				\
+	= { (unsigned long)&__dot_##sym, __kstrtab___dot_##sym }
+#endif
 
 /* used by various drivers */
 EXPORT_SYMBOL(sparc_cpu_model);
@@ -131,13 +147,13 @@
 EXPORT_SYMBOL(phys_base);
 
 /* Atomic operations. */
-EXPORT_SYMBOL_PRIVATE(_atomic_add);
-EXPORT_SYMBOL_PRIVATE(_atomic_sub);
+EXPORT_SYMBOL(___atomic_add);
+EXPORT_SYMBOL(___atomic_sub);
 
 /* Bit operations. */
-EXPORT_SYMBOL_PRIVATE(_set_bit);
-EXPORT_SYMBOL_PRIVATE(_clear_bit);
-EXPORT_SYMBOL_PRIVATE(_change_bit);
+EXPORT_SYMBOL(___set_bit);
+EXPORT_SYMBOL(___clear_bit);
+EXPORT_SYMBOL(___change_bit);
 
 #ifdef CONFIG_SMP
 /* IRQ implementation. */
=== scripts/modpost.c 1.17 vs edited ==--- 1.17/scripts/modpost.c	Mon Jan 19 15:38:10 2004
+++ edited/scripts/modpost.c	Wed Feb  4 22:03:18 2004
@@ -141,14 +141,26 @@
 	symbolhash[hash] = new;
 }
 
+#define DOTSYM_PFX "__dot_"
+
 struct symbol *
 find_symbol(const char *name)
 {
 	struct symbol *s;
+	char dotname[64 + sizeof(DOTSYM_PFX)];
 
-	/* For our purposes, .foo matches foo.  PPC64 needs this. */
-	if (name[0] = '.')
+	/* .foo matches foo.  PPC64 needs this. */
+	if (name[0] = '.') {
 		name++;
+		strcpy(dotname, DOTSYM_PFX);
+		strncat(dotname, name, sizeof(dotname) - sizeof(DOTSYM_PFX) - 1);
+		dotname[sizeof(dotname)-1] = 0;
+		/* Sparc32 wants .foo to match __dot_foo, try this first. */
+		for (s = symbolhash[tdb_hash(dotname) % SYMBOL_HASH_SIZE]; s; s=s->next) {
+			if (strcmp(s->name, dotname) = 0)
+				return s;
+		}
+	}
 
 	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s=s->next) {
 		if (strcmp(s->name, name) = 0)


-- 
Keith M Wesolowski
