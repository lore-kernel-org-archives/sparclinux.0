Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE9C433EF
	for <sparclinux@archiver.kernel.org>; Sat, 18 Jun 2022 08:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiFRIJ0 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 18 Jun 2022 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFRIJZ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 18 Jun 2022 04:09:25 -0400
X-Greylist: delayed 1887 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 01:09:23 PDT
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F9AB2AE0E
        for <sparclinux@vger.kernel.org>; Sat, 18 Jun 2022 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cwvrM
        twwaf2eGhHlVdwPwEDf4EW4aPt9uaNxslFq5Iw=; b=AtTFpsS6NRsz6EmMRKouh
        FFIeJbtaM85094GmIAs4K4+wMLl4w44kaU7Uf1oIeRPQUp8y1WCNVfoof1C9fTRm
        RPquwtVvXxqDsL/qdXzjgjUV59S9ByVBUZ7/ARs05oUhRJZYVHSLcTgsAqG3LkM/
        qwgqBoVnEBk2aMJ8W3FqiI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgCH51vLgK1iiG+cEw--.30712S2;
        Sat, 18 Jun 2022 15:37:47 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net
Cc:     windhl@126.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sbus: char: Fix refcount leak bug in openrom.c
Date:   Sat, 18 Jun 2022 15:37:46 +0800
Message-Id: <20220618073746.4059541-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgCH51vLgK1iiG+cEw--.30712S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW8Jr1fCF45WF1fCrW5trb_yoWxtrb_CF
        1xXryxtr1ktFsxC3sFvws3uryFyF1FgrZYvFnIqa45t3WYqrWfWryjvr95WryUAFW8Jry7
        A39rZFyrArnrtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU3fH5UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gskF1uwMOngXAAAss
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In opiocgetnext(), we need a of_node_put() to keep refcount balance
for device_node pointer returned by of_find_node_by_phandle() or
of_find_node_by_path().

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/sbus/char/openprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 30b9751aad30..701978db0f0f 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -518,6 +518,7 @@ static int opiocgetnext(unsigned int cmd, void __user *argp)
 	}
 	if (dp)
 		nd = dp->phandle;
+	of_node_put(dp);
 	if (copy_to_user(argp, &nd, sizeof(phandle)))
 		return -EFAULT;
 
-- 
2.25.1

