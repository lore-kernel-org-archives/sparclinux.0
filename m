From: Robert Reif <reif@earthlink.net>
Date: Fri, 10 Oct 2008 11:33:38 +0000
Subject: [PATCH] leo.c disable cursor when leaving graphics mode
Message-Id: <48EF3D92.2070102@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050603000101010608050105"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603000101010608050105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On sparc32 debian etch, the cursor is not disabled
when leaving X windows.  This patch disables the
cursor when leaving graphics mode just like the
ffb driver.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------050603000101010608050105
Content-Type: text/plain;
 name="leo.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="leo.diff.txt"

diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 13fea61..26187d5 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -33,6 +33,7 @@ static int leo_blank(int, struct fb_info *);
 
 static int leo_mmap(struct fb_info *, struct vm_area_struct *);
 static int leo_ioctl(struct fb_info *, unsigned int, unsigned long);
+static int leo_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
  *  Frame buffer operations
@@ -42,6 +43,7 @@ static struct fb_ops leo_ops = {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= leo_setcolreg,
 	.fb_blank		= leo_blank,
+	.fb_pan_display		= leo_pan_display,
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
@@ -206,6 +208,60 @@ static void leo_wait(struct leo_lx_krn __iomem *lx_krn)
 	return;
 }
 
+static void leo_switch_from_graph(struct fb_info *info)
+{
+	struct leo_par *par = (struct leo_par *) info->par;
+	struct leo_ld_ss0 __iomem *ss = par->ld_ss0;
+	struct leo_cursor __iomem *cursor = par->cursor;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&par->lock, flags);
+
+	par->extent = ((info->var.xres - 1) |
+		       ((info->var.yres - 1) << 16));
+
+	sbus_writel(0xffffffff, &ss->wid);
+	sbus_writel(0xffff, &ss->wmask);
+	sbus_writel(0, &ss->vclipmin);
+	sbus_writel(par->extent, &ss->vclipmax);
+	sbus_writel(0, &ss->fg);
+	sbus_writel(0xff000000, &ss->planemask);
+	sbus_writel(0x310850, &ss->rop);
+	sbus_writel(0, &ss->widclip);
+	sbus_writel((info->var.xres-1) | ((info->var.yres-1) << 11),
+		    &par->lc_ss0_usr->extent);
+	sbus_writel(4, &par->lc_ss0_usr->addrspace);
+	sbus_writel(0x80000000, &par->lc_ss0_usr->fill);
+	sbus_writel(0, &par->lc_ss0_usr->fontt);
+	do {
+		val = sbus_readl(&par->lc_ss0_usr->csr);
+	} while (val & 0x20000000);
+
+	/* setup screen buffer for cfb_* functions */
+	sbus_writel(1, &ss->wid);
+	sbus_writel(0x00ffffff, &ss->planemask);
+	sbus_writel(0x310b90, &ss->rop);
+	sbus_writel(0, &par->lc_ss0_usr->addrspace);
+
+	/* hide cursor */
+	sbus_writel(sbus_readl(&cursor->cur_misc) & ~LEO_CUR_ENABLE, &cursor->cur_misc);
+
+	spin_unlock_irqrestore(&par->lock, flags);
+}
+
+static int leo_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	/* We just use this to catch switches out of
+	 * graphics mode.
+	 */
+	leo_switch_from_graph(info);
+
+	if (var->xoffset || var->yoffset || var->vmode)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  *      leo_setcolreg - Optional function. Sets a color register.
  *      @regno: boolean, 0 copy local, 1 get_user() function
@@ -454,44 +510,6 @@ static void leo_init_wids(struct fb_info *info)
 	leo_wid_put(info, &wl);
 }
 
-static void leo_switch_from_graph(struct fb_info *info)
-{
-	struct leo_par *par = (struct leo_par *) info->par;
-	struct leo_ld_ss0 __iomem *ss = par->ld_ss0;
-	unsigned long flags;
-	u32 val;
-
-	spin_lock_irqsave(&par->lock, flags);
-
-	par->extent = ((info->var.xres - 1) |
-		       ((info->var.yres - 1) << 16));
-
-	sbus_writel(0xffffffff, &ss->wid);
-	sbus_writel(0xffff, &ss->wmask);
-	sbus_writel(0, &ss->vclipmin);
-	sbus_writel(par->extent, &ss->vclipmax);
-	sbus_writel(0, &ss->fg);
-	sbus_writel(0xff000000, &ss->planemask);
-	sbus_writel(0x310850, &ss->rop);
-	sbus_writel(0, &ss->widclip);
-	sbus_writel((info->var.xres-1) | ((info->var.yres-1) << 11),
-		    &par->lc_ss0_usr->extent);
-	sbus_writel(4, &par->lc_ss0_usr->addrspace);
-	sbus_writel(0x80000000, &par->lc_ss0_usr->fill);
-	sbus_writel(0, &par->lc_ss0_usr->fontt);
-	do {
-		val = sbus_readl(&par->lc_ss0_usr->csr);
-	} while (val & 0x20000000);
-
-	/* setup screen buffer for cfb_* functions */
-	sbus_writel(1, &ss->wid);
-	sbus_writel(0x00ffffff, &ss->planemask);
-	sbus_writel(0x310b90, &ss->rop);
-	sbus_writel(0, &par->lc_ss0_usr->addrspace);
-
-	spin_unlock_irqrestore(&par->lock, flags);
-}
-
 static void leo_init_hw(struct fb_info *info)
 {
 	struct leo_par *par = (struct leo_par *) info->par;

--------------050603000101010608050105--
