From: Robert Reif <reif@earthlink.net>
Date: Tue, 23 Dec 2008 01:11:03 +0000
Subject: [PATCH] fix array overrun check in of_device_64.c
Message-Id: <49503AA7.0@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060002080408030003060106"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060002080408030003060106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Do the array length check and fixup before copying the array.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------060002080408030003060106
Content-Type: text/plain;
 name="of_device_64.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="of_device_64.diff.txt"

diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 0f616ae..46e231f 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -811,20 +811,20 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
 
 	irq = of_get_property(dp, "interrupts", &len);
 	if (irq) {
-		memcpy(op->irqs, irq, len);
 		op->num_irqs = len / 4;
+
+		/* Prevent overrunning the op->irqs[] array.  */
+		if (op->num_irqs > PROMINTR_MAX) {
+			printk(KERN_WARNING "%s: Too many irqs (%d), "
+			       "limiting to %d.\n",
+			       dp->full_name, op->num_irqs, PROMINTR_MAX);
+			op->num_irqs = PROMINTR_MAX;
+		}
+		memcpy(op->irqs, irq, op->num_irqs * 4);
 	} else {
 		op->num_irqs = 0;
 	}
 
-	/* Prevent overrunning the op->irqs[] array.  */
-	if (op->num_irqs > PROMINTR_MAX) {
-		printk(KERN_WARNING "%s: Too many irqs (%d), "
-		       "limiting to %d.\n",
-		       dp->full_name, op->num_irqs, PROMINTR_MAX);
-		op->num_irqs = PROMINTR_MAX;
-	}
-
 	build_device_resources(op, parent);
 	for (i = 0; i < op->num_irqs; i++)
 		op->irqs[i] = build_one_device_irq(op, parent, op->irqs[i]);

--------------060002080408030003060106--
