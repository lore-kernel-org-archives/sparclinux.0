From: Christoph Hellwig <hch@lst.de>
Date: Wed, 09 May 2018 13:59:46 +0000
Subject: [PATCH 5/7] aoe: handle highmem pages
Message-Id: <20180509135948.20329-6-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180509135948.20329-1-hch@lst.de>
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org

Use kmap_atomic when copying out of a bio_vec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/aoe/aoeblk.c | 1 -
 drivers/block/aoe/aoecmd.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 6797e6c23c8a..027b876370bc 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -388,7 +388,6 @@ aoeblk_gdalloc(void *vp)
 			d->aoemajor, d->aoeminor);
 		goto err_mempool;
 	}
-	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 
 	spin_lock_irqsave(&d->lock, flags);
 	WARN_ON(!(d->flags & DEVFL_GD_NOW));
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 540bb60cd071..096882e54095 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1032,8 +1032,9 @@ bvcpy(struct sk_buff *skb, struct bio *bio, struct bvec_iter iter, long cnt)
 	iter.bi_size = cnt;
 
 	__bio_for_each_segment(bv, bio, iter, iter) {
-		char *p = page_address(bv.bv_page) + bv.bv_offset;
+		char *p = kmap_atomic(bv.bv_page) + bv.bv_offset;
 		skb_copy_bits(skb, soff, p, bv.bv_len);
+		kunmap_atomic(p);
 		soff += bv.bv_len;
 	}
 }
-- 
2.17.0

