From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:06:33 +0000
Subject: [PATCH 30/37] drivers/cdrom: use .of_node instead of
Message-Id: <20100311180633.4824.27717.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311174830.4824.19820.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade

.archdata.node is being removed from Microblaze, SPARC and PowerPC.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/cdrom/viocd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index cc435be..451cd70 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -567,7 +567,7 @@ static int viocd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	struct disk_info *d;
 	struct cdrom_device_info *c;
 	struct request_queue *q;
-	struct device_node *node = vdev->dev.archdata.of_node;
+	struct device_node *node = vdev->dev.of_node;
 
 	deviceno = vdev->unit_address;
 	if (deviceno >= VIOCD_MAX_CD)

