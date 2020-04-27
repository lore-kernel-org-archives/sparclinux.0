From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 27 Apr 2020 12:24:15 +0000
Subject: [PATCH -next] sparc64: vcc: Fix error return code in vcc_probe()
Message-Id: <20200427122415.47416-1-weiyongjun1@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/vcc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index d2a1e1228c82..9ffd42e333b8 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -605,6 +605,7 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	port->index = vcc_table_add(port);
 	if (port->index = -1) {
 		pr_err("VCC: no more TTY indices left for allocation\n");
+		rv = -ENOMEM;
 		goto free_ldc;
 	}
