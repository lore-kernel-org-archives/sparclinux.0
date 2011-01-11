From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:52:11 +0000
Subject: [PATCH 12/22] svga: Make svga_tilecursor() take an iomem regbase
Message-Id: <20110111.155211.255391137.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c    |    9 ++++++++-
 drivers/video/s3fb.c     |   11 +++++++++--
 drivers/video/svgalib.c  |   12 ++++++------
 drivers/video/vt8623fb.c |    8 +++++++-
 include/linux/svga.h     |    2 +-
 5 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index d282aa1..7c21bb7 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -158,12 +158,19 @@ static void arkfb_settile(struct fb_info *info, struct fb_tilemap *map)
 	}
 }
 
+static void arkfb_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
+{
+	struct arkfb_info *par = info->par;
+
+	svga_tilecursor(par->state.vgabase, info, cursor);
+}
+
 static struct fb_tile_ops arkfb_tile_ops = {
 	.fb_settile	= arkfb_settile,
 	.fb_tilecopy	= svga_tilecopy,
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
-	.fb_tilecursor  = svga_tilecursor,
+	.fb_tilecursor  = arkfb_tilecursor,
 	.fb_get_tilemax = svga_get_tilemax,
 };
 
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index eef988d..0ec0f39 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -188,12 +188,19 @@ static void s3fb_settile_fast(struct fb_info *info, struct fb_tilemap *map)
 	}
 }
 
+static void s3fb_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
+{
+	struct s3fb_info *par = info->par;
+
+	svga_tilecursor(par->state.vgabase, info, cursor);
+}
+
 static struct fb_tile_ops s3fb_tile_ops = {
 	.fb_settile	= svga_settile,
 	.fb_tilecopy	= svga_tilecopy,
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
-	.fb_tilecursor  = svga_tilecursor,
+	.fb_tilecursor  = s3fb_tilecursor,
 	.fb_get_tilemax = svga_get_tilemax,
 };
 
@@ -202,7 +209,7 @@ static struct fb_tile_ops s3fb_fast_tile_ops = {
 	.fb_tilecopy	= svga_tilecopy,
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
-	.fb_tilecursor  = svga_tilecursor,
+	.fb_tilecursor  = s3fb_tilecursor,
 	.fb_get_tilemax = svga_get_tilemax,
 };
 
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index ecda90e..4876be8 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -299,7 +299,7 @@ void svga_tileblit(struct fb_info *info, struct fb_tileblit *blit)
 }
 
 /* Set cursor in text (tileblit) mode */
-void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
+void svga_tilecursor(void __iomem *regbase, struct fb_info *info, struct fb_tilecursor *cursor)
 {
 	u8 cs = 0x0d;
 	u8 ce = 0x0e;
@@ -310,7 +310,7 @@ void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
 	if (! cursor -> mode)
 		return;
 
-	svga_wcrt_mask(NULL, 0x0A, 0x20, 0x20); /* disable cursor */
+	svga_wcrt_mask(regbase, 0x0A, 0x20, 0x20); /* disable cursor */
 
 	if (cursor -> shape = FB_TILE_CURSOR_NONE)
 		return;
@@ -334,11 +334,11 @@ void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
 	}
 
 	/* set cursor position */
-	vga_wcrt(NULL, 0x0E, pos >> 8);
-	vga_wcrt(NULL, 0x0F, pos & 0xFF);
+	vga_wcrt(regbase, 0x0E, pos >> 8);
+	vga_wcrt(regbase, 0x0F, pos & 0xFF);
 
-	vga_wcrt(NULL, 0x0B, ce); /* set cursor end */
-	vga_wcrt(NULL, 0x0A, cs); /* set cursor start and enable it */
+	vga_wcrt(regbase, 0x0B, ce); /* set cursor end */
+	vga_wcrt(regbase, 0x0A, cs); /* set cursor start and enable it */
 }
 
 int svga_get_tilemax(struct fb_info *info)
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 47f0199..7e6afe1 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -121,13 +121,19 @@ MODULE_PARM_DESC(mtrr, "Enable write-combining with MTRR (1=enable, 0=disable, d
 
 /* ------------------------------------------------------------------------- */
 
+static void vt8623fb_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
+{
+	struct vt8623fb_info *par = info->par;
+
+	svga_tilecursor(par->state.vgabase, info, cursor);
+}
 
 static struct fb_tile_ops vt8623fb_tile_ops = {
 	.fb_settile	= svga_settile,
 	.fb_tilecopy	= svga_tilecopy,
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
-	.fb_tilecursor  = svga_tilecursor,
+	.fb_tilecursor  = vt8623fb_tilecursor,
 	.fb_get_tilemax = svga_get_tilemax,
 };
 
diff --git a/include/linux/svga.h b/include/linux/svga.h
index 767937d..8787950 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -109,7 +109,7 @@ void svga_settile(struct fb_info *info, struct fb_tilemap *map);
 void svga_tilecopy(struct fb_info *info, struct fb_tilearea *area);
 void svga_tilefill(struct fb_info *info, struct fb_tilerect *rect);
 void svga_tileblit(struct fb_info *info, struct fb_tileblit *blit);
-void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor);
+void svga_tilecursor(void __iomem *regbase, struct fb_info *info, struct fb_tilecursor *cursor);
 int svga_get_tilemax(struct fb_info *info);
 void svga_get_caps(struct fb_info *info, struct fb_blit_caps *caps,
 		   struct fb_var_screeninfo *var);
-- 
1.7.3.4

