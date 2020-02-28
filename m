From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 28 Feb 2020 03:46:40 +0000
Subject: [PATCH] kbuild: use KBUILD_DEFCONFIG as the fallback for DEFCONFIG_LIST
Message-Id: <20200228034640.25247-1-masahiroy@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200216154502.26478-1-masahiroy@kernel.org>
In-Reply-To: <20200216154502.26478-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>

Most of the Kconfig commands (except defconfig and all*config) read
the .config file as a base set of CONFIG options.

When it does not exist, the files in DEFCONFIG_LIST are searched in
this order and loaded if found.

I do not see much sense in the last two lines in DEFCONFIG_LIST.

[1] ARCH_DEFCONFIG

The entry for DEFCONFIG_LIST is guarded by 'depends on !UML'. So, the
ARCH_DEFCONFIG definition in arch/x86/um/Kconfig is meaningless.

arch/{sh,sparc,x86}/Kconfig define ARCH_DEFCONFIG depending on 32 or
64 bit variant symbols. This is a little bit strange; ARCH_DEFCONFIG
should be a fixed string because the base config file is loaded before
the symbol evaluation stage.

Using KBUILD_DEFCONFIG makes more sense because it is fixed before
Kconfig is invoked. Fortunately, arch/{sh,sparc,x86}/Makefile define it
in the same way, and it works as expected. Hence, replace ARCH_DEFCONFIG
with "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)".

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

I moved the default KBUILD_DEFCONFIG to the top Makefile. Otherwise,
the 7 architectures listed above would end up with endless loop of
syncconfig.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 | 3 +++
 arch/sh/Kconfig          | 5 -----
 arch/sparc/Kconfig       | 5 -----
 arch/x86/Kconfig         | 5 -----
 arch/x86/um/Kconfig      | 5 -----
 init/Kconfig             | 3 +--
 scripts/kconfig/Makefile | 4 ----
 7 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 81d130ad9534..17cc09304561 100644
--- a/Makefile
+++ b/Makefile
@@ -388,6 +388,9 @@ endif
 KCONFIG_CONFIG	?= .config
 export KCONFIG_CONFIG
 
+# Default file for 'make defconfig'. This may be overridden by arch-Makefile.
+export KBUILD_DEFCONFIG := defconfig
+
 # SHELL used by kbuild
 CONFIG_SHELL := sh
 
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
index 20a6ac33761c..240c1ed15c69 100644
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
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5887ceb6229e..c9d0a4a8efb3 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -12,10 +12,6 @@ else
 Kconfig := Kconfig
 endif
 
-ifndef KBUILD_DEFCONFIG
-KBUILD_DEFCONFIG := defconfig
-endif
-
 ifeq ($(quiet),silent_)
 silent := -s
 endif
-- 
2.17.1
