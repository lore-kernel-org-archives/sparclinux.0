From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 02 Sep 2014 21:39:17 +0000
Subject: [PATCH 08/26] serial: sunsab: Don't enable tx if tx stopped
Message-Id: <1409693975-1028-9-git-send-email-peter@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

The serial core may call the UART driver's start_tx() even if
tx is stopped; the UART driver must verify tx should be enabled
before transmitting.

Reported-by: Sam Ravnborg <sam@ravnborg.org>
cc: David S. Miller <davem@davemloft.net>
cc: <sparclinux@vger.kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/sunsab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index c83b1c6..448a93b 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -427,7 +427,7 @@ static void sunsab_start_tx(struct uart_port *port)
 	struct circ_buf *xmit = &up->port.state->xmit;
 	int i;
 
-	if (uart_circ_empty(xmit))
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return;
 
 	up->interrupt_mask1 &= ~(SAB82532_IMR1_ALLS|SAB82532_IMR1_XPR);
-- 
2.1.0

