From: Jiang Liu <liuj97@gmail.com>
Date: Sun, 10 Mar 2013 08:01:08 +0000
Subject: [PATCH v2, part2 08/10] mm/SPARC: use free_highmem_page() to free highmem pages into buddy system
Message-Id: <1362902470-25787-9-git-send-email-jiang.liu@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org

Use helper function free_highmem_page() to free highmem pages into
the buddy system.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/sparc/mm/init_32.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 13d6fee..6a7eb68 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -282,14 +282,8 @@ static void map_high_region(unsigned long start_pfn, unsigned long end_pfn)
 	printk("mapping high region %08lx - %08lx\n", start_pfn, end_pfn);
 #endif
 
-	for (tmp = start_pfn; tmp < end_pfn; tmp++) {
-		struct page *page = pfn_to_page(tmp);
-
-		ClearPageReserved(page);
-		init_page_count(page);
-		__free_page(page);
-		totalhigh_pages++;
-	}
+	for (tmp = start_pfn; tmp < end_pfn; tmp++)
+		free_higmem_page(pfn_to_page(tmp));
 }
 
 void __init mem_init(void)
@@ -347,8 +341,6 @@ void __init mem_init(void)
 		map_high_region(start_pfn, end_pfn);
 	}
 	
-	totalram_pages += totalhigh_pages;
-
 	codepages = (((unsigned long) &_etext) - ((unsigned long)&_start));
 	codepages = PAGE_ALIGN(codepages) >> PAGE_SHIFT;
 	datapages = (((unsigned long) &_edata) - ((unsigned long)&_etext));
-- 
1.7.9.5

