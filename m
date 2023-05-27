Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44481C77B73
	for <sparclinux@archiver.kernel.org>; Sat, 27 May 2023 01:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbjE0Bms (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 May 2023 21:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbjE0Bmo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 26 May 2023 21:42:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15923E73
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1172704b3a.2
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151743; x=1687743743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYlDoP4hBUi1FEPJVk5SoicXju51KfuvgdrLi507k6g=;
        b=gGebBDgShZ+uN8dr+HtKBh/CQRIJdRl3JqouzIec7Inm884gWhnWsPBrktTgLBZqXK
         0Vn2L9wyjn0IxKnQRYUzz2PDRwxJ3dxbO49ReX7U7tQFaXawnlPxAsmZ8tisnLvHt2wy
         vVnzj/jVyWUESXQN92jj0oJ3Exaj1AaFGtAnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151743; x=1687743743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYlDoP4hBUi1FEPJVk5SoicXju51KfuvgdrLi507k6g=;
        b=Wlg9UeLWAWb+AsR745WIdLUQxrTZnA9+k6jerkECyLkghouMr/Vhjp1QnTdG3fufTg
         JmNv3Lj9av1Nv5ctmD4pGDvjLijsVWsYFWK6FMDpu+ckdR+QMQNtDQI1lpZjDMm3mZjZ
         3K72XHqQq8Oe/3PyqbxMgbXZoy3OZJFGTXLNDrCAx9W/P2Fro+EhNrPWslnzmRIgitj0
         6MmrBkRgxaz18/jHDPrqsoPz/jaw4Su+3JBSQUTb7Kav6y52W5oRpEuy6XK9kOSnVxjc
         nXfN4g2e6M18tHMKgJYvkXQJzCHoTQdqDywS+yYm70FHzvEcJXtf6TB2/oQMOM/aqMWh
         yibA==
X-Gm-Message-State: AC+VfDz+WNGjvC48oYbc3es2xWOCGHCDuNrKETHrqkyx689B8UmlQhuU
        o1bp3n26EhNGoQJXcAa+exh0Cg==
X-Google-Smtp-Source: ACHHUZ6PdCEKx9zc9UIjD6M27djXcRY5u4ncxaUOpt/n6iXeRwmVg57h5L9TsPisjROyLLUKXE2Imw==
X-Received: by 2002:a05:6a21:9985:b0:101:2ad0:1347 with SMTP id ve5-20020a056a21998500b001012ad01347mr1527991pzb.23.1685151743331;
        Fri, 26 May 2023 18:42:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 04/10] watchdog/hardlockup: In watchdog_hardlockup_check() use cpumask_copy()
Date:   Fri, 26 May 2023 18:41:34 -0700
Message-ID: <20230526184139.4.Iccee2d1ea19114dafb6553a854ea4d8ab2a3f25b@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In the patch ("watchdog/hardlockup: add a "cpu" param to
watchdog_hardlockup_check()") we started using a cpumask to keep track
of which CPUs to backtrace. When setting up this cpumask, it's better
to use cpumask_copy() than to just copy the structure directly. Fix this.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 32dac8028753..85f4839b6faf 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -154,7 +154,9 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	 */
 	if (is_hardlockup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
-		struct cpumask backtrace_mask = *cpu_online_mask;
+		struct cpumask backtrace_mask;
+
+		cpumask_copy(&backtrace_mask, cpu_online_mask);
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
-- 
2.41.0.rc0.172.g3f132b7071-goog

