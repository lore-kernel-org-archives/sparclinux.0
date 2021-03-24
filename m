Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A275C433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E462361A17
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 23:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhCXX3A (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCXX2i (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 Mar 2021 19:28:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14229C06174A
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 16:28:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y5so104891pfn.1
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMPjWd70KFrFjfBSIIPdDbtPfSy+a6K9fF4onrnkDLI=;
        b=Y3vMo6uIFgxM6sdit3Y48ZcwGsY0oUVwDnjkImrirSGAiBHwxO2pRYPkOgAiSCIIHk
         PHeuPo/MA63wo3rPPTNvxJh3p867PIXzlNgO5rjTDnULgIjSHJ3z4ZxzB9U+3PhrdSDS
         HDVOxqZPPK/Habrw6Js6l7sTcttLC0fmev4OFMiP8EHWdWGALqqUpXtXEtgaVUbFW7MZ
         wMpGVDOs/QFBHqFMzFqhHJW80aq8YqMhIQKUqUkuonOj9WbYVeV/dt0DfFRL/G0PRbXa
         51f4T8WS43UlsJBeIJ/SJwDrr5jl/6S4Yx3nQ5O/bW2EPD02SnTZj4dnf5QlZ/+pvtS7
         NV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMPjWd70KFrFjfBSIIPdDbtPfSy+a6K9fF4onrnkDLI=;
        b=N+g9M37WOyW2yZVzIn7I+hZh1P1IJiRH/N+mdwGIiVicEq4FM7adG8jhhSBuU2cFK1
         uWWg74IxwBh98CikDYdpyXh1/ZSc0Ezvc13T6DduCe9hxNw2szwSwwuEKrvvNQO5TsWu
         IYdYEJnktp2AeeQayBsn9t7ldRYQnkzgN6yusKN6sTYYOdhGotWA1paaFQb4KMNzRZzO
         rhkXIV0IzrS/vvH4nxKAqUlk2GDStJDYrj7J3MqPRYEzFvWMbMkZ/Wlmi7rAlb7YoooQ
         VwtLraPzkSZYP8JhwkxlJOXyqdsM6+BGnxA4bABpJ38S0zDGwmHUafC3YG+ZE/m3eV8t
         BsFA==
X-Gm-Message-State: AOAM532Mb3ZIlUmivvEfXJUBed7FPfMazde+LWIm5Sw+ukdT+kbdKKxC
        mKD2viFadeI2f/MPCCax8hs=
X-Google-Smtp-Source: ABdhPJyHdrEywyxkXSbrenUecLuYOoW1JE5yG8XhBwrAeuo5l3eE6M3sJCc9TuWU+sc1HXHTYNagcA==
X-Received: by 2002:a62:3646:0:b029:205:2117:f339 with SMTP id d67-20020a6236460000b02902052117f339mr5242606pfa.32.1616628517581;
        Wed, 24 Mar 2021 16:28:37 -0700 (PDT)
Received: from bobo.ibm.com ([1.132.133.45])
        by smtp.gmail.com with ESMTPSA id u22sm3333292pgh.20.2021.03.24.16.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:28:37 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] sparc32: add stub pud_page define for walking huge vmalloc page tables
Date:   Thu, 25 Mar 2021 09:28:25 +1000
Message-Id: <20210324232825.1157363-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Similarly to the stub p4d_page in sparc64, add a stub pud_page, this
is needed for hugepages in the vmap page tables to be walked without
ifdefs, which should be no functional change for sparc32.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This should go in Andrew's mm tree which has a compile error on sparc32
introduced by the huge vmalloc pages, noticed by Stephen.

Thanks,
Nick

 arch/sparc/include/asm/pgtable_32.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 632cdb959542..a5cf79c149fe 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -321,6 +321,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 		pgprot_val(newprot));
 }
 
+/* only used by the huge vmap code, should never be called */
+#define pud_page(pud)			NULL
+
 struct seq_file;
 void mmu_info(struct seq_file *m);
 
-- 
2.23.0

