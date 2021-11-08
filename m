Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E416C4332F
	for <sparclinux@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0CF610F8
	for <sparclinux@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhKHKQA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 8 Nov 2021 05:16:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38536 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhKHKPX (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:23 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F4841EC0529;
        Mon,  8 Nov 2021 11:12:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+U0N1WhO/TgXQDOA2GkcCX7tzQA/fw5C7L0WOlLoySU=;
        b=re3054RNR1F8oPYRTdcjLHrbluM61LEeuqGN9VtnP96HvckuRHz/SwnoYSxg9qQKgO9IbR
        uxH8lXh81utOZ704plkssgA8gtNWufQdWLykUomCC+vbSQAVG5Aoa3DUjWM9nXuj5ILE8X
        EuNi8BXpdljJ17IUvRwJfLuQVq202c4=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     sparclinux@vger.kernel.org
Subject: [PATCH v0 37/42] sparc: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:52 +0100
Message-Id: <20211108101157.15189-38-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/sstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sstate.c b/arch/sparc/kernel/sstate.c
index 3bcc4ddc6911..4e29e8977609 100644
--- a/arch/sparc/kernel/sstate.c
+++ b/arch/sparc/kernel/sstate.c
@@ -106,8 +106,10 @@ static int __init sstate_init(void)
 
 	do_set_sstate(HV_SOFT_STATE_TRANSITION, booting_msg);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &sstate_panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &sstate_panic_block))
+		pr_warn("Soft state panic notifier already registered\n");
+
 	register_reboot_notifier(&sstate_reboot_notifier);
 
 	return 0;
-- 
2.29.2

