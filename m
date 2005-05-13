From: domen@coderock.org
Date: Fri, 13 May 2005 22:22:51 +0000
Subject: [patch 1/1] min/max : drivers/sbus/char/aurora.c
Message-Id: <20050513222250.340315000@nd47.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>



min/max macros from kernel.h are safe, a lot of handcrafted MIN/MAX are
not.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>


---
 aurora.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

Index: quilt/drivers/sbus/char/aurora.c
=================================--- quilt.orig/drivers/sbus/char/aurora.c
+++ quilt/drivers/sbus/char/aurora.c
@@ -81,10 +81,6 @@ unsigned char irqs[4] = {
 int irqhit=0;
 #endif
 
-#ifndef MIN
-#define MIN(a,b) ((a) < (b) ? (a) : (b))
-#endif
-
 static struct tty_driver *aurora_driver;
 static struct Aurora_board aurora_board[AURORA_NBOARD] = {
 	{0,},
@@ -594,7 +590,7 @@ static void aurora_transmit(struct Auror
 					    &bp->r[chip]->r[CD180_TDR]);
 				port->COR2 &= ~COR2_ETC;
 			}
-			count = MIN(port->break_length, 0xff);
+			count = min(port->break_length, 0xff);
 			sbus_writeb(CD180_C_ESC,
 				    &bp->r[chip]->r[CD180_TDR]);
 			sbus_writeb(CD180_C_DELAY,
@@ -1573,7 +1569,7 @@ static int aurora_write(struct tty_struc
 	save_flags(flags);
 	while (1) {
 		cli();
-		c = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+		c = min(count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 				   SERIAL_XMIT_SIZE - port->xmit_head));
 		if (c <= 0) {
 			restore_flags(flags);

--
