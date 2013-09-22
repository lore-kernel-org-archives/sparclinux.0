From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 22 Sep 2013 19:33:04 +0000
Subject: [PATCH 2/2] silo: compile host-side tools with HOSTCC
Message-Id: <1379878384-26476-3-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Compile host-side tools with HOSTCC/HOSTCFLAGS.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 Rules.make      | 2 ++
 common/Makefile | 3 +++
 second/Makefile | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Rules.make b/Rules.make
index 4e722f9..0f176db 100644
--- a/Rules.make
+++ b/Rules.make
@@ -4,6 +4,7 @@ SHELL=/bin/bash
 RM=rm -f
 # We want to force 32-bit builds
 CC=gcc -m32
+HOSTCC=gcc
 LD=ld -m elf32_sparc
 AS=as
 STRIP=strip
@@ -20,6 +21,7 @@ cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
 CFLAGS = -Os -Wall -I. -I../include -fomit-frame-pointer \
 	-fno-strict-aliasing -DSMALL_RELOC=$(SMALL_RELOC) \
 	-DLARGE_RELOC=$(LARGE_RELOC)
+HOSTCFLAGS = -O2 -Wall
 
 ifeq ($(call cc-option-yn, -fno-stack-protector),y)
 CFLAGS += -fno-stack-protector
diff --git a/common/Makefile b/common/Makefile
index f931af2..4c6f116 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -16,6 +16,9 @@ PROGRAMS = bin2h
 
 all: $(OBJS) $(PROGRAMS)
 
+bin2h: bin2h.c
+	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
+
 prom.o: prom.c
 	$(CC) $(CFLAGS) -c -Wa,-Av9 -o prom.o prom.c
 
diff --git a/second/Makefile b/second/Makefile
index 75f9c20..1b504f3 100644
--- a/second/Makefile
+++ b/second/Makefile
@@ -85,7 +85,7 @@ malloc.o: ../common/malloc.c
 	$(CC) $(CFLAGS) -c -o $@ $<
 
 util:	util.c
-	$(CC) -DSMALL_RELOC=$(SMALL_RELOC) -DLARGE_RELOC=$(LARGE_RELOC) -o $@ $<
+	$(HOSTCC) $(HOSTCFLAGS) -DSMALL_RELOC=$(SMALL_RELOC) -DLARGE_RELOC=$(LARGE_RELOC) -o $@ $<
 
 clean:
 	$(RM) *.o fs/*.o second* silotftp* util fs/libfs.a
-- 
1.8.4.rc3

