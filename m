From: Robert Reif <reif@earthlink.net>
Date: Sun, 27 Apr 2008 15:00:54 +0000
Subject: [PATCH] sparc: video drivers: add facility level
Message-Id: <48149526.1050800@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010900000401030600070305"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900000401030600070305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add KERN_ facility level to sparc video drivers.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------010900000401030600070305
Content-Type: text/plain;
 name="video.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="video.diff.txt"

diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 833b10c..275d9da 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -339,7 +339,7 @@ static int __devinit bw2_probe(struct of_device *op, const struct of_device_id *
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: bwtwo at %lx:%lx\n",
+	printk(KERN_INFO "%s: bwtwo at %lx:%lx\n",
 	       dp->full_name, par->which_io, par->physbase);
 
 	return 0;
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index fdc9f43..0db0fec 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -556,7 +556,7 @@ static int __devinit cg14_probe(struct of_device *op, const struct of_device_id
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: cgfourteen at %lx:%lx, %dMB\n",
+	printk(KERN_INFO "%s: cgfourteen at %lx:%lx, %dMB\n",
 	       dp->full_name,
 	       par->iospace, par->physbase,
 	       par->ramsize >> 20);
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index a5c7fb3..010ea53 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -419,7 +419,7 @@ static int __devinit cg3_probe(struct of_device *op,
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: cg3 at %lx:%lx\n",
+	printk(KERN_INFO "%s: cg3 at %lx:%lx\n",
 	       dp->full_name, par->which_io, par->physbase);
 
 	return 0;
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 549891d..fc90db6 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -781,7 +781,7 @@ static int __devinit cg6_probe(struct of_device *op,
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: CGsix [%s] at %lx:%lx\n",
+	printk(KERN_INFO "%s: CGsix [%s] at %lx:%lx\n",
 	       dp->full_name, info->fix.id,
 	       par->which_io, par->physbase);
 
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index d7e2488..93dca3e 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -1001,7 +1000,7 @@ static int __devinit ffb_probe(struct of_device *op,
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: %s at %016lx, type %d, "
+	printk(KERN_INFO "%s: %s at %016lx, type %d, "
 	       "DAC pnum[%x] rev[%d] manuf_rev[%d]\n",
 	       dp->full_name,
 	       ((par->flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 45b9a5d..f3160fc 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -614,7 +614,7 @@ static int __devinit leo_probe(struct of_device *op, const struct of_device_id *
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: leo at %lx:%lx\n",
+	printk(KERN_INFO "%s: leo at %lx:%lx\n",
 	       dp->full_name,
 	       par->which_io, par->physbase);
 
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index 5849606..c95874f 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -310,7 +310,7 @@ static int __devinit p9100_probe(struct of_device *op, const struct of_device_id
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: p9100 at %lx:%lx\n",
+	printk(KERN_INFO "%s: p9100 at %lx:%lx\n",
 	       dp->full_name,
 	       par->which_io, par->physbase);
 
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index e5a9ddb..a717743 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -470,7 +470,7 @@ static int __devinit tcx_init_one(struct of_device *op)
 
 	dev_set_drvdata(&op->dev, info);
 
-	printk("%s: TCX at %lx:%lx, %s\n",
+	printk(KERN_INFO "%s: TCX at %lx:%lx, %s\n",
 	       dp->full_name,
 	       par->which_io,
 

--------------010900000401030600070305--
