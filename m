From: David Miller <davem@davemloft.net>
Date: Fri, 03 Dec 2010 18:41:01 +0000
Subject: [PATCH 6/9] sparc: Do not export prom_nb{get,put}char().
Message-Id: <20101203.104101.68123711.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Never used outside of console_{32,64}.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/oplib_32.h |    6 ------
 arch/sparc/include/asm/oplib_64.h |    6 ------
 arch/sparc/prom/console_32.c      |    6 ++----
 arch/sparc/prom/console_64.c      |    6 ++----
 4 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 1d893fa..49fe426 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -104,12 +104,6 @@ extern int prom_getprev(void);
 
 /* Character operations to/from the console.... */
 
-/* Non-blocking get character from console. */
-extern int prom_nbgetchar(void);
-
-/* Non-blocking put character to console. */
-extern int prom_nbputchar(char character);
-
 /* Blocking get character from console. */
 extern char prom_getchar(void);
 
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index 56985e3..d541de4 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -96,12 +96,6 @@ extern unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
 
 /* Character operations to/from the console.... */
 
-/* Non-blocking get character from console. */
-extern int prom_nbgetchar(void);
-
-/* Non-blocking put character to console. */
-extern int prom_nbputchar(char character);
-
 /* Blocking get character from console. */
 extern char prom_getchar(void);
 
diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
index 5340264..2ce5acb 100644
--- a/arch/sparc/prom/console_32.c
+++ b/arch/sparc/prom/console_32.c
@@ -19,8 +19,7 @@ extern void restore_current(void);
 /* Non blocking get character from console input device, returns -1
  * if no input was taken.  This can be used for polling.
  */
-int
-prom_nbgetchar(void)
+static int prom_nbgetchar(void)
 {
 	static char inc;
 	int i = -1;
@@ -51,8 +50,7 @@ prom_nbgetchar(void)
 /* Non blocking put character to console device, returns -1 if
  * unsuccessful.
  */
-int
-prom_nbputchar(char c)
+static int prom_nbputchar(char c)
 {
 	static char outc;
 	unsigned long flags;
diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index de67fc7..33a8b27 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -18,8 +18,7 @@ extern int prom_stdin, prom_stdout;
 /* Non blocking get character from console input device, returns -1
  * if no input was taken.  This can be used for polling.
  */
-inline int
-prom_nbgetchar(void)
+static int prom_nbgetchar(void)
 {
 	unsigned long args[7];
 	char inc;
@@ -42,8 +41,7 @@ prom_nbgetchar(void)
 /* Non blocking put character to console device, returns -1 if
  * unsuccessful.
  */
-inline int
-prom_nbputchar(char c)
+static int prom_nbputchar(char c)
 {
 	unsigned long args[7];
 	char outc;
-- 
1.7.3.2

