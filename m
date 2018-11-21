From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 21 Nov 2018 15:22:54 +0000
Subject: [PATCH] drivers/tty: add missing of_node_put()
Message-Id: <20181121152254.23480-1-tiny.windzz@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place is not doing this, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/tty/serial/suncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 70a4ea4eaa6e..990376576970 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -112,6 +112,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
+		of_node_put(dp);
 	}
 
 	cflag = CREAD | HUPCL | CLOCAL;
-- 
2.17.0
