From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:53:11 +0000
Subject: [PATCH 16/22] vt8623fb: Pass par->state.vgabase to vga_*() calls.
Message-Id: <20110111.155311.66725233.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Instead of just plain NULL.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/vt8623fb.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index f36c0e5..b470157 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -271,12 +271,12 @@ static void vt8623_set_pixclock(struct fb_info *info, u32 pixclock)
 	}
 
 	/* Set VGA misc register  */
-	regval = vga_r(NULL, VGA_MIS_R);
-	vga_w(NULL, VGA_MIS_W, regval | VGA_MIS_ENB_PLL_LOAD);
+	regval = vga_r(par->state.vgabase, VGA_MIS_R);
+	vga_w(par->state.vgabase, VGA_MIS_W, regval | VGA_MIS_ENB_PLL_LOAD);
 
 	/* Set clock registers */
-	vga_wseq(NULL, 0x46, (n  | (r << 6)));
-	vga_wseq(NULL, 0x47, m);
+	vga_wseq(par->state.vgabase, 0x46, (n  | (r << 6)));
+	vga_wseq(par->state.vgabase, 0x47, m);
 
 	udelay(1000);
 
@@ -454,18 +454,18 @@ static int vt8623fb_set_par(struct fb_info *info)
 	svga_wseq_mask(par->state.vgabase, 0x1E, 0xF0, 0xF0); // DI/DVP bus
 	svga_wseq_mask(par->state.vgabase, 0x2A, 0x0F, 0x0F); // DI/DVP bus
 	svga_wseq_mask(par->state.vgabase, 0x16, 0x08, 0xBF); // FIFO read threshold
-	vga_wseq(NULL, 0x17, 0x1F);       // FIFO depth
-	vga_wseq(NULL, 0x18, 0x4E);
+	vga_wseq(par->state.vgabase, 0x17, 0x1F);       // FIFO depth
+	vga_wseq(par->state.vgabase, 0x18, 0x4E);
 	svga_wseq_mask(par->state.vgabase, 0x1A, 0x08, 0x08); // enable MMIO ?
 
-	vga_wcrt(NULL, 0x32, 0x00);
-	vga_wcrt(NULL, 0x34, 0x00);
-	vga_wcrt(NULL, 0x6A, 0x80);
-	vga_wcrt(NULL, 0x6A, 0xC0);
+	vga_wcrt(par->state.vgabase, 0x32, 0x00);
+	vga_wcrt(par->state.vgabase, 0x34, 0x00);
+	vga_wcrt(par->state.vgabase, 0x6A, 0x80);
+	vga_wcrt(par->state.vgabase, 0x6A, 0xC0);
 
-	vga_wgfx(NULL, 0x20, 0x00);
-	vga_wgfx(NULL, 0x21, 0x00);
-	vga_wgfx(NULL, 0x22, 0x00);
+	vga_wgfx(par->state.vgabase, 0x20, 0x00);
+	vga_wgfx(par->state.vgabase, 0x21, 0x00);
+	vga_wgfx(par->state.vgabase, 0x22, 0x00);
 
 	/* Set SR15 according to number of bits per pixel */
 	mode = svga_match_format(vt8623fb_formats, &(info->var), &(info->fix));
@@ -478,7 +478,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 		break;
 	case 1:
 		pr_debug("fb%d: 4 bit pseudocolor\n", info->node);
-		vga_wgfx(NULL, VGA_GFX_MODE, 0x40);
+		vga_wgfx(par->state.vgabase, VGA_GFX_MODE, 0x40);
 		svga_wseq_mask(par->state.vgabase, 0x15, 0x20, 0xFE);
 		svga_wcrt_mask(par->state.vgabase, 0x11, 0x00, 0x70);
 		break;
@@ -717,8 +717,8 @@ static int __devinit vt8623_pci_probe(struct pci_dev *dev, const struct pci_devi
 	}
 
 	/* Find how many physical memory there is on card */
-	memsize1 = (vga_rseq(NULL, 0x34) + 1) >> 1;
-	memsize2 = vga_rseq(NULL, 0x39) << 2;
+	memsize1 = (vga_rseq(par->state.vgabase, 0x34) + 1) >> 1;
+	memsize2 = vga_rseq(par->state.vgabase, 0x39) << 2;
 
 	if ((16 <= memsize1) && (memsize1 <= 64) && (memsize1 = memsize2))
 		info->screen_size = memsize1 << 20;
-- 
1.7.3.4

