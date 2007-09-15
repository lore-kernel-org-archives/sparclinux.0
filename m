From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Sep 2007 20:04:08 +0000
Subject: [PATCH] sparc64: beautify vmlinux.lds
Message-Id: <20070915200408.GC14858@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[forwarded to list - used wrong address in frst post (as usual) ]

Apply a consistent format to vmlinux.lds.
The file is now to some degree readable.

In addition move several labels inside the braces
such that they reflect the actual start address of a section.

Without this the label would not reflect if ld added alignment.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
buildtested only. But there should be no functional changes.
Will do this for all archs (over time).

	Sam

diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc64/kernel/vmlinux.lds.S
index b982fa3..9fcd503 100644
--- a/arch/sparc64/kernel/vmlinux.lds.S
+++ b/arch/sparc64/kernel/vmlinux.lds.S
@@ -10,105 +10,138 @@ ENTRY(_start)
 jiffies = jiffies_64;
 SECTIONS
 {
-  swapper_low_pmd_dir = 0x0000000000402000;
-  . = 0x4000;
-  .text 0x0000000000404000 :
-  {
-    _text = .;
-    TEXT_TEXT
-    SCHED_TEXT
-    LOCK_TEXT
-    KPROBES_TEXT
-    *(.gnu.warning)
-  } =0
-  _etext = .;
-  PROVIDE (etext = .);
+	swapper_low_pmd_dir = 0x0000000000402000;
+	. = 0x4000;
+	.text 0x0000000000404000 : {
+		_text = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		*(.gnu.warning)
+	} = 0
+	_etext = .;
+	PROVIDE (etext = .);
 
-  RO_DATA(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
+	.data : {
+		DATA_DATA
+		CONSTRUCTORS
+	}
+	.data1 : {
+		*(.data1)
+	}
+	. = ALIGN(64);
+	.data.cacheline_aligned : {
+		*(.data.cacheline_aligned)
+	}
+	. = ALIGN(64);
+	.data.read_mostly : {
+		*(.data.read_mostly)
+	}
+	_edata = .;
+	PROVIDE (edata = .);
+	.fixup : {
+		*(.fixup)
+	}
+	. = ALIGN(16);
+	__ex_table : {
+		__start___ex_table = .;
+		*(__ex_table)
+		__stop___ex_table = .;
+	}
+	NOTES
 
-  .data    :
-  {
-    DATA_DATA
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  . = ALIGN(64);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-  . = ALIGN(64);
-  .data.read_mostly : { *(.data.read_mostly) }
-  _edata  =  .;
-  PROVIDE (edata = .);
-  .fixup   : { *(.fixup) }
+	. = ALIGN(PAGE_SIZE);
+	.init.text : {
+		__init_begin = .;
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
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
+		__initcall_end = .;
+	}
+	.con_initcall.init : {
+		__con_initcall_start = .;
+		*(.con_initcall.init)
+		__con_initcall_end = .;
+	}
+	SECURITY_INIT
 
-  . = ALIGN(16);
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+	. = ALIGN(4);
+	.tsb_ldquad_phys_patch : {
+		__tsb_ldquad_phys_patch = .;
+		*(.tsb_ldquad_phys_patch)
+		__tsb_ldquad_phys_patch_end = .;
+	}
 
-  NOTES
+	.tsb_phys_patch : {
+		__tsb_phys_patch = .;
+		*(.tsb_phys_patch)
+		__tsb_phys_patch_end = .;
+	}
 
-  . = ALIGN(PAGE_SIZE);
-  __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
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
-  . = ALIGN(4);
-  __tsb_ldquad_phys_patch = .;
-  .tsb_ldquad_phys_patch : { *(.tsb_ldquad_phys_patch) }
-  __tsb_ldquad_phys_patch_end = .;
-  __tsb_phys_patch = .;
-  .tsb_phys_patch : { *(.tsb_phys_patch) }
-  __tsb_phys_patch_end = .;
-  __cpuid_patch = .;
-  .cpuid_patch : { *(.cpuid_patch) }
-  __cpuid_patch_end = .;
-  __sun4v_1insn_patch = .;
-  .sun4v_1insn_patch : { *(.sun4v_1insn_patch) }
-  __sun4v_1insn_patch_end = .;
-  __sun4v_2insn_patch = .;
-  .sun4v_2insn_patch : { *(.sun4v_2insn_patch) }
-  __sun4v_2insn_patch_end = .;
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
 
 #ifdef CONFIG_BLK_DEV_INITRD
-  . = ALIGN(PAGE_SIZE);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
+	. = ALIGN(PAGE_SIZE);
+	.init.ramfs : {
+		__initramfs_start = .;
+		*(.init.ramfs)
+		__initramfs_end = .;
+	}
 #endif
 
-  PERCPU(PAGE_SIZE)
+	PERCPU(PAGE_SIZE)
 
-  . = ALIGN(PAGE_SIZE);
-  __init_end = .;
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
+	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
+	__bss_start = .;
+	.sbss : {
+		*(.sbss)
+		*(.scommon)
+	}
+	.bss : {
+		*(.dynbss)
+		*(.bss)
+		*(COMMON)
+	}
+	_end = . ;
+	PROVIDE (end = .);
 
-  STABS_DEBUG
+	/DISCARD/ : {
+		*(.exit.text)
+		*(.exit.data)
+		*(.exitcall.exit)
+	}
 
-  DWARF_DEBUG
+	STABS_DEBUG
+	DWARF_DEBUG
 }

----- End forwarded message -----
