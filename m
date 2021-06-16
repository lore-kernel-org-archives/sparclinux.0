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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA4C48BE5
	for <sparclinux@archiver.kernel.org>; Wed, 16 Jun 2021 10:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB36100A
	for <sparclinux@archiver.kernel.org>; Wed, 16 Jun 2021 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhFPKrv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 16 Jun 2021 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhFPKrv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 16 Jun 2021 06:47:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DCBC061574
        for <sparclinux@vger.kernel.org>; Wed, 16 Jun 2021 03:45:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so3730382pjs.2
        for <sparclinux@vger.kernel.org>; Wed, 16 Jun 2021 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0O3sjyW95LTPoAX9d9UnAXEjpJ08cyAS0IPbgTZbn0A=;
        b=G8ZTy+aOzALP+7aD2iU6agEWpyLpyZwYHNuFV60NbNuRU/FDpu3Lhgef34Gk0+3ZHl
         7/jz4EKcQx5G6YoNsrBmYggfEpRXjZUu4YHC/GEzP8CG00E+zfF1JnpsqrANGNR9gdbP
         wMLAV49KdzVprJmFFVyRjNr36Hz2lvd3qE7UxGttSlm5lypl51qUn7QREVClyf0PYS8d
         bFNbUF9W2wrBrXMxMnvW/MqHzjm1mpqORc9Lpk3e02WY2IDqGjRKpeFOTTHSrQ5IAII3
         gz+uSlPpspiECkeS2x+locSRx4rR9D4w3Vc78Uo46vrm+TYMP8KiE3337ZPu78Nx0M0i
         4lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0O3sjyW95LTPoAX9d9UnAXEjpJ08cyAS0IPbgTZbn0A=;
        b=XJqgElw2dZNJM577eaFnos32JI/0rPY9t2HDaXaGHk9tI1kDW1IXfghmPCN7Igmcuj
         HUoNOCOskAXKTFoaY8iyRvatifZTuE/WIAiE+IYjxxOBoax5uCm+72+Htp5/r+fc8BP1
         9hCSZOt2Tclp/QBR4zj851a0uSBrPIh7bXSu2XVasUX4S5EfEwGh64BUCpf9A/nbGs1Z
         SYEGurYxrWfRes8V15oTDx1iNuggAQZUsOF5ugtFoFvSHfBQFZv9R/kqdSOAfdLSwlg5
         TqO8sNzF5xZQ/ih01cXor+MLjff2yRn3Fgr8DOZ4a+EGwX59hpvy6SJiS9gPtIJb/uAl
         jlyw==
X-Gm-Message-State: AOAM530ecarzIdBtdW8UOVhmwsHWDQcTujgMBDwTHbzY/0/4MthIJVUT
        PkHjBYWLyNafdAlIBIzeAP45PyYatKQ=
X-Google-Smtp-Source: ABdhPJyOPGIgPXM8EygOrCx36A4NA9s/ATB986W8PBYrGlMXDU+dd2eHDuUZ7IDZJJK7cveUD5uxIA==
X-Received: by 2002:a17:90b:e8e:: with SMTP id fv14mr9903245pjb.29.1623840344444;
        Wed, 16 Jun 2021 03:45:44 -0700 (PDT)
Received: from bobo.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id d22sm1937614pgb.15.2021.06.16.03.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:45:44 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, sparclinux@vger.kernel.org
Subject: [PATCH 2/2] sparc32: fix mm_cpumask maintenance causing missing TLB flushing
Date:   Wed, 16 Jun 2021 20:45:34 +1000
Message-Id: <20210616104534.1614087-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210616104534.1614087-1-npiggin@gmail.com>
References: <20210616104534.1614087-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Fix a bug in mm_cpumask maintenance where a CPU can have switched to an
mm but it's not present in the cpumask, resulting in possible lost TLB
flushes. switch_mm() can be called without switching thread (exec(2),
kthread_use_mm()). Move mm_cpumask setting there, matching sparc64.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sparc/include/asm/switch_to_32.h | 1 -
 arch/sparc/mm/srmmu.c                 | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/switch_to_32.h b/arch/sparc/include/asm/switch_to_32.h
index 42eeafcb8a41..1d9855abbc00 100644
--- a/arch/sparc/include/asm/switch_to_32.h
+++ b/arch/sparc/include/asm/switch_to_32.h
@@ -58,7 +58,6 @@ extern struct thread_info *current_set[NR_CPUS];
 #define switch_to(prev, next, last) do {						\
 	SWITCH_ENTER(prev);								\
 	SWITCH_DO_LAZY_FPU(next);							\
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(next->active_mm));		\
 	__asm__ __volatile__(								\
 	"sethi	%%hi(here - 0x8), %%o7\n\t"						\
 	"mov	%%g6, %%g3\n\t"								\
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index fefbd08bdc91..dc07b3d68fc1 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -473,6 +473,9 @@ void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 {
 	unsigned long flags;
 
+	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
+		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+
 	if (mm->context == NO_CONTEXT) {
 		spin_lock_irqsave(&srmmu_context_spinlock, flags);
 		alloc_context(old_mm, mm);
-- 
2.23.0

