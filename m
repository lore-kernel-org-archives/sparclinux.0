From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 23 Dec 2015 18:55:33 +0000
Subject: [PATCH] tty/serial: Skip 'NULL' char after console break when sysrq enabled
Message-Id: <1450896933-192269-1-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, gregkh@linuxfoundation.org, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, karl.volz@oracle.com
Cc: vijay.ac.kumar@oracle.com

When sysrq is triggered from console, serial driver for SUN hypervisor
console receives a console break and enables the sysrq. It expects a valid
sysrq char following with break. Meanwhile if driver receives 'NULL'
ASCII char then it disables sysrq and sysrq handler will never be invoked.

This fix skips calling uart sysrq handler when 'NULL' is received while
sysrq is enabled.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
Acked-by: Karl Volz <karl.volz@oracle.com>
---
 drivers/tty/serial/sunhv.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 0640318..163ae5d 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -148,8 +148,10 @@ static int receive_chars_read(struct uart_port *port)
 			uart_handle_dcd_change(port, 1);
 		}
 
-		for (i = 0; i < bytes_read; i++)
-			uart_handle_sysrq_char(port, con_read_page[i]);
+		if (port->sysrq != 0 &&  *con_read_page) {
+			for (i = 0; i < bytes_read; i++)
+				uart_handle_sysrq_char(port, con_read_page[i]);
+		}
 
 		if (port->state = NULL)
 			continue;
-- 
1.7.1

