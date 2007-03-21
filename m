From: Robert Reif <reif@earthlink.net>
Date: Wed, 21 Mar 2007 11:22:48 +0000
Subject: [PATCH] fix section mismatch in cg3.c
Message-Id: <1174476168.22880.7.camel@dell>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix section mismatch warning by moving data into __devinitdata section.
Add __devinit to initialization functions.

diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index ada6f7e..767c850 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -186,8 +186,7 @@ static int cg3_setcolreg(unsigned regno,
  *      @blank_mode: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame
buffer
  */
-static int
-cg3_blank(int blank, struct fb_info *info)
+static int cg3_blank(int blank, struct fb_info *info)
 {
 	struct cg3_par *par = (struct cg3_par *) info->par;
 	struct cg3_regs __iomem *regs = par->regs;
@@ -251,8 +250,8 @@ static int cg3_ioctl(struct fb_info *info, unsigned
int cmd, unsigned long arg)
  *  Initialisation
  */
 
-static void
-cg3_init_fix(struct fb_info *info, int linebytes, struct device_node
*dp)
+static void __devinit cg3_init_fix(struct fb_info *info, int linebytes,
+				   struct device_node *dp)
 {
 	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
 
@@ -264,8 +263,8 @@ cg3_init_fix(struct fb_info *info, int linebytes,
struct device_node *dp)
 	info->fix.accel = FB_ACCEL_SUN_CGTHREE;
 }
 
-static void cg3_rdi_maybe_fixup_var(struct fb_var_screeninfo *var,
-				    struct device_node *dp)
+static void __devinit cg3_rdi_maybe_fixup_var(struct fb_var_screeninfo
*var,
+					      struct device_node *dp)
 {
 	char *params;
 	char *p;
@@ -287,36 +286,36 @@ static void cg3_rdi_maybe_fixup_var(struct
fb_var_screeninfo *var,
 	}
 }
 
-static u8 cg3regvals_66hz[] __initdata = {	/* 1152 x 900, 66 Hz */
+static u8 cg3regvals_66hz[] __devinitdata = {	/* 1152 x 900, 66 Hz */
 	0x14, 0xbb,	0x15, 0x2b,	0x16, 0x04,	0x17, 0x14,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xa8,	0x1b, 0x24,
 	0x1c, 0x01,	0x1d, 0x05,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x20,	0
 };
 
-static u8 cg3regvals_76hz[] __initdata = {	/* 1152 x 900, 76 Hz */
+static u8 cg3regvals_76hz[] __devinitdata = {	/* 1152 x 900, 76 Hz */
 	0x14, 0xb7,	0x15, 0x27,	0x16, 0x03,	0x17, 0x0f,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xae,	0x1b, 0x2a,
 	0x1c, 0x01,	0x1d, 0x09,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x24,	0
 };
 
-static u8 cg3regvals_rdi[] __initdata = {	/* 640 x 480, cgRDI */
+static u8 cg3regvals_rdi[] __devinitdata = {	/* 640 x 480, cgRDI */
 	0x14, 0x70,	0x15, 0x20,	0x16, 0x08,	0x17, 0x10,
 	0x18, 0x06,	0x19, 0x02,	0x1a, 0x31,	0x1b, 0x51,
 	0x1c, 0x06,	0x1d, 0x0c,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x22,	0
 };
 
-static u8 *cg3_regvals[] __initdata = {
+static u8 *cg3_regvals[] __devinitdata = {
 	cg3regvals_66hz, cg3regvals_76hz, cg3regvals_rdi
 };
 
-static u_char cg3_dacvals[] __initdata = {
+static u_char cg3_dacvals[] __devinitdata = {
 	4, 0xff,	5, 0x00,	6, 0x70,	7, 0x00,	0
 };
 
-static void cg3_do_default_mode(struct cg3_par *par)
+static void __devinit cg3_do_default_mode(struct cg3_par *par)
 {
 	enum cg3_type type;
 	u8 *p;
@@ -433,7 +432,8 @@ static int __devinit cg3_init_one(struct of_device
*op)
 	return 0;
 }
 
-static int __devinit cg3_probe(struct of_device *dev, const struct
of_device_id *match)
+static int __devinit cg3_probe(struct of_device *dev,
+			       const struct of_device_id *match)
 {
 	struct of_device *op = to_of_device(&dev->dev);
 



