From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 29 Aug 2017 02:02:13 +0000
Subject: [PATCH v7 02/11] sparc64/mm: setting fields in deferred pages
Message-Id: <1503972142-289376-3-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1503972142-289376-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1503972142-289376-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Without deferred struct page feature (CONFIG_DEFERRED_STRUCT_PAGE_INIT),
flags and other fields in "struct page"es are never changed prior to first
initializing struct pages by going through __init_single_page().

With deferred struct page feature enabled there is a case where we set some
fields prior to initializing:

mem_init() {
     register_page_bootmem_info();
     free_all_bootmem();
     ...
}

When register_page_bootmem_info() is called only non-deferred struct pages
are initialized. But, this function goes through some reserved pages which
might be part of the deferred, and thus are not yet initialized.

mem_init
register_page_bootmem_info
register_page_bootmem_info_node
 get_page_bootmem
  .. setting fields here ..
  such as: page->freelist = (void *)type;

free_all_bootmem()
free_low_memory_core_early()
 for_each_reserved_mem_region()
  reserve_bootmem_region()
   init_reserved_page() <- Only if this is deferred reserved page
    __init_single_pfn()
     __init_single_page()
      memset(0) <-- Loose the set fields here

We end-up with similar issue as in the previous patch, where currently we
do not observe problem as memory is zeroed. But, if flag asserts are
changed we can start hitting issues.

Also, because in this patch series we will stop zeroing struct page memory
during allocation, we must make sure that struct pages are properly
initialized prior to using them.

The deferred-reserved pages are initialized in free_all_bootmem().
Therefore, the fix is to switch the above calls.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/init_64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index b3020a956b87..12dbba85a2e2 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2508,9 +2508,15 @@ void __init mem_init(void)
 {
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
 
-	register_page_bootmem_info();
 	free_all_bootmem();
 
+	/* Must be done after boot memory is put on freelist, because here we
+	 * might set fields in deferred struct pages that have not yet been
+	 * initialized, and free_all_bootmem() initializes all the reserved
+	 * deferred pages for us.
+	 */
+	register_page_bootmem_info();
+
 	/*
 	 * Set up the zero page, mark it reserved, so that page count
 	 * is not manipulated when freeing the page from user ptes.
-- 
2.14.1

