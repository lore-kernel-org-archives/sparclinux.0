From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:33 +0000
Subject: [PATCH v2 11/11] tilo: adjust comments/documentation
Message-Id: <1387827813-8279-12-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Make some corrections to the maketilo documentation.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/maketilo.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tilo/maketilo.c b/tilo/maketilo.c
index bf088b91f149..e698c925acc4 100644
--- a/tilo/maketilo.c
+++ b/tilo/maketilo.c
@@ -7,18 +7,21 @@
 	to the boot loader and patches the addresses in its image_table[]
 	
 	Parameters:
-			kernel4=<filename>
-			kernel4c=<filename>
-			kernel4u=<filename>
-				... compressed kernel images (in a.out format)
+			sun4=<filename>
+			sun4c=<filename>
+			sun4u=<filename>
+				... compressed kernel images
+				    (in a.out or ELF format)
 			size4=<bytes>
 			size4c=<bytes>
 			size4u=<bytes>
-				... original sizes of kernel images (uncompressed)
+				... original sizes of kernel images
+				    (uncompressed)
 			root4=<addr>
 			root4c=<addr>
 			root4u=<addr>
-				... virtual address of root image for each kernel (in hex)
+				... virtual address of root image for each
+				    kernel (in hex)
 			root=<filename>
 				... compressed root image
 			out=<filename>
-- 
1.8.5.1

