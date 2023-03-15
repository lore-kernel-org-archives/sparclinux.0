Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1DFC7618A
	for <sparclinux@archiver.kernel.org>; Wed, 15 Mar 2023 04:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjCOE2W (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 00:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCOE2U (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 15 Mar 2023 00:28:20 -0400
X-Greylist: delayed 1806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 21:28:17 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57CE92659E
        for <sparclinux@vger.kernel.org>; Tue, 14 Mar 2023 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nxAQc
        H9Vrs4ySQgSAQ51YQQPZlErU1uZ8zu2c7n/26w=; b=fuzxtsuY+fiIBJoNwSm76
        bN+PGEHzEC7p8U0gOsc722bx2uyvFryIwNdZvu4dvPlqzZhq2pHIxBtJQCHz77Cs
        ll/cSeWgHesulzBb/OUNzmzskrw3T7XCre9Ynwj3pSBQmfntMNyYZd0X7IeWkL3f
        yTbZHIE0jyKB9KnJBF7jVA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wDXZpU7QhFkOqBvAA--.15282S2;
        Wed, 15 Mar 2023 11:57:49 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net, windhl@126.com, sparclinux@vger.kernel.org
Subject: [PATCH] sparc64: Add Null-checking for mdesc_grab() in ds_probe()
Date:   Wed, 15 Mar 2023 11:57:46 +0800
Message-Id: <20230315035746.1740236-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXZpU7QhFkOqBvAA--.15282S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy8ZF1fuFW5Cw45XF1xuFg_yoWxKFc_G3
        97Z3W5GF4S9F4Ivr1UCr4Syr40yanYqrWSv3ykXr45Grn5Jr4DJrZ0yFs8JrnrWr1q9rWk
        Kwn09F4q9rna9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREYii5UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAMzF2JVmfJZawAAsx
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In ds_probe(), the mdesc_grab() may return NULL pointer,
we should add the check to avoid NPD bug.

Fixes: a88b5ba8bd8a ("sparc,sparc64: unify kernel/")
Signed-off-by: Liang He <windhl@126.com>
---
 arch/sparc/kernel/ds.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 4a5bdb0df779..e14a8fb466b8 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -1178,6 +1178,10 @@ static int ds_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto out_err;
 
 	hp = mdesc_grab();
+	if (!hp) {
+		err = -ENODEV;
+		goto out_err;
+	}
 	val = mdesc_get_property(hp, vdev->mp, "id", NULL);
 	if (val)
 		dp->id = *val;
-- 
2.25.1

