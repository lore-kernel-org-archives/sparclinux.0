From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 02 Feb 2004 09:50:05 +0000
Subject: sparc32 module status
Message-Id: <20040202095005.GD22498@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With -rc3 and the patches I've sent so far, plus the one attached
here, I can now load modules, including those that want .udiv and
friends.

This patch is not much different from what I asked people to test a
while back.  I believe Spot mentioned he had some problems with it; I
did as well mainly because mm was broken.

Can people please try this out and confirm whether it works?  If so, I
need to talk with Rusty and the ppc folks and find the right fix for
this.  This version probably breaks ppc64.

=== arch/sparc/kernel/sparc_ksyms.c 1.22 vs edited ==--- 1.22/arch/sparc/kernel/sparc_ksyms.c	Sat Dec 27 01:38:21 2003
+++ edited/arch/sparc/kernel/sparc_ksyms.c	Mon Feb  2 00:07:45 2004
@@ -85,22 +85,41 @@
 
 extern void dump_thread(struct pt_regs *, struct user *);
 
+#ifdef CONFIG_MODULES
 /* One thing to note is that the way the symbols of the mul/div
  * support routines are named is a mess, they all start with
  * a '.' which makes it a bitch to export, here is the trick:
  */
 
-#define EXPORT_SYMBOL_DOT(sym)					\
-extern int __sparc_dot_ ## sym (int) __asm__("." #sym);		\
-const struct kernel_symbol __ksymtab___sparc_dot_##sym		\
-__attribute__((section("__ksymtab")))				\
-= { (unsigned long)&__sparc_dot_##sym , "." #sym }
+#ifdef __GENKSYMS__
+/* XXX If the interface of any DOT or PRIVATE function does ever
+ * XXX change in an incompatible way, you must modify this.
+ */
+#define EXPORT_SYMBOL_DOT(sym)						\
+	extern int __sparc_dot_ ## sym (int, int);			\
+	EXPORT_SYMBOL(__sparc_dot_ ## sym)
+
+#else /* __GENKSYMS__ */
+
+#define EXPORT_SYMBOL_DOT(sym)						\
+	extern int __sparc_dot_ ## sym (int, int) __asm__("." # sym);	\
+	__CRC_SYMBOL(__sparc_dot_ ## sym, "")				\
+	static const char __kstrtab___sparc_dot_##sym[]			\
+	__attribute__((section("__ksymtab_strings")))			\
+	= "." #sym;						\
+	static const struct kernel_symbol __ksymtab___sparc_dot_##sym	\
+	__attribute__((section("__ksymtab")))				\
+	= { (unsigned long)&__sparc_dot_##sym, __kstrtab___sparc_dot_##sym }
+#endif
+
+#define EXPORT_SYMBOL_PRIVATE(sym)					\
+	extern void __ ## sym (void);					\
+	EXPORT_SYMBOL(__ ## sym)
 
-#define EXPORT_SYMBOL_PRIVATE(sym)				\
-extern int __sparc_priv_ ## sym (int) __asm__("__" #sym);	\
-const struct kernel_symbol __export_priv_##sym			\
-__attribute__((section("__ksymtab"))) =				\
-{ (unsigned long) &__sparc_priv_ ## sym, "__" #sym }
+#else /* ! CONFIG_MODULES */
+#define EXPORT_SYMBOL_DOT(sym)
+#define EXPORT_SYMBOL_PRIVATE(sym)
+#endif
 
 /* used by various drivers */
 EXPORT_SYMBOL(sparc_cpu_model);
=== scripts/modpost.c 1.17 vs edited ==--- 1.17/scripts/modpost.c	Mon Jan 19 15:38:10 2004
+++ edited/scripts/modpost.c	Sat Jan 31 21:55:16 2004
@@ -141,17 +141,27 @@
 	symbolhash[hash] = new;
 }
 
+#define DOTSYM_PFX "__sparc_dot_"
+
 struct symbol *
 find_symbol(const char *name)
 {
 	struct symbol *s;
+	const char *match;
+	char nbuf[64 + sizeof(DOTSYM_PFX)];
 
 	/* For our purposes, .foo matches foo.  PPC64 needs this. */
-	if (name[0] = '.')
+	if (name[0] = '.') {
 		name++;
+		strcpy(nbuf, DOTSYM_PFX);
+		strncat(nbuf, name, sizeof(nbuf) - sizeof(DOTSYM_PFX) - 1);
+		nbuf[sizeof(nbuf)-1] = 0;
+		match = nbuf;
+	} else
+		match = name;
 
-	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s=s->next) {
-		if (strcmp(s->name, name) = 0)
+	for (s = symbolhash[tdb_hash(match) % SYMBOL_HASH_SIZE]; s; s=s->next) {
+		if (strcmp(s->name, match) = 0)
 			return s;
 	}
 	return NULL;


-- 
Keith M Wesolowski
