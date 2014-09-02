From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 02 Sep 2014 21:39:15 +0000
Subject: [PATCH 06/26] serial: Fix send_xchar() handlers
Message-Id: <1409693975-1028-7-git-send-email-peter@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

START_CHAR() & STOP_CHAR() can be disabled if set to '\0'
(__DISABLED_CHAR).  UART drivers which define a send_xchar()
handler must not transmit __DISABLED_CHAR.

Document requirement.

Affected drivers:
sunsab
sunhv

cc: David S. Miller <davem@davemloft.net>
cc: <sparclinux@vger.kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 Documentation/serial/driver | 2 ++
 drivers/tty/serial/sunhv.c  | 3 +++
 drivers/tty/serial/sunsab.c | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 3bba1ae..ba64e4b 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -140,6 +140,8 @@ hardware.
 	will append the character to the circular buffer and then call
 	start_tx() / stop_tx() to flush the data out.
 
+	Do not transmit if ch = '\0' (__DISABLED_CHAR).
+
 	Locking: none.
 	Interrupts: caller dependent.
 
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 20521db..25d43ce 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -268,6 +268,9 @@ static void sunhv_send_xchar(struct uart_port *port, char ch)
 	unsigned long flags;
 	int limit = 10000;
 
+	if (ch = __DISABLED_CHAR)
+		return;
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	while (limit-- > 0) {
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index bb09920..c83b1c6 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -459,6 +459,9 @@ static void sunsab_send_xchar(struct uart_port *port, char ch)
 	struct uart_sunsab_port *up = (struct uart_sunsab_port *) port;
 	unsigned long flags;
 
+	if (ch = __DISABLED_CHAR)
+		return;
+
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	sunsab_tec_wait(up);
-- 
2.1.0

