Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E26ECAAD3
	for <sparclinux@archiver.kernel.org>; Wed, 14 Sep 2022 07:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiINHYH (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiINHYG (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 14 Sep 2022 03:24:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950D6E8A5
        for <sparclinux@vger.kernel.org>; Wed, 14 Sep 2022 00:24:05 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MSBYf4cVdz13Kht;
        Wed, 14 Sep 2022 15:20:06 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 15:24:03 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <davem@davemloft.net>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <rppt@kernel.org>,
        <sfr@canb.auug.org.au>, <ben-linux@fluff.org>,
        <pasha.tatashin@oracle.com>, <cuigaosheng1@huawei.com>
CC:     <sparclinux@vger.kernel.org>
Subject: [PATCH 0/2] Remove unused declarations for sparc
Date:   Wed, 14 Sep 2022 15:24:00 +0800
Message-ID: <20220914072402.1337408-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
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

This series contains a few cleanup patches, to remove unused
declarations which have been removed. Thanks!

Gaosheng Cui (2):
  sparc: remove unused xcall_new_mmu_context_version declaration
  sparc: remove unused vdso_fix_stick declaration

 arch/sparc/include/asm/vvar.h | 1 -
 arch/sparc/kernel/smp_64.c    | 1 -
 2 files changed, 2 deletions(-)

-- 
2.25.1

