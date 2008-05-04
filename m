From: Robert Reif <reif@earthlink.net>
Date: Sun, 04 May 2008 01:18:45 +0000
Subject: [PATCH] sparc video: make blank use proper constant
Message-Id: <481D0EF5.7040400@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070303080607080005010901"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303080607080005010901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make blank functions use proper constant for unblanking.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------070303080607080005010901
Content-Type: text/plain;
 name="blank.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blank.diff.txt"

diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 275d9da..79f85dc 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -329,7 +329,7 @@ static int __devinit bw2_probe(struct of_device *op, const struct of_device_id *
 	if (!info->screen_base)
 		goto out_unmap_regs;
 
-	bw2_blank(0, info);
+	bw2_blank(FB_BLANK_UNBLANK, info);
 
 	bw2_init_fix(info, linebytes);
 
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index 010ea53..e31e26a 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -398,7 +398,7 @@ static int __devinit cg3_probe(struct of_device *op,
 	if (!info->screen_base)
 		goto out_unmap_regs;
 
-	cg3_blank(0, info);
+	cg3_blank(FB_BLANK_UNBLANK, info);
 
 	if (!of_find_property(dp, "width", NULL)) {
 		err = cg3_do_default_mode(par);
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index fc90db6..8000bcc 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -767,7 +767,7 @@ static int __devinit cg6_probe(struct of_device *op,
 
 	cg6_bt_init(par);
 	cg6_chip_init(info);
-	cg6_blank(0, info);
+	cg6_blank(FB_BLANK_UNBLANK, info);
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0))
 		goto out_unmap_regs;
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 93dca3e..0f42a69 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -987,7 +987,7 @@ static int __devinit ffb_probe(struct of_device *op,
 	 * chosen console, it will have video outputs off in
 	 * the DAC.
 	 */
-	ffb_blank(0, info);
+	ffb_blank(FB_BLANK_UNBLANK, info);
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0))
 		goto out_unmap_dac;
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index f3160fc..fb12992 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -601,7 +601,7 @@ static int __devinit leo_probe(struct of_device *op, const struct of_device_id *
 	leo_init_wids(info);
 	leo_init_hw(info);
 
-	leo_blank(0, info);
+	leo_blank(FB_BLANK_UNBLANK, info);
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0))
 		goto out_unmap_regs;
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index c95874f..676ffb0 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -295,7 +295,7 @@ static int __devinit p9100_probe(struct of_device *op, const struct of_device_id
 	if (!info->screen_base)
 		goto out_unmap_regs;
 
-	p9100_blank(0, info);
+	p9100_blank(FB_BLANK_UNBLANK, info);
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0))
 		goto out_unmap_screen;

--------------070303080607080005010901--
