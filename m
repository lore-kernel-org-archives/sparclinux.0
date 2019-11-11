From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Nov 2019 01:11:06 +0000
Subject: [PATCH] sparc: vdso: Fix build failure seen due to kbuild changes
Message-Id: <20191111011106.18427-1-linux@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Marc Zyngier <maz@kernel.org>

sparc64:allmodconfig fails to build with the following error.

unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
arch/sparc/vdso/vdso32/vclock_gettime.o: failed
make[2]: *** [arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
make[2]: *** Waiting for unfinished jobs....

The problem bisects to commit a3de7a72c517 ("kbuild: change
*FLAGS_<basetarget>.o to take the path relative to $(obj)").
Duplicate the x86 specific defines from this commit to the sparc
vdso Makefile to fix the problem.

Fixes: a3de7a72c517 ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/vdso/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 324a23947585..cb72a205cd7e 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -67,6 +67,7 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS
 #
 CFLAGS_REMOVE_vdso-note.o = -pg
 CFLAGS_REMOVE_vclock_gettime.o = -pg
+CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
@@ -74,6 +75,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf32_sparc -soname linux-gate.so.1
+VDSO_LDFLAGS_vdso32/vdso32.lds = -m elf32_sparc -soname linux-gate.so.1
 
 #This makes sure the $(obj) subdirectory exists even though vdso32/
 #is not a kbuild sub-make subdirectory
-- 
2.17.1
