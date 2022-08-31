Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F248ECAAA1
	for <sparclinux@archiver.kernel.org>; Wed, 31 Aug 2022 00:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiHaAyc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiHaAyc (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 Aug 2022 20:54:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5C37F82;
        Tue, 30 Aug 2022 17:54:29 -0700 (PDT)
X-QQ-mid: bizesmtp66t1661907259tqaon2sv
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 08:54:18 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: Sb649gZU4sLinyAXp9w5iheVS+x7OIXtZrsQy6fs//yS898SmzYhc009VCvcS
        ict9hrsUXGgXO3HnFgVIjjrDZnvxmXP2VgLvcolBCvB3D4mUpRRk56Z70ypFisRnxXEcgS/
        mmBOhjX+C853tQDrHMbznfO2tXVI+c4E2nMGKLA0WS3xaGuJBMRPP1gFD6HWDUWW8tZI/69
        xNpTIK/LscMe4GMx2F9qx/bJ1E3BLPv5WkgWf8l9MndVmmoIt9rHkg9j4gU5tBPA4KiBhJx
        Twof78cBGmFLlkQ2/TKv4UNPimMy4LLI/+PdNybEUc2lQqnbphpvzzfLfBBiDgoy4usOJJ4
        Q+uz8wh04cu5Y+SaR7YbywAedh42FxGnjX/Dn/Irq7AE2z+gJs=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] sparc64: fix repeated words in comments
Date:   Wed, 31 Aug 2022 08:54:12 +0800
Message-Id: <20220831005412.40418-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Delete the redundant word 'new'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/sparc/kernel/traps_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 5b4de4a89dec..511756cc7aaa 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -911,7 +911,7 @@ void __init cheetah_ecache_flush_init(void)
 	memset(cheetah_error_log, 0, PAGE_SIZE << order);
 
 	/* Mark all AFSRs as invalid so that the trap handler will
-	 * log new new information there.
+	 * log new information there.
 	 */
 	for (i = 0; i < 2 * NR_CPUS; i++)
 		cheetah_error_log[i].afsr = CHAFSR_INVALID;
-- 
2.36.1

