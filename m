From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:50:04 +0000
Subject: [PATCH 5/22] svga: Make svga_set_default_gfx_regs take an iomem
Message-Id: <20110111.155004.141237935.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |    2 +-
 drivers/video/s3fb.c     |    2 +-
 drivers/video/svgalib.c  |   26 +++++++++++++-------------
 drivers/video/vt8623fb.c |    2 +-
 include/linux/svga.h     |    2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 311a512..7939d5e 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -653,7 +653,7 @@ static int arkfb_set_par(struct fb_info *info)
 	svga_wcrt_mask(0x17, 0x00, 0x80);
 
 	/* Set default values */
-	svga_set_default_gfx_regs();
+	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs();
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 26698e6..773650c 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -514,7 +514,7 @@ static int s3fb_set_par(struct fb_info *info)
 	svga_wcrt_mask(0x17, 0x00, 0x80);
 
 	/* Set default values */
-	svga_set_default_gfx_regs();
+	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs();
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index ed190aa..25f9f87 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -75,21 +75,21 @@ static unsigned int svga_regset_size(const struct vga_regset *regset)
 
 
 /* Set graphics controller registers to sane values */
-void svga_set_default_gfx_regs(void)
+void svga_set_default_gfx_regs(void __iomem *regbase)
 {
 	/* All standard GFX registers (GR00 - GR08) */
-	vga_wgfx(NULL, VGA_GFX_SR_VALUE, 0x00);
-	vga_wgfx(NULL, VGA_GFX_SR_ENABLE, 0x00);
-	vga_wgfx(NULL, VGA_GFX_COMPARE_VALUE, 0x00);
-	vga_wgfx(NULL, VGA_GFX_DATA_ROTATE, 0x00);
-	vga_wgfx(NULL, VGA_GFX_PLANE_READ, 0x00);
-	vga_wgfx(NULL, VGA_GFX_MODE, 0x00);
-/*	vga_wgfx(NULL, VGA_GFX_MODE, 0x20); */
-/*	vga_wgfx(NULL, VGA_GFX_MODE, 0x40); */
-	vga_wgfx(NULL, VGA_GFX_MISC, 0x05);
-/*	vga_wgfx(NULL, VGA_GFX_MISC, 0x01); */
-	vga_wgfx(NULL, VGA_GFX_COMPARE_MASK, 0x0F);
-	vga_wgfx(NULL, VGA_GFX_BIT_MASK, 0xFF);
+	vga_wgfx(regbase, VGA_GFX_SR_VALUE, 0x00);
+	vga_wgfx(regbase, VGA_GFX_SR_ENABLE, 0x00);
+	vga_wgfx(regbase, VGA_GFX_COMPARE_VALUE, 0x00);
+	vga_wgfx(regbase, VGA_GFX_DATA_ROTATE, 0x00);
+	vga_wgfx(regbase, VGA_GFX_PLANE_READ, 0x00);
+	vga_wgfx(regbase, VGA_GFX_MODE, 0x00);
+/*	vga_wgfx(regbase, VGA_GFX_MODE, 0x20); */
+/*	vga_wgfx(regbase, VGA_GFX_MODE, 0x40); */
+	vga_wgfx(regbase, VGA_GFX_MISC, 0x05);
+/*	vga_wgfx(regbase, VGA_GFX_MISC, 0x01); */
+	vga_wgfx(regbase, VGA_GFX_COMPARE_MASK, 0x0F);
+	vga_wgfx(regbase, VGA_GFX_BIT_MASK, 0xFF);
 }
 
 /* Set attribute controller registers to sane values */
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 5301151..77382e9 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -425,7 +425,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 	svga_wcrt_mask(0x17, 0x00, 0x80);
 
 	/* Set default values */
-	svga_set_default_gfx_regs();
+	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs();
 	svga_set_default_seq_regs();
 	svga_set_default_crt_regs();
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 357e2bd..4591032 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -99,7 +99,7 @@ static inline int svga_primary_device(struct pci_dev *dev)
 void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value);
 void svga_wseq_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value);
 
-void svga_set_default_gfx_regs(void);
+void svga_set_default_gfx_regs(void __iomem *regbase);
 void svga_set_default_atc_regs(void);
 void svga_set_default_seq_regs(void);
 void svga_set_default_crt_regs(void);
-- 
1.7.3.4

