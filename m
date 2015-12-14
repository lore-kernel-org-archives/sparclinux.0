From: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
Date: Mon, 14 Dec 2015 23:37:57 +0000
Subject: [PATCH] tty: serial: constify sunhv_ops structs
Message-Id: <20151214233757.GA5869@waves>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Constifies sunhv_ops structures in tty's serial
driver since they are not modified after their
initialization.

Detected and found using Coccinelle.

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
---
 drivers/tty/serial/sunhv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 0640318..f224e8a 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -168,17 +168,17 @@ struct sunhv_ops {
 	int (*receive_chars)(struct uart_port *port);
 };
 
-static struct sunhv_ops bychar_ops = {
+static const struct sunhv_ops bychar_ops = {
 	.transmit_chars = transmit_chars_putchar,
 	.receive_chars = receive_chars_getchar,
 };
 
-static struct sunhv_ops bywrite_ops = {
+static const struct sunhv_ops bywrite_ops = {
 	.transmit_chars = transmit_chars_write,
 	.receive_chars = receive_chars_read,
 };
 
-static struct sunhv_ops *sunhv_ops = &bychar_ops;
+static const struct sunhv_ops *sunhv_ops = &bychar_ops;
 
 static struct tty_port *receive_chars(struct uart_port *port)
 {
-- 
2.4.3


-- 
Kind Regards,
Aya Saif El-yazal Mahfouz
