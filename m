Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ACAC433E0
	for <sparclinux@archiver.kernel.org>; Mon, 15 Mar 2021 07:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7970364E41
	for <sparclinux@archiver.kernel.org>; Mon, 15 Mar 2021 07:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCOHVh (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:21:37 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:63278 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229679AbhCOHVZ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Mon, 15 Mar 2021 03:21:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0URx1q6._1615792861;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0URx1q6._1615792861)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Mar 2021 15:21:13 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] sparc: fix warning comparing pointer to 0
Date:   Mon, 15 Mar 2021 15:20:58 +0800
Message-Id: <1615792858-79126-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Fix the following coccicheck warning:

./arch/sparc/prom/tree_64.c:335:15-16: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/sparc/prom/tree_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 989e799..85b5101 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -332,7 +332,7 @@ int prom_node_has_property(phandle node, const char *prop)
 
 	if (size == 0)
 		return 0;
-	if ((pname == 0) || (value == 0))
+	if (!pname || !value)
 		return 0;
 	
 #ifdef CONFIG_SUN_LDOMS
-- 
1.8.3.1

