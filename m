From: Jing Xiangfeng <jingxiangfeng@huawei.com>
Date: Fri, 11 Sep 2020 07:13:41 +0000
Subject: [PATCH] sbus: char: Remove meaningless jump label out_free
Message-Id: <20200911071341.101397-1-jingxiangfeng@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, dan.j.williams@intel.com, dvhart@infradead.org, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, dsterba@suse.com, arnd@arndb.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jingxiangfeng@huawei.com

After commit 57a4a3d7f756 ("display7seg: Introduce the use of the managed
version of kzalloc"), The out_free jump label has nothing to do but goto
out. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/sbus/char/display7seg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index fad936eb845f..00e72b97d0b6 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -186,7 +186,7 @@ static int d7s_probe(struct platform_device *op)
 	p->regs = of_ioremap(&op->resource[0], 0, sizeof(u8), "d7s");
 	if (!p->regs) {
 		printk(KERN_ERR PFX "Cannot map chip registers\n");
-		goto out_free;
+		goto out;
 	}
 
 	err = misc_register(&d7s_miscdev);
@@ -228,8 +228,6 @@ static int d7s_probe(struct platform_device *op)
 
 out_iounmap:
 	of_iounmap(&op->resource[0], p->regs, sizeof(u8));
-
-out_free:
 	goto out;
 }
 
-- 
2.17.1
