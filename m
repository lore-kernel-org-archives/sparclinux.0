From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 05 May 2008 18:23:36 +0000
Subject: [2.6 patch] sparc64: remove online_page()
Message-Id: <20080505182336.GH17139@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The identical online_page() implementations from all architectures got 
moved to mm/memory_hotplug.c - except for the sparc64 one that even was 
dead code due to MEMORY_HOTPLUG not being available there.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
4bd8f2a3209b4bca3f04f10e995c55ead827ae7e diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 8c2b50e..3feb4ff 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -2361,16 +2361,3 @@ void __flush_tlb_all(void)
 	__asm__ __volatile__("wrpr	%0, 0, %%pstate"
 			     : : "r" (pstate));
 }
-
-#ifdef CONFIG_MEMORY_HOTPLUG
-
-void online_page(struct page *page)
-{
-	ClearPageReserved(page);
-	init_page_count(page);
-	__free_page(page);
-	totalram_pages++;
-	num_physpages++;
-}
-
-#endif /* CONFIG_MEMORY_HOTPLUG */
