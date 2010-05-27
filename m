From: David Miller <davem@davemloft.net>
Date: Thu, 27 May 2010 04:19:40 +0000
Subject: Re: question about drivers/serial/sunsu.c
Message-Id: <20100526.211940.200373719.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1003281737590.29824@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003281737590.29824@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Sat, 15 May 2010 10:15:17 +0200 (CEST)

> The following function in drivers/serial/sunsu.c contains a possible use 
> after free:
 ...
> Is it safe to simply move the if (up->port.membase) of_iounmap(...); up 
> above the other ifs, or should something else be done?

No, that isn't safe.  We have to unregister the device from the SERIO
layer before we do that.

Practically speaking, these remove methods never really ever execute
on sparc64 since 1) sunsu is usually built statically so we can get
a console and 2) hotplug of these devices is basically a non-occurance
as well.

Anyways, I'm going to fix this bug as follows, thanks for spotting it!

--------------------
sunsu: Fix use after free in su_remove().

Real serial port 'up' objects are statically allocated from an
array in the driver.  Keyboard and mouse ports, on the other
hand, are dynamically allocated.

Unfortunately, we free these dynamic 'up' objects before we unmap the
I/O registers.

Rearrange su_remove() so that this does not happen.

Noticed by Julia Lawall.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/sunsu.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index 234459c..ffbf455 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1500,20 +1500,25 @@ out_unmap:
 static int __devexit su_remove(struct of_device *op)
 {
 	struct uart_sunsu_port *up = dev_get_drvdata(&op->dev);
+	bool kbdms = false;
 
 	if (up->su_type = SU_PORT_MS ||
-	    up->su_type = SU_PORT_KBD) {
+	    up->su_type = SU_PORT_KBD)
+		kbdms = true;
+
+	if (kbdms) {
 #ifdef CONFIG_SERIO
 		serio_unregister_port(&up->serio);
 #endif
-		kfree(up);
-	} else if (up->port.type != PORT_UNKNOWN) {
+	} else if (up->port.type != PORT_UNKNOWN)
 		uart_remove_one_port(&sunsu_reg, &up->port);
-	}
 
 	if (up->port.membase)
 		of_iounmap(&op->resource[0], up->port.membase, up->reg_size);
 
+	if (kbdms)
+		kfree(up);
+
 	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
-- 
1.7.0.4

