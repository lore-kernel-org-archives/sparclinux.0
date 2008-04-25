From: Robert Reif <reif@earthlink.net>
Date: Fri, 25 Apr 2008 12:16:24 +0000
Subject: [PATCH] sparc: sunzilog.c remove unused argument
Message-Id: <4811CB98.7050702@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070109040407040508030308"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070109040407040508030308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove unused argument in function call.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------070109040407040508030308
Content-Type: text/plain;
 name="sunzilog.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sunzilog.diff.txt"

diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index 3271379..90a20a1 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1231,7 +1231,7 @@ #else
 #define SUNZILOG_CONSOLE()	(NULL)
 #endif
 
-static void __devinit sunzilog_init_kbdms(struct uart_sunzilog_port *up, int channel)
+static void __devinit sunzilog_init_kbdms(struct uart_sunzilog_port *up)
 {
 	int baud, brg;
 
@@ -1305,7 +1305,7 @@ static void __devinit sunzilog_init_hw(s
 		up->curregs[R7] = 0x7E; /* SDLC Flag    */
 		up->curregs[R9] = NV;
 		up->curregs[R7p] = 0x00;
-		sunzilog_init_kbdms(up, up->port.line);
+		sunzilog_init_kbdms(up);
 		/* Only enable interrupts if an ISR handler available */
 		if (up->flags & SUNZILOG_FLAG_ISR_HANDLER)
 			up->curregs[R9] |= MIE;

--------------070109040407040508030308--
