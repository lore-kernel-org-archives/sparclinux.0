From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 21 Apr 2011 18:35:56 +0000
Subject: [PATCH revised v2] sparc32: avoid build warning at mm/percpu.c:1647
Message-Id: <20110421183556.GA27199@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:

mm/percpu.c: In function 'pcpu_embed_first_chunk':
mm/percpu.c:1647:3: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'unsigned int'

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
[sam: added warning message to changelog, use _AC()]
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Use _AC() as pointed out.
Build tested. 

	Sam

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 303bd4d..5b31a8e 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -8,6 +8,8 @@
  *  Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
 
+#include <linux/const.h>
+
 #ifndef __ASSEMBLY__
 #include <asm-generic/4level-fixup.h>
 
@@ -456,9 +458,9 @@ extern int io_remap_pfn_range(struct vm_area_struct *vma,
 
 #endif /* !(__ASSEMBLY__) */
 
-#define VMALLOC_START           0xfe600000
+#define VMALLOC_START           _AC(0xfe600000,UL)
 /* XXX Alter this when I get around to fixing sun4c - Anton */
-#define VMALLOC_END             0xffc00000
+#define VMALLOC_END             _AC(0xffc00000,UL)
 
 
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
