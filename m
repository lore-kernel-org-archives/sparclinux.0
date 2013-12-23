From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:30 +0000
Subject: [PATCH v2 08/11] tilo: check kernel space limits
Message-Id: <1387827813-8279-9-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sanity check the space available for kernel decompression.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/tilo.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tilo/tilo.c b/tilo/tilo.c
index afbd848d9814..dc626efc7b02 100644
--- a/tilo/tilo.c
+++ b/tilo/tilo.c
@@ -175,6 +175,7 @@ char *my_main (struct linux_romvec *promvec, void *cifh, void *cifs)
 char *orig_code,*moved_code,*moved_ramdisk,*moved_kernel,*kernel_base;
 unsigned *p,*q = NULL;
 int kernel_number;
+char *kernel_end, *kernel_limit;
 
     prom_init(promvec, cifh, cifs);
     
@@ -215,9 +216,16 @@ int kernel_number;
 
     gzminp = (unsigned char *)moved_kernel;		/* decompress kernel */
     kernel_base = (char*) 0x4000;
+    kernel_end = kernel_base +
+		 ((image_table[kernel_number].unpacked_len + 0xfff) & ~0xfff);
+    kernel_limit = moved_kernel;
 
-    if (decompress (kernel_base, kernel_base + ((image_table[kernel_number].unpacked_len
-		 + 0xfff) & ~0xfff), get_input, unget_input) = -1)
+    if (kernel_end > kernel_limit) {
+	printf("No space to decompress the kernel.\n");
+	prom_halt();
+    }
+
+    if (decompress (kernel_base, kernel_end, get_input, unget_input) = -1)
     	{
         printf ("\nKernel decompression error\n");
         prom_halt();
-- 
1.8.5.1

