From: Robert Reif <reif@earthlink.net>
Date: Fri, 09 May 2008 01:34:02 +0000
Subject: [PATCH] sparc video: remove open boot prom code
Message-Id: <4823AA0A.6070206@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020007060601080509050807"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------020007060601080509050807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Replace remaining open boot prom code with of.

Boot tested on sparc32 and compile tested on sparc64.

Signed-off-by: Robert Reif <reif@earthlink.net>



--------------020007060601080509050807
Content-Type: text/plain;
 name="prom.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prom.diff.txt"

diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 79f85dc..e721644 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -17,11 +17,9 @@
 #include <linux/init.h>
 #include <linux/fb.h>
 #include <linux/mm.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/oplib.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -299,7 +297,7 @@ static int __devinit bw2_probe(struct of_device *op, const struct of_device_id *
 	par->physbase = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
-	sbusfb_fill_var(&info->var, dp->node, 1);
+	sbusfb_fill_var(&info->var, dp, 1);
 	linebytes = of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
 
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index 0db0fec..b17e746 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -17,10 +17,9 @@
 #include <linux/fb.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -482,7 +481,7 @@ static int __devinit cg14_probe(struct of_device *op, const struct of_device_id
 
 	spin_lock_init(&par->lock);
 
-	sbusfb_fill_var(&info->var, dp->node, 8);
+	sbusfb_fill_var(&info->var, dp, 8);
 	info->var.red.length = 8;
 	info->var.green.length = 8;
 	info->var.blue.length = 8;
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index e31e26a..3aa7b6c 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -17,11 +17,9 @@
 #include <linux/init.h>
 #include <linux/fb.h>
 #include <linux/mm.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/oplib.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -373,7 +371,7 @@ static int __devinit cg3_probe(struct of_device *op,
 	par->physbase = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
-	sbusfb_fill_var(&info->var, dp->node, 8);
+	sbusfb_fill_var(&info->var, dp, 8);
 	info->var.red.length = 8;
 	info->var.green.length = 8;
 	info->var.blue.length = 8;
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 8000bcc..2f64bb3 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -17,9 +17,9 @@
 #include <linux/init.h>
 #include <linux/fb.h>
 #include <linux/mm.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -728,7 +728,7 @@ static int __devinit cg6_probe(struct of_device *op,
 	par->physbase = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
-	sbusfb_fill_var(&info->var, dp->node, 8);
+	sbusfb_fill_var(&info->var, dp, 8);
 	info->var.red.length = 8;
 	info->var.green.length = 8;
 	info->var.blue.length = 8;
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 0f42a69..7992b13 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -16,11 +16,10 @@
 #include <linux/fb.h>
 #include <linux/mm.h>
 #include <linux/timer.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 #include <asm/upa.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -941,7 +940,7 @@ static int __devinit ffb_probe(struct of_device *op,
 	info->screen_base = (char *) par->physbase + FFB_DFB24_POFF;
 	info->pseudo_palette = par->pseudo_palette;
 
-	sbusfb_fill_var(&info->var, dp->node, 32);
+	sbusfb_fill_var(&info->var, dp, 32);
 	par->fbsize = PAGE_ALIGN(info->var.xres * info->var.yres * 4);
 	ffb_fixup_var_rgb(&info->var);
 
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index fb12992..8bc46e9 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -16,10 +16,9 @@
 #include <linux/init.h>
 #include <linux/fb.h>
 #include <linux/mm.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -562,7 +561,7 @@ static int __devinit leo_probe(struct of_device *op, const struct of_device_id *
 	par->physbase = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
-	sbusfb_fill_var(&info->var, dp->node, 32);
+	sbusfb_fill_var(&info->var, dp, 32);
 	leo_fixup_var_rgb(&info->var);
 
 	linebytes = of_getintprop_default(dp, "linebytes",
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index 676ffb0..9e90345 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -15,10 +15,9 @@
 #include <linux/init.h>
 #include <linux/fb.h>
 #include <linux/mm.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -275,7 +274,7 @@ static int __devinit p9100_probe(struct of_device *op, const struct of_device_id
 	par->physbase = op->resource[2].start;
 	par->which_io = op->resource[2].flags & IORESOURCE_BITS;
 
-	sbusfb_fill_var(&info->var, dp->node, 8);
+	sbusfb_fill_var(&info->var, dp, 8);
 	info->var.red.length = 8;
 	info->var.green.length = 8;
 	info->var.blue.length = 8;
diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
index 4deaac0..37d764a 100644
--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -10,18 +10,19 @@
 #include <linux/fb.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/of_device.h>
 
-#include <asm/oplib.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
 
-void sbusfb_fill_var(struct fb_var_screeninfo *var, int prom_node, int bpp)
+void sbusfb_fill_var(struct fb_var_screeninfo *var, struct device_node *dp,
+		     int bpp)
 {
 	memset(var, 0, sizeof(*var));
 
-	var->xres = prom_getintdefault(prom_node, "width", 1152);
-	var->yres = prom_getintdefault(prom_node, "height", 900);
+	var->xres = of_getintprop_default(dp, "width", 1152);
+	var->yres = of_getintprop_default(dp, "height", 900);
 	var->xres_virtual = var->xres;
 	var->yres_virtual = var->yres;
 	var->bits_per_pixel = bpp;
diff --git a/drivers/video/sbuslib.h b/drivers/video/sbuslib.h
index 492828c..7ba3250 100644
--- a/drivers/video/sbuslib.h
+++ b/drivers/video/sbuslib.h
@@ -11,7 +11,8 @@ struct sbus_mmap_map {
 #define SBUS_MMAP_FBSIZE(n) (-n)
 #define SBUS_MMAP_EMPTY	0x80000000
 
-extern void sbusfb_fill_var(struct fb_var_screeninfo *var, int prom_node, int bpp);
+extern void sbusfb_fill_var(struct fb_var_screeninfo *var,
+			    struct device_node *dp, int bpp);
 struct vm_area_struct;
 extern int sbusfb_mmap_helper(struct sbus_mmap_map *map,
 			      unsigned long physbase, unsigned long fbsize,
@@ -21,6 +22,6 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 			struct fb_info *info,
 			int type, int fb_depth, unsigned long fb_size);
 int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd,
-		unsigned long arg);
+			unsigned long arg);
 
 #endif /* _SBUSLIB_H */
diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
index c3869a9..b1dde09 100644
--- a/drivers/video/sunxvr2500.c
+++ b/drivers/video/sunxvr2500.c
@@ -9,10 +9,9 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 
 struct s3d_info {
 	struct fb_info		*info;
diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index 71bf3f1..c2ba51b 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -9,10 +9,9 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 
 /* XXX This device has a 'dev-comm' property which aparently is
  * XXX a pointer into the openfirmware's address space which is
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index 44e8c27..2a03f78 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -17,10 +17,9 @@
 #include <linux/init.h>
 #include <linux/fb.h>
 #include <linux/mm.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -385,7 +384,7 @@ static int __devinit tcx_probe(struct of_device *op,
 	par->lowdepth =
 		(of_find_property(dp, "tcx-8-bit", NULL) != NULL);
 
-	sbusfb_fill_var(&info->var, dp->node, 8);
+	sbusfb_fill_var(&info->var, dp, 8);
 	info->var.red.length = 8;
 	info->var.green.length = 8;
 	info->var.blue.length = 8;

--------------020007060601080509050807--
