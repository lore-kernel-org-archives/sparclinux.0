From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 09:57:28 +0000
Subject: [PATCH] sparc32: avoid build warning at mm/percpu.c:1647
Message-Id: <1303293448-13168-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/pgtable_32.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
1.5.4

