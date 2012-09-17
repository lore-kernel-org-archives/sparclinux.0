From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 17 Sep 2012 15:22:28 +0000
Subject: [PATCH] sparc32: Enable the relocation target R_SPARC_DISP32 for sparc32
Message-Id: <1347895348-24728-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

GNU Binutils 2.20.1 generates .eh_frame sections that uses R_SPARC_DISP32.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/module.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 15e0a16..f42ab3e 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -116,6 +116,11 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 		v = sym->st_value + rel[i].r_addend;
 
 		switch (ELF_R_TYPE(rel[i].r_info) & 0xff) {
+
+		case R_SPARC_DISP32:
+			v -= (Elf_Addr) location;
+			*loc32 = v;
+			break;
 #ifdef CONFIG_SPARC64
 		case R_SPARC_64:
 			location[0] = v >> 56;
@@ -128,11 +133,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 			location[7] = v >>  0;
 			break;
 
-		case R_SPARC_DISP32:
-			v -= (Elf_Addr) location;
-			*loc32 = v;
-			break;
-
 		case R_SPARC_WDISP19:
 			v -= (Elf_Addr) location;
 			*loc32 = (*loc32 & ~0x7ffff) |
-- 
1.7.0.4

