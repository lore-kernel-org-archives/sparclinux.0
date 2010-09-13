From: Joe Perches <joe@perches.com>
Date: Mon, 13 Sep 2010 19:47:56 +0000
Subject: [PATCH 18/25] drivers/serial/suncore.c: Use static const char arrays
Message-Id: <0ab674aa32a5fcc364982c78efdf44864a61523b.1284406639.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1284406638.git.joe@perches.com>
In-Reply-To: <cover.1284406638.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/serial/suncore.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/suncore.c b/drivers/serial/suncore.c
index 6381a02..f2a5b54 100644
--- a/drivers/serial/suncore.c
+++ b/drivers/serial/suncore.c
@@ -84,8 +84,8 @@ EXPORT_SYMBOL(sunserial_console_match);
 
 void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 {
+	char mode_prop[sizeof("ttyX-mode")];
 	const char *mode, *s;
-	char mode_prop[] = "ttyX-mode";
 	int baud, bits, stop, cflag;
 	char parity;
 
@@ -106,7 +106,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 		if (of_console_options)
 			c = *of_console_options;
 
-		mode_prop[3] = c;
+		sprintf(mode_prop, "tty%c-mode", c);
 
 		dp = of_find_node_by_path("/options");
 		mode = of_get_property(dp, mode_prop, NULL);
-- 
1.7.3.rc1

