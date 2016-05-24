From: Joe Moriarty <joe.moriarty@oracle.com>
Date: Tue, 24 May 2016 15:16:11 +0000
Subject: [PATCH V2 1/2] arch/sparc:  SPARC-S7 piggyback support
Message-Id: <1464102972-676961-2-git-send-email-joe.moriarty@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Merge: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux

The a.out header is sometimes wrong and doesn't match the binary file
contents for different Oracle projects using Oracle Linux. This patch
was created to make sure the set of changes in a.out header file match
the changes in the a.out binary file.

Orabug: 23055807
Signed-off-by: Joe Moriarty <joe.moriarty@oracle.com>
Acked-by: Karl Volz <karl.volz@oracle.com>
---
 arch/sparc/boot/piggyback.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
index bb7c951..85e5816 100644
--- a/arch/sparc/boot/piggyback.c
+++ b/arch/sparc/boot/piggyback.c
@@ -103,7 +103,7 @@ static int end_line(const char *line)
  * f0004000 ... _start
  * f0379f79 ... _end
  * 1234567890123456
- * ^coloumn 1
+ * ^column 1
  * There is support for 64 bit addresses too.
  *
  * Return 0 if either start or end is not found
@@ -216,13 +216,15 @@ int main(int argc,char **argv)
 	 * To locate these symbols search for the "HdrS" text which appear
 	 * in the image a little before the gokernel symbol.
 	 * See definition of these in init_32.S
+	 * See definition of these in head_32.S (there is no gokernel symbol
+	 * in head_64.S).
 	 */
 
 	offset = get_hdrs_offset(image, argv[2]);
 	/* skip HdrS + LINUX_VERSION_CODE + HdrS version */
 	offset += 10;
 
-	if (lseek(image, offset, 0) < 0)
+	if (lseek(image, offset, SEEK_SET) < 0)
 		die("lseek");
 
 	/*
@@ -234,7 +236,7 @@ int main(int argc,char **argv)
 	 */
 	st4(buffer, 0);
 	st4(buffer + 4, 0x01000000);
-	st4(buffer + 8, align(end + 32));
+	st4(buffer + 8, align(end));
 	st4(buffer + 12, s.st_size);
 
 	if (write(image, buffer + 2, 14) != 14)
@@ -243,11 +245,10 @@ int main(int argc,char **argv)
 	/* For sparc64 update a_text and clear a_data + a_bss */
 	if (is64bit)
 	{
-		if (lseek(image, 4, 0) < 0)
+		if (lseek(image, 4, SEEK_SET) < 0)
 			die("lseek");
 		/* a_text */
-		st4(buffer, align(end + 32 + 8191) - (start & ~0x3fffffUL) +
-		            s.st_size);
+		st4(buffer, align(end - start) + s.st_size);
 		/* a_data */
 		st4(buffer + 4, 0);
 		/* a_bss */
@@ -256,8 +257,8 @@ int main(int argc,char **argv)
 			die(argv[2]);
 	}
 
-	/* seek page aligned boundary in the image file and add boot image */
-	if (lseek(image, AOUT_TEXT_OFFSET - start + align(end + 32), 0) < 0)
+	/* seek page aligned boundary in the text and add boot image */
+	if (lseek(image, AOUT_TEXT_OFFSET + align(end - start), SEEK_SET) < 0)
 		die("lseek");
 	if ((tail = open(argv[4], O_RDONLY)) < 0)
 		die(argv[4]);
-- 
1.7.1

