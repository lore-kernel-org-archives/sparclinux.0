From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:29 +0000
Subject: [PATCH v2 07/11] tilo: support super large images
Message-Id: <1387827813-8279-8-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Support images bigger than 4 MB. At least Sun Ultra 5/10 PROM maps 10 MB,
so make that a new limit.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/Makefile   | 22 ++++++++++++++++++++--
 tilo/crt0.S     |  4 ++++
 tilo/maketilo.c | 12 ++++++++++--
 tilo/tilo.c     |  4 ++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tilo/Makefile b/tilo/Makefile
index 800e65f02767..bcc5806bed4f 100644
--- a/tilo/Makefile
+++ b/tilo/Makefile
@@ -10,6 +10,8 @@ include ../Rules.make
 LDFLAGS_SMALL=-N -Ttext 0x3c0000
 # This is even more, but will be used only for extra large images.
 LDFLAGS_LARGE=-N -Ttext 0x4c0000
+# This is even more, but will be used only for super large images.
+LDFLAGS_SUPER=-N -Ttext 0x9c0000
 
 all: maketilo
 
@@ -25,8 +27,9 @@ OBJS_COMMON = ../common/printf.o ../common/jmp.o ../common/prom.o \
 	../common/divdi3.o ../common/udivdi3.o
 OBJS = crt0.o tilo.o $(OBJS_COMMON) malloc.o
 OBJS2 = crt0l.o tilol.o $(OBJS_COMMON) mallocl.o
+OBJS3 = crt0sup.o tilosup.o $(OBJS_COMMON) mallocsup.o
 
-maketilo: maketilo.c b.h b2.h
+maketilo: maketilo.c b.h b2.h b3.h
 	$(HOSTCC) $(HOSTCFLAGS) -g maketilo.c -o maketilo
 
 b.h : b.out $(BIN2H)
@@ -35,6 +38,9 @@ b.h : b.out $(BIN2H)
 b2.h : b2.out $(BIN2H)
 	$(BIN2H) -l LARGE_BOOT_LEN large_boot_loader $< > $@ || ($(RM) $@; exit 1)
 
+b3.h : b3.out $(BIN2H)
+	$(BIN2H) -l SUPER_BOOT_LEN super_boot_loader $< > $@ || ($(RM) $@; exit 1)
+
 b.out: $(OBJS)
 	$(LD) $(LDFLAGS_SMALL) -Bstatic -o boot $(OBJS)
 	$(ELFTOAOUT) boot -o b.out
@@ -43,6 +49,12 @@ b2.out: $(OBJS2)
 	$(LD) $(LDFLAGS_LARGE) -Bstatic -o boot2 $(OBJS2)
 	$(ELFTOAOUT) boot2 -o b2.out
 
+b3.out: $(OBJS3)
+	$(LD) $(LDFLAGS_SUPER) -Bstatic -o boot3 $(OBJS3)
+	$(ELFTOAOUT) boot3 -o b3.out
+
+mallocsup.o: ../common/malloc.c
+	$(CC) $(CFLAGS) -DMALLOC_BASE=0x9D0000 -c -o $@ $<
 
 mallocl.o: ../common/malloc.c
 	$(CC) $(CFLAGS) -DMALLOC_BASE=0x4D0000 -c -o $@ $<
@@ -50,6 +62,9 @@ mallocl.o: ../common/malloc.c
 malloc.o: ../common/malloc.c
 	$(CC) $(CFLAGS) -DMALLOC_BASE=0x3D0000 -c -o $@ $<
 
+tilosup.o: tilo.c
+	$(CC) $(CFLAGS) -DSUPERTILO -c -o $@ $<
+
 tilol.o: tilo.c
 	$(CC) $(CFLAGS) -DLARGETILO -c -o $@ $<
 
@@ -59,5 +74,8 @@ crt0.o:	crt0.S
 crt0l.o: crt0.S
 	$(CC) $(CFLAGS) -c -Wa,-Av9 -DLARGETILO -o $@ $<
 
+crt0sup.o: crt0.S
+	$(CC) $(CFLAGS) -c -Wa,-Av9 -DSUPERTILO -o $@ $<
+
 clean:
-	$(RM) *.o boot boot2 *.out b.h b2.h maketilo
+	$(RM) *.o boot boot2 boot3 *.out b.h b2.h b3.h maketilo
diff --git a/tilo/crt0.S b/tilo/crt0.S
index 3e24a77f104b..82db19a666e3 100644
--- a/tilo/crt0.S
+++ b/tilo/crt0.S
@@ -23,11 +23,15 @@
 
 #define COPY	jmpl	%o7 + (copy - _start), %l7
 
+#ifdef SUPERTILO
+#define STACK_BASE 0xa00000
+#else
 #ifndef LARGETILO
 #define STACK_BASE 0x400000
 #else
 #define STACK_BASE 0x500000
 #endif
+#endif
 
 	.text
 	.global _start
diff --git a/tilo/maketilo.c b/tilo/maketilo.c
index 6bc2f767fcb6..bf088b91f149 100644
--- a/tilo/maketilo.c
+++ b/tilo/maketilo.c
@@ -33,8 +33,9 @@
 #include <string.h>
 #include "b.h"
 #include "b2.h"
+#include "b3.h"
 
-#define MAX_BOOT_LEN	0x400000
+#define MAX_BOOT_LEN	0x900000
 
 char output_buffer[MAX_BOOT_LEN];
 
@@ -162,7 +163,14 @@ int main (int argc, char **argv)
 		rootlen = 0;
 	}
 	
-	if (rootlen + sun4_size + 0x4000 + 0x10000 >= 0x330000 ||
+	if (rootlen + sun4_size + 0x4000 + 0x10000 >= 0x430000 ||
+	    rootlen + sun4c_size + 0x4000 + 0x10000 >= 0x430000 ||
+	    rootlen + sun4u_size + 0x4000 + 0x10000 >= 0x430000) {
+		printf("Images are super large. Will load on machines with at least 10M mapped by PROM only\n");
+
+		for (i=0; i<SUPER_BOOT_LEN; i++)
+			output_buffer[i] = super_boot_loader[i];
+	} else if (rootlen + sun4_size + 0x4000 + 0x10000 >= 0x330000 ||
 	    rootlen + sun4c_size + 0x4000 + 0x10000 >= 0x330000 ||
 	    rootlen + sun4u_size + 0x4000 + 0x10000 >= 0x330000) {
 		printf("Images are large. Will load on machines with at least 5M mapped by PROM only\n");
diff --git a/tilo/tilo.c b/tilo/tilo.c
index d9a749de6eea..afbd848d9814 100644
--- a/tilo/tilo.c
+++ b/tilo/tilo.c
@@ -24,11 +24,15 @@
 #define NULL (void *)0
 #endif
 
+#ifdef SUPERTILO
+#define MOVED_BASE 0x9c0000
+#else
 #ifndef LARGETILO
 #define MOVED_BASE 0x3c0000
 #else
 #define MOVED_BASE 0x4c0000
 #endif
+#endif
 
 /*
  * gzip declarations
-- 
1.8.5.1

