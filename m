From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 15:45:48 +0000
Subject: [PATCH 3/4] fix sparc32 modpost warnings
Message-Id: <20061010154548.GD30909@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix these 2.6.19-rc1 build warnings from modpost:

WARNING: vmlinux - Section mismatch: reference to .init.text:__alloc_bootmem from .text between 'srmmu_nocache_init' (at offset 0x1a0f8) and 'srmmu_mmu_info'
WARNING: vmlinux - Section mismatch: reference to .init.text:__alloc_bootmem from .text between 'srmmu_nocache_init' (at offset 0x1a118) and 'srmmu_mmu_info'
WARNING: vmlinux - Section mismatch: reference to .init.text:srmmu_early_allocate_ptable_skeleton from .text between 'srmmu_nocache_init' (at offset 0x1a188) and 'srmmu_mmu_info'

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: linux/arch/sparc/mm/srmmu.c
=================================--- linux.orig/arch/sparc/mm/srmmu.c	2006-10-06 00:33:30.000000000 +0100
+++ linux/arch/sparc/mm/srmmu.c	2006-10-07 02:35:52.000000000 +0100
@@ -402,7 +402,7 @@
 	srmmu_nocache_end = SRMMU_NOCACHE_VADDR + srmmu_nocache_size;
 }
 
-void srmmu_nocache_init(void)
+void __init srmmu_nocache_init(void)
 {
 	unsigned int bitmap_bits;
 	pgd_t *pgd;
