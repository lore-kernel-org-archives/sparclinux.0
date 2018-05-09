From: Christoph Hellwig <hch@lst.de>
Date: Wed, 09 May 2018 13:59:47 +0000
Subject: [PATCH 6/7] jsflash: handle highmem pages
Message-Id: <20180509135948.20329-7-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180509135948.20329-1-hch@lst.de>
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org

Just kmap the bio single page payload before processing it.

(and yes, now highmem on sparc32 anyway, but kmap_(un)map atomic are nops,
so this gives the right example)

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/sbus/char/jsflash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index 14f377ac1280..8520587b8d09 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -215,6 +215,7 @@ static void jsfd_request(void)
 		unsigned long offset = blk_rq_pos(req) << 9;
 		size_t len = blk_rq_cur_bytes(req);
 		blk_status_t err = BLK_STS_IOERR;
+		void *p;
 
 		if ((offset + len) > jdp->dsize)
 			goto end;
@@ -229,7 +230,9 @@ static void jsfd_request(void)
 			goto end;
 		}
 
-		jsfd_read(bio_data(req->bio), jdp->dbase + offset, len);
+		p = kmap_atomic(bio_page(bio)) + bio_offset(bio);
+		jsfd_read(p, jdp->dbase + offset, len);
+		kunmap_atomic(p);
 		err = BLK_STS_OK;
 	end:
 		if (!__blk_end_request_cur(req, err))
@@ -592,7 +595,6 @@ static int jsfd_init(void)
 			put_disk(disk);
 			goto out;
 		}
-		blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 		jsfd_disk[i] = disk;
 	}
 
-- 
2.17.0

