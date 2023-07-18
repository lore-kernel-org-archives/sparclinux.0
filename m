Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB0EB64DC
	for <sparclinux@archiver.kernel.org>; Tue, 18 Jul 2023 16:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjGRQcr (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjGRQcp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 18 Jul 2023 12:32:45 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F310E5
        for <sparclinux@vger.kernel.org>; Tue, 18 Jul 2023 09:32:41 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R54HT2hWJzBR9ss
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 00:32:37 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689697957; x=1692289958; bh=ytYLT++mGja82GJdf7wPpzcdDAh
        6O7ZkLiAb4ChQPFA=; b=pw2dTxW2GuXcCYX41B24eViPM+Eg5xVV0Ll0JuHXG76
        wv8ADa5Wgx2wv7iA5HW9Zadjb4XZmkgCQ9B2yJlL3g7OjAnKkje5Ardj70oHSfR6
        V5iZROlrf4WTXjghQHrGH/AwEB4vVASiMJY0Ks+sWzeRkYDBCZd5n5hnapY75ae1
        TxXcuFrMgTg/tpTXwa6RsGdpYMXfPJiqrdmHWPuVWilQg3ZlRdNo83Ujs53clmEF
        CrMogqs9LWVExN+VugfQ83KFJ76QScJ2auGK/eAZ2m4Snyw/8TxzoRJsjk3MRcoY
        QLX6Ite+4Zb7/50tvYQxDQNchs7IqJd7CilJ1LcydDA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fPN85ygj-hU9 for <sparclinux@vger.kernel.org>;
        Wed, 19 Jul 2023 00:32:37 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R54HT0B01zBR1PQ;
        Wed, 19 Jul 2023 00:32:36 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:32:36 +0800
From:   pangzizhen001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc/kernel: Fix comment typo
In-Reply-To: <e0a298222f3e1c880c3dfa957c487cfd@208suo.com>
References: <20230712083035.47189-1-wangjianli@cdjrlc.com>
 <e0a298222f3e1c880c3dfa957c487cfd@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <f259c5935d8601e64bc8f680281e9e0e@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  arch/sparc/kernel/pci.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index a948a49817c7..c759bfcaf387 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -310,7 +310,7 @@ static struct pci_dev *of_create_pci_dev(struct 
pci_pbm_info *pbm,
      /* We can't actually use the firmware value, we have
       * to read what is in the register right now.  One
       * reason is that in the case of IDE interfaces the
-     * firmware can sample the value before the the IDE
+     * firmware can sample the value before the IDE
       * interface is programmed into native mode.
       */
      pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
