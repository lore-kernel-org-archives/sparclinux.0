From: Rob Herring <robh@kernel.org>
Date: Wed, 05 Dec 2018 19:50:43 +0000
Subject: [PATCH] tty: Use of_node_name_{eq,prefix} for node name comparisons
Message-Id: <20181205195050.4759-27-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For hvc, the code can also be simplified by using of_stdout pointer
instead of searching again for the stdout node.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-serial@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/hvc/hvc_opal.c      |  2 +-
 drivers/tty/hvc/hvc_vio.c       | 11 +----------
 drivers/tty/serial/pmac_zilog.c |  4 ++--
 drivers/tty/serial/suncore.c    |  8 ++++----
 drivers/tty/serial/sunsu.c      |  4 ++--
 5 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 77baf895108f..c66412566efc 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -353,7 +353,7 @@ void __init hvc_opal_init_early(void)
 		if (!opal)
 			return;
 		for_each_child_of_node(opal, np) {
-			if (!strcmp(np->name, "serial")) {
+			if (of_node_name_eq(np, "serial")) {
 				stdout_node = np;
 				break;
 			}
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 59eaa620bf13..6de6d4a1a221 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -371,20 +371,11 @@ device_initcall(hvc_vio_init); /* after drivers/tty/hvc/hvc_console.c */
 void __init hvc_vio_init_early(void)
 {
 	const __be32 *termno;
-	const char *name;
 	const struct hv_ops *ops;
 
 	/* find the boot console from /chosen/stdout */
-	if (!of_stdout)
-		return;
-	name = of_get_property(of_stdout, "name", NULL);
-	if (!name) {
-		printk(KERN_WARNING "stdout node missing 'name' property!\n");
-		return;
-	}
-
 	/* Check if it's a virtual terminal */
-	if (strncmp(name, "vty", 3) != 0)
+	if (!of_node_name_prefix(of_stdout, "vty"))
 		return;
 	termno = of_get_property(of_stdout, "reg", NULL);
 	if (termno = NULL)
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index a9d40988e1c8..bcb5bf70534e 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1648,9 +1648,9 @@ static int __init pmz_probe(void)
 		 */
 		node_a = node_b = NULL;
 		for (np = NULL; (np = of_get_next_child(node_p, np)) != NULL;) {
-			if (strncmp(np->name, "ch-a", 4) = 0)
+			if (of_node_name_prefix(np, "ch-a"))
 				node_a = of_node_get(np);
-			else if (strncmp(np->name, "ch-b", 4) = 0)
+			else if (of_node_name_prefix(np, "ch-b"))
 				node_b = of_node_get(np);
 		}
 		if (!node_a && !node_b) {
diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 70a4ea4eaa6e..661e8b151366 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -89,14 +89,14 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 	int baud, bits, stop, cflag;
 	char parity;
 
-	if (!strcmp(uart_dp->name, "rsc") ||
-	    !strcmp(uart_dp->name, "rsc-console") ||
-	    !strcmp(uart_dp->name, "rsc-control")) {
+	if (of_node_name_eq(uart_dp, "rsc") ||
+	    of_node_name_eq(uart_dp, "rsc-console") ||
+	    of_node_name_eq(uart_dp, "rsc-control")) {
 		mode = of_get_property(uart_dp,
 				       "ssp-console-modes", NULL);
 		if (!mode)
 			mode = "115200,8,n,1,-";
-	} else if (!strcmp(uart_dp->name, "lom-console")) {
+	} else if (of_node_name_eq(uart_dp, "lom-console")) {
 		mode = "9600,8,n,1,-";
 	} else {
 		struct device_node *dp;
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6cf3e9b0728f..8ed60ccd45fb 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1482,8 +1482,8 @@ static int su_probe(struct platform_device *op)
 	up->port.ops = &sunsu_pops;
 
 	ignore_line = false;
-	if (!strcmp(dp->name, "rsc-console") ||
-	    !strcmp(dp->name, "lom-console"))
+	if (of_node_name_eq(dp, "rsc-console") ||
+	    of_node_name_eq(dp, "lom-console"))
 		ignore_line = true;
 
 	sunserial_console_match(SUNSU_CONSOLE(), dp,
-- 
2.19.1
