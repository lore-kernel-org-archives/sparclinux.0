From: Robert Reif <reif@earthlink.net>
Date: Sat, 03 May 2008 20:14:08 +0000
Subject: [PATCH] sparc: tcx.c remove unnecessary function
Message-Id: <481CC790.7080607@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060902080808050900010001"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060902080808050900010001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Replaced tcx_init_one with tcx_probe.
Fixed some checkpatch problems.

--------------060902080808050900010001
Content-Type: text/plain;
 name="tcx.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcx.diff.txt"

diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index a717743..44e8c27 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -84,7 +84,7 @@ struct tcx_tec {
 
 struct tcx_thc {
 	u32 thc_rev;
-        u32 thc_pad0[511];
+	u32 thc_pad0[511];
 	u32 thc_hs;		/* hsync timing */
 	u32 thc_hsdvs;
 	u32 thc_hd;
@@ -126,10 +126,10 @@ struct tcx_par {
 };
 
 /* Reset control plane so that WID is 8-bit plane. */
-static void __tcx_set_control_plane (struct tcx_par *par)
+static void __tcx_set_control_plane(struct tcx_par *par)
 {
 	u32 __iomem *p, *pend;
-        
+
 	if (par->lowdepth)
 		return;
 
@@ -143,8 +143,8 @@ static void __tcx_set_control_plane (struct tcx_par *par)
 		sbus_writel(tmp, p);
 	}
 }
-                                                
-static void tcx_reset (struct fb_info *info)
+
+static void tcx_reset(struct fb_info *info)
 {
 	struct tcx_par *par = (struct tcx_par *) info->par;
 	unsigned long flags;
@@ -365,7 +365,8 @@ static void tcx_unmap_regs(struct of_device *op, struct fb_info *info,
 			   info->screen_base, par->fbsize);
 }
 
-static int __devinit tcx_init_one(struct of_device *op)
+static int __devinit tcx_probe(struct of_device *op,
+			       const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
 	struct fb_info *info;
@@ -488,13 +489,6 @@ out_err:
 	return err;
 }
 
-static int __devinit tcx_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
-
-	return tcx_init_one(op);
-}
-
 static int __devexit tcx_remove(struct of_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);

--------------060902080808050900010001--
