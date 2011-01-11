From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:52:40 +0000
Subject: [PATCH 14/22] arkfb: Pass par->state.vgabase to vga_*() calls.
Message-Id: <20110111.155240.146103294.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Instead of just plain NULL.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c |   60 +++++++++++++++++++++++++++---------------------
 1 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 9c1632e..f328c9d 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -473,32 +473,40 @@ static unsigned short dac_regs[4] = {0x3c8, 0x3c9, 0x3c6, 0x3c7};
 
 static void ark_dac_read_regs(void *data, u8 *code, int count)
 {
-	u8 regval = vga_rseq(NULL, 0x1C);
+	struct fb_info *info = data;
+	struct arkfb_info *par;
+	u8 regval;
 
+	par = info->par;
+	regval = vga_rseq(par->state.vgabase, 0x1C);
 	while (count != 0)
 	{
-		vga_wseq(NULL, 0x1C, regval | (code[0] & 4 ? 0x80 : 0));
-		code[1] = vga_r(NULL, dac_regs[code[0] & 3]);
+		vga_wseq(par->state.vgabase, 0x1C, regval | (code[0] & 4 ? 0x80 : 0));
+		code[1] = vga_r(par->state.vgabase, dac_regs[code[0] & 3]);
 		count--;
 		code += 2;
 	}
 
-	vga_wseq(NULL, 0x1C, regval);
+	vga_wseq(par->state.vgabase, 0x1C, regval);
 }
 
 static void ark_dac_write_regs(void *data, u8 *code, int count)
 {
-	u8 regval = vga_rseq(NULL, 0x1C);
+	struct fb_info *info = data;
+	struct arkfb_info *par;
+	u8 regval;
 
+	par = info->par;
+	regval = vga_rseq(par->state.vgabase, 0x1C);
 	while (count != 0)
 	{
-		vga_wseq(NULL, 0x1C, regval | (code[0] & 4 ? 0x80 : 0));
-		vga_w(NULL, dac_regs[code[0] & 3], code[1]);
+		vga_wseq(par->state.vgabase, 0x1C, regval | (code[0] & 4 ? 0x80 : 0));
+		vga_w(par->state.vgabase, dac_regs[code[0] & 3], code[1]);
 		count--;
 		code += 2;
 	}
 
-	vga_wseq(NULL, 0x1C, regval);
+	vga_wseq(par->state.vgabase, 0x1C, regval);
 }
 
 
@@ -514,8 +522,8 @@ static void ark_set_pixclock(struct fb_info *info, u32 pixclock)
 	}
 
 	/* Set VGA misc register  */
-	regval = vga_r(NULL, VGA_MIS_R);
-	vga_w(NULL, VGA_MIS_W, regval | VGA_MIS_ENB_PLL_LOAD);
+	regval = vga_r(par->state.vgabase, VGA_MIS_R);
+	vga_w(par->state.vgabase, VGA_MIS_W, regval | VGA_MIS_ENB_PLL_LOAD);
 }
 
 
@@ -671,15 +679,15 @@ static int arkfb_set_par(struct fb_info *info)
 	svga_wseq_mask(par->state.vgabase, 0x10, 0x1F, 0x1F); /* enable linear framebuffer and full memory access */
 	svga_wseq_mask(par->state.vgabase, 0x12, 0x03, 0x03); /* 4 MB linear framebuffer size */
 
-	vga_wseq(NULL, 0x13, info->fix.smem_start >> 16);
-	vga_wseq(NULL, 0x14, info->fix.smem_start >> 24);
-	vga_wseq(NULL, 0x15, 0);
-	vga_wseq(NULL, 0x16, 0);
+	vga_wseq(par->state.vgabase, 0x13, info->fix.smem_start >> 16);
+	vga_wseq(par->state.vgabase, 0x14, info->fix.smem_start >> 24);
+	vga_wseq(par->state.vgabase, 0x15, 0);
+	vga_wseq(par->state.vgabase, 0x16, 0);
 
 	/* Set the FIFO threshold register */
 	/* It is fascinating way to store 5-bit value in 8-bit register */
 	regval = 0x10 | ((threshold & 0x0E) >> 1) | (threshold & 0x01) << 7 | (threshold & 0x10) << 1;
-	vga_wseq(NULL, 0x18, regval);
+	vga_wseq(par->state.vgabase, 0x18, regval);
 
 	/* Set the offset register */
 	pr_debug("fb%d: offset register       : %d\n", info->node, offset_value);
@@ -708,30 +716,30 @@ static int arkfb_set_par(struct fb_info *info)
 		pr_debug("fb%d: text mode\n", info->node);
 		svga_set_textmode_vga_regs(par->state.vgabase);
 
-		vga_wseq(NULL, 0x11, 0x10); /* basic VGA mode */
+		vga_wseq(par->state.vgabase, 0x11, 0x10); /* basic VGA mode */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
 		dac_set_mode(par->dac, DAC_PSEUDO8_8);
 
 		break;
 	case 1:
 		pr_debug("fb%d: 4 bit pseudocolor\n", info->node);
-		vga_wgfx(NULL, VGA_GFX_MODE, 0x40);
+		vga_wgfx(par->state.vgabase, VGA_GFX_MODE, 0x40);
 
-		vga_wseq(NULL, 0x11, 0x10); /* basic VGA mode */
+		vga_wseq(par->state.vgabase, 0x11, 0x10); /* basic VGA mode */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
 		dac_set_mode(par->dac, DAC_PSEUDO8_8);
 		break;
 	case 2:
 		pr_debug("fb%d: 4 bit pseudocolor, planar\n", info->node);
 
-		vga_wseq(NULL, 0x11, 0x10); /* basic VGA mode */
+		vga_wseq(par->state.vgabase, 0x11, 0x10); /* basic VGA mode */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x00, 0x04); /* 8bit pixel path */
 		dac_set_mode(par->dac, DAC_PSEUDO8_8);
 		break;
 	case 3:
 		pr_debug("fb%d: 8 bit pseudocolor\n", info->node);
 
-		vga_wseq(NULL, 0x11, 0x16); /* 8bpp accel mode */
+		vga_wseq(par->state.vgabase, 0x11, 0x16); /* 8bpp accel mode */
 
 		if (info->var.pixclock > 20000) {
 			pr_debug("fb%d: not using multiplex\n", info->node);
@@ -747,21 +755,21 @@ static int arkfb_set_par(struct fb_info *info)
 	case 4:
 		pr_debug("fb%d: 5/5/5 truecolor\n", info->node);
 
-		vga_wseq(NULL, 0x11, 0x1A); /* 16bpp accel mode */
+		vga_wseq(par->state.vgabase, 0x11, 0x1A); /* 16bpp accel mode */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB1555_16);
 		break;
 	case 5:
 		pr_debug("fb%d: 5/6/5 truecolor\n", info->node);
 
-		vga_wseq(NULL, 0x11, 0x1A); /* 16bpp accel mode */
+		vga_wseq(par->state.vgabase, 0x11, 0x1A); /* 16bpp accel mode */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB0565_16);
 		break;
 	case 6:
 		pr_debug("fb%d: 8/8/8 truecolor\n", info->node);
 
-		vga_wseq(NULL, 0x11, 0x16); /* 8bpp accel mode ??? */
+		vga_wseq(par->state.vgabase, 0x11, 0x16); /* 8bpp accel mode ??? */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB0888_16);
 		hmul = 3;
@@ -770,7 +778,7 @@ static int arkfb_set_par(struct fb_info *info)
 	case 7:
 		pr_debug("fb%d: 8/8/8/8 truecolor\n", info->node);
 
-		vga_wseq(NULL, 0x11, 0x1E); /* 32bpp accel mode */
+		vga_wseq(par->state.vgabase, 0x11, 0x1E); /* 32bpp accel mode */
 		svga_wcrt_mask(par->state.vgabase, 0x46, 0x04, 0x04); /* 16bit pixel path */
 		dac_set_mode(par->dac, DAC_RGB8888_16);
 		hmul = 2;
@@ -789,7 +797,7 @@ static int arkfb_set_par(struct fb_info *info)
 	/* Set interlaced mode start/end register */
 	value = info->var.xres + info->var.left_margin + info->var.right_margin + info->var.hsync_len;
 	value = ((value * hmul / hdiv) / 8) - 5;
-	vga_wcrt(NULL, 0x42, (value + 1) / 2);
+	vga_wcrt(par->state.vgabase, 0x42, (value + 1) / 2);
 
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
@@ -996,7 +1004,7 @@ static int __devinit ark_pci_probe(struct pci_dev *dev, const struct pci_device_
 	}
 
 	/* FIXME get memsize */
-	regval = vga_rseq(NULL, 0x10);
+	regval = vga_rseq(par->state.vgabase, 0x10);
 	info->screen_size = (1 << (regval >> 6)) << 20;
 	info->fix.smem_len = info->screen_size;
 
-- 
1.7.3.4

