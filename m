From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 15:44:16 +0000
Subject: [PATCH 1/4] fix sparc32 modpost warnings
Message-Id: <20061010154416.GB30909@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Subject: [PATCH 1/4] fix sparc32 modpost warnings

Fix these 2.6.19-rc1 build warnings from modpost:

WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'core_kernel_text' (at offset 0x3e060) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'core_kernel_text' (at offset 0x3e064) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'core_kernel_text' (at offset 0x3e07c) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'core_kernel_text' (at offset 0x3e080) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'is_ksym_addr' (at offset 0x4b3a4) and 'kallsyms_expand_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'is_ksym_addr' (at offset 0x4b3a8) and 'kallsyms_expand_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'is_ksym_addr' (at offset 0x4b3b4) and 'kallsyms_expand_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'is_ksym_addr' (at offset 0x4b3e4) and 'kallsyms_expand_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'get_symbol_pos' (at offset 0x4b640) and 'kallsyms_lookup_size_offset'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'get_symbol_pos' (at offset 0x4b644) and 'kallsyms_lookup_size_offset'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'get_symbol_pos' (at offset 0x4b654) and 'kallsyms_lookup_size_offset'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'get_symbol_pos' (at offset 0x4b658) and 'kallsyms_lookup_size_offset'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'get_symbol_pos' (at offset 0x4b68c) and 'kallsyms_lookup_size_offset'

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: linux/arch/sparc/kernel/vmlinux.lds.S
=================================--- linux.orig/arch/sparc/kernel/vmlinux.lds.S	2006-10-07 04:55:15.000000000 +0100
+++ linux/arch/sparc/kernel/vmlinux.lds.S	2006-10-07 05:00:40.000000000 +0100
@@ -36,11 +36,11 @@
 
   . = ALIGN(4096);
   __init_begin = .;
+  _sinittext = .;
   .init.text : { 
-	_sinittext = .;
 	*(.init.text)
-	_einittext = .;
   }
+  _einittext = .;
   __init_text_end = .;
   .init.data : { *(.init.data) }
   . = ALIGN(16);
