From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 20:32:27 +0000
Subject: [PATCH revised] sparc32: avoid build warning at mm/percpu.c:1647
Message-Id: <20110420203227.GA3610@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:

mm/percpu.c: In function 'pcpu_embed_first_chunk':
mm/percpu.c:1647:3: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'unsigned int'

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
[sam: added warning message to changelog]
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 303bd4d..5aa2e9c 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -456,9 +456,9 @@ extern int io_remap_pfn_range(struct vm_area_struct *vma,
 
 #endif /* !(__ASSEMBLY__) */
 
-#define VMALLOC_START           0xfe600000
+#define VMALLOC_START           0xfe600000UL
 /* XXX Alter this when I get around to fixing sun4c - Anton */
-#define VMALLOC_END             0xffc00000
+#define VMALLOC_END             0xffc00000UL
 
 
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
