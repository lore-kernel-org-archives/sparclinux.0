From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 08 Aug 2010 07:19:38 +0000
Subject: [PATCH] of/sparc: fix build regression from of_device changes
Message-Id: <20100808071628.11437.93510.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, davem@davemloft.net, linux-kernel@vger.kernel.org

Commit id 1636f8ac2b08410df4766449f7c86b912443cd99 (sparc/of: Move
of_device fields into struct pdev_archdata) missed fixing up the
n2_core.c and greth.c drivers.  This patch makes the required changes.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

David, I've currently got this one in my next-devicetree branch.  You
can either pick it up, or it can go out when I ask Linus to pull on
Monday or Tuesday.

g.

 drivers/crypto/n2_core.c |    4 ++--
 drivers/net/greth.c      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 26af2dd..3704e46 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1580,7 +1580,7 @@ static int find_devino_index(struct of_device *dev, struct spu_mdesc_info *ip,
 	if (!dev_intrs)
 		return -ENODEV;
 
-	for (i = 0; i < dev->num_irqs; i++) {
+	for (i = 0; i < dev->archdata.num_irqs; i++) {
 		if (dev_intrs[i] = intr)
 			return i;
 	}
@@ -1603,7 +1603,7 @@ static int spu_map_ino(struct of_device *dev, struct spu_mdesc_info *ip,
 	if (index < 0)
 		return index;
 
-	p->irq = dev->irqs[index];
+	p->irq = dev->archdata.irqs[index];
 
 	sprintf(p->irq_name, "%s-%d", irq_name, index);
 
diff --git a/drivers/net/greth.c b/drivers/net/greth.c
index 4d09eab..ffe8bed 100644
--- a/drivers/net/greth.c
+++ b/drivers/net/greth.c
@@ -1412,7 +1412,7 @@ static int __devinit greth_of_probe(struct of_device *ofdev, const struct of_dev
 	}
 
 	regs = (struct greth_regs *) greth->regs;
-	greth->irq = ofdev->irqs[0];
+	greth->irq = ofdev->archdata.irqs[0];
 
 	dev_set_drvdata(greth->dev, dev);
 	SET_NETDEV_DEV(dev, greth->dev);

