From: Robert Reif <reif@earthlink.net>
Date: Fri, 09 Mar 2007 05:10:34 +0000
Subject: [PATCH]: fix section mismatch warnings in bw2.c
Message-Id: <1173417034.7278.10.camel@dell>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix section mismatch warnings by moving data into __devinitdata section.
Add __devinit to two initialization functions.

Signed-off-by: Robert Reif <reif@earthlink.net>

diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 9bb6257..b0b2e40 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -186,8 +186,7 @@ static int bw2_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
  *  Initialisation
  */
 
-static void
-bw2_init_fix(struct fb_info *info, int linebytes)
+static void __devinit bw2_init_fix(struct fb_info *info, int linebytes)
 {
 	strlcpy(info->fix.id, "bwtwo", sizeof(info->fix.id));
 
@@ -199,43 +198,44 @@ bw2_init_fix(struct fb_info *info, int linebytes)
 	info->fix.accel = FB_ACCEL_SUN_BWTWO;
 }
 
-static u8 bw2regs_1600[] __initdata = {
+static u8 bw2regs_1600[] __devinitdata = {
 	0x14, 0x8b,	0x15, 0x28,	0x16, 0x03,	0x17, 0x13,
 	0x18, 0x7b,	0x19, 0x05,	0x1a, 0x34,	0x1b, 0x2e,
 	0x1c, 0x00,	0x1d, 0x0a,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x21,	0
 };
 
-static u8 bw2regs_ecl[] __initdata = {
+static u8 bw2regs_ecl[] __devinitdata = {
 	0x14, 0x65,	0x15, 0x1e,	0x16, 0x04,	0x17, 0x0c,
 	0x18, 0x5e,	0x19, 0x03,	0x1a, 0xa7,	0x1b, 0x23,
 	0x1c, 0x00,	0x1d, 0x08,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x20,	0
 };
 
-static u8 bw2regs_analog[] __initdata = {
+static u8 bw2regs_analog[] __devinitdata = {
 	0x14, 0xbb,	0x15, 0x2b,	0x16, 0x03,	0x17, 0x13,
 	0x18, 0xb0,	0x19, 0x03,	0x1a, 0xa6,	0x1b, 0x22,
 	0x1c, 0x01,	0x1d, 0x05,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x20,	0
 };
 
-static u8 bw2regs_76hz[] __initdata = {
+static u8 bw2regs_76hz[] __devinitdata = {
 	0x14, 0xb7,	0x15, 0x27,	0x16, 0x03,	0x17, 0x0f,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xae,	0x1b, 0x2a,
 	0x1c, 0x01,	0x1d, 0x09,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x24,	0
 };
 
-static u8 bw2regs_66hz[] __initdata = {
+static u8 bw2regs_66hz[] __devinitdata = {
 	0x14, 0xbb,	0x15, 0x2b,	0x16, 0x04,	0x17, 0x14,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xa8,	0x1b, 0x24,
 	0x1c, 0x01,	0x1d, 0x05,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x20,	0
 };
 
-static void bw2_do_default_mode(struct bw2_par *par, struct fb_info *info,
-				int *linebytes)
+static void __devinit bw2_do_default_mode(struct bw2_par *par,
+					  struct fb_info *info,
+					  int *linebytes)
 {
 	u8 status, mon;
 	u8 *p;



