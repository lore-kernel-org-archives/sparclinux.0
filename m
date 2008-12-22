From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 22:14:17 +0000
Subject: [PATCH 3/5] sparc64: use bit neutral Elf symbols
Message-Id: <1229984059-3743-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To prepare for unification use the bit neutral versions of
the Elf types defined by asm/module.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/module_64.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/kernel/module_64.c b/arch/sparc/kernel/module_64.c
index 158484b..9f7e8d0 100644
--- a/arch/sparc/kernel/module_64.c
+++ b/arch/sparc/kernel/module_64.c
@@ -63,7 +63,7 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      struct module *mod)
 {
 	unsigned int symidx;
-	Elf64_Sym *sym;
+	Elf_Sym *sym;
 	const char *strtab;
 	int i;
 
@@ -73,18 +73,18 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 			return -ENOEXEC;
 		}
 	}
-	sym = (Elf64_Sym *)sechdrs[symidx].sh_addr;
+	sym = (Elf_Sym *)sechdrs[symidx].sh_addr;
 	strtab = (char *)sechdrs[sechdrs[symidx].sh_link].sh_addr;
 
 	for (i = 1; i < sechdrs[symidx].sh_size / sizeof(Elf_Sym); i++) {
 		if (sym[i].st_shndx = SHN_UNDEF &&
-		    ELF64_ST_TYPE(sym[i].st_info) = STT_REGISTER)
+		    ELF_ST_TYPE(sym[i].st_info) = STT_REGISTER)
 			sym[i].st_shndx = SHN_ABS;
 	}
 	return 0;
 }
 
-int apply_relocate(Elf64_Shdr *sechdrs,
+int apply_relocate(Elf_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
 		   unsigned int relsec,
@@ -95,20 +95,20 @@ int apply_relocate(Elf64_Shdr *sechdrs,
 	return -ENOEXEC;
 }
 
-int apply_relocate_add(Elf64_Shdr *sechdrs,
+int apply_relocate_add(Elf_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
 		       unsigned int relsec,
 		       struct module *me)
 {
 	unsigned int i;
-	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
-	Elf64_Sym *sym;
+	Elf_Rela *rel = (void *)sechdrs[relsec].sh_addr;
+	Elf_Sym *sym;
 	u8 *location;
 	u32 *loc32;
 
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
-		Elf64_Addr v;
+		Elf_Addr v;
 
 		/* This is where to make the change */
 		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_addr
@@ -119,11 +119,11 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 		/* This is the symbol it is referring to.  Note that all
 		   undefined symbols have been resolved.  */
-		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
-			+ ELF64_R_SYM(rel[i].r_info);
+		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
+			+ ELF_R_SYM(rel[i].r_info);
 		v = sym->st_value + rel[i].r_addend;
 
-		switch (ELF64_R_TYPE(rel[i].r_info) & 0xff) {
+		switch (ELF_R_TYPE(rel[i].r_info) & 0xff) {
 		case R_SPARC_64:
 			location[0] = v >> 56;
 			location[1] = v >> 48;
@@ -143,24 +143,24 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			break;
 
 		case R_SPARC_DISP32:
-			v -= (Elf64_Addr) location;
+			v -= (Elf_Addr) location;
 			*loc32 = v;
 			break;
 
 		case R_SPARC_WDISP30:
-			v -= (Elf64_Addr) location;
+			v -= (Elf_Addr) location;
 			*loc32 = (*loc32 & ~0x3fffffff) |
 				((v >> 2) & 0x3fffffff);
 			break;
 
 		case R_SPARC_WDISP22:
-			v -= (Elf64_Addr) location;
+			v -= (Elf_Addr) location;
 			*loc32 = (*loc32 & ~0x3fffff) |
 				((v >> 2) & 0x3fffff);
 			break;
 
 		case R_SPARC_WDISP19:
-			v -= (Elf64_Addr) location;
+			v -= (Elf_Addr) location;
 			*loc32 = (*loc32 & ~0x7ffff) |
 				((v >> 2) & 0x7ffff);
 			break;
@@ -177,14 +177,14 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		case R_SPARC_OLO10:
 			*loc32 = (*loc32 & ~0x1fff) |
 				(((v & 0x3ff) +
-				  (ELF64_R_TYPE(rel[i].r_info) >> 8))
+				  (ELF_R_TYPE(rel[i].r_info) >> 8))
 				 & 0x1fff);
 			break;
 
 		default:
 			printk(KERN_ERR "module %s: Unknown relocation: %x\n",
 			       me->name,
-			       (int) (ELF64_R_TYPE(rel[i].r_info) & 0xff));
+			       (int) (ELF_R_TYPE(rel[i].r_info) & 0xff));
 			return -ENOEXEC;
 		};
 	}
-- 
1.6.0.2.GIT

