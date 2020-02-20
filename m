From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 20 Feb 2020 07:11:40 +0000
Subject: [PATCH 2/2] compiler: Remove CONFIG_OPTIMIZE_INLINING entirely
Message-Id: <20200220071140.14080-2-masahiroy@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200220071140.14080-1-masahiroy@kernel.org>
In-Reply-To: <20200220071140.14080-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, clang-built-linux@googlegroups.com, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org

Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") made this always-on option. We released v5.4 and v5.5
including that commit.

Remove the CONFIG option and clean up the code now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/configs/i386_defconfig   |  1 -
 arch/x86/configs/x86_64_defconfig |  1 -
 include/linux/compiler_types.h    | 11 +----------
 kernel/configs/tiny.config        |  1 -
 lib/Kconfig.debug                 | 12 ------------
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 59ce9ed58430..d961d831c266 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -288,7 +288,6 @@ CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_RODATA_TEST is not set
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_OPTIMIZE_INLINING=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0b9654c7a05c..4826254c6140 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -285,7 +285,6 @@ CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_RODATA_TEST is not set
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_OPTIMIZE_INLINING=y
 CONFIG_UNWINDER_ORC=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c..e970f97a7fcb 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -129,22 +129,13 @@ struct ftrace_likely_data {
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
- * Force always-inline if the user requests it so via the .config.
  * Prefer gnu_inline, so that extern inline functions do not emit an
  * externally visible function. This makes extern inline behave as per gnu89
  * semantics rather than c99. This prevents multiple symbol definition errors
  * of extern inline functions at link time.
  * A lot of inline functions can cause havoc with function tracing.
- * Do not use __always_inline here, since currently it expands to inline again
- * (which would break users of __always_inline).
  */
-#if !defined(CONFIG_OPTIMIZE_INLINING)
-#define inline inline __attribute__((__always_inline__)) __gnu_inline \
-	__inline_maybe_unused notrace
-#else
-#define inline inline                                    __gnu_inline \
-	__inline_maybe_unused notrace
-#endif
+#define inline inline __gnu_inline __inline_maybe_unused notrace
 
 /*
  * gcc provides both __inline__ and __inline as alternate spellings of
diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index 7fa0c4ae6394..8a44b93da0f3 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -6,7 +6,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KERNEL_XZ=y
 # CONFIG_KERNEL_LZO is not set
 # CONFIG_KERNEL_LZ4 is not set
-CONFIG_OPTIMIZE_INLINING=y
 # CONFIG_SLAB is not set
 # CONFIG_SLUB is not set
 CONFIG_SLOB=y
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df00..5abde39c3c69 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -305,18 +305,6 @@ config HEADERS_INSTALL
 	  user-space program samples. It is also needed by some features such
 	  as uapi header sanity checks.
 
-config OPTIMIZE_INLINING
-	def_bool y
-	help
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  enabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc 4.x and above to make the
-	  decision will become the default in the future. Until then this option
-	  is there to test gcc for this.
-
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1
