Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C163EC433EF
	for <sparclinux@archiver.kernel.org>; Tue,  5 Jul 2022 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiGENmy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiGENmh (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 5 Jul 2022 09:42:37 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0433A201A1
        for <sparclinux@vger.kernel.org>; Tue,  5 Jul 2022 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TT+Yi
        Jz2yCtxPNvrllatIUMuhMbwZ6imHWAwdqqWZP8=; b=doxc/borjcZN4C5mMxsAJ
        b0XREyjCChx1CBn2TwuWMK65Tf1rGbQf4ij19tjS4+hB8AXG/JO/1EoPxTPbp3o6
        09ns4LQU2d9fqFe41BJuDzwJCvMketdp64Q3udcgYE2sYmj87V0SQidTaqdPeNXk
        ztavk/ex/9gIr51RGYIJQQ=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowABXSNBWN8Ri+pfVEQ--.53276S2;
        Tue, 05 Jul 2022 21:06:31 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net, sparclinux@vger.kernel.org, windhl@126.com
Subject: [PATCH] floppy: Add of_node_put() for the break of for_each_node_by_name()
Date:   Tue,  5 Jul 2022 21:06:30 +0800
Message-Id: <20220705130630.294535-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowABXSNBWN8Ri+pfVEQ--.53276S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy7Wr48ury8Gw4xKF15Arb_yoWrAr4Dpa
        4DKrZ0yry8Wan2k34Iyrykur17Arn3Kay7J3y7C3s5tFnrtr1Ygryvg342kry3GFWUu3W5
        AFZavF15GF4UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEb18ZUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7Rg1F1pEAV64RAAAsq
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

for_each_node_by_name() will automatically increase and decrease the
refcount. We should call of_node_put() when there is a break during
the iteration.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/sparc/include/asm/floppy_32.h |  8 ++++++--
 arch/sparc/include/asm/floppy_64.h | 31 ++++++++++++++++++------------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index e10ab9ad3097..5e17d35833c8 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -324,14 +324,18 @@ static int sun_floppy_init(void)
 	op = NULL;
 	for_each_node_by_name(dp, "SUNW,fdtwo") {
 		op = of_find_device_by_node(dp);
-		if (op)
+		if (op) {
+			of_node_put(dp);
 			break;
+		}
 	}
 	if (!op) {
 		for_each_node_by_name(dp, "fd") {
 			op = of_find_device_by_node(dp);
-			if (op)
+			if (op) {
+				of_node_put(dp);
 				break;
+			}
 		}
 	}
 	if (!op)
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 070c8c1f5c8f..39dfaead1c6c 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -548,7 +548,7 @@ static int __init ebus_fdthree_p(struct device_node *dp)
 static unsigned long __init sun_floppy_init(void)
 {
 	static int initialized = 0;
-	struct device_node *dp;
+	struct device_node *dp, *ebus_dp;
 	struct platform_device *op;
 	const char *prop;
 	char state[128];
@@ -563,14 +563,15 @@ static unsigned long __init sun_floppy_init(void)
 		if (!of_node_name_eq(dp->parent, "sbus"))
 			continue;
 		op = of_find_device_by_node(dp);
-		if (op)
+		if (op) {
+			of_node_put(dp);
 			break;
+		}
 	}
 	if (op) {
 		floppy_op = op;
 		FLOPPY_IRQ = op->archdata.irqs[0];
 	} else {
-		struct device_node *ebus_dp;
 		void __iomem *auxio_reg;
 		const char *state_prop;
 		unsigned long config;
@@ -584,15 +585,15 @@ static unsigned long __init sun_floppy_init(void)
 		}
 	found_fdthree:
 		if (!dp)
-			return 0;
+			goto out_put_node;
 
 		op = of_find_device_by_node(dp);
 		if (!op)
-			return 0;
+			goto out_put_node;
 
 		state_prop = of_get_property(op->dev.of_node, "status", NULL);
 		if (state_prop && !strncmp(state_prop, "disabled", 8))
-			return 0;
+			goto out_put_node;
 
 		FLOPPY_IRQ = op->archdata.irqs[0];
 
@@ -610,7 +611,7 @@ static unsigned long __init sun_floppy_init(void)
 		sun_pci_fd_ebus_dma.regs = (void __iomem *)
 			op->resource[1].start;
 		if (!sun_pci_fd_ebus_dma.regs)
-			return 0;
+			goto out_put_node;
 
 		sun_pci_fd_ebus_dma.flags = (EBUS_DMA_FLAG_USE_EBDMA_HANDLER |
 					     EBUS_DMA_FLAG_TCI_DISABLE);
@@ -619,7 +620,7 @@ static unsigned long __init sun_floppy_init(void)
 		sun_pci_fd_ebus_dma.irq = FLOPPY_IRQ;
 		strcpy(sun_pci_fd_ebus_dma.name, "floppy");
 		if (ebus_dma_register(&sun_pci_fd_ebus_dma))
-			return 0;
+			goto out_put_node;
 
 		/* XXX ioremap */
 		sun_fdc = (struct sun_flpy_controller *) op->resource[0].start;
@@ -686,7 +687,7 @@ static unsigned long __init sun_floppy_init(void)
 		}
 
 		if (!config)
-			return sun_floppy_types[0];
+			goto out_floppy;
 
 		/* Enable PC-AT mode. */
 		ns87303_modify(config, ASC, 0, 0xc0);
@@ -715,11 +716,11 @@ static unsigned long __init sun_floppy_init(void)
 		}
 #endif /* PCI_FDC_SWAP_DRIVES */
 
-		return sun_floppy_types[0];
+		goto out_floppy;
 	}
 	prop = of_get_property(op->dev.of_node, "status", NULL);
 	if (prop && !strncmp(state, "disabled", 8))
-		return 0;
+		goto out_put_node;
 
 	/*
 	 * We cannot do of_ioremap here: it does request_region,
@@ -734,7 +735,7 @@ static unsigned long __init sun_floppy_init(void)
 	/* Last minute sanity check... */
 	if (sbus_readb(&sun_fdc->status1_82077) == 0xff) {
 		sun_fdc = (struct sun_flpy_controller *)-1;
-		return 0;
+		goto out_put_node;
 	}
 
         sun_fdops.fd_inb = sun_82077_fd_inb;
@@ -760,7 +761,13 @@ static unsigned long __init sun_floppy_init(void)
 	sun_floppy_types[0] = 4;
 	sun_floppy_types[1] = 0;
 
+out_floppy:
+	of_node_put(ebus_dp);
 	return sun_floppy_types[0];
+
+out_put_node:
+	of_node_put(ebus_dp);
+	return 0;
 }
 
 #define EXTRA_FLOPPY_PARAMS
-- 
2.25.1

