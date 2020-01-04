From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 04 Jan 2020 15:36:51 +0000
Subject: [PATCH] modpost: assume STT_SPARC_REGISTER is defined
Message-Id: <20200104153651.2258-1-masahiroy@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kbuild@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ben Colline <bcollins@debian.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org

Commit 8d5290149ee1 ("[SPARC]: Deal with glibc changing macro names in
modpost.c") was more than 14 years ago. STT_SPARC_REGISTER is hopefully
defined in elf.h of recent C libraries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6e892c93d104..7edfdb2f4497 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -12,6 +12,7 @@
  */
 
 #define _GNU_SOURCE
+#include <elf.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
@@ -729,12 +730,6 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 			break;
 		if (ignore_undef_symbol(info, symname))
 			break;
-/* cope with newer glibc (2.3.4 or higher) STT_ definition in elf.h */
-#if defined(STT_REGISTER) || defined(STT_SPARC_REGISTER)
-/* add compatibility with older glibc */
-#ifndef STT_SPARC_REGISTER
-#define STT_SPARC_REGISTER STT_REGISTER
-#endif
 		if (info->hdr->e_machine = EM_SPARC ||
 		    info->hdr->e_machine = EM_SPARCV9) {
 			/* Ignore register directives. */
@@ -747,7 +742,6 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 				symname = munged;
 			}
 		}
-#endif
 
 		mod->unres = alloc_symbol(symname,
 					  ELF_ST_BIND(sym->st_info) = STB_WEAK,
-- 
2.17.1
