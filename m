From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2006 23:41:52 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <20060717.164152.66061233.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2006 15:52:55 -0700 (PDT)

> I hooked up a serial console line to my ultra60 and will try
> to work this out.  I think the problem is not related to
> interrupts this time.

Ok, your patch was only half-correct. :-) This patch below, which goes
on top of your's, fixes things up and also fixes a problem with the
uart table sizing in this driver.

I was able to boot up to full multi-user with full serial
console on my ultra60 after these changes.

Let me know how it goes for you.

Thanks.

diff-tree f26a75da243428fdeb1e9b2e57cd713a5cdb53a8 (from e25b839bd81dd04df8c5d3f4713c66703a13cc14)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Jul 17 16:40:26 2006 -0700

    [SERIAL] sunsab: Get line numbers and table sizing correct.
    
    Table sizing code should look for "se" not "su" nodes.
    
    The chip at the lower address should get the first index.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index cb55d81..dc673e1 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -1047,12 +1047,13 @@ static int __devinit sab_probe(struct of
 	up = &sunsab_ports[inst * 2];
 
 	err = sunsab_init_one(&up[0], op,
-			      sizeof(union sab82532_async_regs),
+			      0,
 			      (inst * 2) + 0);
 	if (err)
 		return err;
 
-	err = sunsab_init_one(&up[1], op, 0,
+	err = sunsab_init_one(&up[1], op,
+			      sizeof(union sab82532_async_regs),
 			      (inst * 2) + 1);
 	if (err) {
 		of_iounmap(up[0].port.membase,
@@ -1061,8 +1062,8 @@ static int __devinit sab_probe(struct of
 		return err;
 	}
 
-	uart_add_one_port(&sunsab_reg, &up[1].port);
 	uart_add_one_port(&sunsab_reg, &up[0].port);
+	uart_add_one_port(&sunsab_reg, &up[1].port);
 
 	dev_set_drvdata(&op->dev, &up[0]);
 
@@ -1117,7 +1118,7 @@ static int __init sunsab_init(void)
 	int err;
 
 	num_channels = 0;
-	for_each_node_by_name(dp, "su")
+	for_each_node_by_name(dp, "se")
 		num_channels += 2;
 	for_each_node_by_name(dp, "serial") {
 		if (of_device_is_compatible(dp, "sab82532"))
