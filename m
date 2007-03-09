From: Robert Reif <reif@earthlink.net>
Date: Fri, 09 Mar 2007 05:16:13 +0000
Subject: [PATCH]: fix section mismatch warning in cg14.c
Message-Id: <1173417373.7384.2.camel@dell>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix section mismatch warning by moving data into __devinitdata section.
Add __devinit to an initialization function.

Signed-off-by: Robert Reif <reif@earthlink.net>

diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index ec6a51a..b071bb6 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -354,7 +354,8 @@ static int cg14_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
  *  Initialisation
  */
 
-static void cg14_init_fix(struct fb_info *info, int linebytes, struct device_node *dp)
+static void __devinit cg14_init_fix(struct fb_info *info, int linebytes,
+				    struct device_node *dp)
 {
 	const char *name = dp->name;
 
@@ -368,7 +369,7 @@ static void cg14_init_fix(struct fb_info *info, int linebytes, struct device_nod
 	info->fix.accel = FB_ACCEL_SUN_CG14;
 }
 
-static struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] __initdata = {
+static struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] __devinitdata = {
 	{
 		.voff	= CG14_REGS,
 		.poff	= 0x80000000,



