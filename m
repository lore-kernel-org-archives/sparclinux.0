Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8688C433FE
	for <sparclinux@archiver.kernel.org>; Sat, 22 Oct 2022 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJVLpR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 22 Oct 2022 07:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJVLpO (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 22 Oct 2022 07:45:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186555A8C9
        for <sparclinux@vger.kernel.org>; Sat, 22 Oct 2022 04:45:11 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MvfXP36tgzmV91;
        Sat, 22 Oct 2022 19:40:21 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 19:45:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 22 Oct
 2022 19:45:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <sparclinux@vger.kernel.org>
CC:     <davem@davemloft.net>, <yangyingliang@huawei.com>
Subject: [PATCH 2/2] sparc64/of: fix possible memory leak in scan_one_device()
Date:   Sat, 22 Oct 2022 19:44:14 +0800
Message-ID: <20221022114414.3430637-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221022114414.3430637-1-yangyingliang@huawei.com>
References: <20221022114414.3430637-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

dev_set_name() in scan_one_device() allocates memory for name,
it need be freed when of_device_register() fails, call put_device()
to give up the reference that hold in device_initialize(), so that
it can be freed in kobject_cleanup() when the refcount hit to 0.
And add op_dev_release() to free platform device.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/sparc/kernel/of_device_64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 5a9f86b1d4e7..7496c8af12a6 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -239,6 +239,11 @@ static struct of_bus *of_match_bus(struct device_node *np)
 	return NULL;
 }
 
+static void op_dev_release(struct device *dev)
+{
+	kfree(to_platform_device(dev));
+}
+
 static int __init build_one_resource(struct device_node *parent,
 				     struct of_bus *bus,
 				     struct of_bus *pbus,
@@ -677,10 +682,11 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		dev_set_name(&op->dev, "%08x", dp->phandle);
 	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	op->dev.dma_mask = &op->dev.coherent_dma_mask;
+	op->dev.release = op_dev_release;
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
-		kfree(op);
+		put_device(&op->dev);
 		op = NULL;
 	}
 
-- 
2.25.1

