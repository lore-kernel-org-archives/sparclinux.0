From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 30 Mar 2004 07:43:21 +0000
Subject: Re: Compiling modules question
Message-Id: <20040330074321.GA4282@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040329201901.GD30251@artsapartment.org>
In-Reply-To: <20040329201901.GD30251@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 30, 2004 at 10:21:12AM +1000, Rusty Russell wrote:

> I really dislike this approach: we already have the code everywhere to
> ignore the first dot, and I'd prefer sparc use that same trick.

Works for me.  Can we put this sucker to bed for good now?

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/29 23:41:46-08:00 wesolows@foobazco.org 
#   [SPARC32]: Update module linking for symbols starting with "."
#   
#   Rusty did not like the __dot_sym approach and suggested instead:
#   
#   1) make rem, urem, mul, umul, div and udiv aliases to .rem, .urem etc:
#   
#      extern int rem(int, int) __attribute__((weak,alias(".rem")));
#   
#   2) EXPORT_SYMBOL(rem) etc.
#   3) Check genksyms recognises that prototype (it should).
#   4) Copy "dedotify" from ppc64 to handle them on load.
#   
#   The only real downside is the risk that someone else will export
#   those names, but I think that's pretty unlikely.
# 
# scripts/modpost.c
#   2004/03/29 23:38:38-08:00 wesolows@foobazco.org +2 -14
#   [SPARC32]: Update module linking for symbols starting with "."
# 
# arch/sparc/kernel/sparc_ksyms.c
#   2004/03/29 23:38:38-08:00 wesolows@foobazco.org +19 -29
#   [SPARC32]: Update module linking for symbols starting with "."
# 
# arch/sparc/kernel/module.c
#   2004/03/29 23:38:38-08:00 wesolows@foobazco.org +13 -5
#   [SPARC32]: Update module linking for symbols starting with "."
# 
diff -Nru a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
--- a/arch/sparc/kernel/module.c	Mon Mar 29 23:42:11 2004
+++ b/arch/sparc/kernel/module.c	Mon Mar 29 23:42:11 2004
@@ -36,7 +36,9 @@
            table entries. */
 }
 
-/* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
+/* Make generic code ignore STT_REGISTER dummy undefined symbols,
+ * and replace references to .func with func as in ppc64's dedotify.
+ */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
 			      char *secstrings,
@@ -44,7 +46,7 @@
 {
 	unsigned int symidx;
 	Elf32_Sym *sym;
-	const char *strtab;
+	char *strtab;
 	int i;
 
 	for (symidx = 0; sechdrs[symidx].sh_type != SHT_SYMTAB; symidx++) {
@@ -57,9 +59,15 @@
 	strtab = (char *)sechdrs[sechdrs[symidx].sh_link].sh_addr;
 
 	for (i = 1; i < sechdrs[symidx].sh_size / sizeof(Elf_Sym); i++) {
-		if (sym[i].st_shndx = SHN_UNDEF &&
-		    ELF32_ST_TYPE(sym[i].st_info) = STT_REGISTER)
-			sym[i].st_shndx = SHN_ABS;
+		if (sym[i].st_shndx = SHN_UNDEF) {
+			if (ELF32_ST_TYPE(sym[i].st_info) = STT_REGISTER)
+				sym[i].st_shndx = SHN_ABS;
+			else {
+				char *name = strtab + sym[i].st_name;
+				if (name[0] = '.')
+					memmove(name, name+1, strlen(name));
+			}
+		}
 	}
 	return 0;
 }
diff -Nru a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
--- a/arch/sparc/kernel/sparc_ksyms.c	Mon Mar 29 23:42:11 2004
+++ b/arch/sparc/kernel/sparc_ksyms.c	Mon Mar 29 23:42:11 2004
@@ -92,31 +92,21 @@
 extern void ___clear_bit(void);
 extern void ___change_bit(void);
 
-/* One thing to note is that the way the symbols of the mul/div
- * support routines are named is a mess, they all start with
- * a '.' which makes it a bitch to export, here is the trick:
+/* Alias functions whose names begin with "." and export the aliases.
+ * The module references will be fixed up by module_frob_arch_sections.
  */
+#define DOT_ALIAS2(__ret, __x, __arg1, __arg2) \
+	extern __ret __x(__arg1, __arg2) \
+	             __attribute__((weak, alias("." # __x)));
+
+DOT_ALIAS2(int, div, int, int)
+DOT_ALIAS2(int, mul, int, int)
+DOT_ALIAS2(int, rem, int, int)
+DOT_ALIAS2(unsigned, udiv, unsigned, unsigned)
+DOT_ALIAS2(unsigned, umul, unsigned, unsigned)
+DOT_ALIAS2(unsigned, urem, unsigned, unsigned)
 
-/* If the interface of any of these special functions does ever
- * change in an incompatible way, you must modify this.
- */
-#define DOT_PROTO(sym) extern int __dot_##sym(int, int)
-
-#ifdef __GENKSYMS__
-#define EXPORT_SYMBOL_DOT(sym)						\
-	DOT_PROTO(sym);							\
-	EXPORT_SYMBOL(__dot_ ## sym)
-#else /* !__GENKSYMS__ */
-#define EXPORT_SYMBOL_DOT(sym)						\
-	DOT_PROTO(sym) __asm__("." # sym);				\
-	__CRC_SYMBOL(__dot_##sym, "")					\
-	static const char __kstrtab___dot_##sym[]			\
-	__attribute__((section("__ksymtab_strings")))			\
-	= "." #sym;							\
-	static const struct kernel_symbol __ksymtab___dot_##sym		\
-	__attribute__((section("__ksymtab")))				\
-	= { (unsigned long)&__dot_##sym, __kstrtab___dot_##sym }
-#endif
+#undef DOT_ALIAS2
 
 /* used by various drivers */
 EXPORT_SYMBOL(sparc_cpu_model);
@@ -325,12 +315,12 @@
 EXPORT_SYMBOL_NOVERS(__muldi3);
 EXPORT_SYMBOL_NOVERS(__divdi3);
 
-EXPORT_SYMBOL_DOT(rem);
-EXPORT_SYMBOL_DOT(urem);
-EXPORT_SYMBOL_DOT(mul);
-EXPORT_SYMBOL_DOT(umul);
-EXPORT_SYMBOL_DOT(div);
-EXPORT_SYMBOL_DOT(udiv);
+EXPORT_SYMBOL(rem);
+EXPORT_SYMBOL(urem);
+EXPORT_SYMBOL(mul);
+EXPORT_SYMBOL(umul);
+EXPORT_SYMBOL(div);
+EXPORT_SYMBOL(udiv);
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 EXPORT_SYMBOL(do_BUG);
diff -Nru a/scripts/modpost.c b/scripts/modpost.c
--- a/scripts/modpost.c	Mon Mar 29 23:42:11 2004
+++ b/scripts/modpost.c	Mon Mar 29 23:42:11 2004
@@ -141,26 +141,14 @@
 	symbolhash[hash] = new;
 }
 
-#define DOTSYM_PFX "__dot_"
-
 struct symbol *
 find_symbol(const char *name)
 {
 	struct symbol *s;
-	char dotname[64 + sizeof(DOTSYM_PFX)];
 
-	/* .foo matches foo.  PPC64 needs this. */
-	if (name[0] = '.') {
+	/* For our purposes, .foo matches foo.  PPC64 needs this. */
+	if (name[0] = '.')
 		name++;
-		strcpy(dotname, DOTSYM_PFX);
-		strncat(dotname, name, sizeof(dotname) - sizeof(DOTSYM_PFX) - 1);
-		dotname[sizeof(dotname)-1] = 0;
-		/* Sparc32 wants .foo to match __dot_foo, try this first. */
-		for (s = symbolhash[tdb_hash(dotname) % SYMBOL_HASH_SIZE]; s; s=s->next) {
-			if (strcmp(s->name, dotname) = 0)
-				return s;
-		}
-	}
 
 	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s=s->next) {
 		if (strcmp(s->name, name) = 0)


-- 
Keith M Wesolowski
