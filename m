From: Doug <doug.lkml@gmail.com>
Date: Fri, 07 Mar 2014 10:59:35 +0000
Subject: [PATCH 1/1] sparc64:tsb.c:use array size macro rather than number
Message-Id: <1394189943-6012-1-git-send-email-doug.lkml@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1393956248-9354-1-git-send-email-doug.lkml@gmail.com>
In-Reply-To: <1393956248-9354-1-git-send-email-doug.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Doug Wilson <doug.lkml@gmail.com>

From: Doug Wilson <doug.lkml@gmail.com>

    This is a small patch which uses ARRAY_SIZE macro
    rather than a number to make code readability better.

Signed-off-by: Doug Wilson <doug.lkml@gmail.com>
---
 arch/sparc/mm/tsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 3b3a360..f5d506f 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -273,7 +273,7 @@ void __init pgtable_cache_init(void)
 		prom_halt();
 	}
 
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < ARRAY_SIZE(tsb_cache_names); i++) {
 		unsigned long size = 8192 << i;
 		const char *name = tsb_cache_names[i];
 
-- 
1.8.1.2

