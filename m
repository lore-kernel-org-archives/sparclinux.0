Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA47DC433EF
	for <sparclinux@archiver.kernel.org>; Wed, 29 Jun 2022 07:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiF2HRB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiF2HQ7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 29 Jun 2022 03:16:59 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82DAD3389B;
        Wed, 29 Jun 2022 00:16:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5A9F91E80D11;
        Wed, 29 Jun 2022 15:15:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1c-x7jyf8M6s; Wed, 29 Jun 2022 15:15:44 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 233B91E80CDC;
        Wed, 29 Jun 2022 15:15:44 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] sparc: Fix a spelling mistake
Date:   Wed, 29 Jun 2022 15:16:37 +0800
Message-Id: <20220629071637.26779-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Change 'wont' to 'won't'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/sparc/kernel/leon_smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1eed26d423fb..cf3bddda8bb0 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -135,7 +135,7 @@ static void leon_smp_setbroadcast(unsigned int mask)
 	    ((LEON3_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpstatus)) >>
 	      LEON3_IRQMPSTATUS_BROADCAST) & 1);
 	if (!broadcast) {
-		prom_printf("######## !!!! The irqmp-ctrl must have broadcast enabled, smp wont work !!!!! ####### nr cpus: %d\n",
+		prom_printf("######## !!!! The irqmp-ctrl must have broadcast enabled, smp won't work !!!!! ####### nr cpus: %d\n",
 		     leon_smp_nrcpus());
 		if (leon_smp_nrcpus() > 1) {
 			BUG();
-- 
2.34.1

