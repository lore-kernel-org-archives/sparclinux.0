From: Robert Reif <reif@earthlink.net>
Date: Sun, 27 Apr 2008 14:40:02 +0000
Subject: [PATCH] sparc: tcx.c make tcx_init and tcx_exit static
Message-Id: <48149042.6040702@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050203030102000107080809"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050203030102000107080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make tcx_init and tcx_exit static.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------050203030102000107080809
Content-Type: text/plain;
 name="tcx.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcx.diff.txt"

diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index e5a9ddb..7dc33bf 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -527,7 +527,7 @@ static struct of_platform_driver tcx_driver = {
 	.remove		= __devexit_p(tcx_remove),
 };
 
-int __init tcx_init(void)
+static int __init tcx_init(void)
 {
 	if (fb_get_options("tcxfb", NULL))
 		return -ENODEV;
@@ -535,7 +535,7 @@ int __init tcx_init(void)
 	return of_register_driver(&tcx_driver, &of_bus_type);
 }
 
-void __exit tcx_exit(void)
+static void __exit tcx_exit(void)
 {
 	of_unregister_driver(&tcx_driver);
 }

--------------050203030102000107080809--
