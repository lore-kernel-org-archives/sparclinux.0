From: David Miller <davem@davemloft.net>
Date: Tue, 16 Mar 2010 22:15:46 +0000
Subject: Re: Debian Sparc 5.4 on Sun blade 2500
Message-Id: <20100316.151546.01215837.davem@davemloft.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Next_Part(Tue_Mar_16_15_15_46_2010_673)--"
List-Id: <sparclinux.vger.kernel.org>
References: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
In-Reply-To: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
To: sparclinux@vger.kernel.org

----Next_Part(Tue_Mar_16_15_15_46_2010_673)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: David Miller <davem@davemloft.net>
Date: Tue, 16 Mar 2010 12:40:42 -0700 (PDT)

> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Tue, 16 Mar 2010 20:34:50 +0100
> 
>> If I am well your card isn't supported yet. Searching the attachment
>> it's a XVR 600 true. 
>> 
>> Maybe we can get the XVR 500 driver to do the XVR 600 as well. 
>> 
>> Forwarding this e-mail to the kernel Sparc list. I know kernel developer
>> David was looking for the XVR 600 information, to check this out.
> 
> The XVR-500 driver supports his XVR-600's PCI ID, 3d3d:07a2

Ugh, even in Debian testing none of the SUNXVR* framebuffer drivers
are even enabled in the sparc64 kernel.

Josip, please make sure this gets fixed, please get my
sunxvr1000 driver added (attached) and then add:

CONFIG_FB_XVR500=y
CONFIG_FB_XVR2500=y
CONFIG_FB_XVR1000=y

to the config for sparc64.

As it is right now even though there are full drivers for
XVR-500, XVR-600 and XVR-1200 in the tree, none of them are
getting enabled so users can't even install.

Thanks!

----Next_Part(Tue_Mar_16_15_15_46_2010_673)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="sparc64_xvr1000.diff"

From 2d378b9179881b46a0faf11430efb421fe03ddd8 Mon Sep 17 00:00:00 2001
From: David S. Miller <davem@davemloft.net>
Date: Sat, 13 Mar 2010 16:25:03 -0800
Subject: [PATCH] sparc64: Add very basic XVR-1000 framebuffer driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: Frans van Berckel <fberckel@xs4all.nl>
---
 drivers/video/Kconfig      |   12 +++
 drivers/video/Makefile     |    1 +
 drivers/video/sunxvr1000.c |  228 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/sunxvr1000.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5a5c303..a5755b8 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -909,6 +909,18 @@ config FB_XVR2500
 	  mostly initialized the card already.  It is treated as a
 	  completely dumb framebuffer device.
 
+config FB_XVR1000
+	bool "Sun XVR-1000 support"
+	depends on SPARC64
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer device for the Sun XVR-1000 and similar
+	  graphics cards.  The driver only works on sparc64 systems where
+	  the system firmware has mostly initialized the card already.  It
+	  is treated as a completely dumb framebuffer device.
+
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
 	depends on FB && SH_DREAMCAST
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 4ecb30c..8c9a357 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_FB_N411)             += n411.o
 obj-$(CONFIG_FB_HGA)              += hgafb.o
 obj-$(CONFIG_FB_XVR500)           += sunxvr500.o
 obj-$(CONFIG_FB_XVR2500)          += sunxvr2500.o
+obj-$(CONFIG_FB_XVR1000)          += sunxvr1000.o
 obj-$(CONFIG_FB_IGA)              += igafb.o
 obj-$(CONFIG_FB_APOLLO)           += dnfb.o
 obj-$(CONFIG_FB_Q40)              += q40fb.o
diff --git a/drivers/video/sunxvr1000.c b/drivers/video/sunxvr1000.c
new file mode 100644
index 0000000..a8248c0
--- /dev/null
+++ b/drivers/video/sunxvr1000.c
@@ -0,0 +1,228 @@
+/* sunxvr1000.c: Sun XVR-1000 driver for sparc64 systems
+ *
+ * Copyright (C) 2010 David S. Miller (davem@davemloft.net)
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+
+struct gfb_info {
+	struct fb_info		*info;
+
+	char __iomem		*fb_base;
+	unsigned long		fb_base_phys;
+
+	struct device_node	*of_node;
+
+	unsigned int		width;
+	unsigned int		height;
+	unsigned int		depth;
+	unsigned int		fb_size;
+
+	u32			pseudo_palette[16];
+};
+
+static int __devinit gfb_get_props(struct gfb_info *gp)
+{
+	gp->width = of_getintprop_default(gp->of_node, "width", 0);
+	gp->height = of_getintprop_default(gp->of_node, "height", 0);
+	gp->depth = of_getintprop_default(gp->of_node, "depth", 32);
+
+	if (!gp->width || !gp->height) {
+		printk(KERN_ERR "gfb: Critical properties missing for %s\n",
+		       gp->of_node->full_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gfb_setcolreg(unsigned regno,
+			 unsigned red, unsigned green, unsigned blue,
+			 unsigned transp, struct fb_info *info)
+{
+	u32 value;
+
+	if (regno < 16) {
+		red >>= 8;
+		green >>= 8;
+		blue >>= 8;
+
+		value = (blue << 16) | (green << 8) | red;
+		((u32 *)info->pseudo_palette)[regno] = value;
+	}
+
+	return 0;
+}
+
+static struct fb_ops gfb_ops = {
+	.owner			= THIS_MODULE,
+	.fb_setcolreg		= gfb_setcolreg,
+	.fb_fillrect		= cfb_fillrect,
+	.fb_copyarea		= cfb_copyarea,
+	.fb_imageblit		= cfb_imageblit,
+};
+
+static int __devinit gfb_set_fbinfo(struct gfb_info *gp)
+{
+	struct fb_info *info = gp->info;
+	struct fb_var_screeninfo *var = &info->var;
+
+	info->flags = FBINFO_DEFAULT;
+	info->fbops = &gfb_ops;
+	info->screen_base = gp->fb_base;
+	info->screen_size = gp->fb_size;
+
+	info->pseudo_palette = gp->pseudo_palette;
+
+	/* Fill fix common fields */
+	strlcpy(info->fix.id, "gfb", sizeof(info->fix.id));
+        info->fix.smem_start = gp->fb_base_phys;
+        info->fix.smem_len = gp->fb_size;
+        info->fix.type = FB_TYPE_PACKED_PIXELS;
+	if (gp->depth == 32 || gp->depth == 24)
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+	else
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+
+	var->xres = gp->width;
+	var->yres = gp->height;
+	var->xres_virtual = var->xres;
+	var->yres_virtual = var->yres;
+	var->bits_per_pixel = gp->depth;
+
+	var->red.offset = 0;
+	var->red.length = 8;
+	var->green.offset = 8;
+	var->green.length = 8;
+	var->blue.offset = 16;
+	var->blue.length = 8;
+	var->transp.offset = 0;
+	var->transp.length = 0;
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
+		printk(KERN_ERR "gfb: Cannot allocate color map.\n");
+		return -ENOMEM;
+	}
+
+        return 0;
+}
+
+static int __devinit gfb_probe(struct of_device *op,
+			       const struct of_device_id *match)
+{
+	struct device_node *dp = op->node;
+	struct fb_info *info;
+	struct gfb_info *gp;
+	int err;
+
+	info = framebuffer_alloc(sizeof(struct gfb_info), &op->dev);
+	if (!info) {
+		printk(KERN_ERR "gfb: Cannot allocate fb_info\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	gp = info->par;
+	gp->info = info;
+	gp->of_node = dp;
+
+	gp->fb_base_phys = op->resource[6].start;
+
+	err = gfb_get_props(gp);
+	if (err)
+		goto err_release_fb;
+
+	/* Framebuffer length is the same regardless of resolution. */
+	info->fix.line_length = 16384;
+	gp->fb_size = info->fix.line_length * gp->height;
+
+	gp->fb_base = of_ioremap(&op->resource[6], 0,
+				 gp->fb_size, "gfb fb");
+	if (!gp->fb_base)
+		goto err_release_fb;
+
+	err = gfb_set_fbinfo(gp);
+	if (err)
+		goto err_unmap_fb;
+
+	printk("gfb: Found device at %s\n", dp->full_name);
+
+	err = register_framebuffer(info);
+	if (err < 0) {
+		printk(KERN_ERR "gfb: Could not register framebuffer %s\n",
+		       dp->full_name);
+		goto err_unmap_fb;
+	}
+
+	dev_set_drvdata(&op->dev, info);
+
+	return 0;
+
+err_unmap_fb:
+	of_iounmap(&op->resource[6], gp->fb_base, gp->fb_size);
+
+err_release_fb:
+        framebuffer_release(info);
+
+err_out:
+	return err;
+}
+
+static int __devexit gfb_remove(struct of_device *op)
+{
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct gfb_info *gp = info->par;
+
+	unregister_framebuffer(info);
+
+	iounmap(gp->fb_base);
+
+	of_iounmap(&op->resource[6], gp->fb_base, gp->fb_size);
+
+        framebuffer_release(info);
+
+	dev_set_drvdata(&op->dev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id gfb_match[] = {
+	{
+		.name = "SUNW,gfb",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ffb_match);
+
+static struct of_platform_driver gfb_driver = {
+	.name		= "gfb",
+	.match_table	= gfb_match,
+	.probe		= gfb_probe,
+	.remove		= __devexit_p(gfb_remove),
+};
+
+static int __init gfb_init(void)
+{
+	if (fb_get_options("gfb", NULL))
+		return -ENODEV;
+
+	return of_register_driver(&gfb_driver, &of_bus_type);
+}
+
+static void __exit gfb_exit(void)
+{
+	of_unregister_driver(&gfb_driver);
+}
+
+module_init(gfb_init);
+module_exit(gfb_exit);
+
+MODULE_DESCRIPTION("framebuffer driver for Sun XVR-1000 graphics");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL");
-- 
1.6.6.1


----Next_Part(Tue_Mar_16_15_15_46_2010_673)----
