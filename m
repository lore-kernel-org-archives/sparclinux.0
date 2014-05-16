From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:43 +0000
Subject: [PATCH 05/34] sparc32: fix sparse warning in auxio_32.c
Message-Id: <1400275572-17424-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
auxio_32.c:133:33: warning: cast removes address space of expression

To fix this auxio_power_register had to be defined as u8 _iomem.
Use proper sbus operations on the pointer.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/auxio_32.h | 2 +-
 arch/sparc/kernel/auxio_32.c      | 6 +++---
 arch/sparc/kernel/process_32.c    | 8 ++++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/auxio_32.h b/arch/sparc/include/asm/auxio_32.h
index 3a31977..b816660 100644
--- a/arch/sparc/include/asm/auxio_32.h
+++ b/arch/sparc/include/asm/auxio_32.h
@@ -78,7 +78,7 @@ do { \
 
 
 /* AUXIO2 (Power Off Control) */
-extern __volatile__ unsigned char * auxio_power_register;
+extern volatile u8 __iomem *auxio_power_register;
 
 #define	AUXIO_POWER_DETECT_FAILURE	32
 #define	AUXIO_POWER_CLEAR_FAILURE	2
diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index c6fc1d4..ae88c22 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -106,7 +106,7 @@ EXPORT_SYMBOL(set_auxio);
 
 /* sun4m power control register (AUXIO2) */
 
-volatile unsigned char * auxio_power_register = NULL;
+volatile u8 __iomem *auxio_power_register = NULL;
 
 void __init auxio_power_probe(void)
 {
@@ -130,8 +130,8 @@ void __init auxio_power_probe(void)
 	r.flags = regs.which_io & 0xF;
 	r.start = regs.phys_addr;
 	r.end = regs.phys_addr + regs.reg_size - 1;
-	auxio_power_register = (unsigned char *) of_ioremap(&r, 0,
-	    regs.reg_size, "auxpower");
+	auxio_power_register +		(u8 __iomem *)of_ioremap(&r, 0, regs.reg_size, "auxpower");
 
 	/* Display a quick message on the console. */
 	if (auxio_power_register)
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 61f810b..50e7b62 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -106,8 +106,12 @@ void machine_restart(char * cmd)
 void machine_power_off(void)
 {
 	if (auxio_power_register &&
-	    (strcmp(of_console_device->type, "serial") || scons_pwroff))
-		*auxio_power_register |= AUXIO_POWER_OFF;
+	    (strcmp(of_console_device->type, "serial") || scons_pwroff)) {
+		u8 power_register = sbus_readb(auxio_power_register);
+		power_register |= AUXIO_POWER_OFF;
+		sbus_writeb(power_register, auxio_power_register);
+	}
+
 	machine_halt();
 }
 
-- 
1.9.0

