From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:49:34 +0000
Subject: [PATCH 3/22] svga: Make svga_wcrt_multi take an iomem regbase
Message-Id: <20110111.154934.218079330.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |    9 +++++----
 drivers/video/s3fb.c     |   13 +++++++------
 drivers/video/svgalib.c  |   32 ++++++++++++++++----------------
 drivers/video/vt8623fb.c |   10 ++++++----
 include/linux/svga.h     |    2 +-
 5 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index d583bea..311a512 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -657,8 +657,8 @@ static int arkfb_set_par(struct fb_info *info)
 	svga_set_default_atc_regs();
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
-	svga_wcrt_multi(ark_line_compare_regs, 0xFFFFFFFF);
-	svga_wcrt_multi(ark_start_address_regs, 0);
+	svga_wcrt_multi(par->state.vgabase, ark_line_compare_regs, 0xFFFFFFFF);
+	svga_wcrt_multi(par->state.vgabase, ark_start_address_regs, 0);
 
 	/* ARK specific initialization */
 	svga_wseq_mask(0x10, 0x1F, 0x1F); /* enable linear framebuffer and full memory access */
@@ -676,7 +676,7 @@ static int arkfb_set_par(struct fb_info *info)
 
 	/* Set the offset register */
 	pr_debug("fb%d: offset register       : %d\n", info->node, offset_value);
-	svga_wcrt_multi(ark_offset_regs, offset_value);
+	svga_wcrt_multi(par->state.vgabase, ark_offset_regs, offset_value);
 
 	/* fix for hi-res textmode */
 	svga_wcrt_mask(0x40, 0x08, 0x08);
@@ -884,6 +884,7 @@ static int arkfb_blank(int blank_mode, struct fb_info *info)
 
 static int arkfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
+	struct arkfb_info *par = info->par;
 	unsigned int offset;
 
 	/* Calculate the offset */
@@ -897,7 +898,7 @@ static int arkfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info
 	}
 
 	/* Set the offset */
-	svga_wcrt_multi(ark_start_address_regs, offset);
+	svga_wcrt_multi(par->state.vgabase, ark_start_address_regs, offset);
 
 	return 0;
 }
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 0791f30..26698e6 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -518,8 +518,8 @@ static int s3fb_set_par(struct fb_info *info)
 	svga_set_default_atc_regs();
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
-	svga_wcrt_multi(s3_line_compare_regs, 0xFFFFFFFF);
-	svga_wcrt_multi(s3_start_address_regs, 0);
+	svga_wcrt_multi(par->state.vgabase, s3_line_compare_regs, 0xFFFFFFFF);
+	svga_wcrt_multi(par->state.vgabase, s3_start_address_regs, 0);
 
 	/* S3 specific initialization */
 	svga_wcrt_mask(0x58, 0x10, 0x10); /* enable linear framebuffer */
@@ -540,7 +540,7 @@ static int s3fb_set_par(struct fb_info *info)
 
 	/* Set the offset register */
 	pr_debug("fb%d: offset register       : %d\n", info->node, offset_value);
-	svga_wcrt_multi(s3_offset_regs, offset_value);
+	svga_wcrt_multi(par->state.vgabase, s3_offset_regs, offset_value);
 
 	if (par->chip != CHIP_360_TRIO3D_1X &&
 	    par->chip != CHIP_362_TRIO3D_2X &&
@@ -822,8 +822,9 @@ static int s3fb_blank(int blank_mode, struct fb_info *info)
 
 /* Pan the display */
 
-static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info) {
-
+static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct s3fb_info *par = info->par;
 	unsigned int offset;
 
 	/* Calculate the offset */
@@ -837,7 +838,7 @@ static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	}
 
 	/* Set the offset */
-	svga_wcrt_multi(s3_start_address_regs, offset);
+	svga_wcrt_multi(par->state.vgabase, s3_start_address_regs, offset);
 
 	return 0;
 }
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 59c99fd..bf3c7a9 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -20,12 +20,12 @@
 
 
 /* Write a CRT register value spread across multiple registers */
-void svga_wcrt_multi(const struct vga_regset *regset, u32 value) {
-
+void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value)
+{
 	u8 regval, bitval, bitnum;
 
 	while (regset->regnum != VGA_REGSET_END_VAL) {
-		regval = vga_rcrt(NULL, regset->regnum);
+		regval = vga_rcrt(regbase, regset->regnum);
 		bitnum = regset->lowbit;
 		while (bitnum <= regset->highbit) {
 			bitval = 1 << bitnum;
@@ -34,7 +34,7 @@ void svga_wcrt_multi(const struct vga_regset *regset, u32 value) {
 			bitnum ++;
 			value = value >> 1;
 		}
-		vga_wcrt(NULL, regset->regnum, regval);
+		vga_wcrt(regbase, regset->regnum, regval);
 		regset ++;
 	}
 }
@@ -516,62 +516,62 @@ void svga_set_timings(const struct svga_timing_regs *tm, struct fb_var_screeninf
 	value = var->xres + var->left_margin + var->right_margin + var->hsync_len;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal total      : %d\n", node, value);
-	svga_wcrt_multi(tm->h_total_regs, (value / 8) - 5);
+	svga_wcrt_multi(NULL, tm->h_total_regs, (value / 8) - 5);
 
 	value = var->xres;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal display    : %d\n", node, value);
-	svga_wcrt_multi(tm->h_display_regs, (value / 8) - 1);
+	svga_wcrt_multi(NULL, tm->h_display_regs, (value / 8) - 1);
 
 	value = var->xres;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal blank start: %d\n", node, value);
-	svga_wcrt_multi(tm->h_blank_start_regs, (value / 8) - 1 + hborder);
+	svga_wcrt_multi(NULL, tm->h_blank_start_regs, (value / 8) - 1 + hborder);
 
 	value = var->xres + var->left_margin + var->right_margin + var->hsync_len;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal blank end  : %d\n", node, value);
-	svga_wcrt_multi(tm->h_blank_end_regs, (value / 8) - 1 - hborder);
+	svga_wcrt_multi(NULL, tm->h_blank_end_regs, (value / 8) - 1 - hborder);
 
 	value = var->xres + var->right_margin;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal sync start : %d\n", node, value);
-	svga_wcrt_multi(tm->h_sync_start_regs, (value / 8));
+	svga_wcrt_multi(NULL, tm->h_sync_start_regs, (value / 8));
 
 	value = var->xres + var->right_margin + var->hsync_len;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal sync end   : %d\n", node, value);
-	svga_wcrt_multi(tm->h_sync_end_regs, (value / 8));
+	svga_wcrt_multi(NULL, tm->h_sync_end_regs, (value / 8));
 
 	value = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical total        : %d\n", node, value);
-	svga_wcrt_multi(tm->v_total_regs, value - 2);
+	svga_wcrt_multi(NULL, tm->v_total_regs, value - 2);
 
 	value = var->yres;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical display      : %d\n", node, value);
-	svga_wcrt_multi(tm->v_display_regs, value - 1);
+	svga_wcrt_multi(NULL, tm->v_display_regs, value - 1);
 
 	value = var->yres;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical blank start  : %d\n", node, value);
-	svga_wcrt_multi(tm->v_blank_start_regs, value);
+	svga_wcrt_multi(NULL, tm->v_blank_start_regs, value);
 
 	value = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical blank end    : %d\n", node, value);
-	svga_wcrt_multi(tm->v_blank_end_regs, value - 2);
+	svga_wcrt_multi(NULL, tm->v_blank_end_regs, value - 2);
 
 	value = var->yres + var->lower_margin;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical sync start   : %d\n", node, value);
-	svga_wcrt_multi(tm->v_sync_start_regs, value);
+	svga_wcrt_multi(NULL, tm->v_sync_start_regs, value);
 
 	value = var->yres + var->lower_margin + var->vsync_len;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical sync end     : %d\n", node, value);
-	svga_wcrt_multi(tm->v_sync_end_regs, value);
+	svga_wcrt_multi(NULL, tm->v_sync_end_regs, value);
 
 	/* Set horizontal and vertical sync pulse polarity in misc register */
 
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 85d76ec..9d4f7d4 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -373,6 +373,7 @@ static int vt8623fb_check_var(struct fb_var_screeninfo *var, struct fb_info *inf
 static int vt8623fb_set_par(struct fb_info *info)
 {
 	u32 mode, offset_value, fetch_value, screen_size;
+	struct vt8623fb_info *par = info->par;
 	u32 bpp = info->var.bits_per_pixel;
 
 	if (bpp != 0) {
@@ -428,10 +429,10 @@ static int vt8623fb_set_par(struct fb_info *info)
 	svga_set_default_atc_regs();
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
-	svga_wcrt_multi(vt8623_line_compare_regs, 0xFFFFFFFF);
-	svga_wcrt_multi(vt8623_start_address_regs, 0);
+	svga_wcrt_multi(par->state.vgabase, vt8623_line_compare_regs, 0xFFFFFFFF);
+	svga_wcrt_multi(par->state.vgabase, vt8623_start_address_regs, 0);
 
-	svga_wcrt_multi(vt8623_offset_regs, offset_value);
+	svga_wcrt_multi(par->state.vgabase, vt8623_offset_regs, offset_value);
 	svga_wseq_multi(vt8623_fetch_count_regs, fetch_value);
 
 	/* Clear H/V Skew */
@@ -603,6 +604,7 @@ static int vt8623fb_blank(int blank_mode, struct fb_info *info)
 
 static int vt8623fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
+	struct vt8623fb_info *par = info->par;
 	unsigned int offset;
 
 	/* Calculate the offset */
@@ -616,7 +618,7 @@ static int vt8623fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *i
 	}
 
 	/* Set the offset */
-	svga_wcrt_multi(vt8623_start_address_regs, offset);
+	svga_wcrt_multi(par->state.vgabase, vt8623_start_address_regs, offset);
 
 	return 0;
 }
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 95d3941..8ca81e0 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -96,7 +96,7 @@ static inline int svga_primary_device(struct pci_dev *dev)
 }
 
 
-void svga_wcrt_multi(const struct vga_regset *regset, u32 value);
+void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value);
 void svga_wseq_multi(const struct vga_regset *regset, u32 value);
 
 void svga_set_default_gfx_regs(void);
-- 
1.7.3.4

