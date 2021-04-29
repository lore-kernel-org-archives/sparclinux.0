Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F76C433ED
	for <sparclinux@archiver.kernel.org>; Thu, 29 Apr 2021 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4578361185
	for <sparclinux@archiver.kernel.org>; Thu, 29 Apr 2021 19:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhD2TR3 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 29 Apr 2021 15:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbhD2TIn (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 29 Apr 2021 15:08:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D2C06138C
        for <sparclinux@vger.kernel.org>; Thu, 29 Apr 2021 12:07:55 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h12-20020a0cf44c0000b02901c0e9c3e1d0so3889979qvm.4
        for <sparclinux@vger.kernel.org>; Thu, 29 Apr 2021 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zxaAMw4akhCbciRHPnpZSHUl30YIRQsaz3gXR9kG1Po=;
        b=d2dcs4BQqMnuAq7Rr2xTHD45zjt6wGFRFpEysevYk2/CGmmxeZMMpXnHYBKDqseXlR
         BcPpXMVzceP84eBbiOpZI1KIEKAgozCL4pT3/6KT2j2FZ8ODykcyIvKDurPZ8A1zQPQv
         uawZnMPzGMGpBe9kdh9k44bxDYQ8gNA4DN6IxqUqxuTu2OpoBLeAe0W0AvnxrX6bDjCJ
         x8HGM7mUjGdt3dFAKlyzhHDLNuaTY0QMI3Qj1M5+2pb/Rm1gkAYyDCHGoptvR/KV/Jnt
         sZ+hySRgaLsOjMFtDXg65EyqMhCS+J2zK0CX9D8HTPcLa4/9drV1aljrr73oITrCC/nq
         QMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zxaAMw4akhCbciRHPnpZSHUl30YIRQsaz3gXR9kG1Po=;
        b=V87XVJFVqqYuMvJxi0CGmetuwC1yb5lCkkbqqjXrCDeCtY632H3OnQXwQffsl+OQoy
         I7SfyeKWftik0XjF8+2aQK9Wr8UwByDTAsaGYY/75yOP8djbLAICZuuVCXomdabb1lV/
         b5yy1N1G8oV03bbQH9ypOsWCfS8Ya0eeIOjv1/PDvCV8NDgHf911/JDJkv08tZpmBJkN
         zX98FbwCKeMaLl7NUklvKvcpY5npCa0+yBJ24Olsf+gSkDClLurJCtlwFyco1s9BEdAT
         IBhtDCIcq8TDHseCQQ6TRVAtYTJ8Eyt/3mV+8QkpNF63oHsFlTXj27hsa6dtHduzpGif
         Ti3Q==
X-Gm-Message-State: AOAM533eJSfShZJDwMhp2t2b3dKaYq+ocAPd9Lyc7FCSrCVdp+EzgvA6
        6GQ0Yw8MqchEuLWh7U1sF/SkUjuGDg==
X-Google-Smtp-Source: ABdhPJy/xmZl4EBaLLb/PjEuNHU5XmzVn22MP13ocH+LwGQaeM9nB5FZ38e86gmKR5VieNOLBxZqjEgobw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4399:f8b0:aefa:628])
 (user=elver job=sendgmr) by 2002:a0c:be11:: with SMTP id k17mr1312693qvg.42.1619723274382;
 Thu, 29 Apr 2021 12:07:54 -0700 (PDT)
Date:   Thu, 29 Apr 2021 21:07:33 +0200
In-Reply-To: <20210429190734.624918-1-elver@google.com>
Message-Id: <20210429190734.624918-2-elver@google.com>
Mime-Version: 1.0
References: <20210429190734.624918-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 2/3] arm: Add compile-time asserts for siginfo_t offsets
From:   Marco Elver <elver@google.com>
To:     elver@google.com, ebiederm@xmission.com
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        davem@davemloft.net, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

To help catch ABI breaks at compile-time, add compile-time assertions to
verify the siginfo_t layout.

This could have caught that we cannot portably add 64-bit integers to
siginfo_t on 32-bit architectures like Arm before reaching -next:
https://lkml.kernel.org/r/20210422191823.79012-1-elver@google.com

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/arm/kernel/signal.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a3a38d0a4c85..2dac5d2c5cf6 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -725,3 +725,39 @@ asmlinkage void do_rseq_syscall(struct pt_regs *regs)
 	rseq_syscall(regs);
 }
 #endif
+
+/*
+ * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
+ * changes likely come with new fields that should be added below.
+ */
+static_assert(NSIGILL	== 11);
+static_assert(NSIGFPE	== 15);
+static_assert(NSIGSEGV	== 9);
+static_assert(NSIGBUS	== 5);
+static_assert(NSIGTRAP	== 6);
+static_assert(NSIGCHLD	== 6);
+static_assert(NSIGSYS	== 2);
+static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
+static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
+static_assert(offsetof(siginfo_t, si_code)	== 0x08);
+static_assert(offsetof(siginfo_t, si_pid)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_uid)	== 0x10);
+static_assert(offsetof(siginfo_t, si_tid)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_overrun)	== 0x10);
+static_assert(offsetof(siginfo_t, si_status)	== 0x14);
+static_assert(offsetof(siginfo_t, si_utime)	== 0x18);
+static_assert(offsetof(siginfo_t, si_stime)	== 0x1c);
+static_assert(offsetof(siginfo_t, si_value)	== 0x14);
+static_assert(offsetof(siginfo_t, si_int)	== 0x14);
+static_assert(offsetof(siginfo_t, si_ptr)	== 0x14);
+static_assert(offsetof(siginfo_t, si_addr)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x10);
+static_assert(offsetof(siginfo_t, si_lower)	== 0x14);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x18);
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x14);
+static_assert(offsetof(siginfo_t, si_perf)	== 0x10);
+static_assert(offsetof(siginfo_t, si_band)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_fd)	== 0x10);
+static_assert(offsetof(siginfo_t, si_call_addr)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_syscall)	== 0x10);
+static_assert(offsetof(siginfo_t, si_arch)	== 0x14);
-- 
2.31.1.527.g47e6f16901-goog

