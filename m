From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:58:05 +0000
Subject: [RFC 6/8] sparc: oplib: Remove prom_console_write_buf() definition
Message-Id: <4CF9BC4D.3020605@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove prom_console_write_buf() defs as they are not used anywhere
within the kernel tree.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---
 arch/sparc/include/asm/oplib_32.h |    3 ---
 arch/sparc/include/asm/oplib_64.h |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 9e5c640..24952ba 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -102,9 +102,6 @@ extern int prom_getrev(void);
 /* Get the prom firmware revision. */
 extern int prom_getprev(void);
 
-/* Write a buffer of characters to the console. */
-extern void prom_console_write_buf(const char *buf, int len);
-
 /* Prom's internal routines, don't use in kernel/boot code. */
 extern void prom_printf(const char *fmt, ...);
 extern void prom_write(const char *buf, unsigned int len);
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index 8cd0df3..37cf9f7 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -94,9 +94,6 @@ extern void prom_halt_power_off(void) __attribute__ ((noreturn));
  */
 extern unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
 
-/* Write a buffer of characters to the console. */
-extern void prom_console_write_buf(const char *buf, int len);
-
 /* Prom's internal routines, don't use in kernel/boot code. */
 extern void prom_printf(const char *fmt, ...);
 extern void prom_write(const char *buf, unsigned int len);
