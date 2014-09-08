From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Sep 2014 23:22:56 +0000
Subject: patch "serial: Fix send_xchar() handlers" added to tty tree
Message-Id: <1410218576740@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    serial: Fix send_xchar() handlers

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From db106df32d679db151b48a09543b03ee41cb2580 Mon Sep 17 00:00:00 2001
From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 2 Sep 2014 17:39:15 -0400
Subject: serial: Fix send_xchar() handlers

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/serial/driver | 2 ++
 drivers/tty/serial/sunhv.c  | 3 +++
 drivers/tty/serial/sunsab.c | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 3bba1aeb799c..ba64e4b892e9 100644
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
index 20521db2189f..25d43ce8b318 100644
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
index b9598b227a45..0af75f8b98a4 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -468,6 +468,9 @@ static void sunsab_send_xchar(struct uart_port *port, char ch)
 	struct uart_sunsab_port *up = (struct uart_sunsab_port *) port;
 	unsigned long flags;
 
+	if (ch = __DISABLED_CHAR)
+		return;
+
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	sunsab_tec_wait(up);
-- 
2.1.0


