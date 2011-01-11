From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:51:08 +0000
Subject: [PATCH 8/22] svga: Make svga_wseq_mask() take an iomem regbase
Message-Id: <20110111.155108.73362778.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |   16 +++++++++-------
 drivers/video/s3fb.c     |   20 +++++++++++---------
 drivers/video/svgalib.c  |    2 +-
 drivers/video/vt8623fb.c |   43 +++++++++++++++++++++++--------------------
 include/linux/svga.h     |    4 ++--
 5 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 41a065d..39f00ac 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -649,7 +649,7 @@ static int arkfb_set_par(struct fb_info *info)
 	svga_wcrt_mask(0x11, 0x00, 0x80);
 
 	/* Blank screen and turn off sync */
-	svga_wseq_mask(0x01, 0x20, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 	svga_wcrt_mask(0x17, 0x00, 0x80);
 
 	/* Set default values */
@@ -661,8 +661,8 @@ static int arkfb_set_par(struct fb_info *info)
 	svga_wcrt_multi(par->state.vgabase, ark_start_address_regs, 0);
 
 	/* ARK specific initialization */
-	svga_wseq_mask(0x10, 0x1F, 0x1F); /* enable linear framebuffer and full memory access */
-	svga_wseq_mask(0x12, 0x03, 0x03); /* 4 MB linear framebuffer size */
+	svga_wseq_mask(par->state.vgabase, 0x10, 0x1F, 0x1F); /* enable linear framebuffer and full memory access */
+	svga_wseq_mask(par->state.vgabase, 0x12, 0x03, 0x03); /* 4 MB linear framebuffer size */
 
 	vga_wseq(NULL, 0x13, info->fix.smem_start >> 16);
 	vga_wseq(NULL, 0x14, info->fix.smem_start >> 24);
@@ -787,7 +787,7 @@ static int arkfb_set_par(struct fb_info *info)
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
 	svga_wcrt_mask(0x17, 0x80, 0x80);
-	svga_wseq_mask(0x01, 0x00, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 
 	return 0;
 }
@@ -857,22 +857,24 @@ static int arkfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 static int arkfb_blank(int blank_mode, struct fb_info *info)
 {
+	struct arkfb_info *par = info->par;
+
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		pr_debug("fb%d: unblank\n", info->node);
-		svga_wseq_mask(0x01, 0x00, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 		svga_wcrt_mask(0x17, 0x80, 0x80);
 		break;
 	case FB_BLANK_NORMAL:
 		pr_debug("fb%d: blank\n", info->node);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		svga_wcrt_mask(0x17, 0x80, 0x80);
 		break;
 	case FB_BLANK_POWERDOWN:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_VSYNC_SUSPEND:
 		pr_debug("fb%d: sync down\n", info->node);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		svga_wcrt_mask(0x17, 0x00, 0x80);
 		break;
 	}
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index a4301b6..aafffcc 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -510,7 +510,7 @@ static int s3fb_set_par(struct fb_info *info)
 	svga_wcrt_mask(0x11, 0x00, 0x80);
 
 	/* Blank screen and turn off sync */
-	svga_wseq_mask(0x01, 0x20, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 	svga_wcrt_mask(0x17, 0x00, 0x80);
 
 	/* Set default values */
@@ -700,8 +700,8 @@ static int s3fb_set_par(struct fb_info *info)
 	}
 
 	if (par->chip != CHIP_988_VIRGE_VX) {
-		svga_wseq_mask(0x15, multiplex ? 0x10 : 0x00, 0x10);
-		svga_wseq_mask(0x18, multiplex ? 0x80 : 0x00, 0x80);
+		svga_wseq_mask(par->state.vgabase, 0x15, multiplex ? 0x10 : 0x00, 0x10);
+		svga_wseq_mask(par->state.vgabase, 0x18, multiplex ? 0x80 : 0x00, 0x80);
 	}
 
 	s3_set_pixclock(info, info->var.pixclock);
@@ -718,7 +718,7 @@ static int s3fb_set_par(struct fb_info *info)
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
 	svga_wcrt_mask(0x17, 0x80, 0x80);
-	svga_wseq_mask(0x01, 0x00, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 
 	return 0;
 }
@@ -788,31 +788,33 @@ static int s3fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 static int s3fb_blank(int blank_mode, struct fb_info *info)
 {
+	struct s3fb_info *par = info->par;
+
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		pr_debug("fb%d: unblank\n", info->node);
 		svga_wcrt_mask(0x56, 0x00, 0x06);
-		svga_wseq_mask(0x01, 0x00, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 		break;
 	case FB_BLANK_NORMAL:
 		pr_debug("fb%d: blank\n", info->node);
 		svga_wcrt_mask(0x56, 0x00, 0x06);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		pr_debug("fb%d: hsync\n", info->node);
 		svga_wcrt_mask(0x56, 0x02, 0x06);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		pr_debug("fb%d: vsync\n", info->node);
 		svga_wcrt_mask(0x56, 0x04, 0x06);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_POWERDOWN:
 		pr_debug("fb%d: sync down\n", info->node);
 		svga_wcrt_mask(0x56, 0x06, 0x06);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	}
 
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 6d3d39f..ea74904 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -139,7 +139,7 @@ void svga_set_default_crt_regs(void)
 
 void svga_set_textmode_vga_regs(void)
 {
-	/* svga_wseq_mask(0x1, 0x00, 0x01); */   /* Switch 8/9 pixel per char */
+	/* svga_wseq_mask(NULL, 0x1, 0x00, 0x01); */   /* Switch 8/9 pixel per char */
 	vga_wseq(NULL, VGA_SEQ_MEMORY_MODE,	VGA_SR04_EXT_MEM);
 	vga_wseq(NULL, VGA_SEQ_PLANE_WRITE,	0x03);
 
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index f19dbed..c0ccaae 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -253,6 +253,7 @@ static void vt8623fb_fillrect(struct fb_info *info, const struct fb_fillrect *re
 
 static void vt8623_set_pixclock(struct fb_info *info, u32 pixclock)
 {
+	struct vt8623fb_info *par = info->par;
 	u16 m, n, r;
 	u8 regval;
 	int rv;
@@ -274,8 +275,8 @@ static void vt8623_set_pixclock(struct fb_info *info, u32 pixclock)
 	udelay(1000);
 
 	/* PLL reset */
-	svga_wseq_mask(0x40, 0x02, 0x02);
-	svga_wseq_mask(0x40, 0x00, 0x02);
+	svga_wseq_mask(par->state.vgabase, 0x40, 0x02, 0x02);
+	svga_wseq_mask(par->state.vgabase, 0x40, 0x00, 0x02);
 }
 
 
@@ -415,12 +416,12 @@ static int vt8623fb_set_par(struct fb_info *info)
 	info->var.activate = FB_ACTIVATE_NOW;
 
 	/* Unlock registers */
-	svga_wseq_mask(0x10, 0x01, 0x01);
+	svga_wseq_mask(par->state.vgabase, 0x10, 0x01, 0x01);
 	svga_wcrt_mask(0x11, 0x00, 0x80);
 	svga_wcrt_mask(0x47, 0x00, 0x01);
 
 	/* Device, screen and sync off */
-	svga_wseq_mask(0x01, 0x20, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 	svga_wcrt_mask(0x36, 0x30, 0x30);
 	svga_wcrt_mask(0x17, 0x00, 0x80);
 
@@ -444,12 +445,12 @@ static int vt8623fb_set_par(struct fb_info *info)
 	else
 		svga_wcrt_mask(0x09, 0x00, 0x80);
 
-	svga_wseq_mask(0x1E, 0xF0, 0xF0); // DI/DVP bus
-	svga_wseq_mask(0x2A, 0x0F, 0x0F); // DI/DVP bus
-	svga_wseq_mask(0x16, 0x08, 0xBF); // FIFO read threshold
+	svga_wseq_mask(par->state.vgabase, 0x1E, 0xF0, 0xF0); // DI/DVP bus
+	svga_wseq_mask(par->state.vgabase, 0x2A, 0x0F, 0x0F); // DI/DVP bus
+	svga_wseq_mask(par->state.vgabase, 0x16, 0x08, 0xBF); // FIFO read threshold
 	vga_wseq(NULL, 0x17, 0x1F);       // FIFO depth
 	vga_wseq(NULL, 0x18, 0x4E);
-	svga_wseq_mask(0x1A, 0x08, 0x08); // enable MMIO ?
+	svga_wseq_mask(par->state.vgabase, 0x1A, 0x08, 0x08); // enable MMIO ?
 
 	vga_wcrt(NULL, 0x32, 0x00);
 	vga_wcrt(NULL, 0x34, 0x00);
@@ -466,31 +467,31 @@ static int vt8623fb_set_par(struct fb_info *info)
 	case 0:
 		pr_debug("fb%d: text mode\n", info->node);
 		svga_set_textmode_vga_regs();
-		svga_wseq_mask(0x15, 0x00, 0xFE);
+		svga_wseq_mask(par->state.vgabase, 0x15, 0x00, 0xFE);
 		svga_wcrt_mask(0x11, 0x60, 0x70);
 		break;
 	case 1:
 		pr_debug("fb%d: 4 bit pseudocolor\n", info->node);
 		vga_wgfx(NULL, VGA_GFX_MODE, 0x40);
-		svga_wseq_mask(0x15, 0x20, 0xFE);
+		svga_wseq_mask(par->state.vgabase, 0x15, 0x20, 0xFE);
 		svga_wcrt_mask(0x11, 0x00, 0x70);
 		break;
 	case 2:
 		pr_debug("fb%d: 4 bit pseudocolor, planar\n", info->node);
-		svga_wseq_mask(0x15, 0x00, 0xFE);
+		svga_wseq_mask(par->state.vgabase, 0x15, 0x00, 0xFE);
 		svga_wcrt_mask(0x11, 0x00, 0x70);
 		break;
 	case 3:
 		pr_debug("fb%d: 8 bit pseudocolor\n", info->node);
-		svga_wseq_mask(0x15, 0x22, 0xFE);
+		svga_wseq_mask(par->state.vgabase, 0x15, 0x22, 0xFE);
 		break;
 	case 4:
 		pr_debug("fb%d: 5/6/5 truecolor\n", info->node);
-		svga_wseq_mask(0x15, 0xB6, 0xFE);
+		svga_wseq_mask(par->state.vgabase, 0x15, 0xB6, 0xFE);
 		break;
 	case 5:
 		pr_debug("fb%d: 8/8/8 truecolor\n", info->node);
-		svga_wseq_mask(0x15, 0xAE, 0xFE);
+		svga_wseq_mask(par->state.vgabase, 0x15, 0xAE, 0xFE);
 		break;
 	default:
 		printk(KERN_ERR "vt8623fb: unsupported mode - bug\n");
@@ -507,7 +508,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 	/* Device and screen back on */
 	svga_wcrt_mask(0x17, 0x80, 0x80);
 	svga_wcrt_mask(0x36, 0x00, 0x30);
-	svga_wseq_mask(0x01, 0x00, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 
 	return 0;
 }
@@ -570,31 +571,33 @@ static int vt8623fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 static int vt8623fb_blank(int blank_mode, struct fb_info *info)
 {
+	struct vt8623fb_info *par = info->par;
+
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		pr_debug("fb%d: unblank\n", info->node);
 		svga_wcrt_mask(0x36, 0x00, 0x30);
-		svga_wseq_mask(0x01, 0x00, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 		break;
 	case FB_BLANK_NORMAL:
 		pr_debug("fb%d: blank\n", info->node);
 		svga_wcrt_mask(0x36, 0x00, 0x30);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		pr_debug("fb%d: DPMS standby (hsync off)\n", info->node);
 		svga_wcrt_mask(0x36, 0x10, 0x30);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		pr_debug("fb%d: DPMS suspend (vsync off)\n", info->node);
 		svga_wcrt_mask(0x36, 0x20, 0x30);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_POWERDOWN:
 		pr_debug("fb%d: DPMS off (no sync)\n", info->node);
 		svga_wcrt_mask(0x36, 0x30, 0x30);
-		svga_wseq_mask(0x01, 0x20, 0x20);
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	}
 
diff --git a/include/linux/svga.h b/include/linux/svga.h
index d31a398..93f7777 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -76,9 +76,9 @@ static inline void svga_wattr(void __iomem *regbase, u8 index, u8 data)
 
 /* Write a value to a sequence register with a mask */
 
-static inline void svga_wseq_mask(u8 index, u8 data, u8 mask)
+static inline void svga_wseq_mask(void __iomem *regbase, u8 index, u8 data, u8 mask)
 {
-	vga_wseq(NULL, index, (data & mask) | (vga_rseq(NULL, index) & ~mask));
+	vga_wseq(regbase, index, (data & mask) | (vga_rseq(regbase, index) & ~mask));
 }
 
 /* Write a value to a CRT register with a mask */
-- 
1.7.3.4

