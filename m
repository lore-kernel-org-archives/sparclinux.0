From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 31 Dec 2010 09:39:39 +0000
Subject: [PATCH] sparc: remove obsolete ELF support in piggyback_32.c
Message-Id: <1293788379-32709-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

As we always convert to a.out there is no need to
support ELF.

Removing ELF support because:
- it is not used
- it simplifies code to support a.out only

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/piggyback_32.c |   27 +++++----------------------
 1 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback_32.c
index 5e856f2..369634d 100644
--- a/arch/sparc/boot/piggyback_32.c
+++ b/arch/sparc/boot/piggyback_32.c
@@ -44,12 +44,6 @@ static unsigned short ld2(char *p)
 	return (p[0] << 8) | p[1];
 }
 
-/* read 4 bytes as big endian */
-static unsigned int ld4(char *p)
-{
-	return (p[0] << 24) | (p[1] << 16) | (p[2] << 8) | p[3];
-}
-
 /* save 4 bytes as big endian */
 static void st4(char *p, unsigned int x)
 {
@@ -130,7 +124,7 @@ int main(int argc,char **argv)
 {
 	static char aout_magic[] = { 0x01, 0x03, 0x01, 0x07 };
 	char buffer[1024], *q, *r;
-	unsigned int i, j, k, start, end, offset;
+	unsigned int i, start, end, offset;
 	struct stat s;
 	int image, tail;
 
@@ -147,21 +141,10 @@ int main(int argc,char **argv)
 		die(argv[1]);
 	if (read(image, buffer, 512) != 512)
 		die(argv[1]);
-	if (memcmp (buffer, "\177ELF", 4) = 0) {
-		q = buffer + ld4(buffer + 28);
-		i = ld4(q + 4) + ld4(buffer + 24) - ld4(q + 8);
-		if (lseek(image, i, 0) < 0)
-			die("lseek");
-		if (read(image, buffer, 512) != 512)
-			die(argv[1]);
-		j = 0;
-	} else if (memcmp(buffer, aout_magic, 4) = 0) {
-		i = j = AOUT_TEXT_OFFSET;
-	} else {
-		fprintf (stderr, "Not ELF nor a.out. Don't blame me.\n");
+	if (memcmp(buffer, aout_magic, 4) != 0) {
+		fprintf (stderr, "Not a.out. Don't blame me.\n");
 		exit(1);
 	}
-	k = i;
 	/*
 	 * We need to fill in values for sparc_ramdisk_image + sparc_ramdisk_size
 	 * To locate these symbols search for the "HdrS" text which appear
@@ -170,7 +153,7 @@ int main(int argc,char **argv)
 	 */
 
 	/*  Find the gokernel label */
-	i += (ld2(buffer + j + 2) << 2) - 512;
+	i = AOUT_TEXT_OFFSET + (ld2(buffer + AOUT_TEXT_OFFSET + 2) << 2) - 512;
 	if (lseek(image, i, 0) < 0)
 		die("lseek");
 	if (read(image, buffer, 1024) != 1024)
@@ -203,7 +186,7 @@ int main(int argc,char **argv)
 		die(argv[1]);
 
 	/* seek page aligned boundary in the image file and add boot image */
-	if (lseek(image, k - start + ((end + 32 + 4095) & ~4095), 0) < 0)
+	if (lseek(image, AOUT_TEXT_OFFSET - start + ((end + 32 + 4095) & ~4095), 0) < 0)
 		die("lseek");
 	if ((tail = open(argv[3],O_RDONLY)) < 0)
 		die(argv[3]);
-- 
1.6.0.6

