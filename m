From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 20 Mar 2013 01:12:08 +0000
Subject: [PATCH v2 1/1]sparc64: Do not change num_physpages during initmem freeing
Message-Id: <757251363741928@web15e.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Common hibernation code looks at num_physpages during suspend and restore.
Restore is able to be called from initcall, which is before initmem freeing.
This case leads to restore fail.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
CC: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_64.c |    2 --
 1 file changed, 2 deletions(-)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5c2c6e6..d3f8506 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2125,7 +2125,6 @@ void free_initmem(void)
 			ClearPageReserved(p);
 			init_page_count(p);
 			__free_page(p);
-			num_physpages++;
 			totalram_pages++;
 		}
 	}
@@ -2142,7 +2141,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 		ClearPageReserved(p);
 		init_page_count(p);
 		__free_page(p);
-		num_physpages++;
 		totalram_pages++;
 	}
 }
