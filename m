From: Robert Reif <reif@earthlink.net>
Date: Fri, 06 Jun 2008 23:47:17 +0000
Subject: [PATCH] sparc: get leo framebuffer working
Message-Id: <4849CC85.2040207@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080807010907080304050005"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080807010907080304050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes several issues:
    Use the right openprom device name so the driver is actually loaded.
    Fix a crash due to unitialized info->pseudo_palette.
    Put the framebuffer in the proper mode for software rendering.
    checkpatch cleanups.

Hardware acceleration was removed when the driver was rewritten
for the new framebuffer API in 2003. Software rendering requires
a different framebuffer access mode but that wasn't changed.  The
driver now works again but is slow.  The proper fix is to reintroduce
hardware acceleration.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------080807010907080304050005
Content-Type: text/plain;
 name="leo.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="leo.diff.txt"

diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 8bc46e9..13fea61 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -17,8 +17,8 @@
 #include <linux/fb.h>
 #include <linux/mm.h>
 #include <linux/of_device.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/fbio.h>
 
 #include "sbuslib.h"
@@ -33,7 +33,6 @@ static int leo_blank(int, struct fb_info *);
 
 static int leo_mmap(struct fb_info *, struct vm_area_struct *);
 static int leo_ioctl(struct fb_info *, unsigned int, unsigned long);
-static int leo_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
  *  Frame buffer operations
@@ -43,7 +42,6 @@ static struct fb_ops leo_ops = {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= leo_setcolreg,
 	.fb_blank		= leo_blank,
-	.fb_pan_display		= leo_pan_display,
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
@@ -78,7 +76,7 @@ static struct fb_ops leo_ops = {
 #define LEO_CUR_TYPE_CMAP	0x00000050
 
 struct leo_cursor {
-	u8		xxx0[16];
+	u8	xxx0[16];
 	u32	cur_type;
 	u32	cur_misc;
 	u32	cur_cursxy;
@@ -105,7 +103,7 @@ struct leo_lx_krn {
 
 struct leo_lc_ss0_krn {
 	u32 	misc;
-	u8		xxx0[0x800-4];
+	u8	xxx0[0x800-4];
 	u32	rev;
 };
 
@@ -116,7 +114,7 @@ struct leo_lc_ss0_usr {
 	u32	fontt;
 	u32	extent;
 	u32	src;
-	u32		dst;
+	u32	dst;
 	u32	copy;
 	u32	fill;
 };
@@ -129,8 +127,8 @@ struct leo_lc_ss1_usr {
 	u8	unknown;
 };
 
-struct leo_ld {
-	u8		xxx0[0xe00];
+struct leo_ld_ss0 {
+	u8	xxx0[0xe00];
 	u32	csr;
 	u32	wid;
 	u32	wmask;
@@ -144,13 +142,13 @@ struct leo_ld {
 	u32	src;		/* Copy/Scroll (SS0 only) */
 	u32	dst;		/* Copy/Scroll/Fill (SS0 only) */
 	u32	extent;		/* Copy/Scroll/Fill size (SS0 only) */
-	u32		xxx1[3];
+	u32	xxx1[3];
 	u32	setsem;		/* SS1 only */
 	u32	clrsem;		/* SS1 only */
 	u32	clrpick;	/* SS1 only */
 	u32	clrdat;		/* SS1 only */
 	u32	alpha;		/* SS1 only */
-	u8		xxx2[0x2c];
+	u8	xxx2[0x2c];
 	u32	winbg;
 	u32	planemask;
 	u32	rop;
@@ -199,11 +197,12 @@ struct leo_par {
 static void leo_wait(struct leo_lx_krn __iomem *lx_krn)
 {
 	int i;
-	
+
 	for (i = 0;
-	     (sbus_readl(&lx_krn->krn_csr) & LEO_KRN_CSR_PROGRESS) && i < 300000;
+	     (sbus_readl(&lx_krn->krn_csr) & LEO_KRN_CSR_PROGRESS) &&
+	     i < 300000;
 	     i++)
-		udelay (1); /* Busy wait at most 0.3 sec */
+		udelay(1); /* Busy wait at most 0.3 sec */
 	return;
 }
 
@@ -221,7 +220,7 @@ static int leo_setcolreg(unsigned regno,
 			 unsigned transp, struct fb_info *info)
 {
 	struct leo_par *par = (struct leo_par *) info->par;
-        struct leo_lx_krn __iomem *lx_krn = par->lx_krn;
+	struct leo_lx_krn __iomem *lx_krn = par->lx_krn;
 	unsigned long flags;
 	u32 val;
 	int i;
@@ -408,7 +407,7 @@ static void leo_wid_put(struct fb_info *info, struct fb_wid_list *wl)
 	leo_wait(lx_krn);
 
 	for (i = 0, wi = wl->wl_list; i < wl->wl_count; i++, wi++) {
-		switch(wi->wi_type) {
+		switch (wi->wi_type) {
 		case FB_WID_DBL_8:
 			j = (wi->wi_index & 0xf) + 0x40;
 			break;
@@ -453,13 +452,12 @@ static void leo_init_wids(struct fb_info *info)
 	wi.wi_index = 1;
 	wi.wi_values [0] = 0x30;
 	leo_wid_put(info, &wl);
-
 }
 
 static void leo_switch_from_graph(struct fb_info *info)
 {
 	struct leo_par *par = (struct leo_par *) info->par;
-	struct leo_ld __iomem *ss = (struct leo_ld __iomem *) par->ld_ss0;
+	struct leo_ld_ss0 __iomem *ss = par->ld_ss0;
 	unsigned long flags;
 	u32 val;
 
@@ -485,19 +483,13 @@ static void leo_switch_from_graph(struct fb_info *info)
 		val = sbus_readl(&par->lc_ss0_usr->csr);
 	} while (val & 0x20000000);
 
-	spin_unlock_irqrestore(&par->lock, flags);
-}
-
-static int leo_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
-{
-	/* We just use this to catch switches out of
-	 * graphics mode.
-	 */
-	leo_switch_from_graph(info);
+	/* setup screen buffer for cfb_* functions */
+	sbus_writel(1, &ss->wid);
+	sbus_writel(0x00ffffff, &ss->planemask);
+	sbus_writel(0x310b90, &ss->rop);
+	sbus_writel(0, &par->lc_ss0_usr->addrspace);
 
-	if (var->xoffset || var->yoffset || var->vmode)
-		return -EINVAL;
-	return 0;
+	spin_unlock_irqrestore(&par->lock, flags);
 }
 
 static void leo_init_hw(struct fb_info *info)
@@ -542,7 +534,8 @@ static void leo_unmap_regs(struct of_device *op, struct fb_info *info,
 		of_iounmap(&op->resource[0], info->screen_base, 0x800000);
 }
 
-static int __devinit leo_probe(struct of_device *op, const struct of_device_id *match)
+static int __devinit leo_probe(struct of_device *op,
+			       const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
 	struct fb_info *info;
@@ -594,8 +587,9 @@ static int __devinit leo_probe(struct of_device *op, const struct of_device_id *
 	    !info->screen_base)
 		goto out_unmap_regs;
 
-	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->flags = FBINFO_DEFAULT;
 	info->fbops = &leo_ops;
+	info->pseudo_palette = par->clut_data;
 
 	leo_init_wids(info);
 	leo_init_hw(info);
@@ -649,7 +643,7 @@ static int __devexit leo_remove(struct of_device *op)
 
 static struct of_device_id leo_match[] = {
 	{
-		.name = "leo",
+		.name = "SUNW,leo",
 	},
 	{},
 };

--------------080807010907080304050005--
