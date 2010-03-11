From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:06:28 +0000
Subject: [PATCH 29/37] drivers/char: use .of_node instead of .archdata.of_node
Message-Id: <20100311180627.4824.32286.stgit@angua>
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

 drivers/char/viotape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 042c814..f37935c 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -865,7 +865,7 @@ static int viotape_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
 	int i = vdev->unit_address;
 	int j;
-	struct device_node *node = vdev->dev.archdata.of_node;
+	struct device_node *node = vdev->dev.of_node;
 
 	if (i >= VIOTAPE_MAX_TAPE)
 		return -ENODEV;

