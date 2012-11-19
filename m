From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:27:16 +0000
Subject: [PATCH 487/493] sparc: remove use of __devexit
Message-Id: <1353349642-3677-487-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: sparclinux@vger.kernel.org 
---
 arch/sparc/include/asm/parport.h | 2 +-
 arch/sparc/kernel/chmc.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index 65cabfd..c55291e 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -192,7 +192,7 @@ out_err:
 	return err;
 }
 
-static int __devexit ecpp_remove(struct platform_device *op)
+static int ecpp_remove(struct platform_device *op)
 {
 	struct parport *p = dev_get_drvdata(&op->dev);
 	int slot = p->dma;
diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 4087a77..5097781 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -772,21 +772,21 @@ static int us3mc_probe(struct platform_device *op)
 	return -ENODEV;
 }
 
-static void __devexit chmc_destroy(struct platform_device *op, struct chmc *p)
+static void chmc_destroy(struct platform_device *op, struct chmc *p)
 {
 	list_del(&p->list);
 	of_iounmap(&op->resource[0], p->regs, 0x48);
 	kfree(p);
 }
 
-static void __devexit jbusmc_destroy(struct platform_device *op, struct jbusmc *p)
+static void jbusmc_destroy(struct platform_device *op, struct jbusmc *p)
 {
 	mc_list_del(&p->list);
 	of_iounmap(&op->resource[0], p->regs, JBUSMC_REGS_SIZE);
 	kfree(p);
 }
 
-static int __devexit us3mc_remove(struct platform_device *op)
+static int us3mc_remove(struct platform_device *op)
 {
 	void *p = dev_get_drvdata(&op->dev);
 
-- 
1.8.0

