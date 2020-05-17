From: John Hubbard <jhubbard@nvidia.com>
Date: Sun, 17 May 2020 02:08:29 +0000
Subject: [PATCH] oradax: convert get_user_pages() --> pin_user_pages()
Message-Id: <20200517020829.856731-1-jhubbard@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

This code was using get_user_pages_fast(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages_fast() + put_page() calls to
pin_user_pages_fast() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/sbus/char/oradax.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 8af216287a84..21b7cb6e7e70 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -410,9 +410,7 @@ static void dax_unlock_pages(struct dax_ctx *ctx, int ccb_index, int nelem)
 
 			if (p) {
 				dax_dbg("freeing page %p", p);
-				if (j == OUT)
-					set_page_dirty(p);
-				put_page(p);
+				unpin_user_pages_dirty_lock(&p, 1, j == OUT);
 				ctx->pages[i][j] = NULL;
 			}
 		}
@@ -425,13 +423,13 @@ static int dax_lock_page(void *va, struct page **p)
 
 	dax_dbg("uva %p", va);
 
-	ret = get_user_pages_fast((unsigned long)va, 1, FOLL_WRITE, p);
+	ret = pin_user_pages_fast((unsigned long)va, 1, FOLL_WRITE, p);
 	if (ret == 1) {
 		dax_dbg("locked page %p, for VA %p", *p, va);
 		return 0;
 	}
 
-	dax_dbg("get_user_pages failed, va=%p, ret=%d", va, ret);
+	dax_dbg("pin_user_pages failed, va=%p, ret=%d", va, ret);
 	return -1;
 }
 

base-commit: 3d1c1e5931ce45b3a3f309385bbc00c78e9951c6
-- 
2.26.2
