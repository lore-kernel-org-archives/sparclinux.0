From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Apr 2014 07:57:34 +0000
Subject: [PATCH 1/4] sparc: move page_to_phys to page.h
Message-Id: <1398499057-21497-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Preparation for introducing asm-generic/io.h this move was required.
In asm-generic page_to_phys is placed in page.h - so do the same here.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io_32.h | 2 --
 arch/sparc/include/asm/io_64.h | 1 -
 arch/sparc/include/asm/page.h  | 3 +++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index c1acbd8..271c94a 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -8,8 +8,6 @@
 #include <asm/page.h>      /* IO address mapping routines need this */
 #include <asm-generic/pci_iomap.h>
 
-#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
-
 static inline u32 flip_dword (u32 l)
 {
 	return ((l&0xff)<<24) | (((l>>8)&0xff)<<16) | (((l>>16)&0xff)<<8)| ((l>>24)&0xff);
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 09b0b88..4484563 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -15,7 +15,6 @@
 
 /* BIO layer definitions. */
 extern unsigned long kern_base, kern_size;
-#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 
 static inline u8 _inb(unsigned long addr)
 {
diff --git a/arch/sparc/include/asm/page.h b/arch/sparc/include/asm/page.h
index f21de03..1be2fde 100644
--- a/arch/sparc/include/asm/page.h
+++ b/arch/sparc/include/asm/page.h
@@ -1,5 +1,8 @@
 #ifndef ___ASM_SPARC_PAGE_H
 #define ___ASM_SPARC_PAGE_H
+
+#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/page_64.h>
 #else
-- 
1.9.0

