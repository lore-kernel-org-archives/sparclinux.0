From: zengzhaoxiu@163.com
Date: Thu, 28 Apr 2016 11:43:42 +0000
Subject: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Because some architectures (alpha, armv6, etc.) don't provide hardware division,
the mod operation is slow! Binary GCD algorithm uses simple arithmetic operations,
it replaces division with arithmetic shifts, comparisons, and subtractions.

I have compiled successfully with x86_64_defconfig and i386_defconfig.

Changes to V2:
- Add a new Kconfig variable CPU_NO_EFFICIENT_FFS
- Separate into two versions by CPU_NO_EFFICIENT_FFS
- Return directly from the loop, rather than using break().
- Use "r &= -r" mostly because it's clearer.
- Improve a little bit in even/odd version

Changes to V1:
- Don't touch Kconfig, remove the Euclidean algorithm implementation
- Don't use the "even-odd" variant
- Use __ffs if the CPU has efficient __ffs

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Signed-off-by: George Spelvin <linux@horizon.com>
---
 arch/Kconfig                         |  3 ++
 arch/alpha/Kconfig                   |  1 +
 arch/arm/mm/Kconfig                  |  3 ++
 arch/h8300/Kconfig                   |  1 +
 arch/m32r/Kconfig                    |  1 +
 arch/m68k/Kconfig.cpu                | 11 ++++++
 arch/metag/Kconfig                   |  1 +
 arch/microblaze/Kconfig              |  1 +
 arch/mips/include/asm/cpu-features.h |  3 ++
 arch/nios2/Kconfig                   |  1 +
 arch/openrisc/Kconfig                |  1 +
 arch/parisc/Kconfig                  |  1 +
 arch/score/Kconfig                   |  1 +
 arch/sh/Kconfig                      |  1 +
 arch/sparc/Kconfig                   |  1 +
 lib/gcd.c                            | 66 +++++++++++++++++++++++++++++++-----
 16 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 81869a5..275f17d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -638,4 +638,7 @@ config COMPAT_OLD_SIGACTION
 config ARCH_NO_COHERENT_DMA_MMAP
 	bool
 
+config CPU_NO_EFFICIENT_FFS
+	def_bool n
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 9d8a858..44e6f05 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -27,6 +27,7 @@ config ALPHA
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
+	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5534766..cb569b6 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -421,18 +421,21 @@ config CPU_32v3
 	select CPU_USE_DOMAINS if MMU
 	select NEED_KUSER_HELPERS
 	select TLS_REG_EMUL if SMP || !MMU
+	select CPU_NO_EFFICIENT_FFS
 
 config CPU_32v4
 	bool
 	select CPU_USE_DOMAINS if MMU
 	select NEED_KUSER_HELPERS
 	select TLS_REG_EMUL if SMP || !MMU
+	select CPU_NO_EFFICIENT_FFS
 
 config CPU_32v4T
 	bool
 	select CPU_USE_DOMAINS if MMU
 	select NEED_KUSER_HELPERS
 	select TLS_REG_EMUL if SMP || !MMU
+	select CPU_NO_EFFICIENT_FFS
 
 config CPU_32v5
 	bool
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 986ea84..aa232de 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -20,6 +20,7 @@ config H8300
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_ARCH_KGDB
+	select CPU_NO_EFFICIENT_FFS
 
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index c82b292..3cc8498 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -17,6 +17,7 @@ config M32R
 	select ARCH_USES_GETTIMEOFFSET
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
+	select CPU_NO_EFFICIENT_FFS
 
 config SBUS
 	bool
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 0dfcf12..0b6efe8 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -40,6 +40,7 @@ config M68000
 	select CPU_HAS_NO_MULDIV64
 	select CPU_HAS_NO_UNALIGNED
 	select GENERIC_CSUM
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  The Freescale (was Motorola) 68000 CPU is the first generation of
 	  the well known M68K family of processors. The CPU core as well as
@@ -51,6 +52,7 @@ config MCPU32
 	bool
 	select CPU_HAS_NO_BITFIELDS
 	select CPU_HAS_NO_UNALIGNED
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  The Freescale (was then Motorola) CPU32 is a CPU core that is
 	  based on the 68020 processor. For the most part it is used in
@@ -130,6 +132,7 @@ config M5206
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5206 processor support.
 
@@ -138,6 +141,7 @@ config M5206e
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5206e processor support.
 
@@ -163,6 +167,7 @@ config M5249
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5249 processor support.
 
@@ -171,6 +176,7 @@ config M525x
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Freescale (Motorola) Coldfire 5251/5253 processor support.
 
@@ -189,6 +195,7 @@ config M5272
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5272 processor support.
 
@@ -217,6 +224,7 @@ config M5307
 	select COLDFIRE_SW_A7
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5307 processor support.
 
@@ -242,6 +250,7 @@ config M5407
 	select COLDFIRE_SW_A7
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5407 processor support.
 
@@ -251,6 +260,7 @@ config M547x
 	select MMU_COLDFIRE if MMU
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Freescale ColdFire 5470/5471/5472/5473/5474/5475 processor support.
 
@@ -260,6 +270,7 @@ config M548x
 	select M54xx
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Freescale ColdFire 5480/5481/5482/5483/5484/5485 processor support.
 
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index a0fa88d..2ac2de6 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -29,6 +29,7 @@ config METAG
 	select OF
 	select OF_EARLY_FLATTREE
 	select SPARSE_IRQ
+	select CPU_NO_EFFICIENT_FFS
 
 config STACKTRACE_SUPPORT
 	def_bool y
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3d793b5..f17c3a4 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -32,6 +32,7 @@ config MICROBLAZE
 	select OF_EARLY_FLATTREE
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
+	select CPU_NO_EFFICIENT_FFS
 
 config SWAP
 	def_bool n
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index eeec8c8..fd4ae7d 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -288,6 +288,9 @@
 #ifndef cpu_has_clo_clz
 #define cpu_has_clo_clz	cpu_has_mips_r
 #endif
+#if !cpu_has_clo_clz
+#define CONFIG_CPU_NO_EFFICIENT_FFS 1
+#endif
 
 /*
  * MIPS32 R2, MIPS64 R2, Loongson 3A and Octeon have WSBH.
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 4375554..f10bd2c 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -16,6 +16,7 @@ config NIOS2
 	select SOC_BUS
 	select SPARSE_IRQ
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
+	select CPU_NO_EFFICIENT_FFS
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e118c02..142cb05 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -25,6 +25,7 @@ config OPENRISC
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
+	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 
 config MMU
 	def_bool y
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 88cfaa8..3d498a6 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -32,6 +32,7 @@ config PARISC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select CPU_NO_EFFICIENT_FFS
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 366e1b5..507d631 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -14,6 +14,7 @@ config SCORE
 	select VIRT_TO_BUS
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
+	select CPU_NO_EFFICIENT_FFS
 
 choice
 	prompt "System type"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ed20fc..56cf5e5 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -44,6 +44,7 @@ config SUPERH
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
 	select HAVE_ARCH_AUDITSYSCALL
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 57ffaf2..ca675ed 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -42,6 +42,7 @@ config SPARC
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select ARCH_HAS_SG_CHAIN
+	select CPU_NO_EFFICIENT_FFS
 
 config SPARC32
 	def_bool !64BIT
diff --git a/lib/gcd.c b/lib/gcd.c
index 3657f12..eba7d4e 100644
--- a/lib/gcd.c
+++ b/lib/gcd.c
@@ -2,20 +2,68 @@
 #include <linux/gcd.h>
 #include <linux/export.h>
 
-/* Greatest common divisor */
+/*
+ * This implements the binary GCD algorithm. (Often attributed to Stein,
+ * but as Knuth has noted, appears a first-century Chinese math text.)
+ *
+ * This is faster than the division-based algorithm even on x86, which
+ * has decent hardware division.
+ */
+
+#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS)
+
+/* If __ffs is available, the even/odd algorithm benchmarks slower. */
 unsigned long gcd(unsigned long a, unsigned long b)
 {
-	unsigned long r;
+	unsigned long r = a | b;
+
+	if (!a || !b)
+		return r;
 
-	if (a < b)
-		swap(a, b);
+	b >>= __ffs(b);
 
-	if (!b)
-		return a;
-	while ((r = a % b) != 0) {
-		a = b;
-		b = r;
+	for (;;) {
+		a >>= __ffs(a);
+		if (a = b)
+			return a << __ffs(r);
+		if (a < b)
+			swap(a, b);
+		a -= b;
 	}
+}
+
+#else
+
+/* If normalization is done by loops, the even/odd algorithm is a win. */
+unsigned long gcd(unsigned long a, unsigned long b)
+{
+	unsigned long r = a | b;
+
+	if (!a || !b)
+		return r;
+
+	/* Isolate lsbit of r */
+	r &= -r;
+
+	while (!(a & r))
+		a >>= 1;
+	while (!(b & r))
+		b >>= 1;
+
+	while (a != b) {
+		if (a < b)
+			swap(a, b);
+		a -= b;
+
+		a >>= 1;
+		if (a & r)
+			a += b;
+		do a >>= 1; while (!(a & r));
+	}
+
 	return b;
 }
+
+#endif
+
 EXPORT_SYMBOL_GPL(gcd);
-- 
2.5.0


