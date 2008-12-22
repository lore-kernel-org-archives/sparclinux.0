From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 18:14:12 +0000
Subject: [PATCH] sparc: unify sections.h
Message-Id: <20081222181412.GA29264@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While doing this use standard names for start/end
so we could use definitions straight from asm-generic
for all the typical symbols.

This also allowed us to drop the use of PROVIDE in the linker
script so sprc is less non-standard on this area.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
Build tested with defconfig for sparc and sparc64.
I do not expect any problems with this patch.

	Sam

 arch/sparc/include/asm/sections.h    |   16 +++++++++-------
 arch/sparc/include/asm/sections_32.h |    6 ------
 arch/sparc/include/asm/sections_64.h |    9 ---------
 arch/sparc/kernel/head_32.S          |    2 +-
 arch/sparc/kernel/vmlinux.lds.S      |    3 ---
 arch/sparc/mm/init_32.c              |   14 +++++++-------
 arch/sparc/mm/sun4c.c                |    4 ++--
 7 files changed, 19 insertions(+), 35 deletions(-)
 delete mode 100644 arch/sparc/include/asm/sections_32.h
 delete mode 100644 arch/sparc/include/asm/sections_64.h

diff --git a/arch/sparc/include/asm/sections.h b/arch/sparc/include/asm/sections.h
index c7c69b0..0b0553b 100644
--- a/arch/sparc/include/asm/sections.h
+++ b/arch/sparc/include/asm/sections.h
@@ -1,8 +1,10 @@
-#ifndef ___ASM_SPARC_SECTIONS_H
-#define ___ASM_SPARC_SECTIONS_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/sections_64.h>
-#else
-#include <asm/sections_32.h>
-#endif
+#ifndef __SPARC_SECTIONS_H
+#define __SPARC_SECTIONS_H
+
+/* nothing to see, move along */
+#include <asm-generic/sections.h>
+
+/* sparc entry point */
+extern char _start[];
+
 #endif
diff --git a/arch/sparc/include/asm/sections_32.h b/arch/sparc/include/asm/sections_32.h
deleted file mode 100644
index 6832841..0000000
--- a/arch/sparc/include/asm/sections_32.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _SPARC_SECTIONS_H
-#define _SPARC_SECTIONS_H
-
-#include <asm-generic/sections.h>
-
-#endif
diff --git a/arch/sparc/include/asm/sections_64.h b/arch/sparc/include/asm/sections_64.h
deleted file mode 100644
index 3f4b9fd..0000000
--- a/arch/sparc/include/asm/sections_64.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef _SPARC64_SECTIONS_H
-#define _SPARC64_SECTIONS_H
-
-/* nothing to see, move along */
-#include <asm-generic/sections.h>
-
-extern char _start[];
-
-#endif
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 51b4042..f0b4b51 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -990,7 +990,7 @@ sun4c_continue_boot:
 
 		/* Zero out our BSS section. */
 		set	__bss_start , %o0	! First address of BSS
-		set	end , %o1		! Last address of BSS
+		set	_end , %o1		! Last address of BSS
 		add	%o0, 0x1, %o0
 1:	
 		stb	%g0, [%o0]
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 59c8d09..7626708 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -49,7 +49,6 @@ SECTIONS
 		*(.gnu.warning)
 	} = 0
 	_etext = .;
-	PROVIDE (etext = .);
 
 	RO_DATA(PAGE_SIZE)
 	.data :	{
@@ -69,7 +68,6 @@ SECTIONS
 	}
 	/* End of data section */
 	_edata = .;
-	PROVIDE (edata = .);
 
 	/* init_task */
 	. = ALIGN(THREAD_SIZE);
@@ -172,7 +170,6 @@ SECTIONS
 		*(COMMON)
 	}
 	_end = . ;
-	PROVIDE (end = .);
 
 	/DISCARD/ : {
 		EXIT_TEXT
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 677c1e1..fec9260 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/poison.h>
 
+#include <asm/sections.h>
 #include <asm/system.h>
 #include <asm/vac-ops.h>
 #include <asm/page.h>
@@ -48,9 +49,6 @@ unsigned long sparc_unmapped_base;
 
 struct pgtable_cache_struct pgt_quicklists;
 
-/* References to section boundaries */
-extern char __init_begin, __init_end, _start, _end, etext , edata;
-
 /* Initial ramdisk setup */
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
@@ -450,9 +448,9 @@ void __init mem_init(void)
 	
 	totalram_pages += totalhigh_pages;
 
-	codepages = (((unsigned long) &etext) - ((unsigned long)&_start));
+	codepages = (((unsigned long) &_etext) - ((unsigned long)&_start));
 	codepages = PAGE_ALIGN(codepages) >> PAGE_SHIFT;
-	datapages = (((unsigned long) &edata) - ((unsigned long)&etext));
+	datapages = (((unsigned long) &_edata) - ((unsigned long)&_etext));
 	datapages = PAGE_ALIGN(datapages) >> PAGE_SHIFT;
 	initpages = (((unsigned long) &__init_end) - ((unsigned long) &__init_begin));
 	initpages = PAGE_ALIGN(initpages) >> PAGE_SHIFT;
@@ -476,8 +474,10 @@ void __init mem_init(void)
 void free_initmem (void)
 {
 	unsigned long addr;
+	unsigned long freed;
 
 	addr = (unsigned long)(&__init_begin);
+	freed = (unsigned long)(&__init_end) - addr;
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		struct page *p;
 
@@ -490,8 +490,8 @@ void free_initmem (void)
 		totalram_pages++;
 		num_physpages++;
 	}
-	printk(KERN_INFO "Freeing unused kernel memory: %dk freed\n",
-		(&__init_end - &__init_begin) >> 10);
+	printk(KERN_INFO "Freeing unused kernel memory: %ldk freed\n",
+		freed >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index ad0ce11..2ffacd6 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 
+#include <asm/sections.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
@@ -1951,7 +1952,6 @@ void sun4c_update_mmu_cache(struct vm_area_struct *vma, unsigned long address, p
 }
 
 extern void sparc_context_init(int);
-extern unsigned long end;
 extern unsigned long bootmem_init(unsigned long *pages_avail);
 extern unsigned long last_valid_pfn;
 
@@ -1962,7 +1962,7 @@ void __init sun4c_paging_init(void)
 	extern struct resource sparc_iomap;
 	unsigned long end_pfn, pages_avail;
 
-	kernel_end = (unsigned long) &end;
+	kernel_end = (unsigned long) &_end;
 	kernel_end = SUN4C_REAL_PGDIR_ALIGN(kernel_end);
 
 	pages_avail = 0;
-- 
1.6.0.2.GIT

