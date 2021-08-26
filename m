Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0153C432BE
	for <sparclinux@archiver.kernel.org>; Thu, 26 Aug 2021 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967AB61037
	for <sparclinux@archiver.kernel.org>; Thu, 26 Aug 2021 12:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhHZMF2 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:05:28 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53486
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234332AbhHZMF1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Thu, 26 Aug 2021 08:05:27 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 802AB3F22F;
        Thu, 26 Aug 2021 12:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629979479;
        bh=cBaPIu2GqefVticxEBEafLxyUDIthcEoFWOQdKLLIUg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=KODZ477B6+1hvJk/HxsRZ2cF6PjKECtz/7bFtTnJJWMewTls23RiLocWzd/ExdfQi
         NRMZj0P/pttxyV7PuviS1OSzsb/+s0XpMaAMMB28CmcbX08tpa5jstYrUCjaLQeM35
         IZY32UHW+B7mKQhiC4bCjORtsp/a9ZTut1rQwW4sSJMZ2RIMOsKymiu7Vkz4BVHujJ
         5ejz5H58FFy1cAI56hIADgczeYnf8VY1ENtJ5ecBOcV3ZNxJMhMtTd48I/kABpqhmb
         DH7K6laweFFgbDjVS/qwbgou0NqYjl1wgsOvthnO2FMQjjaB+XEjT4r1nbvW6DDHhT
         x++Io4j+IvBXg==
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Fix spelling mistake "wont" -> "won't"
Date:   Thu, 26 Aug 2021 13:04:39 +0100
Message-Id: <20210826120439.12424-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a prom_printf message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.32.0

