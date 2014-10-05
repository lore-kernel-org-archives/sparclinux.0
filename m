From: Fabian Frederick <fabf@skynet.be>
Date: Sun, 05 Oct 2014 17:01:09 +0000
Subject: [PATCH 08/13 linux-next] serial: sunsu: use container_of to resolve uart_sunsu_port from uart_port
Message-Id: <1412528475-1449-9-git-send-email-fabf@skynet.be>
List-Id: <sparclinux.vger.kernel.org>
References: <1412528475-1449-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1412528475-1449-1-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, "David S. Miller" <davem@davemloft.net>, Jiri Slaby <jslaby@suse.cz>, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org

Use container_of instead of casting first structure member.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/tty/serial/sunsu.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 5326ae1..be010f8 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -264,7 +264,8 @@ static inline void __stop_tx(struct uart_sunsu_port *p)
 
 static void sunsu_stop_tx(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 
 	__stop_tx(up);
 
@@ -279,7 +280,8 @@ static void sunsu_stop_tx(struct uart_port *port)
 
 static void sunsu_start_tx(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 
 	if (!(up->ier & UART_IER_THRI)) {
 		up->ier |= UART_IER_THRI;
@@ -297,7 +299,8 @@ static void sunsu_start_tx(struct uart_port *port)
 
 static void sunsu_stop_rx(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 
 	up->ier &= ~UART_IER_RLSI;
 	up->port.read_status_mask &= ~UART_LSR_DR;
@@ -306,7 +309,8 @@ static void sunsu_stop_rx(struct uart_port *port)
 
 static void sunsu_enable_ms(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
@@ -543,7 +547,8 @@ static irqreturn_t sunsu_kbd_ms_interrupt(int irq, void *dev_id)
 
 static unsigned int sunsu_tx_empty(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned long flags;
 	unsigned int ret;
 
@@ -556,7 +561,8 @@ static unsigned int sunsu_tx_empty(struct uart_port *port)
 
 static unsigned int sunsu_get_mctrl(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned char status;
 	unsigned int ret;
 
@@ -576,7 +582,8 @@ static unsigned int sunsu_get_mctrl(struct uart_port *port)
 
 static void sunsu_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned char mcr = 0;
 
 	if (mctrl & TIOCM_RTS)
@@ -595,7 +602,8 @@ static void sunsu_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void sunsu_break_ctl(struct uart_port *port, int break_state)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
@@ -609,7 +617,8 @@ static void sunsu_break_ctl(struct uart_port *port, int break_state)
 
 static int sunsu_startup(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned long flags;
 	int retval;
 
@@ -719,7 +728,8 @@ static int sunsu_startup(struct uart_port *port)
 
 static void sunsu_shutdown(struct uart_port *port)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned long flags;
 
 	/*
@@ -767,7 +777,8 @@ static void
 sunsu_change_speed(struct uart_port *port, unsigned int cflag,
 		   unsigned int iflag, unsigned int quot)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
 
@@ -918,7 +929,8 @@ static int sunsu_request_port(struct uart_port *port)
 
 static void sunsu_config_port(struct uart_port *port, int flags)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 
 	if (flags & UART_CONFIG_TYPE) {
 		/*
@@ -1277,7 +1289,8 @@ static __inline__ void wait_for_xmitr(struct uart_sunsu_port *up)
 
 static void sunsu_console_putchar(struct uart_port *port, int ch)
 {
-	struct uart_sunsu_port *up = (struct uart_sunsu_port *)port;
+	struct uart_sunsu_port *up +		container_of(port, struct uart_sunsu_port, port);
 
 	wait_for_xmitr(up);
 	serial_out(up, UART_TX, ch);
-- 
1.9.1

