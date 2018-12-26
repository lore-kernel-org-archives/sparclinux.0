From: Sasha Levin <sashal@kernel.org>
Date: Wed, 26 Dec 2018 22:57:40 +0000
Subject: [PATCH AUTOSEL 3.18 12/12] serial/sunsu: fix refcount leak
Message-Id: <20181226225741.151608-12-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181226225741.151608-1-sashal@kernel.org>
In-Reply-To: <20181226225741.151608-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yangtao Li <tiny.windzz@gmail.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit d430aff8cd0c57502d873909c184e3b5753f8b88 ]

The function of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.

su_get_type() doesn't do that. The match node are used as an identifier
to compare against the current node, so we can directly drop the refcount
after getting the node from the path as it is not used as pointer.

Fix this by use a single variable and drop the refcount right after
of_find_node_by_path().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sunsu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 5326ae195e5f..298c11556850 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1380,22 +1380,43 @@ static inline struct console *SUNSU_CONSOLE(void)
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
2.19.1
