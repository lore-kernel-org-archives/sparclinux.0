From: Matt Turner <mattst88@gmail.com>
Date: Sat, 23 May 2020 20:22:30 +0000
Subject: [PATCH 2/5] silo: Build with -U_FORTIFY_SOURCE
Message-Id: <20200523202233.3063074-2-mattst88@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Otherwise the build will fail:

| ld: decompnet.o: in function `error':
| decomp.c:(.text+0x4dc): undefined reference to `__longjmp_chk'

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 Rules.make | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Rules.make b/Rules.make
index 3d0efe7..9739f7a 100644
--- a/Rules.make
+++ b/Rules.make
@@ -19,7 +19,8 @@ cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
 		> /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
 
 CFLAGS = -Os -Wall -I. -I../include -fomit-frame-pointer \
-	-fno-strict-aliasing -fno-PIC -DSMALL_RELOC=$(SMALL_RELOC) \
+	-fno-strict-aliasing -fno-PIC -U_FORTIFY_SOURCE \
+	-DSMALL_RELOC=$(SMALL_RELOC) \
 	-DLARGE_RELOC=$(LARGE_RELOC)
 HOSTCFLAGS = -O2 -Wall
 
-- 
2.26.2
