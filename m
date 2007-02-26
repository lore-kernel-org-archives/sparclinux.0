From: Monakhov Dmitriy <dmonakhov@openvz.org>
Date: Mon, 26 Feb 2007 16:09:27 +0000
Subject: [PATCH 3/3] SPARC: Handle request_irq() failure
Message-Id: <87y7mkq4so.fsf@sw.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, devel@openvz.org



Signed-off-by: Monakhov Dmitriy <dmonakhov@openvz.org>
---
 drivers/sbus/char/uctrl.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 45cf5bc..6b96aa3 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -364,6 +364,7 @@ static int __init ts102_uctrl_init(void)
 	struct linux_prom_irqs tmp_irq[2];
         unsigned int vaddr[2] = { 0, 0 };
 	int tmpnode, uctrlnode = prom_getchild(prom_root_node);
+	int err;
 
 	tmpnode = prom_searchsiblings(uctrlnode, "obio");
 
@@ -389,7 +390,12 @@ static int __init ts102_uctrl_init(void)
 	if(!driver->irq) 
 		driver->irq = tmp_irq[0].pri;
 
-	request_irq(driver->irq, uctrl_interrupt, 0, "uctrl", driver);
+	err = request_irq(driver->irq, uctrl_interrupt, 0, "uctrl", driver);
+	if (err) {
+		printk(KERN_ERR "%s: unable to request irq  %d\n",
+				__FUNCTION__, driver->irq);
+		return -EBUSY;
+	}
 
 	if (misc_register(&uctrl_dev)) {
 		printk("%s: unable to get misc minor %d\n",
-- 
1.5.0.1


