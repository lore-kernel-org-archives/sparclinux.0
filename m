From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Tue, 04 Jun 2019 21:47:48 +0000
Subject: [PATCH silo] tilo: fix rootfs size check
Message-Id: <20190604214748.25377-1-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When checking the rootfs size we use the kernel image size instead of the
rootfs image. Fix that.

Fixes: 9f151df0eecf ("tilo: sanity check image sizes")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/maketilo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tilo/maketilo.c b/tilo/maketilo.c
index e698c92..2292bfd 100644
--- a/tilo/maketilo.c
+++ b/tilo/maketilo.c
@@ -244,8 +244,8 @@ int main (int argc, char **argv)
 	root_image_start = sun4u_kernel_start + len;
 	
 	if (root_image) {
-		check_size (root_image, root_image_start - output_buffer, len,
-			    MAX_BOOT_LEN);
+		check_size (root_image, root_image_start - output_buffer,
+			    rootlen, MAX_BOOT_LEN);
 		fread (root_image_start, 1, rootlen, g);
 		fclose (g);
 	}
-- 
2.17.0
