From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:23 +0000
Subject: [PATCH v2 01/11] tilo: convert data to big endian
Message-Id: <1387827813-8279-2-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Make sure that data in TILO image is big endian.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/maketilo.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tilo/maketilo.c b/tilo/maketilo.c
index b89a4f161769..0a14a96149dc 100644
--- a/tilo/maketilo.c
+++ b/tilo/maketilo.c
@@ -28,6 +28,7 @@
 
 #include <stdio.h>
 #include <sys/stat.h>
+#include <arpa/inet.h>
 #include <stdlib.h>
 #include <string.h>
 #include "b.h"
@@ -220,7 +221,7 @@ int main (int argc, char **argv)
 	output_end = root_image_start + rootlen;
 
 	/* patch code, data and BSS size in the .out header */
-	*(unsigned*)(output_buffer+4) = output_end - output_buffer;
+	*(unsigned*)(output_buffer+4) = htonl(output_end - output_buffer);
 	*(unsigned*)(output_buffer+8) = 0;
 	*(unsigned*)(output_buffer+12) = 0;
 
@@ -268,6 +269,13 @@ int main (int argc, char **argv)
 	ii[3].unpacked_len = 0;
 	ii[3].root_start = 0;
 
+	for (i = 0; i < 4; i++) {
+		ii[i].packed_start = htonl(ii[i].packed_start);
+		ii[i].packed_len   = htonl(ii[i].packed_len);
+		ii[i].unpacked_len = htonl(ii[i].unpacked_len);
+		ii[i].root_start   = htonl(ii[i].root_start);
+	}
+
 	f = fopen (output_file, "wb");
 	if (!f) {
 		fprintf (stderr, "Can't open %s for writing\n", output_file);
-- 
1.8.5.1

