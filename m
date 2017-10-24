From: Kees Cook <keescook@chromium.org>
Date: Tue, 24 Oct 2017 10:00:10 +0000
Subject: [PATCH] tty: vcc: Convert timers to use timer_setup()
Message-Id: <20171024100010.GA67911@beast>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/vcc.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 954b190526e7..58b454c34560 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -361,17 +361,13 @@ static int vcc_ldc_read(struct vcc_port *port)
 	return rv;
 }
 
-static void vcc_rx_timer(unsigned long index)
+static void vcc_rx_timer(struct timer_list *t)
 {
+	struct vcc_port *port = from_timer(port, t, rx_timer);
 	struct vio_driver_state *vio;
-	struct vcc_port *port;
 	unsigned long flags;
 	int rv;
 
-	port = vcc_get_ne(index);
-	if (!port)
-		return;
-
 	spin_lock_irqsave(&port->lock, flags);
 	port->rx_timer.expires = 0;
 
@@ -391,18 +387,14 @@ static void vcc_rx_timer(unsigned long index)
 	vcc_put(port, false);
 }
 
-static void vcc_tx_timer(unsigned long index)
+static void vcc_tx_timer(struct timer_list *t)
 {
-	struct vcc_port *port;
+	struct vcc_port *port = from_timer(port, t, tx_timer);
 	struct vio_vcc *pkt;
 	unsigned long flags;
 	int tosend = 0;
 	int rv;
 
-	port = vcc_get_ne(index);
-	if (!port)
-		return;
-
 	spin_lock_irqsave(&port->lock, flags);
 	port->tx_timer.expires = 0;
 
@@ -645,8 +637,8 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	if (rv)
 		goto free_domain;
 
-	setup_timer(&port->rx_timer, vcc_rx_timer, port->index);
-	setup_timer(&port->tx_timer, vcc_tx_timer, port->index);
+	timer_setup(&port->rx_timer, vcc_rx_timer, 0);
+	timer_setup(&port->tx_timer, vcc_tx_timer, 0);
 
 	dev_set_drvdata(&vdev->dev, port);
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
