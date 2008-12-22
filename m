From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 22:14:18 +0000
Subject: [PATCH 4/5] sparc64: prepare module_64.c for unification
Message-Id: <1229984059-3743-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o Introduce a helper function
o Combine sparc64 specific case values
o add ifdef's around sparc64 code snippets

Note: The ifdef around the BUG_ON is highly questionable
      but for now the safe approach was taken

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/module_64.c |   62 ++++++++++++++++++++++++++--------------
 1 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/kernel/module_64.c b/arch/sparc/kernel/module_64.c
index 9f7e8d0..4deb887 100644
--- a/arch/sparc/kernel/module_64.c
+++ b/arch/sparc/kernel/module_64.c
@@ -16,6 +16,7 @@
 #include <asm/processor.h>
 #include <asm/spitfire.h>
 
+#ifdef CONFIG_SPARC64
 static void *module_map(unsigned long size)
 {
 	struct vm_struct *area;
@@ -31,6 +32,12 @@ static void *module_map(unsigned long size)
 	return __vmalloc_area(area, GFP_KERNEL, PAGE_KERNEL);
 }
 
+static char *dot2underscore(char *name)
+{
+	return name;
+}
+#endif /* CONFIG_SPARC64 */
+
 void *module_alloc(unsigned long size)
 {
 	void *ret;
@@ -64,7 +71,7 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 {
 	unsigned int symidx;
 	Elf_Sym *sym;
-	const char *strtab;
+	char *strtab;
 	int i;
 
 	for (symidx = 0; sechdrs[symidx].sh_type != SHT_SYMTAB; symidx++) {
@@ -77,9 +84,14 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 	strtab = (char *)sechdrs[sechdrs[symidx].sh_link].sh_addr;
 
 	for (i = 1; i < sechdrs[symidx].sh_size / sizeof(Elf_Sym); i++) {
-		if (sym[i].st_shndx = SHN_UNDEF &&
-		    ELF_ST_TYPE(sym[i].st_info) = STT_REGISTER)
-			sym[i].st_shndx = SHN_ABS;
+		if (sym[i].st_shndx = SHN_UNDEF) {
+			if (ELF_ST_TYPE(sym[i].st_info) = STT_REGISTER) {
+				sym[i].st_shndx = SHN_ABS;
+			} else {
+				char *name = strtab + sym[i].st_name;
+				dot2underscore(name);
+			}
+		}
 	}
 	return 0;
 }
@@ -115,7 +127,9 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 			+ rel[i].r_offset;
 		loc32 = (u32 *) location;
 
+#ifdef CONFIG_SPARC64
 		BUG_ON(((u64)location >> (u64)32) != (u64)0);
+#endif /* CONFIG_SPARC64 */
 
 		/* This is the symbol it is referring to.  Note that all
 		   undefined symbols have been resolved.  */
@@ -124,6 +138,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 		v = sym->st_value + rel[i].r_addend;
 
 		switch (ELF_R_TYPE(rel[i].r_info) & 0xff) {
+#ifdef CONFIG_SPARC64
 		case R_SPARC_64:
 			location[0] = v >> 56;
 			location[1] = v >> 48;
@@ -135,6 +150,25 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 			location[7] = v >>  0;
 			break;
 
+		case R_SPARC_DISP32:
+			v -= (Elf_Addr) location;
+			*loc32 = v;
+			break;
+
+		case R_SPARC_WDISP19:
+			v -= (Elf_Addr) location;
+			*loc32 = (*loc32 & ~0x7ffff) |
+				((v >> 2) & 0x7ffff);
+			break;
+
+		case R_SPARC_OLO10:
+			*loc32 = (*loc32 & ~0x1fff) |
+				(((v & 0x3ff) +
+				  (ELF_R_TYPE(rel[i].r_info) >> 8))
+				 & 0x1fff);
+			break;
+#endif /* CONFIG_SPARC64 */
+
 		case R_SPARC_32:
 			location[0] = v >> 24;
 			location[1] = v >> 16;
@@ -142,11 +176,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 			location[3] = v >>  0;
 			break;
 
-		case R_SPARC_DISP32:
-			v -= (Elf_Addr) location;
-			*loc32 = v;
-			break;
-
 		case R_SPARC_WDISP30:
 			v -= (Elf_Addr) location;
 			*loc32 = (*loc32 & ~0x3fffffff) |
@@ -159,12 +188,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 				((v >> 2) & 0x3fffff);
 			break;
 
-		case R_SPARC_WDISP19:
-			v -= (Elf_Addr) location;
-			*loc32 = (*loc32 & ~0x7ffff) |
-				((v >> 2) & 0x7ffff);
-			break;
-
 		case R_SPARC_LO10:
 			*loc32 = (*loc32 & ~0x3ff) | (v & 0x3ff);
 			break;
@@ -174,13 +197,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 				((v >> 10) & 0x3fffff);
 			break;
 
-		case R_SPARC_OLO10:
-			*loc32 = (*loc32 & ~0x1fff) |
-				(((v & 0x3ff) +
-				  (ELF_R_TYPE(rel[i].r_info) >> 8))
-				 & 0x1fff);
-			break;
-
 		default:
 			printk(KERN_ERR "module %s: Unknown relocation: %x\n",
 			       me->name,
@@ -191,6 +207,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 	return 0;
 }
 
+#ifdef CONFIG_SPARC64
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
@@ -207,6 +224,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 	return 0;
 }
+#endif /* CONFIG_SPARC64 */
 
 void module_arch_cleanup(struct module *mod)
 {
-- 
1.6.0.2.GIT

