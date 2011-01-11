From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:52:57 +0000
Subject: [PATCH 15/22] s3fb: Pass par->state.vgabase to vga_*() calls.
Message-Id: <20110111.155257.256857138.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Instead of just plain NULL.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/s3fb.c |  102 +++++++++++++++++++++++++------------------------
 1 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index a53d974..2d436ec 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -348,26 +348,26 @@ static void s3_set_pixclock(struct fb_info *info, u32 pixclock)
 	}
 
 	/* Set VGA misc register  */
-	regval = vga_r(NULL, VGA_MIS_R);
-	vga_w(NULL, VGA_MIS_W, regval | VGA_MIS_ENB_PLL_LOAD);
+	regval = vga_r(par->state.vgabase, VGA_MIS_R);
+	vga_w(par->state.vgabase, VGA_MIS_W, regval | VGA_MIS_ENB_PLL_LOAD);
 
 	/* Set S3 clock registers */
 	if (par->chip = CHIP_360_TRIO3D_1X ||
 	    par->chip = CHIP_362_TRIO3D_2X ||
 	    par->chip = CHIP_368_TRIO3D_2X) {
-		vga_wseq(NULL, 0x12, (n - 2) | ((r & 3) << 6));	/* n and two bits of r */
-		vga_wseq(NULL, 0x29, r >> 2); /* remaining highest bit of r */
+		vga_wseq(par->state.vgabase, 0x12, (n - 2) | ((r & 3) << 6));	/* n and two bits of r */
+		vga_wseq(par->state.vgabase, 0x29, r >> 2); /* remaining highest bit of r */
 	} else
-		vga_wseq(NULL, 0x12, (n - 2) | (r << 5));
-	vga_wseq(NULL, 0x13, m - 2);
+		vga_wseq(par->state.vgabase, 0x12, (n - 2) | (r << 5));
+	vga_wseq(par->state.vgabase, 0x13, m - 2);
 
 	udelay(1000);
 
 	/* Activate clock - write 0, 1, 0 to seq/15 bit 5 */
-	regval = vga_rseq (NULL, 0x15); /* | 0x80; */
-	vga_wseq(NULL, 0x15, regval & ~(1<<5));
-	vga_wseq(NULL, 0x15, regval |  (1<<5));
-	vga_wseq(NULL, 0x15, regval & ~(1<<5));
+	regval = vga_rseq (par->state.vgabase, 0x15); /* | 0x80; */
+	vga_wseq(par->state.vgabase, 0x15, regval & ~(1<<5));
+	vga_wseq(par->state.vgabase, 0x15, regval |  (1<<5));
+	vga_wseq(par->state.vgabase, 0x15, regval & ~(1<<5));
 }
 
 
@@ -511,9 +511,9 @@ static int s3fb_set_par(struct fb_info *info)
 	info->var.activate = FB_ACTIVATE_NOW;
 
 	/* Unlock registers */
-	vga_wcrt(NULL, 0x38, 0x48);
-	vga_wcrt(NULL, 0x39, 0xA5);
-	vga_wseq(NULL, 0x08, 0x06);
+	vga_wcrt(par->state.vgabase, 0x38, 0x48);
+	vga_wcrt(par->state.vgabase, 0x39, 0xA5);
+	vga_wseq(par->state.vgabase, 0x08, 0x06);
 	svga_wcrt_mask(par->state.vgabase, 0x11, 0x00, 0x80);
 
 	/* Blank screen and turn off sync */
@@ -552,13 +552,13 @@ static int s3fb_set_par(struct fb_info *info)
 	if (par->chip != CHIP_360_TRIO3D_1X &&
 	    par->chip != CHIP_362_TRIO3D_2X &&
 	    par->chip != CHIP_368_TRIO3D_2X) {
-		vga_wcrt(NULL, 0x54, 0x18); /* M parameter */
-		vga_wcrt(NULL, 0x60, 0xff); /* N parameter */
-		vga_wcrt(NULL, 0x61, 0xff); /* L parameter */
-		vga_wcrt(NULL, 0x62, 0xff); /* L parameter */
+		vga_wcrt(par->state.vgabase, 0x54, 0x18); /* M parameter */
+		vga_wcrt(par->state.vgabase, 0x60, 0xff); /* N parameter */
+		vga_wcrt(par->state.vgabase, 0x61, 0xff); /* L parameter */
+		vga_wcrt(par->state.vgabase, 0x62, 0xff); /* L parameter */
 	}
 
-	vga_wcrt(NULL, 0x3A, 0x35);
+	vga_wcrt(par->state.vgabase, 0x3A, 0x35);
 	svga_wattr(par->state.vgabase, 0x33, 0x00);
 
 	if (info->var.vmode & FB_VMODE_DOUBLE)
@@ -580,27 +580,27 @@ static int s3fb_set_par(struct fb_info *info)
 
 	/* S3 virge DX hack */
 	if (par->chip = CHIP_375_VIRGE_DX) {
-		vga_wcrt(NULL, 0x86, 0x80);
-		vga_wcrt(NULL, 0x90, 0x00);
+		vga_wcrt(par->state.vgabase, 0x86, 0x80);
+		vga_wcrt(par->state.vgabase, 0x90, 0x00);
 	}
 
 	/* S3 virge VX hack */
 	if (par->chip = CHIP_988_VIRGE_VX) {
-		vga_wcrt(NULL, 0x50, 0x00);
-		vga_wcrt(NULL, 0x67, 0x50);
+		vga_wcrt(par->state.vgabase, 0x50, 0x00);
+		vga_wcrt(par->state.vgabase, 0x67, 0x50);
 
-		vga_wcrt(NULL, 0x63, (mode <= 2) ? 0x90 : 0x09);
-		vga_wcrt(NULL, 0x66, 0x90);
+		vga_wcrt(par->state.vgabase, 0x63, (mode <= 2) ? 0x90 : 0x09);
+		vga_wcrt(par->state.vgabase, 0x66, 0x90);
 	}
 
 	if (par->chip = CHIP_360_TRIO3D_1X ||
 	    par->chip = CHIP_362_TRIO3D_2X ||
 	    par->chip = CHIP_368_TRIO3D_2X) {
 		dbytes = info->var.xres * ((bpp+7)/8);
-		vga_wcrt(NULL, 0x91, (dbytes + 7) / 8);
-		vga_wcrt(NULL, 0x90, (((dbytes + 7) / 8) >> 8) | 0x80);
+		vga_wcrt(par->state.vgabase, 0x91, (dbytes + 7) / 8);
+		vga_wcrt(par->state.vgabase, 0x90, (((dbytes + 7) / 8) >> 8) | 0x80);
 
-		vga_wcrt(NULL, 0x66, 0x81);
+		vga_wcrt(par->state.vgabase, 0x66, 0x81);
 	}
 
 	svga_wcrt_mask(par->state.vgabase, 0x31, 0x00, 0x40);
@@ -627,7 +627,7 @@ static int s3fb_set_par(struct fb_info *info)
 		break;
 	case 1:
 		pr_debug("fb%d: 4 bit pseudocolor\n", info->node);
-		vga_wgfx(NULL, VGA_GFX_MODE, 0x40);
+		vga_wgfx(par->state.vgabase, VGA_GFX_MODE, 0x40);
 
 		/* Set additional registers like in 8-bit mode */
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
@@ -720,7 +720,7 @@ static int s3fb_set_par(struct fb_info *info)
 	/* Set interlaced mode start/end register */
 	value = info->var.xres + info->var.left_margin + info->var.right_margin + info->var.hsync_len;
 	value = ((value * hmul) / 8) - 5;
-	vga_wcrt(NULL, 0x3C, (value + 1) / 2);
+	vga_wcrt(par->state.vgabase, 0x3C, (value + 1) / 2);
 
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
@@ -873,12 +873,14 @@ static struct fb_ops s3fb_ops = {
 
 /* ------------------------------------------------------------------------- */
 
-static int __devinit s3_identification(int chip)
+static int __devinit s3_identification(struct s3fb_info *par)
 {
+	int chip = par->chip;
+
 	if (chip = CHIP_XXX_TRIO) {
-		u8 cr30 = vga_rcrt(NULL, 0x30);
-		u8 cr2e = vga_rcrt(NULL, 0x2e);
-		u8 cr2f = vga_rcrt(NULL, 0x2f);
+		u8 cr30 = vga_rcrt(par->state.vgabase, 0x30);
+		u8 cr2e = vga_rcrt(par->state.vgabase, 0x2e);
+		u8 cr2f = vga_rcrt(par->state.vgabase, 0x2f);
 
 		if ((cr30 = 0xE0) || (cr30 = 0xE1)) {
 			if (cr2e = 0x10)
@@ -893,7 +895,7 @@ static int __devinit s3_identification(int chip)
 	}
 
 	if (chip = CHIP_XXX_TRIO64V2_DXGX) {
-		u8 cr6f = vga_rcrt(NULL, 0x6f);
+		u8 cr6f = vga_rcrt(par->state.vgabase, 0x6f);
 
 		if (! (cr6f & 0x01))
 			return CHIP_775_TRIO64V2_DX;
@@ -902,7 +904,7 @@ static int __devinit s3_identification(int chip)
 	}
 
 	if (chip = CHIP_XXX_VIRGE_DXGX) {
-		u8 cr6f = vga_rcrt(NULL, 0x6f);
+		u8 cr6f = vga_rcrt(par->state.vgabase, 0x6f);
 
 		if (! (cr6f & 0x01))
 			return CHIP_375_VIRGE_DX;
@@ -911,7 +913,7 @@ static int __devinit s3_identification(int chip)
 	}
 
 	if (chip = CHIP_36X_TRIO3D_1X_2X) {
-		switch (vga_rcrt(NULL, 0x2f)) {
+		switch (vga_rcrt(par->state.vgabase, 0x2f)) {
 		case 0x00:
 			return CHIP_360_TRIO3D_1X;
 		case 0x01:
@@ -979,21 +981,21 @@ static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_i
 	}
 
 	/* Unlock regs */
-	cr38 = vga_rcrt(NULL, 0x38);
-	cr39 = vga_rcrt(NULL, 0x39);
-	vga_wseq(NULL, 0x08, 0x06);
-	vga_wcrt(NULL, 0x38, 0x48);
-	vga_wcrt(NULL, 0x39, 0xA5);
+	cr38 = vga_rcrt(par->state.vgabase, 0x38);
+	cr39 = vga_rcrt(par->state.vgabase, 0x39);
+	vga_wseq(par->state.vgabase, 0x08, 0x06);
+	vga_wcrt(par->state.vgabase, 0x38, 0x48);
+	vga_wcrt(par->state.vgabase, 0x39, 0xA5);
 
 	/* Identify chip type */
 	par->chip = id->driver_data & CHIP_MASK;
-	par->rev = vga_rcrt(NULL, 0x2f);
+	par->rev = vga_rcrt(par->state.vgabase, 0x2f);
 	if (par->chip & CHIP_UNDECIDED_FLAG)
-		par->chip = s3_identification(par->chip);
+		par->chip = s3_identification(par);
 
 	/* Find how many physical memory there is on card */
 	/* 0x36 register is accessible even if other registers are locked */
-	regval = vga_rcrt(NULL, 0x36);
+	regval = vga_rcrt(par->state.vgabase, 0x36);
 	if (par->chip = CHIP_360_TRIO3D_1X ||
 	    par->chip = CHIP_362_TRIO3D_2X ||
 	    par->chip = CHIP_368_TRIO3D_2X) {
@@ -1012,13 +1014,13 @@ static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_i
 	info->fix.smem_len = info->screen_size;
 
 	/* Find MCLK frequency */
-	regval = vga_rseq(NULL, 0x10);
-	par->mclk_freq = ((vga_rseq(NULL, 0x11) + 2) * 14318) / ((regval & 0x1F)  + 2);
+	regval = vga_rseq(par->state.vgabase, 0x10);
+	par->mclk_freq = ((vga_rseq(par->state.vgabase, 0x11) + 2) * 14318) / ((regval & 0x1F)  + 2);
 	par->mclk_freq = par->mclk_freq >> (regval >> 5);
 
 	/* Restore locks */
-	vga_wcrt(NULL, 0x38, cr38);
-	vga_wcrt(NULL, 0x39, cr39);
+	vga_wcrt(par->state.vgabase, 0x38, cr38);
+	vga_wcrt(par->state.vgabase, 0x39, cr39);
 
 	strcpy(info->fix.id, s3_names [par->chip]);
 	info->fix.mmio_start = 0;
@@ -1054,8 +1056,8 @@ static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_i
 
 	if (par->chip = CHIP_UNKNOWN)
 		printk(KERN_INFO "fb%d: unknown chip, CR2D=%x, CR2E=%x, CRT2F=%x, CRT30=%x\n",
-			info->node, vga_rcrt(NULL, 0x2d), vga_rcrt(NULL, 0x2e),
-			vga_rcrt(NULL, 0x2f), vga_rcrt(NULL, 0x30));
+			info->node, vga_rcrt(par->state.vgabase, 0x2d), vga_rcrt(par->state.vgabase, 0x2e),
+			vga_rcrt(par->state.vgabase, 0x2f), vga_rcrt(par->state.vgabase, 0x30));
 
 	/* Record a reference to the driver data */
 	pci_set_drvdata(dev, info);
-- 
1.7.3.4

