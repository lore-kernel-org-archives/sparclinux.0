From: Colin King <colin.king@canonical.com>
Date: Fri, 07 Sep 2018 10:35:00 +0000
Subject: [PATCH] oradax: remove redundant null check before kfree
Message-Id: <20180907103500.17453-1-colin.king@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, Rob Gardner <rob.gardner@oracle.com>, Jonathan Helman <jonathan.helman@oracle.com>, sparclinux@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A null check before a kfree is redundant, so remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/sbus/char/oradax.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 524f9ea62e52..6516bc3cb58b 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -689,8 +689,7 @@ static int dax_open(struct inode *inode, struct file *f)
 alloc_error:
 	kfree(ctx->ccb_buf);
 done:
-	if (ctx != NULL)
-		kfree(ctx);
+	kfree(ctx);
 	return -ENOMEM;
 }
 
-- 
2.17.1
