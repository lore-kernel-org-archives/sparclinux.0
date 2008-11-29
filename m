From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:45 +0000
Subject: [PATCH 01/10] sparc,sparc64: prepare vmlinux.lds.S for unification
Message-Id: <1227996354-11478-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch makes the two vmlinux.lds.S files identical
and serve as documentation for the changes in each file.

This mainly add stuffs to sparc32 that is otherwise only
used by sparc64 and thus it should have no effect.

Build tested only.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/vmlinux.lds.S   |   99 +++++++++++++++++++++++++++++-------
 arch/sparc64/kernel/vmlinux.lds.S |   45 ++++++++++++++---
 2 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 5b7e69a..4bfbeff 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -1,27 +1,55 @@
-/* ld script to make SparcLinux kernel */
+/* ld script for sparc32/sparc64 kernel */
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/page.h>
 
+#ifdef CONFIG_SPARC32
+#define INITIAL_ADDRESS  0x10000 + SIZEOF_HEADERS
+#define TEXTSTART	0xf0004000
+
+#define SMP_CACHE_BYTES_SHIFT 5
+
+#else
+#define SMP_CACHE_BYTES_SHIFT 6
+#define INITIAL_ADDRESS 0x4000
+#define TEXTSTART      0x0000000000404000
+
+#endif
+
+#define SMP_CACHE_BYTES (1 << SMP_CACHE_BYTES_SHIFT)
+
+#ifdef CONFIG_SPARC32
 OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
 OUTPUT_ARCH(sparc)
 ENTRY(_start)
 jiffies = jiffies_64 + 4;
+#else
+/* sparc64 */
+OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
+OUTPUT_ARCH(sparc:v9a)
+ENTRY(_start)
+jiffies = jiffies_64;
+#endif
+
 SECTIONS
 {
-	. = 0x10000 + SIZEOF_HEADERS;
-	.text 0xf0004000 :
+	/* swapper_low_pmd_dir is sparc64 only */
+	swapper_low_pmd_dir = 0x0000000000402000;
+	. = INITIAL_ADDRESS;
+	.text TEXTSTART :
 	{
 		_text = .;
 		*(.text.head)
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
+		KPROBES_TEXT
 		*(.gnu.warning)
 	} = 0
 	_etext = .;
 	PROVIDE (etext = .);
-	RODATA
+
+	RO_DATA(PAGE_SIZE)
 	.data :	{
 		DATA_DATA
 		CONSTRUCTORS
@@ -29,25 +57,32 @@ SECTIONS
 	.data1 : {
 		*(.data1)
 	}
+	. = ALIGN(SMP_CACHE_BYTES);
+	.data.cacheline_aligned : {
+		*(.data.cacheline_aligned)
+	}
+	. = ALIGN(SMP_CACHE_BYTES);
+	.data.read_mostly : {
+		*(.data.read_mostly)
+	}
 	_edata = .;
 	PROVIDE (edata = .);
-
 	.fixup : {
 		__start___fixup = .;
 		*(.fixup)
 		__stop___fixup = .;
 	}
+	. = ALIGN(16);
 	__ex_table : {
 		__start___ex_table = .;
 		*(__ex_table)
 		__stop___ex_table = .;
 	}
-
 	NOTES
 
 	. = ALIGN(PAGE_SIZE);
-	__init_begin = .;
 	.init.text : {
+		__init_begin = .;
 		_sinittext = .;
 		INIT_TEXT
 		_einittext = .;
@@ -65,7 +100,7 @@ SECTIONS
 	.initcall.init : {
 		__initcall_start = .;
 		INITCALLS
-	__initcall_end = .;
+		__initcall_end = .;
 	}
 	.con_initcall.init : {
 		__con_initcall_start = .;
@@ -74,31 +109,54 @@ SECTIONS
 	}
 	SECURITY_INIT
 
+	. = ALIGN(4);
+	.tsb_ldquad_phys_patch : {
+		__tsb_ldquad_phys_patch = .;
+		*(.tsb_ldquad_phys_patch)
+		__tsb_ldquad_phys_patch_end = .;
+	}
+
+	.tsb_phys_patch : {
+		__tsb_phys_patch = .;
+		*(.tsb_phys_patch)
+		__tsb_phys_patch_end = .;
+	}
+
+	.cpuid_patch : {
+		__cpuid_patch = .;
+		*(.cpuid_patch)
+		__cpuid_patch_end = .;
+	}
+
+	.sun4v_1insn_patch : {
+		__sun4v_1insn_patch = .;
+		*(.sun4v_1insn_patch)
+		__sun4v_1insn_patch_end = .;
+	}
+	.sun4v_2insn_patch : {
+		__sun4v_2insn_patch = .;
+		*(.sun4v_2insn_patch)
+		__sun4v_2insn_patch_end = .;
+	}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	. = ALIGN(PAGE_SIZE);
 	.init.ramfs : {
-	__initramfs_start = .;
+		__initramfs_start = .;
 		*(.init.ramfs)
-	__initramfs_end = .;
+		__initramfs_end = .;
 	}
 #endif
 
 	PERCPU(PAGE_SIZE)
+
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-	. = ALIGN(32);
-	.data.cacheline_aligned : {
-		*(.data.cacheline_aligned)
-	}
-	. = ALIGN(32);
-	.data.read_mostly : {
-		*(.data.read_mostly)
-	}
-
 	__bss_start = .;
 	.sbss : {
 		*(.sbss)
-		*(.scommon) }
+		*(.scommon)
+	}
 	.bss : {
 		*(.dynbss)
 		*(.bss)
@@ -106,6 +164,7 @@ SECTIONS
 	}
 	_end = . ;
 	PROVIDE (end = .);
+
 	/DISCARD/ : {
 		EXIT_TEXT
 		EXIT_DATA
diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc64/kernel/vmlinux.lds.S
index 01f8096..4bfbeff 100644
--- a/arch/sparc64/kernel/vmlinux.lds.S
+++ b/arch/sparc64/kernel/vmlinux.lds.S
@@ -1,19 +1,45 @@
-/* ld script to make UltraLinux kernel */
+/* ld script for sparc32/sparc64 kernel */
 
-#include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
+
+#ifdef CONFIG_SPARC32
+#define INITIAL_ADDRESS  0x10000 + SIZEOF_HEADERS
+#define TEXTSTART	0xf0004000
+
+#define SMP_CACHE_BYTES_SHIFT 5
+
+#else
+#define SMP_CACHE_BYTES_SHIFT 6
+#define INITIAL_ADDRESS 0x4000
+#define TEXTSTART      0x0000000000404000
+
+#endif
+
+#define SMP_CACHE_BYTES (1 << SMP_CACHE_BYTES_SHIFT)
 
+#ifdef CONFIG_SPARC32
+OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
+OUTPUT_ARCH(sparc)
+ENTRY(_start)
+jiffies = jiffies_64 + 4;
+#else
+/* sparc64 */
 OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
 OUTPUT_ARCH(sparc:v9a)
 ENTRY(_start)
-
 jiffies = jiffies_64;
+#endif
+
 SECTIONS
 {
+	/* swapper_low_pmd_dir is sparc64 only */
 	swapper_low_pmd_dir = 0x0000000000402000;
-	. = 0x4000;
-	.text 0x0000000000404000 : {
+	. = INITIAL_ADDRESS;
+	.text TEXTSTART :
+	{
 		_text = .;
+		*(.text.head)
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -24,25 +50,27 @@ SECTIONS
 	PROVIDE (etext = .);
 
 	RO_DATA(PAGE_SIZE)
-	.data : {
+	.data :	{
 		DATA_DATA
 		CONSTRUCTORS
 	}
 	.data1 : {
 		*(.data1)
 	}
-	. = ALIGN(64);
+	. = ALIGN(SMP_CACHE_BYTES);
 	.data.cacheline_aligned : {
 		*(.data.cacheline_aligned)
 	}
-	. = ALIGN(64);
+	. = ALIGN(SMP_CACHE_BYTES);
 	.data.read_mostly : {
 		*(.data.read_mostly)
 	}
 	_edata = .;
 	PROVIDE (edata = .);
 	.fixup : {
+		__start___fixup = .;
 		*(.fixup)
+		__stop___fixup = .;
 	}
 	. = ALIGN(16);
 	__ex_table : {
@@ -59,6 +87,7 @@ SECTIONS
 		INIT_TEXT
 		_einittext = .;
 	}
+	__init_text_end = .;
 	.init.data : {
 		INIT_DATA
 	}
-- 
1.5.6.GIT

