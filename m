From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:50:54 +0000
Subject: [PATCH 7/22] svga: Make svga_set_default_seq_regs take an iomem
Message-Id: <20110111.155054.37573575.davem@davemloft.net>
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
index 2dfecbf..41a065d 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -655,7 +655,7 @@ static int arkfb_set_par(struct fb_info *info)
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs(par->state.vgabase);
-	svga_set_default_seq_regs();
+	svga_set_default_seq_regs(par->state.vgabase);
 	svga_set_default_crt_regs();
 	svga_wcrt_multi(par->state.vgabase, ark_line_compare_regs, 0xFFFFFFFF);
 	svga_wcrt_multi(par->state.vgabase, ark_start_address_regs, 0);
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index a187376..a4301b6 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -516,7 +516,7 @@ static int s3fb_set_par(struct fb_info *info)
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs(par->state.vgabase);
-	svga_set_default_seq_regs();
+	svga_set_default_seq_regs(par->state.vgabase);
 	svga_set_default_crt_regs();
 	svga_wcrt_multi(par->state.vgabase, s3_line_compare_regs, 0xFFFFFFFF);
 	svga_wcrt_multi(par->state.vgabase, s3_start_address_regs, 0);
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 8b97359..6d3d39f 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -116,14 +116,14 @@ void svga_set_default_atc_regs(void __iomem *regbase)
 }
 
 /* Set sequencer registers to sane values */
-void svga_set_default_seq_regs(void)
+void svga_set_default_seq_regs(void __iomem *regbase)
 {
 	/* Standard sequencer registers (SR01 - SR04), SR00 is not set */
-	vga_wseq(NULL, VGA_SEQ_CLOCK_MODE, VGA_SR01_CHAR_CLK_8DOTS);
-	vga_wseq(NULL, VGA_SEQ_PLANE_WRITE, VGA_SR02_ALL_PLANES);
-	vga_wseq(NULL, VGA_SEQ_CHARACTER_MAP, 0x00);
-/*	vga_wseq(NULL, VGA_SEQ_MEMORY_MODE, VGA_SR04_EXT_MEM | VGA_SR04_SEQ_MODE | VGA_SR04_CHN_4M); */
-	vga_wseq(NULL, VGA_SEQ_MEMORY_MODE, VGA_SR04_EXT_MEM | VGA_SR04_SEQ_MODE);
+	vga_wseq(regbase, VGA_SEQ_CLOCK_MODE, VGA_SR01_CHAR_CLK_8DOTS);
+	vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, VGA_SR02_ALL_PLANES);
+	vga_wseq(regbase, VGA_SEQ_CHARACTER_MAP, 0x00);
+/*	vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, VGA_SR04_EXT_MEM | VGA_SR04_SEQ_MODE | VGA_SR04_CHN_4M); */
+	vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, VGA_SR04_EXT_MEM | VGA_SR04_SEQ_MODE);
 }
 
 /* Set CRTC registers to sane values */
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 24f5b43..f19dbed 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -427,7 +427,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 	/* Set default values */
 	svga_set_default_gfx_regs(par->state.vgabase);
 	svga_set_default_atc_regs(par->state.vgabase);
-	svga_set_default_seq_regs();
+	svga_set_default_seq_regs(par->state.vgabase);
 	svga_set_default_crt_regs();
 	svga_wcrt_multi(par->state.vgabase, vt8623_line_compare_regs, 0xFFFFFFFF);
 	svga_wcrt_multi(par->state.vgabase, vt8623_start_address_regs, 0);
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 87a4164..d31a398 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -101,7 +101,7 @@ void svga_wseq_multi(void __iomem *regbase, const struct vga_regset *regset, u32
 
 void svga_set_default_gfx_regs(void __iomem *regbase);
 void svga_set_default_atc_regs(void __iomem *regbase);
-void svga_set_default_seq_regs(void);
+void svga_set_default_seq_regs(void __iomem *regbase);
 void svga_set_default_crt_regs(void);
 void svga_set_textmode_vga_regs(void);
 
-- 
1.7.3.4

