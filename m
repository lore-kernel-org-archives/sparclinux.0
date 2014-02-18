From: Bob Picco <bpicco@meloft.net>
Date: Tue, 18 Feb 2014 19:11:18 +0000
Subject: [PATCH 1/2] sparc64 - strict devmem
Message-Id: <1392750679-6966-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This is just the first part of restricting /dev/mem access on sparc.
This patch does nothing to change the current behaviour. The patch is
in preparation for a subsequent patch.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/Kconfig.debug         |    8 ++++++++
 arch/sparc/include/asm/page_64.h |    1 +
 arch/sparc/mm/init_64.c          |   11 +++++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 6db35fb..92f2388 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -6,6 +6,14 @@ config TRACE_IRQFLAGS_SUPPORT
 
 source "lib/Kconfig.debug"
 
+config STRICT_DEVMEM
+	bool "Filter access to /dev/mem"
+	---help---
+	  If this option is disabled, you allow userspace (root) access to all
+	  of memory, including kernel and userspace memory. Accidental
+	  access to this is obviously disastrous, but specific access can
+	  be used by people debugging the kernel.
+
 config DEBUG_DCFLUSH
 	bool "D-cache flush debugging"
 	depends on SPARC64 && DEBUG_KERNEL
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index aac53fc..e54ee50 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -36,6 +36,7 @@ extern void hugetlb_setup(struct pt_regs *regs);
 
 #define WANT_PAGE_VIRTUAL
 
+extern int devmem_is_allowed(unsigned long pagenr);
 extern void _clear_page(void *page);
 #define clear_page(X)	_clear_page((void *)(X))
 struct page;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index eafbc65..9c4a820 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2694,3 +2694,14 @@ void hugetlb_setup(struct pt_regs *regs)
 	}
 }
 #endif
+
+#ifdef CONFIG_STRICT_DEVMEM
+/* devmem_is_allowed for sparc.
+ */
+int devmem_is_allowed(unsigned long pagenr)
+{
+	int  rc = page_is_ram(pagenr);
+
+	return rc;
+}
+#endif
-- 
1.7.1

