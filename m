From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Sep 2014 23:22:56 +0000
Subject: patch "serial: sunsab: Don't enable tx if tx stopped" added to tty tree
Message-Id: <14102185761755@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    serial: sunsab: Don't enable tx if tx stopped

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 98f8b83d6a504615f52a095acf92a2bdad985ae0 Mon Sep 17 00:00:00 2001
From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 2 Sep 2014 17:39:17 -0400
Subject: serial: sunsab: Don't enable tx if tx stopped

The serial core may call the UART driver's start_tx() even if
tx is stopped; the UART driver must verify tx should be enabled
before transmitting.

Reported-by: Sam Ravnborg <sam@ravnborg.org>
cc: David S. Miller <davem@davemloft.net>
cc: <sparclinux@vger.kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sunsab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 0af75f8b98a4..b339fe4811cd 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -436,7 +436,7 @@ static void sunsab_start_tx(struct uart_port *port)
 	struct circ_buf *xmit = &up->port.state->xmit;
 	int i;
 
-	if (uart_circ_empty(xmit))
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return;
 
 	up->interrupt_mask1 &= ~(SAB82532_IMR1_ALLS|SAB82532_IMR1_XPR);
-- 
2.1.0


