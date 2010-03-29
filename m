From: Julia Lawall <julia@diku.dk>
Date: Mon, 29 Mar 2010 09:39:53 +0000
Subject: [PATCH] drivers/serial/sunsu.c: Correct use after free
Message-Id: <Pine.LNX.4.64.1003291139250.21896@ask.diku.dk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

The of_iounmap is at the out_unmap label, but at that point up has already
been freed.  The free cannot be moved to the out_unmap label, because that
label is reachable from cases where up should not be freed.  So the call to
of_iounmap is just duplicated, and the goto converted to a return.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,e;
identifier f;
iterator I;
statement S;
@@

*kfree(x);
... when != &x
    when != x = e
    when != I(x,...) S
*x->f
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/serial/sunsu.c              |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index 170d3d6..cbcfb18 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1453,8 +1453,10 @@ static int __devinit su_probe(struct of_device *op, const struct of_device_id *m
 	if (up->su_type = SU_PORT_KBD || up->su_type = SU_PORT_MS) {
 		err = sunsu_kbd_ms_init(up);
 		if (err) {
+			of_iounmap(&op->resource[0],
+				   up->port.membase, up->reg_size);
 			kfree(up);
-			goto out_unmap;
+			return err;
 		}
 		dev_set_drvdata(&op->dev, up);
 
