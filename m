From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 21 Nov 2018 16:06:15 +0000
Subject: [PATCH] serial/sunsu: add missing of_node_put()
Message-Id: <20181121160615.23666-1-tiny.windzz@gmail.com>
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
 drivers/tty/serial/sunsu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6cf3e9b0728f..4a27c0114d50 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1394,22 +1394,32 @@ static inline struct console *SUNSU_CONSOLE(void)
 static enum su_type su_get_type(struct device_node *dp)
 {
 	struct device_node *ap = of_find_node_by_path("/aliases");
+	enum su_type rc = SU_PORT_PORT;
 
 	if (ap) {
+		struct device_node *tmp;
 		const char *keyb = of_get_property(ap, "keyboard", NULL);
 		const char *ms = of_get_property(ap, "mouse", NULL);
 
 		if (keyb) {
-			if (dp = of_find_node_by_path(keyb))
-				return SU_PORT_KBD;
+			tmp = of_find_node_by_path(keyb);
+			if (tmp && dp = tmp){
+				rc = SU_PORT_KBD;
+				goto out;
+			}
 		}
 		if (ms) {
-			if (dp = of_find_node_by_path(ms))
-				return SU_PORT_MS;
+			tmp = of_find_node_by_path(ms);
+			if (tmp && dp = tmp){
+				rc = SU_PORT_MS;
+				goto out;
+			}
 		}
 	}
 
-	return SU_PORT_PORT;
+out:
+	of_node_put(ap);
+	return rc;
 }
 
 static int su_probe(struct platform_device *op)
-- 
2.17.0
