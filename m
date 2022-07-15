Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0593C43334
	for <sparclinux@archiver.kernel.org>; Mon, 18 Jul 2022 12:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGRM2i (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRM2d (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 18 Jul 2022 08:28:33 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C38B25E8D;
        Mon, 18 Jul 2022 05:28:28 -0700 (PDT)
X-QQ-mid: bizesmtp62t1658147295tjonkhrc
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:28:14 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: 4rCmCcmdMHf21FkghsKkD9U1bfbfRHIEFGsJSAc68J4bW5HbM3c3skKotsThN
        QXIhAYkp8Kzkxs7vVWXego9VLz0jB5TWVUhqvFOGw/00AfPTs5SGviv9b9Joo90SGMDIl6E
        XzxotuTPSQPpksDyAzloE//ooyt6gBYPRa0tgL3pvbF3DQY6JKFBtLH5t761TIwOxqkgj0l
        xt7KWzb063OIgiwsV/q9ke5wxDFHd23zHkMGGCDGiOfiJh5n6xLbhQNzRXFdivaSYD8IhvW
        d7vqpZ3V2aNgASa6BNc+7caBA+9sf/oqz2DXFS83bN5A2eUj5yekFyDDQrf7kyc3jzy0/4q
        uNer8Y+jhWTxfqxLTRae3ArcylxWA7WFZKm1xdUipDoAwSCg2Svn78uoB8bYIh9sqBrAcRP
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     schnelle@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] sparc: Fix comment typo
Date:   Fri, 15 Jul 2022 12:26:10 +0800
Message-Id: <20220715042610.14570-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The double `the' is duplicated in line 313, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/sparc/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 31b0c1983286..385c61d199cd 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -310,7 +310,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	/* We can't actually use the firmware value, we have
 	 * to read what is in the register right now.  One
 	 * reason is that in the case of IDE interfaces the
-	 * firmware can sample the value before the the IDE
+	 * firmware can sample the value before the IDE
 	 * interface is programmed into native mode.
 	 */
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
-- 
2.35.1

