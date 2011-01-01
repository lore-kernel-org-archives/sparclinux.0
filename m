From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 21:00:30 +0000
Subject: [PATCH 7/9] sparc: use piggyback_32 for sparc64
Message-Id: <1293915632-4596-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

piggyback_32 adapted to support sparc64:
- locating "HdrS" differs for sparc and sparc64
- sparc64 updates a_text, a_data + a_bss in the final a.out header

Updated Makefile to use piggyback_32 for sparc64.
Deleted the now unused piggyback_64.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/Makefile       |    6 +-
 arch/sparc/boot/piggyback_32.c |   86 +++++++++++++++++++++++++------
 arch/sparc/boot/piggyback_64.c |  110 ----------------------------------------
 3 files changed, 72 insertions(+), 130 deletions(-)
 delete mode 100644 arch/sparc/boot/piggyback_64.c

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 4c81fe5..06a79a2 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -6,7 +6,7 @@
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
-hostprogs-y	:= piggyback_32 piggyback_64 btfixupprep
+hostprogs-y	:= piggyback_32 btfixupprep
 targets		:= tftpboot.img btfix.o btfix.S image zImage vmlinux.aout
 clean-files	:= System.map
 
@@ -69,7 +69,7 @@ endif
 
 ifeq ($(CONFIG_SPARC64),y)
 quiet_cmd_piggy     = PIGGY   $@
-      cmd_piggy     = $(obj)/piggyback_64 $@ System.map $(ROOT_IMG)
+      cmd_piggy     = $(obj)/piggyback_32 $(BITS) $@ System.map $(ROOT_IMG)
 quiet_cmd_strip     = STRIP   $@
       cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
 
@@ -82,7 +82,7 @@ $(obj)/image: vmlinux FORCE
 $(obj)/zImage: $(obj)/image
 	$(call if_changed,gzip)
 
-$(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback_64 System.map $(ROOT_IMG) FORCE
+$(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback_32 System.map $(ROOT_IMG) FORCE
 	$(call if_changed,elftoaout)
 	$(call if_changed,piggy)
 	@echo '  kernel: $@ is ready'
diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback_32.c
index c4b0843..82926f4 100644
--- a/arch/sparc/boot/piggyback_32.c
+++ b/arch/sparc/boot/piggyback_32.c
@@ -131,11 +131,59 @@ static int get_start_end(const char *filename, unsigned int *start, unsigned int
 	return 1;
 }
 
+#define LOOKBACK 512
+#define BUFSIZE 1024
+/*
+ * Find the HdrS entry from head_32/head_64.
+ * We check if it is at the beginning of the file (sparc64 case)
+ * and if not we search for it.
+ *
+ * Return the offset to the HdrS entry (as off_t)
+ */
+static off_t get_hdrs_offset(int kernelfd, const char *filename)
+{
+	char buffer[BUFSIZE];
+	off_t offset;
+	int i;
+
+	if (lseek(kernelfd, 0, SEEK_SET) < 0)
+		die("lseek");
+	if (read(kernelfd, buffer, BUFSIZE) != BUFSIZE)
+		die(filename);
+
+	if (buffer[40] = 'H' && buffer[41] = 'd' &&
+	    buffer[42] = 'r' && buffer[43] = 'S') {
+		return 40;
+	} else {
+		/*  Find the gokernel label */
+		/* Decode offset from branch instruction */
+		offset = ld2(buffer + AOUT_TEXT_OFFSET + 2) << 2;
+		/* Go back 512 bytes so we do not miss HdrS */
+		offset -= LOOKBACK;
+		/* skip a.out header */
+		offset += AOUT_TEXT_OFFSET;
+		if (lseek(kernelfd, offset, SEEK_SET) < 0)
+			die("lseek");
+		if (read(kernelfd, buffer, BUFSIZE) != BUFSIZE)
+			die(filename);
+
+		for (i = 0; i < LOOKBACK; ++i) {
+			if (buffer[i + 0] = 'H' && buffer[i + 1] = 'd' &&
+			    buffer[i + 2] = 'r' && buffer[i + 3] = 'S') {
+				return offset + i;
+			}
+		}
+	}
+	fprintf (stderr, "Couldn't find headers signature in %s\n", filename);
+	exit(1);
+}
+
 int main(int argc,char **argv)
 {
 	static char aout_magic[] = { 0x01, 0x03, 0x01, 0x07 };
-	char buffer[1024], *q, *r;
-	unsigned int i, start, end, offset;
+	char buffer[1024];
+	unsigned int i, start, end;
+	off_t offset;
 	struct stat s;
 	int image, tail;
 
@@ -165,21 +213,10 @@ int main(int argc,char **argv)
 	 * See definition of these in init_32.S
 	 */
 
-	/*  Find the gokernel label */
-	i = AOUT_TEXT_OFFSET + (ld2(buffer + AOUT_TEXT_OFFSET + 2) << 2) - 512;
-	if (lseek(image, i, 0) < 0)
-		die("lseek");
-	if (read(image, buffer, 1024) != 1024)
-		die(argv[2]);
-	for (q = buffer, r = q + 512; q < r; q += 4) {
-		if (*q = 'H' && q[1] = 'd' && q[2] = 'r' && q[3] = 'S')
-			break;
-	}
-	if (q = r) {
-		fprintf (stderr, "Couldn't find headers signature in the kernel.\n");
-		exit(1);
-	}
-	offset = i + (q - buffer) + 10;
+	offset = get_hdrs_offset(image, argv[2]);
+	/* skip HdrS + LINUX_VERSION_CODE + HdrS version */
+	offset += 10;
+
 	if (lseek(image, offset, 0) < 0)
 		die("lseek");
 
@@ -198,6 +235,21 @@ int main(int argc,char **argv)
 	if (write(image, buffer + 2, 14) != 14)
 		die(argv[2]);
 
+	/* For sparc64 update a_text and clear a_data + a_bss */
+	if (is64bit)
+	{
+		if (lseek(image, 4, 0) < 0)
+			die("lseek");
+		/* a_text */
+		st4(buffer, align(end + 32 + 8191) - (start & ~0x3fffffUL) + s.st_size);
+		/* a_data */
+		st4(buffer + 4, 0);
+		/* a_bss */
+		st4(buffer + 8, 0);
+		if (write(image, buffer, 12) != 12)
+			die(argv[2]);
+	}
+
 	/* seek page aligned boundary in the image file and add boot image */
 	if (lseek(image, AOUT_TEXT_OFFSET - start + align(end + 32), 0) < 0)
 		die("lseek");
diff --git a/arch/sparc/boot/piggyback_64.c b/arch/sparc/boot/piggyback_64.c
deleted file mode 100644
index a26a686..0000000
--- a/arch/sparc/boot/piggyback_64.c
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
-   Simple utility to make a single-image install kernel with initial ramdisk
-   for Sparc64 tftpbooting without need to set up nfs.
-   
-   Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-   
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
-   
-#include <stdio.h>
-#include <string.h>
-#include <ctype.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <dirent.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
-/* Note: run this on an a.out kernel (use elftoaout for it), as PROM looks for a.out image onlly
-   usage: piggyback vmlinux System.map tail, where tail is gzipped fs of the initial ramdisk */
-
-static void die(char *str)
-{
-	perror (str);
-	exit(1);
-}
-
-int main(int argc,char **argv)
-{
-	char buffer [1024], *q, *r;
-	unsigned int i, j, k, start, end, offset;
-	FILE *map;
-	struct stat s;
-	int image, tail;
-	
-	start = end = 0;
-	if (stat (argv[3], &s) < 0) die (argv[3]);
-	map = fopen (argv[2], "r");
-	if (!map) die(argv[2]);
-	while (fgets (buffer, 1024, map)) {
-		if (!strcmp (buffer + 19, "_start\n"))
-		start = strtoul (buffer + 8, NULL, 16);
-		else if (!strcmp (buffer + 19, "_end\n"))
-		end = strtoul (buffer + 8, NULL, 16);
-	}
-	fclose (map);
-	if ((image = open(argv[1],O_RDWR)) < 0) die(argv[1]);
-	if (read(image,buffer,512) != 512) die(argv[1]);
-	if (!memcmp (buffer, "\177ELF", 4)) {
-		unsigned int *p = (unsigned int *)(buffer + *(unsigned int *)(buffer + 28));
-		
-		i = p[1] + *(unsigned int *)(buffer + 24) - p[2];
-		if (lseek(image,i,0) < 0) die("lseek");
-		if (read(image,buffer,512) != 512) die(argv[1]);
-		j = 0;
-	} else if (*(unsigned int *)buffer = 0x01030107) {
-		i = j = 32;
-	} else {
-		fprintf (stderr, "Not ELF nor a.out. Don't blame me.\n");
-		exit(1);
-	}
-	k = i;
-	if (j = 32 && buffer[40] = 'H' && buffer[41] = 'd' && buffer[42] = 'r' && buffer[43] = 'S') {
-		offset = 40 + 10;
-	} else {
-		i += ((*(unsigned short *)(buffer + j + 2))<<2) - 512;
-		if (lseek(image,i,0) < 0) die("lseek");
-		if (read(image,buffer,1024) != 1024) die(argv[1]);
-		for (q = buffer, r = q + 512; q < r; q += 4) {
-			if (*q = 'H' && q[1] = 'd' && q[2] = 'r' && q[3] = 'S')
-				break;
-		}
-		if (q = r) {
-			fprintf (stderr, "Couldn't find headers signature in the kernel.\n");
-			exit(1);
-		}
-		offset = i + (q - buffer) + 10;
-	}
-	if (lseek(image, offset, 0) < 0) die ("lseek");
-	*(unsigned *)buffer = 0;
-	*(unsigned *)(buffer + 4) = 0x01000000;
-	*(unsigned *)(buffer + 8) = ((end + 32 + 8191) & ~8191);
-	*(unsigned *)(buffer + 12) = s.st_size;
-	if (write(image,buffer+2,14) != 14) die (argv[1]);
-	if (lseek(image, 4, 0) < 0) die ("lseek");
-	*(unsigned *)buffer = ((end + 32 + 8191) & ~8191) - (start & ~0x3fffffUL) + s.st_size;
-	*(unsigned *)(buffer + 4) = 0;
-	*(unsigned *)(buffer + 8) = 0;
-	if (write(image,buffer,12) != 12) die (argv[1]);
-	if (lseek(image, k - start + ((end + 32 + 8191) & ~8191), 0) < 0) die ("lseek");
-	if ((tail = open(argv[3],O_RDONLY)) < 0) die(argv[3]);
-	while ((i = read (tail,buffer,1024)) > 0)
-		if (write(image,buffer,i) != i) die (argv[1]);
-	if (close(image) < 0) die("close");
-	if (close(tail) < 0) die("close");
-    	return 0;
-}
-- 
1.6.0.6

