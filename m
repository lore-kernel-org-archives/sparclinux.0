From: Matt Turner <mattst88@gmail.com>
Date: Sat, 23 May 2020 20:22:29 +0000
Subject: [PATCH 1/5] silo: Build with -fno-PIC to reduce size
Message-Id: <20200523202233.3063074-1-mattst88@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Otherwise the resulting image will be too large:

| ./util second.map second.aout second2.aout second.b second.b2
| Distance between two changes larger than 63K 3 84553 0

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 Rules.make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Rules.make b/Rules.make
index 0f176db..3d0efe7 100644
--- a/Rules.make
+++ b/Rules.make
@@ -19,7 +19,7 @@ cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
 		> /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
 
 CFLAGS = -Os -Wall -I. -I../include -fomit-frame-pointer \
-	-fno-strict-aliasing -DSMALL_RELOC=$(SMALL_RELOC) \
+	-fno-strict-aliasing -fno-PIC -DSMALL_RELOC=$(SMALL_RELOC) \
 	-DLARGE_RELOC=$(LARGE_RELOC)
 HOSTCFLAGS = -O2 -Wall
 
-- 
2.26.2
