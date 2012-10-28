From: David Miller <davem@davemloft.net>
Date: Sun, 28 Oct 2012 20:34:49 +0000
Subject: [PATCH] qlogicpti: Fix build warning.
Message-Id: <20121028.163449.393346756470366321.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The build warns:

drivers/scsi/qlogicpti.c: In function 'qpti_sbus_probe':
drivers/scsi/qlogicpti.c:1316:45: warning: passing argument 1 of 'scsi_host_alloc' discards 'const' qualifier from pointer target type [enabled by default]
include/scsi/scsi_host.h:778:26: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'

The problem is that of_device_id->data is a const void pointer.

This is pretty silly in this specific instance, because for all
matched device IDs we set match->data to the same value,
&qpti_template.

So just use that directly instead of the unnecessary and improperly
typed abstraction.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/scsi/qlogicpti.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index b191dd5..71fddbc 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1294,26 +1294,19 @@ static struct scsi_host_template qpti_template = {
 static const struct of_device_id qpti_match[];
 static int __devinit qpti_sbus_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
-	struct scsi_host_template *tpnt;
 	struct device_node *dp = op->dev.of_node;
 	struct Scsi_Host *host;
 	struct qlogicpti *qpti;
 	static int nqptis;
 	const char *fcode;
 
-	match = of_match_device(qpti_match, &op->dev);
-	if (!match)
-		return -EINVAL;
-	tpnt = match->data;
-
 	/* Sometimes Antares cards come up not completely
 	 * setup, and we get a report of a zero IRQ.
 	 */
 	if (op->archdata.irqs[0] = 0)
 		return -ENODEV;
 
-	host = scsi_host_alloc(tpnt, sizeof(struct qlogicpti));
+	host = scsi_host_alloc(&qpti_template, sizeof(struct qlogicpti));
 	if (!host)
 		return -ENOMEM;
 
@@ -1445,19 +1438,15 @@ static int __devexit qpti_sbus_remove(struct platform_device *op)
 static const struct of_device_id qpti_match[] = {
 	{
 		.name = "ptisp",
-		.data = &qpti_template,
 	},
 	{
 		.name = "PTI,ptisp",
-		.data = &qpti_template,
 	},
 	{
 		.name = "QLGC,isp",
-		.data = &qpti_template,
 	},
 	{
 		.name = "SUNW,isp",
-		.data = &qpti_template,
 	},
 	{},
 };
-- 
1.7.12.2.dirty

