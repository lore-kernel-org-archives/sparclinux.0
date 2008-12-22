From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 22:14:19 +0000
Subject: [PATCH 5/5] sparc: unify module.c
Message-Id: <1229984059-3743-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o Copy module_64.c to module.c
o Add all sparc specific bits to module.c
o delete module_32.c
o update Makefile

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/Makefile                  |    2 +-
 arch/sparc/kernel/{module_64.c => module.c} |   24 ++++
 arch/sparc/kernel/module_32.c               |  163 ---------------------------
 3 files changed, 25 insertions(+), 164 deletions(-)
 rename arch/sparc/kernel/{module_64.c => module.c} (91%)
 delete mode 100644 arch/sparc/kernel/module_32.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 59aab6a..53adcaa 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_SPARC64_SMP) += hvtramp.o
 obj-y                     += auxio_$(BITS).o
 obj-$(CONFIG_SUN_PM)      += apc.o pmc.o
 
-obj-$(CONFIG_MODULES)     += module_$(BITS).o
+obj-$(CONFIG_MODULES)     += module.o
 obj-$(CONFIG_MODULES)     += sparc_ksyms_$(BITS).o
 obj-$(CONFIG_SPARC_LED)   += led.o
 obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
diff --git a/arch/sparc/kernel/module_64.c b/arch/sparc/kernel/module.c
similarity index 91%
rename from arch/sparc/kernel/module_64.c
rename to arch/sparc/kernel/module.c
index 4deb887..9027376 100644
--- a/arch/sparc/kernel/module_64.c
+++ b/arch/sparc/kernel/module.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 
@@ -36,6 +37,21 @@ static char *dot2underscore(char *name)
 {
 	return name;
 }
+#else
+static void *module_map(unsigned long size)
+{
+	return vmalloc(size);
+}
+
+/* Replace references to .func with _Func */
+static char *dot2underscore(char *name)
+{
+	if (name[0] = '.') {
+		name[0] = '_';
+                name[1] = toupper(name[1]);
+	}
+	return name;
+}
 #endif /* CONFIG_SPARC64 */
 
 void *module_alloc(unsigned long size)
@@ -170,6 +186,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 #endif /* CONFIG_SPARC64 */
 
 		case R_SPARC_32:
+		case R_SPARC_UA32:
 			location[0] = v >> 24;
 			location[1] = v >> 16;
 			location[2] = v >>  8;
@@ -224,6 +241,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 	return 0;
 }
+#else
+int module_finalize(const Elf_Ehdr *hdr,
+                    const Elf_Shdr *sechdrs,
+                    struct module *me)
+{
+        return 0;
+}
 #endif /* CONFIG_SPARC64 */
 
 void module_arch_cleanup(struct module *mod)
diff --git a/arch/sparc/kernel/module_32.c b/arch/sparc/kernel/module_32.c
deleted file mode 100644
index 598682f..0000000
--- a/arch/sparc/kernel/module_32.c
+++ /dev/null
@@ -1,163 +0,0 @@
-/* Kernel module help for sparc32.
- *
- * Copyright (C) 2001 Rusty Russell.
- * Copyright (C) 2002 David S. Miller.
- */
-
-#include <linux/moduleloader.h>
-#include <linux/kernel.h>
-#include <linux/elf.h>
-#include <linux/vmalloc.h>
-#include <linux/fs.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-
-void *module_alloc(unsigned long size)
-{
-	void *ret;
-
-	/* We handle the zero case fine, unlike vmalloc */
-	if (size = 0)
-		return NULL;
-
-	ret = vmalloc(size);
-	if (!ret)
-		ret = ERR_PTR(-ENOMEM);
-	else
-		memset(ret, 0, size);
-
-	return ret;
-}
-
-/* Free memory returned from module_core_alloc/module_init_alloc */
-void module_free(struct module *mod, void *module_region)
-{
-	vfree(module_region);
-	/* FIXME: If module_region = mod->init_region, trim exception
-           table entries. */
-}
-
-/* Make generic code ignore STT_REGISTER dummy undefined symbols,
- * and replace references to .func with _Func
- */
-int module_frob_arch_sections(Elf_Ehdr *hdr,
-			      Elf_Shdr *sechdrs,
-			      char *secstrings,
-			      struct module *mod)
-{
-	unsigned int symidx;
-	Elf32_Sym *sym;
-	char *strtab;
-	int i;
-
-	for (symidx = 0; sechdrs[symidx].sh_type != SHT_SYMTAB; symidx++) {
-		if (symidx = hdr->e_shnum-1) {
-			printk("%s: no symtab found.\n", mod->name);
-			return -ENOEXEC;
-		}
-	}
-	sym = (Elf32_Sym *)sechdrs[symidx].sh_addr;
-	strtab = (char *)sechdrs[sechdrs[symidx].sh_link].sh_addr;
-
-	for (i = 1; i < sechdrs[symidx].sh_size / sizeof(Elf_Sym); i++) {
-		if (sym[i].st_shndx = SHN_UNDEF) {
-			if (ELF32_ST_TYPE(sym[i].st_info) = STT_REGISTER)
-				sym[i].st_shndx = SHN_ABS;
-			else {
-				char *name = strtab + sym[i].st_name;
-				if (name[0] = '.') {
-					name[0] = '_';
-					name[1] = toupper(name[1]);
-				}
-			}
-		}
-	}
-	return 0;
-}
-
-int apply_relocate(Elf32_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
-		   struct module *me)
-{
-	printk(KERN_ERR "module %s: non-ADD RELOCATION unsupported\n",
-	       me->name);
-	return -ENOEXEC;
-}
-
-int apply_relocate_add(Elf32_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
-		       struct module *me)
-{
-	unsigned int i;
-	Elf32_Rela *rel = (void *)sechdrs[relsec].sh_addr;
-	Elf32_Sym *sym;
-	u8 *location;
-	u32 *loc32;
-
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
-		Elf32_Addr v;
-
-		/* This is where to make the change */
-		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rel[i].r_offset;
-		loc32 = (u32 *) location;
-		/* This is the symbol it is referring to.  Note that all
-		   undefined symbols have been resolved.  */
-		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
-			+ ELF32_R_SYM(rel[i].r_info);
-		v = sym->st_value + rel[i].r_addend;
-
-		switch (ELF32_R_TYPE(rel[i].r_info)) {
-		case R_SPARC_32:
-		case R_SPARC_UA32:
-			location[0] = v >> 24;
-			location[1] = v >> 16;
-			location[2] = v >>  8;
-			location[3] = v >>  0;
-			break;
-
-		case R_SPARC_WDISP30:
-			v -= (Elf32_Addr) location;
-			*loc32 = (*loc32 & ~0x3fffffff) |
-				((v >> 2) & 0x3fffffff);
-			break;
-
-		case R_SPARC_WDISP22:
-			v -= (Elf32_Addr) location;
-			*loc32 = (*loc32 & ~0x3fffff) |
-				((v >> 2) & 0x3fffff);
-			break;
-
-		case R_SPARC_LO10:
-			*loc32 = (*loc32 & ~0x3ff) | (v & 0x3ff);
-			break;
-
-		case R_SPARC_HI22:
-			*loc32 = (*loc32 & ~0x3fffff) |
-				((v >> 10) & 0x3fffff);
-			break;
-
-		default:
-			printk(KERN_ERR "module %s: Unknown relocation: %x\n",
-			       me->name,
-			       (int) (ELF32_R_TYPE(rel[i].r_info) & 0xff));
-			return -ENOEXEC;
-		};
-	}
-	return 0;
-}
-
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
-{
-	return 0;
-}
-
-void module_arch_cleanup(struct module *mod)
-{
-}
-- 
1.6.0.2.GIT

