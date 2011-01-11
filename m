From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:50:36 +0000
Subject: [PATCH 6/22] svga: Make svga_set_default_atc_regs take an iomem
Message-Id: <20110111.155036.191158491.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |    2 +-
 drivers/video/s3fb.c     |    2 +-
 drivers/video/svgalib.c  |   24 ++++++++++++------------
 drivers/video/vt8623fb.c |    2 +-
 include/linux/svga.h     |    2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 7939d5e..2dfecbf 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -654,7 +654,7 @@ static int arkfb_set_par(struct fb_info *info)
 
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
-	svga_set_default_atc_regs();
+	svga_set_default_atc_regs(par->state.vgabase);
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
 	svga_wcrt_multi(par->state.vgabase, ark_line_compare_regs, 0xFFFFFFFF);
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 773650c..a187376 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -515,7 +515,7 @@ static int s3fb_set_par(struct fb_info *info)
 
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
-	svga_set_default_atc_regs();
+	svga_set_default_atc_regs(par->state.vgabase);
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
 	svga_wcrt_multi(par->state.vgabase, s3_line_compare_regs, 0xFFFFFFFF);
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 25f9f87..8b97359 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -93,26 +93,26 @@ void svga_set_default_gfx_regs(void __iomem *regbase)
 }
 
 /* Set attribute controller registers to sane values */
-void svga_set_default_atc_regs(void)
+void svga_set_default_atc_regs(void __iomem *regbase)
 {
 	u8 count;
 
-	vga_r(NULL, 0x3DA);
-	vga_w(NULL, VGA_ATT_W, 0x00);
+	vga_r(regbase, 0x3DA);
+	vga_w(regbase, VGA_ATT_W, 0x00);
 
 	/* All standard ATC registers (AR00 - AR14) */
 	for (count = 0; count <= 0xF; count ++)
-		svga_wattr(NULL, count, count);
+		svga_wattr(regbase, count, count);
 
-	svga_wattr(NULL, VGA_ATC_MODE, 0x01);
-/*	svga_wattr(NULL, VGA_ATC_MODE, 0x41); */
-	svga_wattr(NULL, VGA_ATC_OVERSCAN, 0x00);
-	svga_wattr(NULL, VGA_ATC_PLANE_ENABLE, 0x0F);
-	svga_wattr(NULL, VGA_ATC_PEL, 0x00);
-	svga_wattr(NULL, VGA_ATC_COLOR_PAGE, 0x00);
+	svga_wattr(regbase, VGA_ATC_MODE, 0x01);
+/*	svga_wattr(regbase, VGA_ATC_MODE, 0x41); */
+	svga_wattr(regbase, VGA_ATC_OVERSCAN, 0x00);
+	svga_wattr(regbase, VGA_ATC_PLANE_ENABLE, 0x0F);
+	svga_wattr(regbase, VGA_ATC_PEL, 0x00);
+	svga_wattr(regbase, VGA_ATC_COLOR_PAGE, 0x00);
 
-	vga_r(NULL, 0x3DA);
-	vga_w(NULL, VGA_ATT_W, 0x20);
+	vga_r(regbase, 0x3DA);
+	vga_w(regbase, VGA_ATT_W, 0x20);
 }
 
 /* Set sequencer registers to sane values */
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 77382e9..24f5b43 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -426,7 +426,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
-	svga_set_default_atc_regs();
+	svga_set_default_atc_regs(par->state.vgabase);
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
 	svga_wcrt_multi(par->state.vgabase, vt8623_line_compare_regs, 0xFFFFFFFF);
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 4591032..87a4164 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -100,7 +100,7 @@ void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32
 void svga_wseq_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value);
 
 void svga_set_default_gfx_regs(void __iomem *regbase);
-void svga_set_default_atc_regs(void);
+void svga_set_default_atc_regs(void __iomem *regbase);
 void svga_set_default_seq_regs(void);
 void svga_set_default_crt_regs(void);
 void svga_set_textmode_vga_regs(void);
-- 
1.7.3.4

