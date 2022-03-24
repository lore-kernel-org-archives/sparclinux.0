Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FA6C433F5
	for <sparclinux@archiver.kernel.org>; Thu, 24 Mar 2022 01:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiCXBk7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiCXBk6 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 23 Mar 2022 21:40:58 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE592D25;
        Wed, 23 Mar 2022 18:39:26 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 24 Mar
 2022 09:39:25 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 24 Mar
 2022 09:39:24 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <davem@davemloft.net>
CC:     <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] sparc: Fix warning comparing pointer to 0
Date:   Thu, 24 Mar 2022 09:39:23 +0800
Message-ID: <1648085963-25580-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/sparc/prom/tree_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 989e799..88793e5b 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -332,7 +332,7 @@ prom_setprop(phandle node, const char *pname, char *value, int size)
 
 	if (size == 0)
 		return 0;
-	if ((pname == 0) || (value == 0))
+	if ((pname == NULL) || (value == NULL))
 		return 0;
 	
 #ifdef CONFIG_SUN_LDOMS
-- 
2.7.4

