Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A1FC433F5
	for <sparclinux@archiver.kernel.org>; Sat, 12 Mar 2022 19:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiCLTlj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 12 Mar 2022 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiCLTli (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 12 Mar 2022 14:41:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9EB1ABF;
        Sat, 12 Mar 2022 11:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dlhSBVCGSjQxNPG2e1QpZKqKTKUh2j0G3vVAb98ECww=; b=MsPzrQAioAzVYMhbZMN2DtcItj
        CAAkSklcsYj8kH3U8dBTYrJ4Wons6KiV003BTRCRrMR4Yaqa5vKKW8DRqlCYugUeIWaK48T37uKi6
        uLv1bWRYqNwyKg0cadnj4WP/m12z3UkWUweep0UWIv//fAvTPlL1RMoMd/KlZAGyxDgREqFZmSLjP
        fp43dfsZcuCYJItmbcPXezzd2Y09wbxztPfzzsaYcN7nyvwqQKJ5CMunKMmdDAbPQZSAQVyMB9hIT
        PwJ/D7kJSjirKWwV/z/QkdRnUcFw5oa/6gtwNMWg6bgs+VjkEMkshffscvl6LEnuxAiUFVyHYt0rU
        lZKQn8vA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT7bL-001mUg-CB; Sat, 12 Mar 2022 19:40:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Nick Alcock <nick.alcock@oracle.com>
Subject: [PATCH v2] sparc: vDSO: fix return value of __setup handler
Date:   Sat, 12 Mar 2022 11:40:30 -0800
Message-Id: <20220312194030.13733-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled.
A return of 0 causes the boot option/value to be listed as an Unknown
kernel parameter and added to init's (limited) argument or environment
strings. Also, error return codes don't mean anything to
obsolete_checksetup() -- only non-zero (usually 1) or zero.
So return 1 from vdso_setup().

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
From: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Nick Alcock <nick.alcock@oracle.com>
---
v2: correct the Fixes: tag (Dan Carpenter)

 arch/sparc/vdso/vma.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-next-20220310.orig/arch/sparc/vdso/vma.c
+++ linux-next-20220310/arch/sparc/vdso/vma.c
@@ -449,9 +449,8 @@ static __init int vdso_setup(char *s)
 	unsigned long val;
 
 	err = kstrtoul(s, 10, &val);
-	if (err)
-		return err;
-	vdso_enabled = val;
-	return 0;
+	if (!err)
+		vdso_enabled = val;
+	return 1;
 }
 __setup("vdso=", vdso_setup);
