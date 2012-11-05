From: Yinghai Lu <yinghai@kernel.org>
Date: Mon, 05 Nov 2012 20:27:42 +0000
Subject: [PATCH 41/42] sparc, mm: Remove calling of free_all_bootmem_node()
Message-Id: <1352147263-20383-3-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQWUiNqv-fd_4Y79eq+-w6wU34nEwn76+QJ7TWw7uCLaaQ@mail.gmail.com>
 <1352147263-20383-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1352147263-20383-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Jacob Shin <jacob.shin@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Now NO_BOOTMEM version free_all_bootmem_node() does not really
do free_bootmem at all, and it only call
register_page_bootmem_info_node instead.

That is confusing, try to kill that free_all_bootmem_node().

Before that, this patch will remove calling of free_all_bootmem_node()

We add register_page_bootmem_info() to call register_page_bootmem_info_node
directly.

Also could use free_all_bootmem() for numa case, and it is just
the same as free_low_memory_core_early().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/mm/init_64.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 9e28a11..b24bac2 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2021,6 +2021,16 @@ static void __init patch_tlb_miss_handler_bitmap(void)
 	flushi(&valid_addr_bitmap_insn[0]);
 }
 
+static void __init register_page_bootmem_info(void)
+{
+#ifdef CONFIG_NEED_MULTIPLE_NODES
+	int i;
+
+	for_each_online_node(i)
+		if (NODE_DATA(i)->node_spanned_pages)
+			register_page_bootmem_info_node(NODE_DATA(i));
+#endif
+}
 void __init mem_init(void)
 {
 	unsigned long codepages, datapages, initpages;
@@ -2038,20 +2048,8 @@ void __init mem_init(void)
 
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	{
-		int i;
-		for_each_online_node(i) {
-			if (NODE_DATA(i)->node_spanned_pages != 0) {
-				totalram_pages +-					free_all_bootmem_node(NODE_DATA(i));
-			}
-		}
-		totalram_pages += free_low_memory_core_early(MAX_NUMNODES);
-	}
-#else
+	register_page_bootmem_info();
 	totalram_pages = free_all_bootmem();
-#endif
 
 	/* We subtract one to account for the mem_map_zero page
 	 * allocated below.
-- 
1.7.7

