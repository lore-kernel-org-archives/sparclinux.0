From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 13 Aug 2017 06:21:43 +0000
Subject: [PATCH 04/11] serial: sunsu: constify uart_ops structures
Message-Id: <1502605310-4314-5-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/sunsu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 5380407..95d34d7 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -958,7 +958,7 @@ static void sunsu_config_port(struct uart_port *port, int flags)
 	return uart_config[type].name;
 }
 
-static struct uart_ops sunsu_pops = {
+static const struct uart_ops sunsu_pops = {
 	.tx_empty	= sunsu_tx_empty,
 	.set_mctrl	= sunsu_set_mctrl,
 	.get_mctrl	= sunsu_get_mctrl,

