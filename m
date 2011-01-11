From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:52:25 +0000
Subject: [PATCH 13/22] svga: Make svga_set_timings() take an iomem regbase
Message-Id: <20110111.155225.233876725.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |    2 +-
 drivers/video/s3fb.c     |    2 +-
 drivers/video/svgalib.c  |   33 +++++++++++++++++----------------
 drivers/video/vt8623fb.c |    2 +-
 include/linux/svga.h     |    2 +-
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 7c21bb7..9c1632e 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -781,7 +781,7 @@ static int arkfb_set_par(struct fb_info *info)
 	}
 
 	ark_set_pixclock(info, (hdiv * info->var.pixclock) / hmul);
-	svga_set_timings(&ark_timing_regs, &(info->var), hmul, hdiv,
+	svga_set_timings(par->state.vgabase, &ark_timing_regs, &(info->var), hmul, hdiv,
 			 (info->var.vmode & FB_VMODE_DOUBLE)     ? 2 : 1,
 			 (info->var.vmode & FB_VMODE_INTERLACED) ? 2 : 1,
 			  hmul, info->node);
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 0ec0f39..a53d974 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -712,7 +712,7 @@ static int s3fb_set_par(struct fb_info *info)
 	}
 
 	s3_set_pixclock(info, info->var.pixclock);
-	svga_set_timings(&s3_timing_regs, &(info->var), hmul, 1,
+	svga_set_timings(par->state.vgabase, &s3_timing_regs, &(info->var), hmul, 1,
 			 (info->var.vmode & FB_VMODE_DOUBLE)     ? 2 : 1,
 			 (info->var.vmode & FB_VMODE_INTERLACED) ? 2 : 1,
 			 hmul, info->node);
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 4876be8..33df9ec 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -507,8 +507,9 @@ int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screenin
 }
 
 /* Set CRT timing registers */
-void svga_set_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var,
-			u32 hmul, u32 hdiv, u32 vmul, u32 vdiv, u32 hborder, int node)
+void svga_set_timings(void __iomem *regbase, const struct svga_timing_regs *tm,
+		      struct fb_var_screeninfo *var,
+		      u32 hmul, u32 hdiv, u32 vmul, u32 vdiv, u32 hborder, int node)
 {
 	u8 regval;
 	u32 value;
@@ -516,66 +517,66 @@ void svga_set_timings(const struct svga_timing_regs *tm, struct fb_var_screeninf
 	value = var->xres + var->left_margin + var->right_margin + var->hsync_len;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal total      : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->h_total_regs, (value / 8) - 5);
+	svga_wcrt_multi(regbase, tm->h_total_regs, (value / 8) - 5);
 
 	value = var->xres;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal display    : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->h_display_regs, (value / 8) - 1);
+	svga_wcrt_multi(regbase, tm->h_display_regs, (value / 8) - 1);
 
 	value = var->xres;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal blank start: %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->h_blank_start_regs, (value / 8) - 1 + hborder);
+	svga_wcrt_multi(regbase, tm->h_blank_start_regs, (value / 8) - 1 + hborder);
 
 	value = var->xres + var->left_margin + var->right_margin + var->hsync_len;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal blank end  : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->h_blank_end_regs, (value / 8) - 1 - hborder);
+	svga_wcrt_multi(regbase, tm->h_blank_end_regs, (value / 8) - 1 - hborder);
 
 	value = var->xres + var->right_margin;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal sync start : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->h_sync_start_regs, (value / 8));
+	svga_wcrt_multi(regbase, tm->h_sync_start_regs, (value / 8));
 
 	value = var->xres + var->right_margin + var->hsync_len;
 	value = (value * hmul) / hdiv;
 	pr_debug("fb%d: horizontal sync end   : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->h_sync_end_regs, (value / 8));
+	svga_wcrt_multi(regbase, tm->h_sync_end_regs, (value / 8));
 
 	value = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical total        : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->v_total_regs, value - 2);
+	svga_wcrt_multi(regbase, tm->v_total_regs, value - 2);
 
 	value = var->yres;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical display      : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->v_display_regs, value - 1);
+	svga_wcrt_multi(regbase, tm->v_display_regs, value - 1);
 
 	value = var->yres;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical blank start  : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->v_blank_start_regs, value);
+	svga_wcrt_multi(regbase, tm->v_blank_start_regs, value);
 
 	value = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical blank end    : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->v_blank_end_regs, value - 2);
+	svga_wcrt_multi(regbase, tm->v_blank_end_regs, value - 2);
 
 	value = var->yres + var->lower_margin;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical sync start   : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->v_sync_start_regs, value);
+	svga_wcrt_multi(regbase, tm->v_sync_start_regs, value);
 
 	value = var->yres + var->lower_margin + var->vsync_len;
 	value = (value * vmul) / vdiv;
 	pr_debug("fb%d: vertical sync end     : %d\n", node, value);
-	svga_wcrt_multi(NULL, tm->v_sync_end_regs, value);
+	svga_wcrt_multi(regbase, tm->v_sync_end_regs, value);
 
 	/* Set horizontal and vertical sync pulse polarity in misc register */
 
-	regval = vga_r(NULL, VGA_MIS_R);
+	regval = vga_r(regbase, VGA_MIS_R);
 	if (var->sync & FB_SYNC_HOR_HIGH_ACT) {
 		pr_debug("fb%d: positive horizontal sync\n", node);
 		regval = regval & ~0x80;
@@ -590,7 +591,7 @@ void svga_set_timings(const struct svga_timing_regs *tm, struct fb_var_screeninf
 		pr_debug("fb%d: negative vertical sync\n\n", node);
 		regval = regval | 0x40;
 	}
-	vga_w(NULL, VGA_MIS_W, regval);
+	vga_w(regbase, VGA_MIS_W, regval);
 }
 
 
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 7e6afe1..f36c0e5 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -505,7 +505,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 	}
 
 	vt8623_set_pixclock(info, info->var.pixclock);
-	svga_set_timings(&vt8623_timing_regs, &(info->var), 1, 1,
+	svga_set_timings(par->state.vgabase, &vt8623_timing_regs, &(info->var), 1, 1,
 			 (info->var.vmode & FB_VMODE_DOUBLE) ? 2 : 1, 1,
 			 1, info->node);
 
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 8787950..bfa68e8 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -116,7 +116,7 @@ void svga_get_caps(struct fb_info *info, struct fb_blit_caps *caps,
 
 int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u16 *r, int node);
 int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, int node);
-void svga_set_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, u32 hmul, u32 hdiv, u32 vmul, u32 vdiv, u32 hborder, int node);
+void svga_set_timings(void __iomem *regbase, const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, u32 hmul, u32 hdiv, u32 vmul, u32 vdiv, u32 hborder, int node);
 
 int svga_match_format(const struct svga_fb_format *frm, struct fb_var_screeninfo *var, struct fb_fix_screeninfo *fix);
 
-- 
1.7.3.4

