From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:51:56 +0000
Subject: [PATCH 11/22] svga: Make svga_set_textmode_vga_regs() take an
Message-Id: <20110111.155156.219747141.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |    2 +-
 drivers/video/s3fb.c     |    2 +-
 drivers/video/svgalib.c  |   40 ++++++++++++++++++++--------------------
 drivers/video/vt8623fb.c |    2 +-
 include/linux/svga.h     |    2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 8d1f2d3..d282aa1 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -699,7 +699,7 @@ static int arkfb_set_par(struct fb_info *info)
 	switch (mode) {
 	case 0:
 		pr_debug("fb%d: text mode\n", info->node);
-		svga_set_textmode_vga_regs();
+		svga_set_textmode_vga_regs(par->state.vgabase);
 
 		vga_wseq(NULL, 0x11, 0x10); /* basic VGA mode */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 2c4b006..eef988d 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -604,7 +604,7 @@ static int s3fb_set_par(struct fb_info *info)
 	switch (mode) {
 	case 0:
 		pr_debug("fb%d: text mode\n", info->node);
-		svga_set_textmode_vga_regs();
+		svga_set_textmode_vga_regs(par->state.vgabase);
 
 		/* Set additional registers like in 8-bit mode */
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index b046497..ecda90e 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -137,33 +137,33 @@ void svga_set_default_crt_regs(void __iomem *regbase)
 	vga_wcrt(regbase, VGA_CRTC_MODE, 0xE3);
 }
 
-void svga_set_textmode_vga_regs(void)
+void svga_set_textmode_vga_regs(void __iomem *regbase)
 {
-	/* svga_wseq_mask(NULL, 0x1, 0x00, 0x01); */   /* Switch 8/9 pixel per char */
-	vga_wseq(NULL, VGA_SEQ_MEMORY_MODE,	VGA_SR04_EXT_MEM);
-	vga_wseq(NULL, VGA_SEQ_PLANE_WRITE,	0x03);
+	/* svga_wseq_mask(regbase, 0x1, 0x00, 0x01); */   /* Switch 8/9 pixel per char */
+	vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, VGA_SR04_EXT_MEM);
+	vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0x03);
 
-	vga_wcrt(NULL, VGA_CRTC_MAX_SCAN,	0x0f); /* 0x4f */
-	vga_wcrt(NULL, VGA_CRTC_UNDERLINE,	0x1f);
-	svga_wcrt_mask(NULL, VGA_CRTC_MODE, 0x23, 0x7f);
+	vga_wcrt(regbase, VGA_CRTC_MAX_SCAN, 0x0f); /* 0x4f */
+	vga_wcrt(regbase, VGA_CRTC_UNDERLINE, 0x1f);
+	svga_wcrt_mask(regbase, VGA_CRTC_MODE, 0x23, 0x7f);
 
-	vga_wcrt(NULL, VGA_CRTC_CURSOR_START,	0x0d);
-	vga_wcrt(NULL, VGA_CRTC_CURSOR_END,	0x0e);
-	vga_wcrt(NULL, VGA_CRTC_CURSOR_HI,	0x00);
-	vga_wcrt(NULL, VGA_CRTC_CURSOR_LO,	0x00);
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_START, 0x0d);
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_END, 0x0e);
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_HI, 0x00);
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_LO, 0x00);
 
-	vga_wgfx(NULL, VGA_GFX_MODE,		0x10); /* Odd/even memory mode */
-	vga_wgfx(NULL, VGA_GFX_MISC,		0x0E); /* Misc graphics register - text mode enable */
-	vga_wgfx(NULL, VGA_GFX_COMPARE_MASK,	0x00);
+	vga_wgfx(regbase, VGA_GFX_MODE, 0x10); /* Odd/even memory mode */
+	vga_wgfx(regbase, VGA_GFX_MISC, 0x0E); /* Misc graphics register - text mode enable */
+	vga_wgfx(regbase, VGA_GFX_COMPARE_MASK, 0x00);
 
-	vga_r(NULL, 0x3DA);
-	vga_w(NULL, VGA_ATT_W, 0x00);
+	vga_r(regbase, 0x3DA);
+	vga_w(regbase, VGA_ATT_W, 0x00);
 
-	svga_wattr(NULL, 0x10, 0x0C);			/* Attribute Mode Control Register - text mode, blinking and line graphics */
-	svga_wattr(NULL, 0x13, 0x08);			/* Horizontal Pixel Panning Register  */
+	svga_wattr(regbase, 0x10, 0x0C);			/* Attribute Mode Control Register - text mode, blinking and line graphics */
+	svga_wattr(regbase, 0x13, 0x08);			/* Horizontal Pixel Panning Register  */
 
-	vga_r(NULL, 0x3DA);
-	vga_w(NULL, VGA_ATT_W, 0x20);
+	vga_r(regbase, 0x3DA);
+	vga_w(regbase, VGA_ATT_W, 0x20);
 }
 
 #if 0
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index d6ce17b..47f0199 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -466,7 +466,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 	switch (mode) {
 	case 0:
 		pr_debug("fb%d: text mode\n", info->node);
-		svga_set_textmode_vga_regs();
+		svga_set_textmode_vga_regs(par->state.vgabase);
 		svga_wseq_mask(par->state.vgabase, 0x15, 0x00, 0xFE);
 		svga_wcrt_mask(par->state.vgabase, 0x11, 0x60, 0x70);
 		break;
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 2a32dd5..767937d 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -103,7 +103,7 @@ void svga_set_default_gfx_regs(void __iomem *regbase);
 void svga_set_default_atc_regs(void __iomem *regbase);
 void svga_set_default_seq_regs(void __iomem *regbase);
 void svga_set_default_crt_regs(void __iomem *regbase);
-void svga_set_textmode_vga_regs(void);
+void svga_set_textmode_vga_regs(void __iomem *regbase);
 
 void svga_settile(struct fb_info *info, struct fb_tilemap *map);
 void svga_tilecopy(struct fb_info *info, struct fb_tilearea *area);
-- 
1.7.3.4

