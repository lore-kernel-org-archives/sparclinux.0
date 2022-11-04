Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447CBC4332F
	for <sparclinux@archiver.kernel.org>; Fri,  4 Nov 2022 03:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKDDxA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 3 Nov 2022 23:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDDw7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 3 Nov 2022 23:52:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C10013D7E
        for <sparclinux@vger.kernel.org>; Thu,  3 Nov 2022 20:52:58 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N3RSx4qbMzpSsn;
        Fri,  4 Nov 2022 11:49:21 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:52:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 11:52:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <sparclinux@vger.kernel.org>
CC:     <davem@davemloft.net>, <yangyingliang@huawei.com>
Subject: [PATCH v2 0/2] sparc: fix possible memory leak in scan_one_device()
Date:   Fri, 4 Nov 2022 11:51:43 +0800
Message-ID: <20221104035145.1147754-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

This patchset fixes two possible memory leaks if of_device_register()
returns error.

v1 -> v2:
  add fix tag.

Yang Yingliang (2):
  sparc/of: fix possible memory leak in scan_one_device()
  sparc64/of: fix possible memory leak in scan_one_device()

 arch/sparc/kernel/of_device_32.c | 8 +++++++-
 arch/sparc/kernel/of_device_64.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.25.1

