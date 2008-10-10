From: Robert Reif <reif@earthlink.net>
Date: Fri, 10 Oct 2008 11:31:54 +0000
Subject: [PATCH] cg6.c disable cursor when leaving graphics mode
Message-Id: <48EF3D2A.9040505@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030501030607040409070604"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------030501030607040409070604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On sparc32 debian etch, the cursor is not disabled
when leaving X windows.  This patch disables the
cursor when leaving graphics mode just like the
ffb driver.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------030501030607040409070604
Content-Type: text/plain;
 name="cg6.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg6.diff.txt"

diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 2f64bb3..e8e0c08 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -34,10 +34,11 @@ static int cg6_blank(int, struct fb_info
 
 static void cg6_imageblit(struct fb_info *, const struct fb_image *);
 static void cg6_fillrect(struct fb_info *, const struct fb_fillrect *);
+static void cg6_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 static int cg6_sync(struct fb_info *);
 static int cg6_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg6_ioctl(struct fb_info *, unsigned int, unsigned long);
-static void cg6_copyarea(struct fb_info *info, const struct fb_copyarea *area);
+static int cg6_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
  *  Frame buffer operations
@@ -47,6 +48,7 @@ static struct fb_ops cg6_ops = {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= cg6_setcolreg,
 	.fb_blank		= cg6_blank,
+	.fb_pan_display		= cg6_pan_display,
 	.fb_fillrect		= cg6_fillrect,
 	.fb_copyarea		= cg6_copyarea,
 	.fb_imageblit		= cg6_imageblit,
@@ -161,6 +163,7 @@ #define CG6_THC_MISC_CURS_RES		(1 << 6)
 #define CG6_THC_MISC_INT_ENAB		(1 << 5)
 #define CG6_THC_MISC_INT		(1 << 4)
 #define CG6_THC_MISC_INIT		0x9f
+#define CG6_THC_CURSOFF			((65536-32) | ((65536-32) << 16))
 
 /* The contents are unknown */
 struct cg6_tec {
@@ -280,6 +283,33 @@ static int cg6_sync(struct fb_info *info
 	return 0;
 }
 
+static void cg6_switch_from_graph(struct cg6_par *par)
+{
+	struct cg6_thc __iomem *thc = par->thc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&par->lock, flags);
+
+	/* Hide the cursor. */
+	sbus_writel(CG6_THC_CURSOFF, &thc->thc_cursxy);
+
+	spin_unlock_irqrestore(&par->lock, flags);
+}
+
+static int cg6_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct cg6_par *par = (struct cg6_par *)info->par;
+
+	/* We just use this to catch switches out of
+	 * graphics mode.
+	 */
+	cg6_switch_from_graph(par);
+
+	if (var->xoffset || var->yoffset || var->vmode)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  *	cg6_fillrect -	Draws a rectangle on the screen.
  *
@@ -643,9 +673,13 @@ static void __devinit cg6_chip_init(stru
 	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct cg6_tec __iomem *tec = par->tec;
 	struct cg6_fbc __iomem *fbc = par->fbc;
+	struct cg6_thc __iomem *thc = par->thc;
 	u32 rev, conf, mode;
 	int i;
 
+	/* Hide the cursor. */
+	sbus_writel(CG6_THC_CURSOFF, &thc->thc_cursxy);
+
 	/* Turn off stuff in the Transform Engine. */
 	sbus_writel(0, &tec->tec_matrix);
 	sbus_writel(0, &tec->tec_clip);

--------------030501030607040409070604--
