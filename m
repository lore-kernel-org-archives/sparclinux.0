From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 14 Jun 2007 20:00:11 +0000
Subject: [PATCH 2/2] Fix ALSA build error with strict MM checking
Message-Id: <20070614200011.GB14390@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Turning on STRICT_MM_TYPECHECKS in include/asm/page.h causes a
build error in the ALSA code.
Based on input from Takashi Iwai, this is fixed in sparc code:

"PAGE_KERNEL is basically defined like __pgprot(__PAGE_KERNEL) on most
architectures.  If you need extra __pgprot() there, then it must be a
bug specific to sparc32 arch."

Looking at the header, sparc is inconsistent as 2 lines below the fix
it does do the __pgprot().

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk
---
Index: linux/include/asm-sparc/pgtable.h
=================================--- linux.orig/include/asm-sparc/pgtable.h	2006-12-07 15:21:13.000000000 +0000
+++ linux/include/asm-sparc/pgtable.h	2007-06-14 20:33:16.000000000 +0100
@@ -73,7 +73,7 @@
 extern unsigned long page_kernel;
 
 #ifdef MODULE
-#define PAGE_KERNEL	page_kernel
+#define PAGE_KERNEL	__pgprot(page_kernel)
 #else
 #define PAGE_KERNEL    __pgprot(BTFIXUP_INT(page_kernel))
 #endif
