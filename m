From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Sep 2007 20:02:24 +0000
Subject: [PATCH] sparc: beautify vmlinux.lds
Message-Id: <20070915200224.GB14858@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Make vmlinux.lds almost readable.
When going through the file fixed the following:
- Use PAGE_SIZE as replacement for hardcoded 4096
- Moves label definitions inside {} to avoid ld alignment
  that may be added between label and section

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
Build tested only.
Will do this for all archs over time.

PS. I expect that Davem will apply this and a similar
one for sparc64 I already sent.

	Sam

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 15109c1..a8b4200 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -1,6 +1,7 @@
 /* ld script to make SparcLinux kernel */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
 
 OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
 OUTPUT_ARCH(sparc)
@@ -8,84 +9,104 @@ ENTRY(_start)
 jiffies = jiffies_64 + 4;
 SECTIONS
 {
-  . = 0x10000 + SIZEOF_HEADERS;
-  .text 0xf0004000 :
-  {
-    _text = .;
-    TEXT_TEXT
-    SCHED_TEXT
-    LOCK_TEXT
-    *(.gnu.warning)
-  } =0
-  _etext = .;
-  PROVIDE (etext = .);
-  RODATA
-  .data    :
-  {
-    DATA_DATA
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  _edata  =  .;
-  PROVIDE (edata = .);
-  __start___fixup = .;
-  .fixup   : { *(.fixup) }
-  __stop___fixup = .;
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+	. = 0x10000 + SIZEOF_HEADERS;
+	.text 0xf0004000 :
+	{
+		_text = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		*(.gnu.warning)
+	} = 0
+	_etext = .;
+	PROVIDE (etext = .);
+	RODATA
+	.data :	{
+		DATA_DATA
+		CONSTRUCTORS
+	}
+	.data1 : {
+		*(.data1)
+	}
+	_edata = .;
+	PROVIDE (edata = .);
 
-  NOTES
+	.fixup : {
+		__start___fixup = .;
+		*(.fixup)
+		__stop___fixup = .;
+	}
+	__ex_table : {
+		__start___ex_table = .;
+		*(__ex_table)
+		__stop___ex_table = .;
+	}
 
-  . = ALIGN(4096);
-  __init_begin = .;
-  _sinittext = .;
-  .init.text : { 
-	*(.init.text)
-  }
-  _einittext = .;
-  __init_text_end = .;
-  .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	INITCALLS
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
-  SECURITY_INIT
+	NOTES
+
+	. = ALIGN(PAGE_SIZE);
+	__init_begin = .;
+	.init.text : {
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
+	__init_text_end = .;
+	.init.data : {
+		*(.init.data)
+	}
+	. = ALIGN(16);
+	.init.setup : {
+		__setup_start = .;
+		*(.init.setup)
+		__setup_end = .;
+	}
+	.initcall.init : {
+		__initcall_start = .;
+		INITCALLS
+	__initcall_end = .;
+	}
+	.con_initcall.init : {
+		__con_initcall_start = .;
+		*(.con_initcall.init)
+		__con_initcall_end = .;
+	}
+	SECURITY_INIT
 
 #ifdef CONFIG_BLK_DEV_INITRD
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
+	. = ALIGN(PAGE_SIZE);
+	.init.ramfs : {
+	__initramfs_start = .;
+		*(.init.ramfs)
+	__initramfs_end = .;
+	}
 #endif
 
-  PERCPU(4096)
-  . = ALIGN(4096);
-  __init_end = .;
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  __bss_start = .;
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
-  _end = . ;
-  PROVIDE (end = .);
-  /DISCARD/ : { *(.exit.text) *(.exit.data) *(.exitcall.exit) }
+	PERCPU(PAGE_SIZE)
+	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
+	. = ALIGN(32);
+	.data.cacheline_aligned : {
+		*(.data.cacheline_aligned)
+	}
 
-  STABS_DEBUG
+	__bss_start = .;
+	.sbss : {
+		*(.sbss)
+		*(.scommon) }
+	.bss : {
+		*(.dynbss)
+		*(.bss)
+		*(COMMON)
+	}
+	_end = . ;
+	PROVIDE (end = .);
+	/DISCARD/ : {
+		*(.exit.text)
+		*(.exit.data)
+		*(.exitcall.exit)
+	}
 
-  DWARF_DEBUG
+	STABS_DEBUG
+	DWARF_DEBUG
 }
