From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:49:49 +0000
Subject: [PATCH 4/22] svga: Make svga_wseq_multi take an iomem regbase
Message-Id: <20110111.154949.139112133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/svgalib.c  |    8 ++++----
 drivers/video/vt8623fb.c |    2 +-
 include/linux/svga.h     |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index bf3c7a9..ed190aa 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -40,12 +40,12 @@ void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32
 }
 
 /* Write a sequencer register value spread across multiple registers */
-void svga_wseq_multi(const struct vga_regset *regset, u32 value) {
-
+void svga_wseq_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value)
+{
 	u8 regval, bitval, bitnum;
 
 	while (regset->regnum != VGA_REGSET_END_VAL) {
-		regval = vga_rseq(NULL, regset->regnum);
+		regval = vga_rseq(regbase, regset->regnum);
 		bitnum = regset->lowbit;
 		while (bitnum <= regset->highbit) {
 			bitval = 1 << bitnum;
@@ -54,7 +54,7 @@ void svga_wseq_multi(const struct vga_regset *regset, u32 value) {
 			bitnum ++;
 			value = value >> 1;
 		}
-		vga_wseq(NULL, regset->regnum, regval);
+		vga_wseq(regbase, regset->regnum, regval);
 		regset ++;
 	}
 }
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 9d4f7d4..5301151 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -433,7 +433,7 @@ static int vt8623fb_set_par(struct fb_info *info)
 	svga_wcrt_multi(par->state.vgabase, vt8623_start_address_regs, 0);
 
 	svga_wcrt_multi(par->state.vgabase, vt8623_offset_regs, offset_value);
-	svga_wseq_multi(vt8623_fetch_count_regs, fetch_value);
+	svga_wseq_multi(par->state.vgabase, vt8623_fetch_count_regs, fetch_value);
 
 	/* Clear H/V Skew */
 	svga_wcrt_mask(0x03, 0x00, 0x60);
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 8ca81e0..357e2bd 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -97,7 +97,7 @@ static inline int svga_primary_device(struct pci_dev *dev)
 
 
 void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value);
-void svga_wseq_multi(const struct vga_regset *regset, u32 value);
+void svga_wseq_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value);
 
 void svga_set_default_gfx_regs(void);
 void svga_set_default_atc_regs(void);
-- 
1.7.3.4

