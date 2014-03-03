From: Bob Picco <bpicco@meloft.net>
Date: Mon, 03 Mar 2014 17:00:35 +0000
Subject: [PATCH] sparc64 - strict devmem
Message-Id: <1393866035-7939-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This patch adds support to enable STRICT_DEVMEM for sparc64. By selecting the
new config option you enable this feature.

CC: Sam Ravnborg <sam@ravnborg.org>
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
index a4a9b69..0a38a42 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2759,3 +2759,14 @@ static int __init report_memory(void)
 	return 0;
 }
 device_initcall(report_memory);
+
+#ifdef CONFIG_STRICT_DEVMEM
+int devmem_is_allowed(unsigned long pagenr)
+{
+	unsigned long phys_addr = pagenr << PAGE_SHIFT;
+	unsigned long virt_addr = (unsigned long) __va(phys_addr);
+	int rc = kern_addr_valid(virt_addr);
+
+	return rc;
+}
+#endif /* CONFIG_STRICT_DEVMEM */
-- 
1.7.1

