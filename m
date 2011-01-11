From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:49:18 +0000
Subject: [PATCH 2/22] svga: Make svga_wattr take an iomem regbase pointer.
Message-Id: <20110111.154918.163245188.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


And use vga_{r,w}().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/s3fb.c    |    2 +-
 drivers/video/svgalib.c |   18 +++++++++---------
 include/linux/svga.h    |    8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index dce8c97..0791f30 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -552,7 +552,7 @@ static int s3fb_set_par(struct fb_info *info)
 	}
 
 	vga_wcrt(NULL, 0x3A, 0x35);
-	svga_wattr(0x33, 0x00);
+	svga_wattr(par->state.vgabase, 0x33, 0x00);
 
 	if (info->var.vmode & FB_VMODE_DOUBLE)
 		svga_wcrt_mask(0x09, 0x80, 0x80);
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index fdb4567..59c99fd 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -102,14 +102,14 @@ void svga_set_default_atc_regs(void)
 
 	/* All standard ATC registers (AR00 - AR14) */
 	for (count = 0; count <= 0xF; count ++)
-		svga_wattr(count, count);
+		svga_wattr(NULL, count, count);
 
-	svga_wattr(VGA_ATC_MODE, 0x01);
-/*	svga_wattr(VGA_ATC_MODE, 0x41); */
-	svga_wattr(VGA_ATC_OVERSCAN, 0x00);
-	svga_wattr(VGA_ATC_PLANE_ENABLE, 0x0F);
-	svga_wattr(VGA_ATC_PEL, 0x00);
-	svga_wattr(VGA_ATC_COLOR_PAGE, 0x00);
+	svga_wattr(NULL, VGA_ATC_MODE, 0x01);
+/*	svga_wattr(NULL, VGA_ATC_MODE, 0x41); */
+	svga_wattr(NULL, VGA_ATC_OVERSCAN, 0x00);
+	svga_wattr(NULL, VGA_ATC_PLANE_ENABLE, 0x0F);
+	svga_wattr(NULL, VGA_ATC_PEL, 0x00);
+	svga_wattr(NULL, VGA_ATC_COLOR_PAGE, 0x00);
 
 	vga_r(NULL, 0x3DA);
 	vga_w(NULL, VGA_ATT_W, 0x20);
@@ -159,8 +159,8 @@ void svga_set_textmode_vga_regs(void)
 	vga_r(NULL, 0x3DA);
 	vga_w(NULL, VGA_ATT_W, 0x00);
 
-	svga_wattr(0x10, 0x0C);			/* Attribute Mode Control Register - text mode, blinking and line graphics */
-	svga_wattr(0x13, 0x08);			/* Horizontal Pixel Panning Register  */
+	svga_wattr(NULL, 0x10, 0x0C);			/* Attribute Mode Control Register - text mode, blinking and line graphics */
+	svga_wattr(NULL, 0x13, 0x08);			/* Horizontal Pixel Panning Register  */
 
 	vga_r(NULL, 0x3DA);
 	vga_w(NULL, VGA_ATT_W, 0x20);
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 3fc52cb..95d3941 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -67,11 +67,11 @@ struct svga_pll {
 
 /* Write a value to the attribute register */
 
-static inline void svga_wattr(u8 index, u8 data)
+static inline void svga_wattr(void __iomem *regbase, u8 index, u8 data)
 {
-	inb(VGA_IS1_RC);
-	outb(index, VGA_ATT_IW);
-	outb(data, VGA_ATT_W);
+	vga_r(regbase, VGA_IS1_RC);
+	vga_w(regbase, VGA_ATT_IW, index);
+	vga_w(regbase, VGA_ATT_W, data);
 }
 
 /* Write a value to a sequence register with a mask */
-- 
1.7.3.4

