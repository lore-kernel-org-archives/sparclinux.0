From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:51:26 +0000
Subject: [PATCH 9/22] svga: Make svga_wcrt_mask() take an iomem regbase
Message-Id: <20110111.155126.106805863.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |   40 +++++++++---------
 drivers/video/s3fb.c     |   98 +++++++++++++++++++++++-----------------------
 drivers/video/svgalib.c  |    8 ++--
 drivers/video/vt8623fb.c |   36 ++++++++--------
 include/linux/svga.h     |    4 +-
 5 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 39f00ac..5cd4d60 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -646,11 +646,11 @@ static int arkfb_set_par(struct fb_info *info)
 	info->var.activate = FB_ACTIVATE_NOW;
 
 	/* Unlock registers */
-	svga_wcrt_mask(0x11, 0x00, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x11, 0x00, 0x80);
 
 	/* Blank screen and turn off sync */
 	svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
-	svga_wcrt_mask(0x17, 0x00, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x17, 0x00, 0x80);
 
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
@@ -679,17 +679,17 @@ static int arkfb_set_par(struct fb_info *info)
 	svga_wcrt_multi(par->state.vgabase, ark_offset_regs, offset_value);
 
 	/* fix for hi-res textmode */
-	svga_wcrt_mask(0x40, 0x08, 0x08);
+	svga_wcrt_mask(par->state.vgabase, 0x40, 0x08, 0x08);
 
 	if (info->var.vmode & FB_VMODE_DOUBLE)
-		svga_wcrt_mask(0x09, 0x80, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x09, 0x80, 0x80);
 	else
-		svga_wcrt_mask(0x09, 0x00, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x09, 0x00, 0x80);
 
 	if (info->var.vmode & FB_VMODE_INTERLACED)
-		svga_wcrt_mask(0x44, 0x04, 0x04);
+		svga_wcrt_mask(par->state.vgabase, 0x44, 0x04, 0x04);
 	else
-		svga_wcrt_mask(0x44, 0x00, 0x04);
+		svga_wcrt_mask(par->state.vgabase, 0x44, 0x00, 0x04);
 
 	hmul = 1;
 	hdiv = 1;
@@ -702,7 +702,7 @@ static int arkfb_set_par(struct fb_info *info)
 		svga_set_textmode_vga_regs();
 
 		vga_wseq(NULL, 0x11, 0x10); /* basic VGA mode */
-		svga_wcrt_mask(0x46, 0x00, 0x04); /* 8bit pixel path */
+		svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
 		dac_set_mode(par->dac, DAC_PSEUDO8_8);
 
 		break;
@@ -711,14 +711,14 @@ static int arkfb_set_par(struct fb_info *info)
 		vga_wgfx(NULL, VGA_GFX_MODE, 0x40);
 
 		vga_wseq(NULL, 0x11, 0x10); /* basic VGA mode */
-		svga_wcrt_mask(0x46, 0x00, 0x04); /* 8bit pixel path */
+		svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
 		dac_set_mode(par->dac, DAC_PSEUDO8_8);
 		break;
 	case 2:
 		pr_debug("fb%d: 4 bit pseudocolor, planar\n", info->node);
 
 		vga_wseq(NULL, 0x11, 0x10); /* basic VGA mode */
-		svga_wcrt_mask(0x46, 0x00, 0x04); /* 8bit pixel path */
+		svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
 		dac_set_mode(par->dac, DAC_PSEUDO8_8);
 		break;
 	case 3:
@@ -728,11 +728,11 @@ static int arkfb_set_par(struct fb_info *info)
 
 		if (info->var.pixclock > 20000) {
 			pr_debug("fb%d: not using multiplex\n", info->node);
-			svga_wcrt_mask(0x46, 0x00, 0x04); /* 8bit pixel path */
+			svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
 			dac_set_mode(par->dac, DAC_PSEUDO8_8);
 		} else {
 			pr_debug("fb%d: using multiplex\n", info->node);
-			svga_wcrt_mask(0x46, 0x04, 0x04); /* 16bit pixel path */
+			svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 			dac_set_mode(par->dac, DAC_PSEUDO8_16);
 			hdiv = 2;
 		}
@@ -741,21 +741,21 @@ static int arkfb_set_par(struct fb_info *info)
 		pr_debug("fb%d: 5/5/5 truecolor\n", info->node);
 
 		vga_wseq(NULL, 0x11, 0x1A); /* 16bpp accel mode */
-		svga_wcrt_mask(0x46, 0x04, 0x04); /* 16bit pixel path */
+		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB1555_16);
 		break;
 	case 5:
 		pr_debug("fb%d: 5/6/5 truecolor\n", info->node);
 
 		vga_wseq(NULL, 0x11, 0x1A); /* 16bpp accel mode */
-		svga_wcrt_mask(0x46, 0x04, 0x04); /* 16bit pixel path */
+		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB0565_16);
 		break;
 	case 6:
 		pr_debug("fb%d: 8/8/8 truecolor\n", info->node);
 
 		vga_wseq(NULL, 0x11, 0x16); /* 8bpp accel mode ??? */
-		svga_wcrt_mask(0x46, 0x04, 0x04); /* 16bit pixel path */
+		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB0888_16);
 		hmul = 3;
 		hdiv = 2;
@@ -764,7 +764,7 @@ static int arkfb_set_par(struct fb_info *info)
 		pr_debug("fb%d: 8/8/8/8 truecolor\n", info->node);
 
 		vga_wseq(NULL, 0x11, 0x1E); /* 32bpp accel mode */
-		svga_wcrt_mask(0x46, 0x04, 0x04); /* 16bit pixel path */
+		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB8888_16);
 		hmul = 2;
 		break;
@@ -786,7 +786,7 @@ static int arkfb_set_par(struct fb_info *info)
 
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
-	svga_wcrt_mask(0x17, 0x80, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x17, 0x80, 0x80);
 	svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 
 	return 0;
@@ -863,19 +863,19 @@ static int arkfb_blank(int blank_mode, struct fb_info *info)
 	case FB_BLANK_UNBLANK:
 		pr_debug("fb%d: unblank\n", info->node);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
-		svga_wcrt_mask(0x17, 0x80, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x17, 0x80, 0x80);
 		break;
 	case FB_BLANK_NORMAL:
 		pr_debug("fb%d: blank\n", info->node);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
-		svga_wcrt_mask(0x17, 0x80, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x17, 0x80, 0x80);
 		break;
 	case FB_BLANK_POWERDOWN:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_VSYNC_SUSPEND:
 		pr_debug("fb%d: sync down\n", info->node);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
-		svga_wcrt_mask(0x17, 0x00, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x17, 0x00, 0x80);
 		break;
 	}
 	return 0;
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index aafffcc..5f8e9a4 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -507,11 +507,11 @@ static int s3fb_set_par(struct fb_info *info)
 	vga_wcrt(NULL, 0x38, 0x48);
 	vga_wcrt(NULL, 0x39, 0xA5);
 	vga_wseq(NULL, 0x08, 0x06);
-	svga_wcrt_mask(0x11, 0x00, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x11, 0x00, 0x80);
 
 	/* Blank screen and turn off sync */
 	svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
-	svga_wcrt_mask(0x17, 0x00, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x17, 0x00, 0x80);
 
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
@@ -522,20 +522,20 @@ static int s3fb_set_par(struct fb_info *info)
 	svga_wcrt_multi(par->state.vgabase, s3_start_address_regs, 0);
 
 	/* S3 specific initialization */
-	svga_wcrt_mask(0x58, 0x10, 0x10); /* enable linear framebuffer */
-	svga_wcrt_mask(0x31, 0x08, 0x08); /* enable sequencer access to framebuffer above 256 kB */
+	svga_wcrt_mask(par->state.vgabase, 0x58, 0x10, 0x10); /* enable linear framebuffer */
+	svga_wcrt_mask(par->state.vgabase, 0x31, 0x08, 0x08); /* enable sequencer access to framebuffer above 256 kB */
 
-/*	svga_wcrt_mask(0x33, 0x08, 0x08); */ /* DDR ?	*/
-/*	svga_wcrt_mask(0x43, 0x01, 0x01); */ /* DDR ?	*/
-	svga_wcrt_mask(0x33, 0x00, 0x08); /* no DDR ?	*/
-	svga_wcrt_mask(0x43, 0x00, 0x01); /* no DDR ?	*/
+/*	svga_wcrt_mask(par->state.vgabase, 0x33, 0x08, 0x08); */ /* DDR ?	*/
+/*	svga_wcrt_mask(par->state.vgabase, 0x43, 0x01, 0x01); */ /* DDR ?	*/
+	svga_wcrt_mask(par->state.vgabase, 0x33, 0x00, 0x08); /* no DDR ?	*/
+	svga_wcrt_mask(par->state.vgabase, 0x43, 0x00, 0x01); /* no DDR ?	*/
 
-	svga_wcrt_mask(0x5D, 0x00, 0x28); /* Clear strange HSlen bits */
+	svga_wcrt_mask(par->state.vgabase, 0x5D, 0x00, 0x28); /* Clear strange HSlen bits */
 
-/*	svga_wcrt_mask(0x58, 0x03, 0x03); */
+/*	svga_wcrt_mask(par->state.vgabase, 0x58, 0x03, 0x03); */
 
-/*	svga_wcrt_mask(0x53, 0x12, 0x13); */ /* enable MMIO */
-/*	svga_wcrt_mask(0x40, 0x08, 0x08); */ /* enable write buffer */
+/*	svga_wcrt_mask(par->state.vgabase, 0x53, 0x12, 0x13); */ /* enable MMIO */
+/*	svga_wcrt_mask(par->state.vgabase, 0x40, 0x08, 0x08); */ /* enable write buffer */
 
 
 	/* Set the offset register */
@@ -555,19 +555,19 @@ static int s3fb_set_par(struct fb_info *info)
 	svga_wattr(par->state.vgabase, 0x33, 0x00);
 
 	if (info->var.vmode & FB_VMODE_DOUBLE)
-		svga_wcrt_mask(0x09, 0x80, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x09, 0x80, 0x80);
 	else
-		svga_wcrt_mask(0x09, 0x00, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x09, 0x00, 0x80);
 
 	if (info->var.vmode & FB_VMODE_INTERLACED)
-		svga_wcrt_mask(0x42, 0x20, 0x20);
+		svga_wcrt_mask(par->state.vgabase, 0x42, 0x20, 0x20);
 	else
-		svga_wcrt_mask(0x42, 0x00, 0x20);
+		svga_wcrt_mask(par->state.vgabase, 0x42, 0x00, 0x20);
 
 	/* Disable hardware graphics cursor */
-	svga_wcrt_mask(0x45, 0x00, 0x01);
+	svga_wcrt_mask(par->state.vgabase, 0x45, 0x00, 0x01);
 	/* Disable Streams engine */
-	svga_wcrt_mask(0x67, 0x00, 0x0C);
+	svga_wcrt_mask(par->state.vgabase, 0x67, 0x00, 0x0C);
 
 	mode = svga_match_format(s3fb_formats, &(info->var), &(info->fix));
 
@@ -596,7 +596,7 @@ static int s3fb_set_par(struct fb_info *info)
 		vga_wcrt(NULL, 0x66, 0x81);
 	}
 
-	svga_wcrt_mask(0x31, 0x00, 0x40);
+	svga_wcrt_mask(par->state.vgabase, 0x31, 0x00, 0x40);
 	multiplex = 0;
 	hmul = 1;
 
@@ -607,15 +607,15 @@ static int s3fb_set_par(struct fb_info *info)
 		svga_set_textmode_vga_regs();
 
 		/* Set additional registers like in 8-bit mode */
-		svga_wcrt_mask(0x50, 0x00, 0x30);
-		svga_wcrt_mask(0x67, 0x00, 0xF0);
+		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x67, 0x00, 0xF0);
 
 		/* Disable enhanced mode */
-		svga_wcrt_mask(0x3A, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x3A, 0x00, 0x30);
 
 		if (fasttext) {
 			pr_debug("fb%d: high speed text mode set\n", info->node);
-			svga_wcrt_mask(0x31, 0x40, 0x40);
+			svga_wcrt_mask(par->state.vgabase, 0x31, 0x40, 0x40);
 		}
 		break;
 	case 1:
@@ -623,32 +623,32 @@ static int s3fb_set_par(struct fb_info *info)
 		vga_wgfx(NULL, VGA_GFX_MODE, 0x40);
 
 		/* Set additional registers like in 8-bit mode */
-		svga_wcrt_mask(0x50, 0x00, 0x30);
-		svga_wcrt_mask(0x67, 0x00, 0xF0);
+		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x67, 0x00, 0xF0);
 
 		/* disable enhanced mode */
-		svga_wcrt_mask(0x3A, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x3A, 0x00, 0x30);
 		break;
 	case 2:
 		pr_debug("fb%d: 4 bit pseudocolor, planar\n", info->node);
 
 		/* Set additional registers like in 8-bit mode */
-		svga_wcrt_mask(0x50, 0x00, 0x30);
-		svga_wcrt_mask(0x67, 0x00, 0xF0);
+		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x67, 0x00, 0xF0);
 
 		/* disable enhanced mode */
-		svga_wcrt_mask(0x3A, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x3A, 0x00, 0x30);
 		break;
 	case 3:
 		pr_debug("fb%d: 8 bit pseudocolor\n", info->node);
-		svga_wcrt_mask(0x50, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
 		if (info->var.pixclock > 20000 ||
 		    par->chip = CHIP_360_TRIO3D_1X ||
 		    par->chip = CHIP_362_TRIO3D_2X ||
 		    par->chip = CHIP_368_TRIO3D_2X)
-			svga_wcrt_mask(0x67, 0x00, 0xF0);
+			svga_wcrt_mask(par->state.vgabase, 0x67, 0x00, 0xF0);
 		else {
-			svga_wcrt_mask(0x67, 0x10, 0xF0);
+			svga_wcrt_mask(par->state.vgabase, 0x67, 0x10, 0xF0);
 			multiplex = 1;
 		}
 		break;
@@ -656,12 +656,12 @@ static int s3fb_set_par(struct fb_info *info)
 		pr_debug("fb%d: 5/5/5 truecolor\n", info->node);
 		if (par->chip = CHIP_988_VIRGE_VX) {
 			if (info->var.pixclock > 20000)
-				svga_wcrt_mask(0x67, 0x20, 0xF0);
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x20, 0xF0);
 			else
-				svga_wcrt_mask(0x67, 0x30, 0xF0);
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x30, 0xF0);
 		} else {
-			svga_wcrt_mask(0x50, 0x10, 0x30);
-			svga_wcrt_mask(0x67, 0x30, 0xF0);
+			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
+			svga_wcrt_mask(par->state.vgabase, 0x67, 0x30, 0xF0);
 			if (par->chip != CHIP_360_TRIO3D_1X &&
 			    par->chip != CHIP_362_TRIO3D_2X &&
 			    par->chip != CHIP_368_TRIO3D_2X)
@@ -672,12 +672,12 @@ static int s3fb_set_par(struct fb_info *info)
 		pr_debug("fb%d: 5/6/5 truecolor\n", info->node);
 		if (par->chip = CHIP_988_VIRGE_VX) {
 			if (info->var.pixclock > 20000)
-				svga_wcrt_mask(0x67, 0x40, 0xF0);
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x40, 0xF0);
 			else
-				svga_wcrt_mask(0x67, 0x50, 0xF0);
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x50, 0xF0);
 		} else {
-			svga_wcrt_mask(0x50, 0x10, 0x30);
-			svga_wcrt_mask(0x67, 0x50, 0xF0);
+			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
+			svga_wcrt_mask(par->state.vgabase, 0x67, 0x50, 0xF0);
 			if (par->chip != CHIP_360_TRIO3D_1X &&
 			    par->chip != CHIP_362_TRIO3D_2X &&
 			    par->chip != CHIP_368_TRIO3D_2X)
@@ -687,12 +687,12 @@ static int s3fb_set_par(struct fb_info *info)
 	case 6:
 		/* VIRGE VX case */
 		pr_debug("fb%d: 8/8/8 truecolor\n", info->node);
-		svga_wcrt_mask(0x67, 0xD0, 0xF0);
+		svga_wcrt_mask(par->state.vgabase, 0x67, 0xD0, 0xF0);
 		break;
 	case 7:
 		pr_debug("fb%d: 8/8/8/8 truecolor\n", info->node);
-		svga_wcrt_mask(0x50, 0x30, 0x30);
-		svga_wcrt_mask(0x67, 0xD0, 0xF0);
+		svga_wcrt_mask(par->state.vgabase, 0x50, 0x30, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x67, 0xD0, 0xF0);
 		break;
 	default:
 		printk(KERN_ERR "fb%d: unsupported mode - bug\n", info->node);
@@ -717,7 +717,7 @@ static int s3fb_set_par(struct fb_info *info)
 
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
-	svga_wcrt_mask(0x17, 0x80, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x17, 0x80, 0x80);
 	svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 
 	return 0;
@@ -793,27 +793,27 @@ static int s3fb_blank(int blank_mode, struct fb_info *info)
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		pr_debug("fb%d: unblank\n", info->node);
-		svga_wcrt_mask(0x56, 0x00, 0x06);
+		svga_wcrt_mask(par->state.vgabase, 0x56, 0x00, 0x06);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 		break;
 	case FB_BLANK_NORMAL:
 		pr_debug("fb%d: blank\n", info->node);
-		svga_wcrt_mask(0x56, 0x00, 0x06);
+		svga_wcrt_mask(par->state.vgabase, 0x56, 0x00, 0x06);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		pr_debug("fb%d: hsync\n", info->node);
-		svga_wcrt_mask(0x56, 0x02, 0x06);
+		svga_wcrt_mask(par->state.vgabase, 0x56, 0x02, 0x06);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		pr_debug("fb%d: vsync\n", info->node);
-		svga_wcrt_mask(0x56, 0x04, 0x06);
+		svga_wcrt_mask(par->state.vgabase, 0x56, 0x04, 0x06);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_POWERDOWN:
 		pr_debug("fb%d: sync down\n", info->node);
-		svga_wcrt_mask(0x56, 0x06, 0x06);
+		svga_wcrt_mask(par->state.vgabase, 0x56, 0x06, 0x06);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	}
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index ea74904..3d07287 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -130,9 +130,9 @@ void svga_set_default_seq_regs(void __iomem *regbase)
 void svga_set_default_crt_regs(void)
 {
 	/* Standard CRT registers CR03 CR08 CR09 CR14 CR17 */
-	svga_wcrt_mask(0x03, 0x80, 0x80);	/* Enable vertical retrace EVRA */
+	svga_wcrt_mask(NULL, 0x03, 0x80, 0x80);	/* Enable vertical retrace EVRA */
 	vga_wcrt(NULL, VGA_CRTC_PRESET_ROW, 0);
-	svga_wcrt_mask(VGA_CRTC_MAX_SCAN, 0, 0x1F);
+	svga_wcrt_mask(NULL, VGA_CRTC_MAX_SCAN, 0, 0x1F);
 	vga_wcrt(NULL, VGA_CRTC_UNDERLINE, 0);
 	vga_wcrt(NULL, VGA_CRTC_MODE, 0xE3);
 }
@@ -145,7 +145,7 @@ void svga_set_textmode_vga_regs(void)
 
 	vga_wcrt(NULL, VGA_CRTC_MAX_SCAN,	0x0f); /* 0x4f */
 	vga_wcrt(NULL, VGA_CRTC_UNDERLINE,	0x1f);
-	svga_wcrt_mask(VGA_CRTC_MODE,		0x23, 0x7f);
+	svga_wcrt_mask(NULL, VGA_CRTC_MODE, 0x23, 0x7f);
 
 	vga_wcrt(NULL, VGA_CRTC_CURSOR_START,	0x0d);
 	vga_wcrt(NULL, VGA_CRTC_CURSOR_END,	0x0e);
@@ -310,7 +310,7 @@ void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
 	if (! cursor -> mode)
 		return;
 
-	svga_wcrt_mask(0x0A, 0x20, 0x20); /* disable cursor */
+	svga_wcrt_mask(NULL, 0x0A, 0x20, 0x20); /* disable cursor */
 
 	if (cursor -> shape = FB_TILE_CURSOR_NONE)
 		return;
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index c0ccaae..1e6b598 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -417,13 +417,13 @@ static int vt8623fb_set_par(struct fb_info *info)
 
 	/* Unlock registers */
 	svga_wseq_mask(par->state.vgabase, 0x10, 0x01, 0x01);
-	svga_wcrt_mask(0x11, 0x00, 0x80);
-	svga_wcrt_mask(0x47, 0x00, 0x01);
+	svga_wcrt_mask(par->state.vgabase, 0x11, 0x00, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x47, 0x00, 0x01);
 
 	/* Device, screen and sync off */
 	svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
-	svga_wcrt_mask(0x36, 0x30, 0x30);
-	svga_wcrt_mask(0x17, 0x00, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x36, 0x30, 0x30);
+	svga_wcrt_mask(par->state.vgabase, 0x17, 0x00, 0x80);
 
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
@@ -437,13 +437,13 @@ static int vt8623fb_set_par(struct fb_info *info)
 	svga_wseq_multi(par->state.vgabase, vt8623_fetch_count_regs, fetch_value);
 
 	/* Clear H/V Skew */
-	svga_wcrt_mask(0x03, 0x00, 0x60);
-	svga_wcrt_mask(0x05, 0x00, 0x60);
+	svga_wcrt_mask(par->state.vgabase, 0x03, 0x00, 0x60);
+	svga_wcrt_mask(par->state.vgabase, 0x05, 0x00, 0x60);
 
 	if (info->var.vmode & FB_VMODE_DOUBLE)
-		svga_wcrt_mask(0x09, 0x80, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x09, 0x80, 0x80);
 	else
-		svga_wcrt_mask(0x09, 0x00, 0x80);
+		svga_wcrt_mask(par->state.vgabase, 0x09, 0x00, 0x80);
 
 	svga_wseq_mask(par->state.vgabase, 0x1E, 0xF0, 0xF0); // DI/DVP bus
 	svga_wseq_mask(par->state.vgabase, 0x2A, 0x0F, 0x0F); // DI/DVP bus
@@ -468,18 +468,18 @@ static int vt8623fb_set_par(struct fb_info *info)
 		pr_debug("fb%d: text mode\n", info->node);
 		svga_set_textmode_vga_regs();
 		svga_wseq_mask(par->state.vgabase, 0x15, 0x00, 0xFE);
-		svga_wcrt_mask(0x11, 0x60, 0x70);
+		svga_wcrt_mask(par->state.vgabase, 0x11, 0x60, 0x70);
 		break;
 	case 1:
 		pr_debug("fb%d: 4 bit pseudocolor\n", info->node);
 		vga_wgfx(NULL, VGA_GFX_MODE, 0x40);
 		svga_wseq_mask(par->state.vgabase, 0x15, 0x20, 0xFE);
-		svga_wcrt_mask(0x11, 0x00, 0x70);
+		svga_wcrt_mask(par->state.vgabase, 0x11, 0x00, 0x70);
 		break;
 	case 2:
 		pr_debug("fb%d: 4 bit pseudocolor, planar\n", info->node);
 		svga_wseq_mask(par->state.vgabase, 0x15, 0x00, 0xFE);
-		svga_wcrt_mask(0x11, 0x00, 0x70);
+		svga_wcrt_mask(par->state.vgabase, 0x11, 0x00, 0x70);
 		break;
 	case 3:
 		pr_debug("fb%d: 8 bit pseudocolor\n", info->node);
@@ -506,8 +506,8 @@ static int vt8623fb_set_par(struct fb_info *info)
 	memset_io(info->screen_base, 0x00, screen_size);
 
 	/* Device and screen back on */
-	svga_wcrt_mask(0x17, 0x80, 0x80);
-	svga_wcrt_mask(0x36, 0x00, 0x30);
+	svga_wcrt_mask(par->state.vgabase, 0x17, 0x80, 0x80);
+	svga_wcrt_mask(par->state.vgabase, 0x36, 0x00, 0x30);
 	svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 
 	return 0;
@@ -576,27 +576,27 @@ static int vt8623fb_blank(int blank_mode, struct fb_info *info)
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		pr_debug("fb%d: unblank\n", info->node);
-		svga_wcrt_mask(0x36, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x36, 0x00, 0x30);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
 		break;
 	case FB_BLANK_NORMAL:
 		pr_debug("fb%d: blank\n", info->node);
-		svga_wcrt_mask(0x36, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x36, 0x00, 0x30);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		pr_debug("fb%d: DPMS standby (hsync off)\n", info->node);
-		svga_wcrt_mask(0x36, 0x10, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x36, 0x10, 0x30);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		pr_debug("fb%d: DPMS suspend (vsync off)\n", info->node);
-		svga_wcrt_mask(0x36, 0x20, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x36, 0x20, 0x30);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	case FB_BLANK_POWERDOWN:
 		pr_debug("fb%d: DPMS off (no sync)\n", info->node);
-		svga_wcrt_mask(0x36, 0x30, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x36, 0x30, 0x30);
 		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
 		break;
 	}
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 93f7777..5c5b41b 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -83,9 +83,9 @@ static inline void svga_wseq_mask(void __iomem *regbase, u8 index, u8 data, u8 m
 
 /* Write a value to a CRT register with a mask */
 
-static inline void svga_wcrt_mask(u8 index, u8 data, u8 mask)
+static inline void svga_wcrt_mask(void __iomem *regbase, u8 index, u8 data, u8 mask)
 {
-	vga_wcrt(NULL, index, (data & mask) | (vga_rcrt(NULL, index) & ~mask));
+	vga_wcrt(regbase, index, (data & mask) | (vga_rcrt(regbase, index) & ~mask));
 }
 
 static inline int svga_primary_device(struct pci_dev *dev)
-- 
1.7.3.4

