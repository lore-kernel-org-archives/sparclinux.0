From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 May 2007 20:13:11 +0000
Subject: [PATCH 3/5] sparc64: use PAGE_SIZE in vmlinux.lds
Message-Id: <20070524201311.GE1109@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200440.GA1109@uranus.ravnborg.org>
In-Reply-To: <20070524200440.GA1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

sparc64 had hardcoded pagesize to 8192 for alignment.
But optimal alignment is PAGE_SIZE so replace harcoded values
with the PAGE_SIZE constant.
Note: PAGE_SIZE differ with configuration so this is a change
in functionality - see page.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/kernel/vmlinux.lds.S |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc64/kernel/vmlinux.lds.S
index 6f924fd..8559d07 100644
--- a/arch/sparc64/kernel/vmlinux.lds.S
+++ b/arch/sparc64/kernel/vmlinux.lds.S
@@ -1,5 +1,6 @@
 /* ld script to make UltraLinux kernel */
 
+#include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
@@ -22,7 +23,7 @@ SECTIONS
 	_etext = .;
 	PROVIDE (etext = .);
 
-	RODATA
+	RO_DATA(PAGE_SIZE)
 
 	.data : {
 		DATA_DATA
@@ -54,7 +55,7 @@ SECTIONS
 	}
 	__stop___ex_table = .;
 
-	. = ALIGN(8192);
+	. = ALIGN(PAGE_SIZE);
 	__init_begin = .;
 	.init.text : {
 		_sinittext = .;
@@ -117,7 +118,7 @@ SECTIONS
 	__sun4v_2insn_patch_end = .;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	. = ALIGN(8192);
+	. = ALIGN(PAGE_SIZE);
 	__initramfs_start = .;
 	.init.ramfs : {
 		*(.init.ramfs)
@@ -125,13 +126,13 @@ SECTIONS
 	__initramfs_end = .;
 #endif
 
-	. = ALIGN(8192);
+	. = ALIGN(PAGE_SIZE);
 	__per_cpu_start = .;
 	.data.percpu  : {
 		*(.data.percpu)
 	}
 	__per_cpu_end = .;
-	. = ALIGN(8192);
+	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 
 	__bss_start = .;
-- 
1.5.1.rc3.20.gaa453

