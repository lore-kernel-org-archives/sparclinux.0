From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 03 Dec 2008 20:00:44 +0000
Subject: [revised v2 PATCH 5/5] sparc,sparc64: unify boot/
Message-Id: <20081203200044.GA6471@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 45bc2bdccf16c27644abefec11a30a22ad001276 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 Nov 2008 21:15:32 +0100
Subject: [PATCH] sparc,sparc64: unify boot/

Simple unification:
o renamed piggyback to *_32.c/*_64.c
o copied content of Makefile from sparc64 to sparc and guard it
o updated sparc/boot/.gitignore
o deleted remaining files in sparc64/boot

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile            |    9 +--
 arch/sparc/boot/.gitignore     |    3 +
 arch/sparc/boot/Makefile       |   33 +++++++++-
 arch/sparc/boot/piggyback.c    |  137 ----------------------------------------
 arch/sparc/boot/piggyback_32.c |  137 ++++++++++++++++++++++++++++++++++++++++
 arch/sparc/boot/piggyback_64.c |  109 +++++++++++++++++++++++++++++++
 arch/sparc64/boot/.gitignore   |    4 -
 arch/sparc64/boot/Makefile     |   33 ----------
 arch/sparc64/boot/piggyback.c  |  109 -------------------------------
 9 files changed, 283 insertions(+), 291 deletions(-)
 delete mode 100644 arch/sparc/boot/piggyback.c
 create mode 100644 arch/sparc/boot/piggyback_32.c
 create mode 100644 arch/sparc/boot/piggyback_64.c
 delete mode 100644 arch/sparc64/boot/.gitignore
 delete mode 100644 arch/sparc64/boot/Makefile
 delete mode 100644 arch/sparc64/boot/piggyback.c

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 4b39ac6..efc9071 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -89,17 +89,16 @@ ifdef CONFIG_KALLSYMS
 export kallsyms.o := .tmp_kallsyms2.o
 endif
 
-boot-y                 := arch/sparc/boot
-boot-$(CONFIG_SPARC64) := arch/sparc64/boot
+boot := arch/sparc/boot
 
 image zImage tftpboot.img vmlinux.aout: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot-y) $(boot-y)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archclean:
-	$(Q)$(MAKE) $(clean)=$(boot-y)
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 # This is the image used for packaging
-KBUILD_IMAGE := $(boot-y)/zImage
+KBUILD_IMAGE := $(boot)/zImage
 
 # Don't use tabs in echo arguments.
 ifeq ($(ARCH),sparc)
diff --git a/arch/sparc/boot/.gitignore b/arch/sparc/boot/.gitignore
index 8ffba57..fc6f398 100644
--- a/arch/sparc/boot/.gitignore
+++ b/arch/sparc/boot/.gitignore
@@ -2,4 +2,7 @@ btfix.S
 btfixupprep
 image
 zImage
+tftpboot.img
+vmlinux.aout
+piggyback
 
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 06b653d..77fc82c 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -6,14 +6,16 @@
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
-hostprogs-y	:= piggyback btfixupprep
-targets		:= tftpboot.img btfix.o btfix.S image zImage
+hostprogs-y	:= piggyback_32 piggyback_64 btfixupprep
+targets		:= tftpboot.img btfix.o btfix.S image zImage vmlinux.aout
 clean-files	:= System.map
 
 quiet_cmd_elftoaout	= ELFTOAOUT $@
       cmd_elftoaout	= $(ELFTOAOUT) $(obj)/image -o $@
+
+ifeq ($(CONFIG_SPARC32),y)
 quiet_cmd_piggy		= PIGGY   $@
-      cmd_piggy		= $(obj)/piggyback $@ $(obj)/System.map $(ROOT_IMG)
+      cmd_piggy		= $(obj)/piggyback_32 $@ $(obj)/System.map $(ROOT_IMG)
 quiet_cmd_btfix		= BTFIX   $@
       cmd_btfix		= $(OBJDUMP) -x vmlinux | $(obj)/btfixupprep > $@
 quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
@@ -62,3 +64,28 @@ $(obj)/tftpboot.img: $(obj)/piggyback $(obj)/System.map $(obj)/image FORCE
 
 $(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
+
+endif
+
+ifeq ($(CONFIG_SPARC64),y)
+quiet_cmd_piggy     = PIGGY   $@
+      cmd_piggy     = $(obj)/piggyback_64 $@ System.map $(ROOT_IMG)
+quiet_cmd_strip     = STRIP   $@
+      cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
+
+
+# Actual linking
+$(obj)/image: vmlinux FORCE
+        $(call if_changed,strip)
+        @echo '  kernel: $@ is ready'
+
+$(obj)/tftpboot.img: vmlinux $(obj)/piggyback_64 System.map $(ROOT_IMG) FORCE
+        $(call if_changed,elftoaout)
+        $(call if_changed,piggy)
+        @echo '  kernel: $@ is ready'
+
+$(obj)/vmlinux.aout: vmlinux FORCE
+        $(call if_changed,elftoaout)
+        @echo '  kernel: $@ is ready'
+endif
+
diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
deleted file mode 100644
index c9f500c..0000000
--- a/arch/sparc/boot/piggyback.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
-   Simple utility to make a single-image install kernel with initial ramdisk
-   for Sparc tftpbooting without need to set up nfs.
-
-   Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
-   Pete Zaitcev <zaitcev@yahoo.com> endian fixes for cross-compiles, 2000.
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
-/*
- * Note: run this on an a.out kernel (use elftoaout for it),
- * as PROM looks for a.out image only.
- */
-
-unsigned short ld2(char *p)
-{
-	return (p[0] << 8) | p[1];
-}
-
-unsigned int ld4(char *p)
-{
-	return (p[0] << 24) | (p[1] << 16) | (p[2] << 8) | p[3];
-}
-
-void st4(char *p, unsigned int x)
-{
-	p[0] = x >> 24;
-	p[1] = x >> 16;
-	p[2] = x >> 8;
-	p[3] = x;
-}
-
-void usage(void)
-{
-	/* fs_img.gz is an image of initial ramdisk. */
-	fprintf(stderr, "Usage: piggyback vmlinux.aout System.map fs_img.gz\n");
-	fprintf(stderr, "\tKernel image will be modified in place.\n");
-	exit(1);
-}
-
-void die(char *str)
-{
-	perror (str);
-	exit(1);
-}
-
-int main(int argc,char **argv)
-{
-	static char aout_magic[] = { 0x01, 0x03, 0x01, 0x07 };
-	unsigned char buffer[1024], *q, *r;
-	unsigned int i, j, k, start, end, offset;
-	FILE *map;
-	struct stat s;
-	int image, tail;
-
-	if (argc != 4) usage();
-	start = end = 0;
-	if (stat (argv[3], &s) < 0) die (argv[3]);
-	map = fopen (argv[2], "r");
-	if (!map) die(argv[2]);
-	while (fgets (buffer, 1024, map)) {
-		if (!strcmp (buffer + 8, " T start\n") || !strcmp (buffer + 16, " T start\n"))
-			start = strtoul (buffer, NULL, 16);
-		else if (!strcmp (buffer + 8, " A end\n") || !strcmp (buffer + 16, " A end\n"))
-			end = strtoul (buffer, NULL, 16);
-	}
-	fclose (map);
-	if (!start || !end) {
-		fprintf (stderr, "Could not determine start and end from System.map\n");
-		exit(1);
-	}
-	if ((image = open(argv[1],O_RDWR)) < 0) die(argv[1]);
-	if (read(image,buffer,512) != 512) die(argv[1]);
-	if (memcmp (buffer, "\177ELF", 4) = 0) {
-		q = buffer + ld4(buffer + 28);
-		i = ld4(q + 4) + ld4(buffer + 24) - ld4(q + 8);
-		if (lseek(image,i,0) < 0) die("lseek");
-		if (read(image,buffer,512) != 512) die(argv[1]);
-		j = 0;
-	} else if (memcmp(buffer, aout_magic, 4) = 0) {
-		i = j = 32;
-	} else {
-		fprintf (stderr, "Not ELF nor a.out. Don't blame me.\n");
-		exit(1);
-	}
-	k = i;
-	i += (ld2(buffer + j + 2)<<2) - 512;
-	if (lseek(image,i,0) < 0) die("lseek");
-	if (read(image,buffer,1024) != 1024) die(argv[1]);
-	for (q = buffer, r = q + 512; q < r; q += 4) {
-		if (*q = 'H' && q[1] = 'd' && q[2] = 'r' && q[3] = 'S')
-			break;
-	}
-	if (q = r) {
-		fprintf (stderr, "Couldn't find headers signature in the kernel.\n");
-		exit(1);
-	}
-	offset = i + (q - buffer) + 10;
-	if (lseek(image, offset, 0) < 0) die ("lseek");
-
-	st4(buffer, 0);
-	st4(buffer + 4, 0x01000000);
-	st4(buffer + 8, (end + 32 + 4095) & ~4095);
-	st4(buffer + 12, s.st_size);
-
-	if (write(image,buffer+2,14) != 14) die (argv[1]);
-	if (lseek(image, k - start + ((end + 32 + 4095) & ~4095), 0) < 0) die ("lseek");
-	if ((tail = open(argv[3],O_RDONLY)) < 0) die(argv[3]);
-	while ((i = read (tail,buffer,1024)) > 0)
-		if (write(image,buffer,i) != i) die (argv[1]);
-	if (close(image) < 0) die("close");
-	if (close(tail) < 0) die("close");
-    	return 0;
-}
diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback_32.c
new file mode 100644
index 0000000..c9f500c
--- /dev/null
+++ b/arch/sparc/boot/piggyback_32.c
@@ -0,0 +1,137 @@
+/*
+   Simple utility to make a single-image install kernel with initial ramdisk
+   for Sparc tftpbooting without need to set up nfs.
+
+   Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+   Pete Zaitcev <zaitcev@yahoo.com> endian fixes for cross-compiles, 2000.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+   
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+   
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+/*
+ * Note: run this on an a.out kernel (use elftoaout for it),
+ * as PROM looks for a.out image only.
+ */
+
+unsigned short ld2(char *p)
+{
+	return (p[0] << 8) | p[1];
+}
+
+unsigned int ld4(char *p)
+{
+	return (p[0] << 24) | (p[1] << 16) | (p[2] << 8) | p[3];
+}
+
+void st4(char *p, unsigned int x)
+{
+	p[0] = x >> 24;
+	p[1] = x >> 16;
+	p[2] = x >> 8;
+	p[3] = x;
+}
+
+void usage(void)
+{
+	/* fs_img.gz is an image of initial ramdisk. */
+	fprintf(stderr, "Usage: piggyback vmlinux.aout System.map fs_img.gz\n");
+	fprintf(stderr, "\tKernel image will be modified in place.\n");
+	exit(1);
+}
+
+void die(char *str)
+{
+	perror (str);
+	exit(1);
+}
+
+int main(int argc,char **argv)
+{
+	static char aout_magic[] = { 0x01, 0x03, 0x01, 0x07 };
+	unsigned char buffer[1024], *q, *r;
+	unsigned int i, j, k, start, end, offset;
+	FILE *map;
+	struct stat s;
+	int image, tail;
+
+	if (argc != 4) usage();
+	start = end = 0;
+	if (stat (argv[3], &s) < 0) die (argv[3]);
+	map = fopen (argv[2], "r");
+	if (!map) die(argv[2]);
+	while (fgets (buffer, 1024, map)) {
+		if (!strcmp (buffer + 8, " T start\n") || !strcmp (buffer + 16, " T start\n"))
+			start = strtoul (buffer, NULL, 16);
+		else if (!strcmp (buffer + 8, " A end\n") || !strcmp (buffer + 16, " A end\n"))
+			end = strtoul (buffer, NULL, 16);
+	}
+	fclose (map);
+	if (!start || !end) {
+		fprintf (stderr, "Could not determine start and end from System.map\n");
+		exit(1);
+	}
+	if ((image = open(argv[1],O_RDWR)) < 0) die(argv[1]);
+	if (read(image,buffer,512) != 512) die(argv[1]);
+	if (memcmp (buffer, "\177ELF", 4) = 0) {
+		q = buffer + ld4(buffer + 28);
+		i = ld4(q + 4) + ld4(buffer + 24) - ld4(q + 8);
+		if (lseek(image,i,0) < 0) die("lseek");
+		if (read(image,buffer,512) != 512) die(argv[1]);
+		j = 0;
+	} else if (memcmp(buffer, aout_magic, 4) = 0) {
+		i = j = 32;
+	} else {
+		fprintf (stderr, "Not ELF nor a.out. Don't blame me.\n");
+		exit(1);
+	}
+	k = i;
+	i += (ld2(buffer + j + 2)<<2) - 512;
+	if (lseek(image,i,0) < 0) die("lseek");
+	if (read(image,buffer,1024) != 1024) die(argv[1]);
+	for (q = buffer, r = q + 512; q < r; q += 4) {
+		if (*q = 'H' && q[1] = 'd' && q[2] = 'r' && q[3] = 'S')
+			break;
+	}
+	if (q = r) {
+		fprintf (stderr, "Couldn't find headers signature in the kernel.\n");
+		exit(1);
+	}
+	offset = i + (q - buffer) + 10;
+	if (lseek(image, offset, 0) < 0) die ("lseek");
+
+	st4(buffer, 0);
+	st4(buffer + 4, 0x01000000);
+	st4(buffer + 8, (end + 32 + 4095) & ~4095);
+	st4(buffer + 12, s.st_size);
+
+	if (write(image,buffer+2,14) != 14) die (argv[1]);
+	if (lseek(image, k - start + ((end + 32 + 4095) & ~4095), 0) < 0) die ("lseek");
+	if ((tail = open(argv[3],O_RDONLY)) < 0) die(argv[3]);
+	while ((i = read (tail,buffer,1024)) > 0)
+		if (write(image,buffer,i) != i) die (argv[1]);
+	if (close(image) < 0) die("close");
+	if (close(tail) < 0) die("close");
+    	return 0;
+}
diff --git a/arch/sparc/boot/piggyback_64.c b/arch/sparc/boot/piggyback_64.c
new file mode 100644
index 0000000..de364bf
--- /dev/null
+++ b/arch/sparc/boot/piggyback_64.c
@@ -0,0 +1,109 @@
+/*
+   Simple utility to make a single-image install kernel with initial ramdisk
+   for Sparc64 tftpbooting without need to set up nfs.
+   
+   Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+   
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+   
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+   
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+/* Note: run this on an a.out kernel (use elftoaout for it), as PROM looks for a.out image onlly
+   usage: piggyback vmlinux System.map tail, where tail is gzipped fs of the initial ramdisk */
+
+void die(char *str)
+{
+	perror (str);
+	exit(1);
+}
+
+int main(int argc,char **argv)
+{
+	char buffer [1024], *q, *r;
+	unsigned int i, j, k, start, end, offset;
+	FILE *map;
+	struct stat s;
+	int image, tail;
+	
+	if (stat (argv[3], &s) < 0) die (argv[3]);
+	map = fopen (argv[2], "r");
+	if (!map) die(argv[2]);
+	while (fgets (buffer, 1024, map)) {
+		if (!strcmp (buffer + 19, "_start\n"))
+		start = strtoul (buffer + 8, NULL, 16);
+		else if (!strcmp (buffer + 19, "_end\n"))
+		end = strtoul (buffer + 8, NULL, 16);
+	}
+	fclose (map);
+	if ((image = open(argv[1],O_RDWR)) < 0) die(argv[1]);
+	if (read(image,buffer,512) != 512) die(argv[1]);
+	if (!memcmp (buffer, "\177ELF", 4)) {
+		unsigned int *p = (unsigned int *)(buffer + *(unsigned int *)(buffer + 28));
+		
+		i = p[1] + *(unsigned int *)(buffer + 24) - p[2];
+		if (lseek(image,i,0) < 0) die("lseek");
+		if (read(image,buffer,512) != 512) die(argv[1]);
+		j = 0;
+	} else if (*(unsigned int *)buffer = 0x01030107) {
+		i = j = 32;
+	} else {
+		fprintf (stderr, "Not ELF nor a.out. Don't blame me.\n");
+		exit(1);
+	}
+	k = i;
+	if (j = 32 && buffer[40] = 'H' && buffer[41] = 'd' && buffer[42] = 'r' && buffer[43] = 'S') {
+		offset = 40 + 10;
+	} else {
+		i += ((*(unsigned short *)(buffer + j + 2))<<2) - 512;
+		if (lseek(image,i,0) < 0) die("lseek");
+		if (read(image,buffer,1024) != 1024) die(argv[1]);
+		for (q = buffer, r = q + 512; q < r; q += 4) {
+			if (*q = 'H' && q[1] = 'd' && q[2] = 'r' && q[3] = 'S')
+				break;
+		}
+		if (q = r) {
+			fprintf (stderr, "Couldn't find headers signature in the kernel.\n");
+			exit(1);
+		}
+		offset = i + (q - buffer) + 10;
+	}
+	if (lseek(image, offset, 0) < 0) die ("lseek");
+	*(unsigned *)buffer = 0;
+	*(unsigned *)(buffer + 4) = 0x01000000;
+	*(unsigned *)(buffer + 8) = ((end + 32 + 8191) & ~8191);
+	*(unsigned *)(buffer + 12) = s.st_size;
+	if (write(image,buffer+2,14) != 14) die (argv[1]);
+	if (lseek(image, 4, 0) < 0) die ("lseek");
+	*(unsigned *)buffer = ((end + 32 + 8191) & ~8191) - (start & ~0x3fffffUL) + s.st_size;
+	*(unsigned *)(buffer + 4) = 0;
+	*(unsigned *)(buffer + 8) = 0;
+	if (write(image,buffer,12) != 12) die (argv[1]);
+	if (lseek(image, k - start + ((end + 32 + 8191) & ~8191), 0) < 0) die ("lseek");
+	if ((tail = open(argv[3],O_RDONLY)) < 0) die(argv[3]);
+	while ((i = read (tail,buffer,1024)) > 0)
+		if (write(image,buffer,i) != i) die (argv[1]);
+	if (close(image) < 0) die("close");
+	if (close(tail) < 0) die("close");
+    	return 0;
+}
diff --git a/arch/sparc64/boot/.gitignore b/arch/sparc64/boot/.gitignore
deleted file mode 100644
index 36356f9..0000000
--- a/arch/sparc64/boot/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-image
-tftpboot.img
-vmlinux.aout
-piggyback
diff --git a/arch/sparc64/boot/Makefile b/arch/sparc64/boot/Makefile
deleted file mode 100644
index 0458b52..0000000
--- a/arch/sparc64/boot/Makefile
+++ /dev/null
@@ -1,33 +0,0 @@
-# Makefile for the Sparc64 boot stuff.
-#
-# Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
-# Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
-
-ROOT_IMG	:= /usr/src/root.img
-ELFTOAOUT	:= elftoaout
-
-hostprogs-y	:= piggyback
-targets		:= image tftpboot.img vmlinux.aout
-
-quiet_cmd_elftoaout = ELF2AOUT $@
-      cmd_elftoaout = $(ELFTOAOUT) vmlinux -o $@
-quiet_cmd_piggy     = PIGGY   $@
-      cmd_piggy     = $(obj)/piggyback $@ System.map $(ROOT_IMG)
-quiet_cmd_strip     = STRIP   $@
-      cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
-
-
-# Actual linking
-$(obj)/image: vmlinux FORCE
-	$(call if_changed,strip)
-	@echo '  kernel: $@ is ready'
-
-$(obj)/tftpboot.img: vmlinux $(obj)/piggyback System.map $(ROOT_IMG) FORCE
-	$(call if_changed,elftoaout)
-	$(call if_changed,piggy)
-	@echo '  kernel: $@ is ready'
-
-$(obj)/vmlinux.aout: vmlinux FORCE
-	$(call if_changed,elftoaout)
-	@echo '  kernel: $@ is ready'
-
diff --git a/arch/sparc64/boot/piggyback.c b/arch/sparc64/boot/piggyback.c
deleted file mode 100644
index de364bf..0000000
--- a/arch/sparc64/boot/piggyback.c
+++ /dev/null
@@ -1,109 +0,0 @@
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
-void die(char *str)
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
1.5.6.GIT

