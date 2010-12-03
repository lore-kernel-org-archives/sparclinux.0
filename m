From: David Miller <davem@davemloft.net>
Date: Fri, 03 Dec 2010 18:40:58 +0000
Subject: [PATCH 5/9] sparc64: Delete prom_setcallback().
Message-Id: <20101203.104058.02265791.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/oplib_64.h |    8 --------
 arch/sparc/prom/misc_64.c         |   14 --------------
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index daf02d3..56985e3 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -88,14 +88,6 @@ extern void prom_halt(void) __attribute__ ((noreturn));
 /* Halt and power-off the machine. */
 extern void prom_halt_power_off(void) __attribute__ ((noreturn));
 
-/* Set the PROM 'sync' callback function to the passed function pointer.
- * When the user gives the 'sync' command at the prom prompt while the
- * kernel is still active, the prom will call this routine.
- *
- */
-typedef int (*callback_func_t)(long *cmd);
-extern void prom_setcallback(callback_func_t func_ptr);
-
 /* Acquire the IDPROM of the root node in the prom device tree.  This
  * gets passed a buffer where you would like it stuffed.  The return value
  * is the format type of this idprom or 0xff on error.
diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index b900fdf..e4f31d4 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -150,20 +150,6 @@ void prom_halt_power_off(void)
 	prom_halt();
 }
 
-/* Set prom sync handler to call function 'funcp'. */
-void prom_setcallback(callback_func_t funcp)
-{
-	unsigned long args[5];
-	if (!funcp)
-		return;
-	args[0] = (unsigned long) "set-callback";
-	args[1] = 1;
-	args[2] = 1;
-	args[3] = (unsigned long) funcp;
-	args[4] = (unsigned long) -1;
-	p1275_cmd_direct(args);
-}
-
 /* Get the idprom and stuff it into buffer 'idbuf'.  Returns the
  * format type.  'num_bytes' is the number of bytes that your idbuf
  * has space for.  Returns 0xff on error.
-- 
1.7.3.2

