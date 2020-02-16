From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 16 Feb 2020 15:45:02 +0000
Subject: [PATCH] kbuild: use KBUILD_DEFCONFIG as the fallback for DEFCONFIG_LIST
Message-Id: <20200216154502.26478-1-masahiroy@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kbuild@vger.kernel.org
Cc: x86@kernel.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Nick Hu <nickhu@andestech.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-riscv@lists.infradead.org

Most of the Kconfig commands (except defconfig and all*config) read the
.config file as a base set of CONFIG options.

When it does not exist, the files in DEFCONFIG_LIST are searched in this
order and loaded if found.

I do not see much sense in the last two entries in DEFCONFIG_LIST.

[1] ARCH_DEFCONFIG

The entry for DEFCONFIG_LIST is guarded by 'depends on !UML'. So, the
ARCH_DEFCONFIG definition in arch/x86/um/Kconfig is meaningless.

arch/{sh,sparc,x86}/Kconfig define ARCH_DEFCONFIG depending on 32 or 64
bit variant symbols. This is a little bit strange; ARCH_DEFCONFIG should
be a fixed string because the base config file is loaded before the symbol
evaluation stage.

Using KBUILD_DEFCONFIG is saner because it is fixed before Kconfig is
invoked. Fortunately, arch/{sh,sparc,x86}/Makefile define it in the
same way, and it works as expected. Hence, replace ARCH_DEFCONFIG with
"arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)".

[2] arch/$(ARCH)/defconfig

This file path is no longer valid. The defconfig files are always located
in the arch configs/ directories.

  $ find arch -name defconfig | sort
  arch/alpha/configs/defconfig
  arch/arm64/configs/defconfig
  arch/csky/configs/defconfig
  arch/nds32/configs/defconfig
  arch/riscv/configs/defconfig
  arch/s390/configs/defconfig
  arch/unicore32/configs/defconfig

The path arch/*/configs/defconfig is already covered by
"arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)". So, this file path is
not necessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Kconfig     | 5 -----
 arch/sparc/Kconfig  | 5 -----
 arch/x86/Kconfig    | 5 -----
 arch/x86/um/Kconfig | 5 -----
 init/Kconfig        | 3 +--
 5 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9ece111b0254..b4f0e37b83eb 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -87,11 +87,6 @@ config SUPERH64
 	select HAVE_EXIT_THREAD
 	select KALLSYMS
 
-config ARCH_DEFCONFIG
-	string
-	default "arch/sh/configs/shx3_defconfig" if SUPERH32
-	default "arch/sh/configs/cayman_defconfig" if SUPERH64
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG && SUPERH32
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c1dd6dd642f4..0de15380d1fc 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -95,11 +95,6 @@ config SPARC64
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
 
-config ARCH_DEFCONFIG
-	string
-	default "arch/sparc/configs/sparc32_defconfig" if SPARC32
-	default "arch/sparc/configs/sparc64_defconfig" if SPARC64
-
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..98935f4387f9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -240,11 +240,6 @@ config OUTPUT_FORMAT
 	default "elf32-i386" if X86_32
 	default "elf64-x86-64" if X86_64
 
-config ARCH_DEFCONFIG
-	string
-	default "arch/x86/configs/i386_defconfig" if X86_32
-	default "arch/x86/configs/x86_64_defconfig" if X86_64
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index a8985e1f7432..95d26a69088b 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -27,11 +27,6 @@ config X86_64
 	def_bool 64BIT
 	select MODULES_USE_ELF_RELA
 
-config ARCH_DEFCONFIG
-	string
-	default "arch/um/configs/i386_defconfig" if X86_32
-	default "arch/um/configs/x86_64_defconfig" if X86_64
-
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables" if !64BIT
 	default 64BIT
diff --git a/init/Kconfig b/init/Kconfig
index 452bc1835cd4..6ccdb168dee5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -6,8 +6,7 @@ config DEFCONFIG_LIST
 	default "/lib/modules/$(shell,uname -r)/.config"
 	default "/etc/kernel-config"
 	default "/boot/config-$(shell,uname -r)"
-	default ARCH_DEFCONFIG
-	default "arch/$(ARCH)/defconfig"
+	default "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)"
 
 config CC_IS_GCC
 	def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)
-- 
2.17.1
