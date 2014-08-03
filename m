From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 03 Aug 2014 13:44:52 +0000
Subject: [PATCH] bbc-i2c: Fix BBC I2C envctrl on SunBlade 2000
Message-Id: <201408031544.52481.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

Fix regression in bbc i2c temperature and fan control on some Sun systems
that causes the driver to refuse to load due to the bbc_i2c_bussel resource not
being present on the (second) i2c bus where the temperature sensors and fan
control are located. (The check for the number of resources was removed when
the driver was ported to a pure OF driver in mid 2008.)

Patch applies to 3.16-rc6.

Signed-off-by: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

---

diff -Naupr linux-3.16-rc6-orig/drivers/sbus/char/bbc_envctrl.c linux-3.16-rc6-patched/drivers/sbus/char/bbc_envctrl.c
--- linux-3.16-rc6-orig/drivers/sbus/char/bbc_envctrl.c	2014-07-27 11:49:21.000000000 +0200
+++ linux-3.16-rc6-patched/drivers/sbus/char/bbc_envctrl.c	2014-08-03 15:21:17.000000000 +0200
@@ -452,6 +452,9 @@ static void attach_one_temp(struct bbc_i
 	if (!tp)
 		return;
 
+	INIT_LIST_HEAD(&tp->bp_list);
+	INIT_LIST_HEAD(&tp->glob_list);
+
 	tp->client = bbc_i2c_attach(bp, op);
 	if (!tp->client) {
 		kfree(tp);
@@ -497,6 +500,9 @@ static void attach_one_fan(struct bbc_i2
 	if (!fp)
 		return;
 
+	INIT_LIST_HEAD(&fp->bp_list);
+	INIT_LIST_HEAD(&fp->glob_list);
+
 	fp->client = bbc_i2c_attach(bp, op);
 	if (!fp->client) {
 		kfree(fp);
diff -Naupr linux-3.16-rc6-orig/drivers/sbus/char/bbc_i2c.c linux-3.16-rc6-patched/drivers/sbus/char/bbc_i2c.c
--- linux-3.16-rc6-orig/drivers/sbus/char/bbc_i2c.c	2014-07-27 11:49:45.000000000 +0200
+++ linux-3.16-rc6-patched/drivers/sbus/char/bbc_i2c.c	2014-08-03 15:21:08.000000000 +0200
@@ -300,13 +300,18 @@ static struct bbc_i2c_bus * attach_one_i
 	if (!bp)
 		return NULL;
 
+	INIT_LIST_HEAD(&bp->temps);
+	INIT_LIST_HEAD(&bp->fans);
+
 	bp->i2c_control_regs = of_ioremap(&op->resource[0], 0, 0x2, "bbc_i2c_regs");
 	if (!bp->i2c_control_regs)
 		goto fail;
 
-	bp->i2c_bussel_reg = of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bussel");
-	if (!bp->i2c_bussel_reg)
-		goto fail;
+	if (op->num_resources = 2) {
+		bp->i2c_bussel_reg = of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bussel");
+		if (!bp->i2c_bussel_reg)
+			goto fail;
+	}
 
 	bp->waiting = 0;
 	init_waitqueue_head(&bp->wq);
