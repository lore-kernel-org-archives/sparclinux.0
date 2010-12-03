From: David Miller <davem@davemloft.net>
Date: Fri, 03 Dec 2010 18:41:08 +0000
Subject: [PATCH 8/9] sparc: Delete prom_*getchar().
Message-Id: <20101203.104108.191411805.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Completely unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/oplib_32.h |    5 ----
 arch/sparc/include/asm/oplib_64.h |    5 ----
 arch/sparc/prom/console_32.c      |   41 -------------------------------------
 arch/sparc/prom/console_64.c      |   32 ----------------------------
 4 files changed, 0 insertions(+), 83 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 4c25392..40bc9ef 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -102,11 +102,6 @@ extern int prom_getrev(void);
 /* Get the prom firmware revision. */
 extern int prom_getprev(void);
 
-/* Character operations to/from the console.... */
-
-/* Blocking get character from console. */
-extern void prom_getchar(char *buf);
-
 /* Blocking put character to console. */
 extern void prom_putchar(const char *buf);
 
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index 384e558..d461373 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -94,11 +94,6 @@ extern void prom_halt_power_off(void) __attribute__ ((noreturn));
  */
 extern unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
 
-/* Character operations to/from the console.... */
-
-/* Blocking get character from console. */
-extern void prom_getchar(char *buf);
-
 /* Blocking put character to console. */
 extern void prom_putchar(const char *buf);
 
diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
index 69c16bb..157019e 100644
--- a/arch/sparc/prom/console_32.c
+++ b/arch/sparc/prom/console_32.c
@@ -16,37 +16,6 @@
 
 extern void restore_current(void);
 
-/* Non blocking get character from console input device, returns -1
- * if no input was taken.  This can be used for polling.
- */
-static int prom_nbgetchar(char *buf)
-{
-	unsigned long flags;
-	int i = -1;
-
-	spin_lock_irqsave(&prom_lock, flags);
-	switch(prom_vers) {
-	case PROM_V0:
-		i = (*(romvec->pv_nbgetchar))();
-		if (i != -1) {
-			*buf = i;
-			i = 0;
-		}
-		break;
-	case PROM_V2:
-	case PROM_V3:
-		if ((*(romvec->pv_v2devops).v2_dev_read)(*romvec->pv_v2bootargs.fd_stdin,
-							 buf, 0x1) = 1)
-			i = 0;
-		break;
-	default:
-		break;
-	};
-	restore_current();
-	spin_unlock_irqrestore(&prom_lock, flags);
-	return i; /* Ugh, we could spin forever on unsupported proms ;( */
-}
-
 /* Non blocking put character to console device, returns -1 if
  * unsuccessful.
  */
@@ -74,16 +43,6 @@ static int prom_nbputchar(const char *buf)
 	return i; /* Ugh, we could spin forever on unsupported proms ;( */
 }
 
-/* Blocking version of get character routine above. */
-void prom_getchar(char *buf)
-{
-	while (1) {
-		int err = prom_nbgetchar(buf);
-		if (!err)
-			break;
-	}
-}
-
 /* Blocking version of put character routine above. */
 void prom_putchar(const char *buf)
 {
diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index a9a5754..0da88d1 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -15,28 +15,6 @@
 
 extern int prom_stdin, prom_stdout;
 
-/* Non blocking get character from console input device, returns -1
- * if no input was taken.  This can be used for polling.
- */
-static int prom_nbgetchar(char *buf)
-{
-	unsigned long args[7];
-
-	args[0] = (unsigned long) "read";
-	args[1] = 3;
-	args[2] = 1;
-	args[3] = (unsigned int) prom_stdin;
-	args[4] = (unsigned long) buf;
-	args[5] = 1;
-	args[6] = (unsigned long) -1;
-
-	p1275_cmd_direct(args);
-
-	if (args[6] = 1)
-		return 0;
-	return -1;
-}
-
 /* Non blocking put character to console device, returns -1 if
  * unsuccessful.
  */
@@ -60,16 +38,6 @@ static int prom_nbputchar(const char *buf)
 		return -1;
 }
 
-/* Blocking version of get character routine above. */
-void prom_getchar(char *buf)
-{
-	while (1) {
-		int err = prom_nbgetchar(buf);
-		if (!err)
-			break;
-	}
-}
-
 /* Blocking version of put character routine above. */
 void prom_putchar(const char *buf)
 {
-- 
1.7.3.2

