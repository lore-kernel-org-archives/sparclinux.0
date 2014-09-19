From: Dwight Engen <dwight.engen@oracle.com>
Date: Fri, 19 Sep 2014 13:42:53 +0000
Subject: [PATCH] sunvdc: limit each sg segment to a page
Message-Id: <1411134173-26665-1-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

ldc_map_sg() could fail its check that the number of pages referred to
by the sg scatterlist was <= the number of cookies.

This fixes the issue by doing a similar thing to the xen-blkfront driver,
ensuring that the scatterlist will only ever contain a segment count <port->ring_cookies, and each segment will be page aligned, and <= page
size. This ensures that the scatterlist is always mappable.

Orabug: 19347817
OraBZ: 15945

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 drivers/block/sunvdc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 1616ad0..1a9360d 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -747,6 +747,10 @@ static int probe_disk(struct vdc_port *port)
 
 	port->disk = g;
 
+	/* Each segment in a request is up to an aligned page in size. */
+	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	blk_queue_max_segment_size(q, PAGE_SIZE);
+
 	blk_queue_max_segments(q, port->ring_cookies);
 	blk_queue_max_hw_sectors(q, port->max_xfer_size);
 	g->major = vdc_major;
-- 
1.7.1

