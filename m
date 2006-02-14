From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 10:54:08 +0000
Subject: [PATCH] unify pfn_to_page take3 [18/23] sparc pfn_to_page
Message-Id: <43F1B6D0.9010201@jp.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, sparclinux@vger.kernel.org

sparc can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-sparc/page.h
=================================--- testtree.orig/include/asm-sparc/page.h
+++ testtree/include/asm-sparc/page.h
@@ -9,6 +9,7 @@
  #define _SPARC_PAGE_H

  #include <linux/config.h>
+
  #ifdef CONFIG_SUN4
  #define PAGE_SHIFT   13
  #else
@@ -152,8 +153,7 @@ extern unsigned long pfn_base;
  #define virt_to_phys		__pa
  #define phys_to_virt		__va

-#define pfn_to_page(pfn)	(mem_map + ((pfn)-(pfn_base)))
-#define page_to_pfn(page)	((unsigned long)(((page) - mem_map) + pfn_base))
+#define ARCH_PFN_OFFSET		(pfn_base)
  #define virt_to_page(kaddr)	(mem_map + ((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT)))

  #define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
@@ -164,6 +164,7 @@ extern unsigned long pfn_base;

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _SPARC_PAGE_H */


