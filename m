From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 21:00:29 +0000
Subject: [PATCH 6/9] sparc: add $BITS to piggyback arguments
Message-Id: <1293915632-4596-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add new option to piggyback that identify if this is
for 32 or 64 bit.
Use this information to determine the alignment used.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/Makefile       |    2 +-
 arch/sparc/boot/piggyback_32.c |   45 +++++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 97e3feb..4c81fe5 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -15,7 +15,7 @@ quiet_cmd_elftoaout	= ELFTOAOUT $@
 
 ifeq ($(CONFIG_SPARC32),y)
 quiet_cmd_piggy		= PIGGY   $@
-      cmd_piggy		= $(obj)/piggyback_32 $@ System.map $(ROOT_IMG)
+      cmd_piggy		= $(obj)/piggyback_32 $(BITS) $@ System.map $(ROOT_IMG)
 quiet_cmd_btfix		= BTFIX   $@
       cmd_btfix		= $(OBJDUMP) -x vmlinux | $(obj)/btfixupprep > $@
 quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback_32.c
index 369634d..c4b0843 100644
--- a/arch/sparc/boot/piggyback_32.c
+++ b/arch/sparc/boot/piggyback_32.c
@@ -38,6 +38,17 @@
 
 #define AOUT_TEXT_OFFSET   32
 
+static int is64bit = 0;
+
+/* align to power-of-two size */
+static int align(int n)
+{
+	if (is64bit)
+		return (n + 0x1fff) & ~0x1fff;
+	else
+		return (n + 0xfff) & ~0xfff;
+}
+
 /* read two bytes as big endian */
 static unsigned short ld2(char *p)
 {
@@ -62,7 +73,7 @@ static void die(const char *str)
 static void usage(void)
 {
 	/* fs_img.gz is an image of initial ramdisk. */
-	fprintf(stderr, "Usage: piggyback vmlinux.aout System.map fs_img.gz\n");
+	fprintf(stderr, "Usage: piggyback bits vmlinux.aout System.map fs_img.gz\n");
 	fprintf(stderr, "\tKernel image will be modified in place.\n");
 	exit(1);
 }
@@ -128,19 +139,21 @@ int main(int argc,char **argv)
 	struct stat s;
 	int image, tail;
 
-	if (argc != 4)
+	if (argc != 5)
 		usage();
-	if (stat (argv[3], &s) < 0)
-		die(argv[3]);
+	if (strcmp(argv[1], "64") = 0)
+		is64bit = 1;
+	if (stat (argv[4], &s) < 0)
+		die(argv[4]);
 
-	if (!get_start_end(argv[2], &start, &end)) {
-		fprintf (stderr, "Could not determine start and end from %s\n", argv[2]);
+	if (!get_start_end(argv[3], &start, &end)) {
+		fprintf (stderr, "Could not determine start and end from %s\n", argv[3]);
 		exit(1);
 	}
-	if ((image = open(argv[1], O_RDWR)) < 0)
-		die(argv[1]);
+	if ((image = open(argv[2], O_RDWR)) < 0)
+		die(argv[2]);
 	if (read(image, buffer, 512) != 512)
-		die(argv[1]);
+		die(argv[2]);
 	if (memcmp(buffer, aout_magic, 4) != 0) {
 		fprintf (stderr, "Not a.out. Don't blame me.\n");
 		exit(1);
@@ -157,7 +170,7 @@ int main(int argc,char **argv)
 	if (lseek(image, i, 0) < 0)
 		die("lseek");
 	if (read(image, buffer, 1024) != 1024)
-		die(argv[1]);
+		die(argv[2]);
 	for (q = buffer, r = q + 512; q < r; q += 4) {
 		if (*q = 'H' && q[1] = 'd' && q[2] = 'r' && q[3] = 'S')
 			break;
@@ -179,20 +192,20 @@ int main(int argc,char **argv)
 	 */
 	st4(buffer, 0);
 	st4(buffer + 4, 0x01000000);
-	st4(buffer + 8, (end + 32 + 4095) & ~4095);
+	st4(buffer + 8, align(end + 32));
 	st4(buffer + 12, s.st_size);
 
 	if (write(image, buffer + 2, 14) != 14)
-		die(argv[1]);
+		die(argv[2]);
 
 	/* seek page aligned boundary in the image file and add boot image */
-	if (lseek(image, AOUT_TEXT_OFFSET - start + ((end + 32 + 4095) & ~4095), 0) < 0)
+	if (lseek(image, AOUT_TEXT_OFFSET - start + align(end + 32), 0) < 0)
 		die("lseek");
-	if ((tail = open(argv[3],O_RDONLY)) < 0)
-		die(argv[3]);
+	if ((tail = open(argv[4], O_RDONLY)) < 0)
+		die(argv[4]);
 	while ((i = read(tail, buffer, 1024)) > 0)
 		if (write(image, buffer, i) != i)
-			die(argv[1]);
+			die(argv[2]);
 	if (close(image) < 0)
 		die("close");
 	if (close(tail) < 0)
-- 
1.6.0.6

