From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:24 +0000
Subject: [PATCH v2 02/11] tilo: compile maketilo with host toolchain
Message-Id: <1387827813-8279-3-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use HOSTCC to compile maketilo to enable cross-compilation.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tilo/Makefile b/tilo/Makefile
index 89b540fc27a9..800e65f02767 100644
--- a/tilo/Makefile
+++ b/tilo/Makefile
@@ -27,7 +27,7 @@ OBJS = crt0.o tilo.o $(OBJS_COMMON) malloc.o
 OBJS2 = crt0l.o tilol.o $(OBJS_COMMON) mallocl.o
 
 maketilo: maketilo.c b.h b2.h
-	$(CC) $(CFLAGS) maketilo.c -o maketilo
+	$(HOSTCC) $(HOSTCFLAGS) -g maketilo.c -o maketilo
 
 b.h : b.out $(BIN2H)
 	$(BIN2H) -l BOOT_LEN boot_loader $< > $@ || ($(RM) $@; exit 1)
-- 
1.8.5.1

