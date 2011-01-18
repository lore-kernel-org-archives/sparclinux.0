From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 18 Jan 2011 14:10:29 +0000
Subject: [PATCH 6/6 V3] sparc: Fix sbus_alloc_coherent error handling.
Message-Id: <1295359829-27308-7-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Order of kfree and free_pages were swapped in the error handling.

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index bd4fb10..c6ce9a6 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -302,9 +302,9 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 err_noiommu:
 	release_resource(res);
 err_nova:
-	free_pages(va, order);
-err_nomem:
 	kfree(res);
+err_nomem:
+	free_pages(va, order);
 err_nopages:
 	return NULL;
 }
-- 
1.6.4.1

