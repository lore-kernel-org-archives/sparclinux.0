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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE93DC48BE8
	for <sparclinux@archiver.kernel.org>; Wed, 16 Jun 2021 10:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2393611CE
	for <sparclinux@archiver.kernel.org>; Wed, 16 Jun 2021 10:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhFPKrt (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 16 Jun 2021 06:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhFPKrs (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 16 Jun 2021 06:47:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92409C061574
        for <sparclinux@vger.kernel.org>; Wed, 16 Jun 2021 03:45:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so3717987pjz.3
        for <sparclinux@vger.kernel.org>; Wed, 16 Jun 2021 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPUA9WxBDvsPSFmUad8+sPLmPKHUzRsn1OY2xtUh6GI=;
        b=tih2UFKa/U+KPfUOj4qCnP7XTaAYavsduoKbBLr0k4PSJnU3sh41ilFjAU9yk2k/ca
         Tu0NjqUuaPF5RNuDQxvurFycx7HzU5TgyrlLd1/5zDSvjaEalIkI17Yftvi7EdbmPHMy
         Hp7zstpPhE/GucPaMjLNykWQ5hGNVxHGOnexxBuTJekaUbWUES3eUQimg0KkTU7jecq/
         UTsLKcPCDyZQY1B6loq1wD9Dk/AEmBiMY+QjILbcCzIVT8PuggwhdxJE0o0qZkeybMOT
         nw8c3Kmi3MhIuiDz74/tYsQy+e8yBO+X7F9NdbSt/t5oiXwAByO2iWDHhyNoCVJjcXUw
         1AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPUA9WxBDvsPSFmUad8+sPLmPKHUzRsn1OY2xtUh6GI=;
        b=ZQA8KS4zZsA7Wt48PrXL3m3ca2KDMoamWDR6uUp68TIfNbKzVvD+DbgaA2nlVlyGE9
         FWsQIbCQLDbddrpB5b4LF+GAvoqy9XrDgIFRD+oI4VfTDwkqcgZDHI3tYJ4swrdt8QMP
         7PadubLVVHY2oEVjcaCXjOYbmQW41mOw6MSezmYhXy/BymmBgA6T2O+VB8dnL/gsb7N1
         HMBPCvjr59dmFghaM/r7y8sLfZ337rSxHnFonwWya8IshZe/J+/rMfURnotHzfBLB3pQ
         W7OJiRBos6Vi/slvUqBbCDnTuHDnYvQx5forMVr56gJh3DmptgWGK1H3yHoD9E0vgJaZ
         Y3Ug==
X-Gm-Message-State: AOAM5330f6Y/LGV+kIQA5jMbpU4Lkr4C83q5G95hsfNpoPRa9MfFqoqn
        ibw8QW1JldE14/SgE1T6EyE=
X-Google-Smtp-Source: ABdhPJwjUTxf5oa0gws933dwA7V7v35sXjKseiNQ5wEWd4/rHghfHVZF92Aw38DR+FMzfo0KfhA5Mw==
X-Received: by 2002:a17:90b:2405:: with SMTP id nr5mr4183143pjb.184.1623840342202;
        Wed, 16 Jun 2021 03:45:42 -0700 (PDT)
Received: from bobo.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id d22sm1937614pgb.15.2021.06.16.03.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:45:42 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, sparclinux@vger.kernel.org
Subject: [PATCH 1/2] sparc32: remove mm_cpumask clearing to fix kthread_use_mm race
Date:   Wed, 16 Jun 2021 20:45:33 +1000
Message-Id: <20210616104534.1614087-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210616104534.1614087-1-npiggin@gmail.com>
References: <20210616104534.1614087-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Commit bafb056ce279 ("sparc64: remove mm_cpumask clearing to fix
kthread_use_mm race") fixed this for sparc64, but missed the same bug in
sparc32. Fix it similarly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sparc/mm/srmmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a9aa6a92c7fe..fefbd08bdc91 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1670,12 +1670,8 @@ static void smp_flush_tlb_mm(struct mm_struct *mm)
 		cpumask_t cpu_mask;
 		cpumask_copy(&cpu_mask, mm_cpumask(mm));
 		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask)) {
+		if (!cpumask_empty(&cpu_mask))
 			xc1((smpfunc_t) local_ops->tlb_mm, (unsigned long) mm);
-			if (atomic_read(&mm->mm_users) == 1 && current->active_mm == mm)
-				cpumask_copy(mm_cpumask(mm),
-					     cpumask_of(smp_processor_id()));
-		}
 		local_ops->tlb_mm(mm);
 	}
 }
-- 
2.23.0

