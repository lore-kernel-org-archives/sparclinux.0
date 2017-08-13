From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 13 Aug 2017 06:21:42 +0000
Subject: [PATCH 03/11] serial: sunsab: constify uart_ops structures
Message-Id: <1502605310-4314-4-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/tty/serial/sunsab.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index b5e3195..653a076 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -819,7 +819,7 @@ static int sunsab_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return -EINVAL;
 }
 
-static struct uart_ops sunsab_pops = {
+static const struct uart_ops sunsab_pops = {
 	.tx_empty	= sunsab_tx_empty,
 	.set_mctrl	= sunsab_set_mctrl,
 	.get_mctrl	= sunsab_get_mctrl,

