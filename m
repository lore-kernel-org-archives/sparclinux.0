From: Robert Reif <reif@earthlink.net>
Date: Sun, 27 Apr 2008 14:35:32 +0000
Subject: [PATCH] sparc: cg14.c make cg14_init and cg15_exit static
Message-Id: <48148F34.5060906@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020607070609070709050805"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607070609070709050805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make cg14_init and cg14_exit static.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------020607070609070709050805
Content-Type: text/plain;
 name="cg14.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg14.diff.txt"

diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index fdc9f43..359734e 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -605,7 +605,7 @@ static struct of_platform_driver cg14_driver = {
 	.remove		= __devexit_p(cg14_remove),
 };
 
-int __init cg14_init(void)
+static int __init cg14_init(void)
 {
 	if (fb_get_options("cg14fb", NULL))
 		return -ENODEV;
@@ -613,7 +613,7 @@ int __init cg14_init(void)
 	return of_register_driver(&cg14_driver, &of_bus_type);
 }
 
-void __exit cg14_exit(void)
+static void __exit cg14_exit(void)
 {
 	of_unregister_driver(&cg14_driver);
 }

--------------020607070609070709050805--
