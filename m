From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:51:41 +0000
Subject: [PATCH 10/22] svga: Make svga_set_default_crt_regs() take an iomem
Message-Id: <20110111.155141.171497186.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |    2 +-
 drivers/video/s3fb.c     |    2 +-
 drivers/video/svgalib.c  |   12 ++++++------
 drivers/video/vt8623fb.c |    2 +-
 include/linux/svga.h     |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 5cd4d60..8d1f2d3 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -656,7 +656,7 @@ static int arkfb_set_par(struct fb_info *info)
 	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs(par->state.vgabase);
 	svga_set_default_seq_regs(par->state.vgabase);
-	svga_set_default_crt_regs();
+	svga_set_default_crt_regs(par->state.vgabase);
 	svga_wcrt_multi(par->state.vgabase, ark_line_compare_regs, 0xFFFFFFFF);
 	svga_wcrt_multi(par->state.vgabase, ark_start_address_regs, 0);
 
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 5f8e9a4..2c4b006 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -517,7 +517,7 @@ static int s3fb_set_par(struct fb_info *info)
 	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs(par->state.vgabase);
 	svga_set_default_seq_regs(par->state.vgabase);
-	svga_set_default_crt_regs();
+	svga_set_default_crt_regs(par->state.vgabase);
 	svga_wcrt_multi(par->state.vgabase, s3_line_compare_regs, 0xFFFFFFFF);
 	svga_wcrt_multi(par->state.vgabase, s3_start_address_regs, 0);
 
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 3d07287..b046497 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -127,14 +127,14 @@ void svga_set_default_seq_regs(void __iomem *regbase)
 }
 
 /* Set CRTC registers to sane values */
-void svga_set_default_crt_regs(void)
+void svga_set_default_crt_regs(void __iomem *regbase)
 {
 	/* Standard CRT registers CR03 CR08 CR09 CR14 CR17 */
-	svga_wcrt_mask(NULL, 0x03, 0x80, 0x80);	/* Enable vertical retrace EVRA */
-	vga_wcrt(NULL, VGA_CRTC_PRESET_ROW, 0);
-	svga_wcrt_mask(NULL, VGA_CRTC_MAX_SCAN, 0, 0x1F);
-	vga_wcrt(NULL, VGA_CRTC_UNDERLINE, 0);
-	vga_wcrt(NULL, VGA_CRTC_MODE, 0xE3);
+	svga_wcrt_mask(regbase, 0x03, 0x80, 0x80);	/* Enable vertical retrace EVRA */
+	vga_wcrt(regbase, VGA_CRTC_PRESET_ROW, 0);
+	svga_wcrt_mask(regbase, VGA_CRTC_MAX_SCAN, 0, 0x1F);
+	vga_wcrt(regbase, VGA_CRTC_UNDERLINE, 0);
+	vga_wcrt(regbase, VGA_CRTC_MODE, 0xE3);
 }
 
 void svga_set_textmode_vga_regs(void)
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 1e6b598..d6ce17b 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -429,7 +429,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs(par->state.vgabase);
 	svga_set_default_seq_regs(par->state.vgabase);
-	svga_set_default_crt_regs();
+	svga_set_default_crt_regs(par->state.vgabase);
 	svga_wcrt_multi(par->state.vgabase, vt8623_line_compare_regs, 0xFFFFFFFF);
 	svga_wcrt_multi(par->state.vgabase, vt8623_start_address_regs, 0);
 
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 5c5b41b..2a32dd5 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -102,7 +102,7 @@ void svga_wseq_multi(void __iomem *regbase, const struct vga_regset *regset, u32
 void svga_set_default_gfx_regs(void __iomem *regbase);
 void svga_set_default_atc_regs(void __iomem *regbase);
 void svga_set_default_seq_regs(void __iomem *regbase);
-void svga_set_default_crt_regs(void);
+void svga_set_default_crt_regs(void __iomem *regbase);
 void svga_set_textmode_vga_regs(void);
 
 void svga_settile(struct fb_info *info, struct fb_tilemap *map);
-- 
1.7.3.4

