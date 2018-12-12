From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 12 Dec 2018 16:01:45 +0000
Subject: [PATCH] serial/sunsu: fix refcount leak
Message-Id: <20181212160145.23117-1-tiny.windzz@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org
Cc: daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>

The function of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.

su_get_type() doesn't do that. The match node are used as an identifier
to compare against the current node, so we can directly drop the refcount
after getting the node from the path as it is not used as pointer.

Fix this by use a single variable and drop the refcount right after
of_find_node_by_path().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/tty/serial/sunsu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6cf3e9b0728f..c5428b0426a9 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1394,22 +1394,43 @@ static inline struct console *SUNSU_CONSOLE(void)
 static enum su_type su_get_type(struct device_node *dp)
 {
 	struct device_node *ap = of_find_node_by_path("/aliases");
+	enum su_type rc = SU_PORT_PORT;
 
 	if (ap) {
 		const char *keyb = of_get_property(ap, "keyboard", NULL);
 		const char *ms = of_get_property(ap, "mouse", NULL);
+		struct device_node *match;
 
 		if (keyb) {
-			if (dp = of_find_node_by_path(keyb))
-				return SU_PORT_KBD;
+			match = of_find_node_by_path(keyb);
+
+			/*
+			 * The pointer is used as an identifier not
+			 * as a pointer, we can drop the refcount on
+			 * the of__node immediately after getting it.
+			 */
+			of_node_put(match);
+
+			if (dp = match) {
+				rc = SU_PORT_KBD;
+				goto out;
+			}
 		}
 		if (ms) {
-			if (dp = of_find_node_by_path(ms))
-				return SU_PORT_MS;
+			match = of_find_node_by_path(ms);
+
+			of_node_put(match);
+
+			if (dp = match) {
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
