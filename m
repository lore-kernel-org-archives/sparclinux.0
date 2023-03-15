Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3A5C6FD1D
	for <sparclinux@archiver.kernel.org>; Wed, 15 Mar 2023 05:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCOFkM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 01:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCOFkM (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 15 Mar 2023 01:40:12 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1480D3B3D9
        for <sparclinux@vger.kernel.org>; Tue, 14 Mar 2023 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4YKgP
        7vqLJcawLX0zcldw2zaCBe2wj4ts7s/IMwl7Y8=; b=ZkTAbD/NtKfsWJ4h5MMTH
        45+ihszfzEXk22yelvksQJqH/yzQm/PkMIg/ac4VXQiFut3Hz/KJDBImARBAE8O3
        InCZxBS8VCCC6Dj93oxj1Dp6KX17jld4j4H258Rb32vJtCLznxAZIKwPZIOfK4AZ
        eP5MparD2PASMCtl0/Bb7w=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wA3ZlArWhFk2gpzAA--.24819S2;
        Wed, 15 Mar 2023 13:39:56 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net, windhl@126.com, sparclinux@vger.kernel.org
Subject: [PATCH] sparc/mm: add check for mdesc_grab()
Date:   Wed, 15 Mar 2023 13:39:54 +0800
Message-Id: <20230315053954.1740751-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3ZlArWhFk2gpzAA--.24819S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur15Cw1fXw4kAF4fZFy8AFb_yoWDJFb_Ar
        WxW34xJrnYgas7ArsF9ryrXr1xZFs5Gr4YvryfZF9rXa1rJryDJrWftw45Zr17Wr4fCrZ5
        KFn0yry0yw4jyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRA5r43UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BMzF1pEFEouZAAAsh
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In of_node_to_nid() and numa_parse_mdesc(), we should consider
the return value of mdesc_grab() as it may return NULL.
We should add check to avoid NPD bug.

Fixes: 27137e5285a3 ("sparc,sparc64: unify mm/")
Signed-off-by: Liang He <windhl@126.com>
---
 arch/sparc/mm/init_64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..d0a0c1a78b41 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1176,6 +1176,8 @@ int of_node_to_nid(struct device_node *dp)
 	cfg_handle = (regs->phys_addr >> 32UL) & 0x0fffffff;
 
 	md = mdesc_grab();
+	if (!md)
+		return -1;
 
 	count = 0;
 	nid = NUMA_NO_NODE;
@@ -1449,6 +1451,9 @@ static int __init numa_parse_mdesc(void)
 	int i, j, err, count;
 	u64 node;
 
+	if (!md)
+		return -ENODEV;
+
 	node = mdesc_node_by_name(md, MDESC_NODE_NULL, "latency-groups");
 	if (node == MDESC_NODE_NULL) {
 		mdesc_release(md);
-- 
2.25.1

