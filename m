From: Robert Reif <reif@earthlink.net>
Date: Sun, 27 Apr 2008 14:38:10 +0000
Subject: [PATCH] sparc: ffb.c make ffb_init and ffb_exit static
Message-Id: <48148FD2.8030500@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020209010409080201030009"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------020209010409080201030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make ffb_init and ffb_exit static.
Remove unnecessary function prototype.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------020209010409080201030009
Content-Type: text/plain;
 name="ffb.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ffb.diff.txt"

diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index d7e2488..02a6114 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -32,7 +32,6 @@
 static int ffb_setcolreg(unsigned, unsigned, unsigned, unsigned,
 			 unsigned, struct fb_info *);
 static int ffb_blank(int, struct fb_info *);
-static void ffb_init_fix(struct fb_info *);
 
 static void ffb_imageblit(struct fb_info *, const struct fb_image *);
 static void ffb_fillrect(struct fb_info *, const struct fb_fillrect *);
@@ -1062,7 +1061,7 @@ static struct of_platform_driver ffb_driver = {
 	.remove		= __devexit_p(ffb_remove),
 };
 
-int __init ffb_init(void)
+static int __init ffb_init(void)
 {
 	if (fb_get_options("ffb", NULL))
 		return -ENODEV;
@@ -1070,7 +1069,7 @@ int __init ffb_init(void)
 	return of_register_driver(&ffb_driver, &of_bus_type);
 }
 
-void __exit ffb_exit(void)
+static void __exit ffb_exit(void)
 {
 	of_unregister_driver(&ffb_driver);
 }

--------------020209010409080201030009--
