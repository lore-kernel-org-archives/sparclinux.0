From: Robert Reif <reif@earthlink.net>
Date: Sun, 27 Apr 2008 14:31:33 +0000
Subject: [PATCH] sparc: bw2.c fix bw2_exit
Message-Id: <48148E45.5040506@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060709000702080508010406"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709000702080508010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix void function bw2_exit returning value.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------060709000702080508010406
Content-Type: text/plain;
 name="bw2.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bw2.diff.txt"

diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 833b10c..bb0bb55 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -399,10 +399,9 @@ static int __init bw2_init(void)
 
 static void __exit bw2_exit(void)
 {
-	return of_unregister_driver(&bw2_driver);
+	of_unregister_driver(&bw2_driver);
 }
 
-
 module_init(bw2_init);
 module_exit(bw2_exit);
 

--------------060709000702080508010406--
