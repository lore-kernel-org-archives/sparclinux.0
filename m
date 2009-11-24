From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:38 +0000
Subject: [PATCH 6/7]: sunsu: Pass true 'ignore_line' to console match when
Message-Id: <20091124.142138.85245096.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/sunsu.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index 4868b31..4ee4167 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1409,6 +1409,7 @@ static int __devinit su_probe(struct of_device *op, const struct of_device_id *m
 	struct uart_sunsu_port *up;
 	struct resource *rp;
 	enum su_type type;
+	bool ignore_line;
 	int err;
 
 	type = su_get_type(dp);
@@ -1467,9 +1468,14 @@ static int __devinit su_probe(struct of_device *op, const struct of_device_id *m
 
 	up->port.ops = &sunsu_pops;
 
+	ignore_line = false;
+	if (!strcmp(dp->name, "rsc-console") ||
+	    !strcmp(dp->name, "lom-console"))
+		ignore_line = true;
+
 	sunserial_console_match(SUNSU_CONSOLE(), dp,
 				&sunsu_reg, up->port.line,
-				false);
+				ignore_line);
 	err = uart_add_one_port(&sunsu_reg, &up->port);
 	if (err)
 		goto out_unmap;
-- 
1.6.5.3

