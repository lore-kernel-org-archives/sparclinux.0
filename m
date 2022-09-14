Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37109C6FA8A
	for <sparclinux@archiver.kernel.org>; Wed, 14 Sep 2022 07:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiINHYJ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiINHYH (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 14 Sep 2022 03:24:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372696E8A5
        for <sparclinux@vger.kernel.org>; Wed, 14 Sep 2022 00:24:07 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSBXx1fywzNmGd;
        Wed, 14 Sep 2022 15:19:29 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 15:24:04 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <davem@davemloft.net>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <rppt@kernel.org>,
        <sfr@canb.auug.org.au>, <ben-linux@fluff.org>,
        <pasha.tatashin@oracle.com>, <cuigaosheng1@huawei.com>
CC:     <sparclinux@vger.kernel.org>
Subject: [PATCH 2/2] sparc: remove unused vdso_fix_stick declaration
Date:   Wed, 14 Sep 2022 15:24:02 +0800
Message-ID: <20220914072402.1337408-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914072402.1337408-1-cuigaosheng1@huawei.com>
References: <20220914072402.1337408-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

All uses of vdso_fix_stick were removed by
commit 2f6c9bf31a0b ("sparc: Improve VDSO instruction
patching."), so remove the declaration, too.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/sparc/include/asm/vvar.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/include/asm/vvar.h b/arch/sparc/include/asm/vvar.h
index 6eaf5cfcaae1..a09bfa46696c 100644
--- a/arch/sparc/include/asm/vvar.h
+++ b/arch/sparc/include/asm/vvar.h
@@ -36,7 +36,6 @@ struct vvar_data {
 };
 
 extern struct vvar_data *vvar_data;
-extern int vdso_fix_stick;
 
 static inline unsigned int vvar_read_begin(const struct vvar_data *s)
 {
-- 
2.25.1

