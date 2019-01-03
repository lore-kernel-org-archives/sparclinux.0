From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 03 Jan 2019 01:19:48 +0000
Subject: [PATCH] block: sunvdc: don't run hw queue synchronously from irq context
Message-Id: <20190103011948.25706-1-ming.lei@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>, Anatoly Pugachev <matorola@gmail.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

vdc_blk_queue_start() may be called from irq context, so we can't run
queue via blk_mq_start_hw_queues() since we never allow to run queue
from irq context. Use blk_mq_start_stopped_hw_queues(q, true) to fix
this issue.

Fixes: fa182a1fa97dff56cd ("sunvdc: convert to blk-mq")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Tested-by: Anatoly Pugachev <matorola@gmail.com>
Cc: Anatoly Pugachev <matorola@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/sunvdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 9c0553dd13e7..ab7f7ab4c472 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -181,7 +181,7 @@ static void vdc_blk_queue_start(struct vdc_port *port)
 	 * allocated a disk.
 	 */
 	if (port->disk && vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
-		blk_mq_start_hw_queues(port->disk->queue);
+		blk_mq_start_stopped_hw_queues(port->disk->queue, true);
 }
 
 static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)
-- 
2.9.5
