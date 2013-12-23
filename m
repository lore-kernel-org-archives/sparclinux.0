From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:28 +0000
Subject: [PATCH v2 06/11] tilo: sanity check image sizes
Message-Id: <1387827813-8279-7-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sanity check image sizes to prevent buffer overflow.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/maketilo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tilo/maketilo.c b/tilo/maketilo.c
index 30eaef4c2868..6bc2f767fcb6 100644
--- a/tilo/maketilo.c
+++ b/tilo/maketilo.c
@@ -53,6 +53,14 @@ int root_tweak (char *s)
 	return p ? (p + 32 + 0x1fff) & ~0x1fff : 0;	/* add 32 bytes and round to 8 KB */
 }
 
+static void check_size (char const *name, int len, int pos, int max)
+{
+	if (max - pos < len) {
+		fprintf (stderr, "%s will not fit into the image.\n", name);
+		exit (EXIT_FAILURE);
+	}
+}
+
 int main (int argc, char **argv)
 {
 	int i,len,rootlen;
@@ -177,6 +185,8 @@ int main (int argc, char **argv)
 		fseek (f, 0, SEEK_END);
 		len = ftell (f);
 		fseek (f, 0, SEEK_SET);
+		check_size (sun4_kernel, sun4_kernel_start - output_buffer, len,
+			    MAX_BOOT_LEN);
 		fread (sun4_kernel_start, 1, len, f);
 		fclose (f);
 	} else
@@ -194,6 +204,8 @@ int main (int argc, char **argv)
 		fseek (f, 0, SEEK_END);
 		len = ftell (f);
 		fseek (f, 0, SEEK_SET);
+		check_size (sun4c_kernel, sun4c_kernel_start - output_buffer,
+			    len, MAX_BOOT_LEN);
 		fread (sun4c_kernel_start, 1, len, f);
 		fclose (f);
 	} else
@@ -211,6 +223,8 @@ int main (int argc, char **argv)
 		fseek (f, 0, SEEK_END);
 		len = ftell (f);
 		fseek (f, 0, SEEK_SET);
+		check_size (sun4u_kernel, sun4u_kernel_start - output_buffer,
+			    len, MAX_BOOT_LEN);
 		fread (sun4u_kernel_start, 1, len, f);
 		fclose (f);
 	} else
@@ -219,6 +233,8 @@ int main (int argc, char **argv)
 	root_image_start = sun4u_kernel_start + len;
 	
 	if (root_image) {
+		check_size (root_image, root_image_start - output_buffer, len,
+			    MAX_BOOT_LEN);
 		fread (root_image_start, 1, rootlen, g);
 		fclose (g);
 	}
-- 
1.8.5.1

