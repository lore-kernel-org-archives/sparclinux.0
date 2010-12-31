From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 31 Dec 2010 09:39:38 +0000
Subject: [PATCH] sparc: additional comments to piggyback_32.c
Message-Id: <1293788379-32709-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While reverse engineering the functionality of piggyback
I missed that the code was actually commented.
So I added a few comments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/piggyback_32.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback_32.c
index 5c86a7d..5e856f2 100644
--- a/arch/sparc/boot/piggyback_32.c
+++ b/arch/sparc/boot/piggyback_32.c
@@ -36,6 +36,8 @@
  * as PROM looks for a.out image only.
  */
 
+#define AOUT_TEXT_OFFSET   32
+
 /* read two bytes as big endian */
 static unsigned short ld2(char *p)
 {
@@ -154,12 +156,20 @@ int main(int argc,char **argv)
 			die(argv[1]);
 		j = 0;
 	} else if (memcmp(buffer, aout_magic, 4) = 0) {
-		i = j = 32;
+		i = j = AOUT_TEXT_OFFSET;
 	} else {
 		fprintf (stderr, "Not ELF nor a.out. Don't blame me.\n");
 		exit(1);
 	}
 	k = i;
+	/*
+	 * We need to fill in values for sparc_ramdisk_image + sparc_ramdisk_size
+	 * To locate these symbols search for the "HdrS" text which appear
+	 * in the image a little before the gokernel symbol.
+	 * See definition of these in init_32.S
+	 */
+
+	/*  Find the gokernel label */
 	i += (ld2(buffer + j + 2) << 2) - 512;
 	if (lseek(image, i, 0) < 0)
 		die("lseek");
@@ -177,6 +187,13 @@ int main(int argc,char **argv)
 	if (lseek(image, offset, 0) < 0)
 		die("lseek");
 
+	/*
+	 * root_flags = 0
+	 * root_dev = 1 (RAMDISK_MAJOR)
+	 * ram_flags = 0
+	 * sparc_ramdisk_image = "PAGE aligned address after _end")
+	 * sparc_ramdisk_size = size of image
+	 */
 	st4(buffer, 0);
 	st4(buffer + 4, 0x01000000);
 	st4(buffer + 8, (end + 32 + 4095) & ~4095);
@@ -184,11 +201,13 @@ int main(int argc,char **argv)
 
 	if (write(image, buffer + 2, 14) != 14)
 		die(argv[1]);
+
+	/* seek page aligned boundary in the image file and add boot image */
 	if (lseek(image, k - start + ((end + 32 + 4095) & ~4095), 0) < 0)
 		die("lseek");
 	if ((tail = open(argv[3],O_RDONLY)) < 0)
 		die(argv[3]);
-	while ((i = read (tail, buffer, 1024)) > 0)
+	while ((i = read(tail, buffer, 1024)) > 0)
 		if (write(image, buffer, i) != i)
 			die(argv[1]);
 	if (close(image) < 0)
-- 
1.6.0.6

