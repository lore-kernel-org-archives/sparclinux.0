Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F07C77B75
	for <sparclinux@archiver.kernel.org>; Fri, 19 May 2023 17:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjESRWp (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 May 2023 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjESRWJ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 May 2023 13:22:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682CE40
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:21:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-253340db64fso3409805a91.2
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516894; x=1687108894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrP+bq8OuhPbpRrmH69BUF/ETBoN12s5FsuLw9NdkoQ=;
        b=KkHmwe229DgAVffDLLznQfZWYuRIjXT+TDyQaWKGhvDfbVO2pTXwGDMq0uniEUc2pr
         PrWIBYD5RByt6+6OuFJh3BfSsmjMjr+HVbYZDUr8BC7pa7Ol2rviQXeKqKzIVrcEOc/5
         3zOswXTomM9TSMrnUjjTtNDfYXbvYca89iJE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516894; x=1687108894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrP+bq8OuhPbpRrmH69BUF/ETBoN12s5FsuLw9NdkoQ=;
        b=YWjpelvrpFOlV5tjxQnGUevAULSMmMIXP+tUnT8U3YpNLUOe1GI2lxR88pwHLsydea
         Zm4Vew0ZtGK9vqwExkLl431rFisMf+Xu0Z8H48dFGI81fodIV0Q9L7Dbg9yT/RhgJjHT
         1zoO84jOvK1sI2Wf6Hs8AIrLI/sXpNYh78QECbBKfuJVmPM7hc1veL+sydPkTWjO3ux2
         5TBdrmHXeqfdsVRGkYa5q7qyj1eLvMjC+8KxzS6eUQ1F4JDF4sIrvclN+uym7DxWGFru
         d45l+nBGiG/5Wx2rKSSaxYdHcpFnFsjRGukYyXYIF0nMeVqwfkwQbzXihS1AVQepS4V6
         GmLg==
X-Gm-Message-State: AC+VfDxyLQa8l/c/nIWtRCnz1efCIj+7iBhS+rdVp9cX+2IPUo8BaB3v
        I094plYFYNZKUDLF05V9yS4KDQ==
X-Google-Smtp-Source: ACHHUZ54/kcRAIYK35dSsdk2yWtyGoA/hM9uTSr2W1P6Cx1odcfE7RiCCJfOYdeD35/q03bKDA/ezA==
X-Received: by 2002:a17:90a:f2d1:b0:24e:3a0a:9b48 with SMTP id gt17-20020a17090af2d100b0024e3a0a9b48mr2771022pjb.21.1684516893906;
        Fri, 19 May 2023 10:21:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:21:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v5 18/18] arm64: Enable perf events based hard lockup detector
Date:   Fri, 19 May 2023 10:18:42 -0700
Message-ID: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
Message-ID: <20230519171842.7AA_sBAHkFZkrQKv9oZddtazPoFsKxVwNeV9MwWVacs@z>

With the recent feature added to enable perf events to use pseudo NMIs
as interrupts on platforms which support GICv3 or later, its now been
possible to enable hard lockup detector (or NMI watchdog) on arm64
platforms. So enable corresponding support.

One thing to note here is that normally lockup detector is initialized
just after the early initcalls but PMU on arm64 comes up much later as
device_initcall(). To cope with that, override
arch_perf_nmi_is_available() to let the watchdog framework know PMU
not ready, and inform the framework to re-initialize lockup detection
once PMU has been initialized.

Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I yanked this patch from the mailing lists [1] into my series just to
make it easier to avoid conflicts between my series and the one adding
the arm64 perf hardlockup detector, in case someone wanted to test
them both together.

As part of making this match with my series, I needed to resolve
conflicts with the patch ("watchdog/hardlockup: Have the perf
hardlockup use __weak functions more cleanly"). This makes ${SUBJECT}
patch now depend on the patch ("watchdog/perf: Add a weak function for
an arch to detect if perf can use NMIs"). As talked about in that
patch, there may be better alternatives to accomplish the same thing.

As mentioned in the cover letter, I'm not really expecting this patch
to land together with the patches for the buddy detector. I included
it with my series simply for convenience of testing both series
together.

NOTE: the previous patch posted by Lecopzer pointed to Sumit's
patch [2] in the commit text but provided no context. I moved it to
this "after the cut" note.

[1] https://lore.kernel.org/r/20220903093415.15850-7-lecopzer.chen@mediatek.com/
[2] http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org

(no changes since v4)

Changes in v4:
- Pulled ("Enable perf events based hard ...") into my series for v4.

 arch/arm64/Kconfig               |  2 ++
 arch/arm64/kernel/watchdog_hld.c | 12 ++++++++++++
 drivers/perf/arm_pmu.c           |  5 +++++
 drivers/perf/arm_pmuv3.c         | 12 ++++++++++--
 include/linux/perf/arm_pmu.h     |  2 ++
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d25a8a4..b3718e538f18 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -203,12 +203,14 @@ config ARM64
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KVM
 	select HAVE_NMI
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
index 2401eb1b7e55..dcd25322127c 100644
--- a/arch/arm64/kernel/watchdog_hld.c
+++ b/arch/arm64/kernel/watchdog_hld.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/nmi.h>
 #include <linux/cpufreq.h>
+#include <linux/perf/arm_pmu.h>
 
 /*
  * Safe maximum CPU frequency in case a particular platform doesn't implement
@@ -22,3 +24,13 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 
 	return (u64)max_cpu_freq * watchdog_thresh;
 }
+
+bool __init arch_perf_nmi_is_available(void)
+{
+	/*
+	 * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns off,
+	 * however, the pmu interrupts will act like a normal interrupt instead of
+	 * NMI and the hardlockup detector would be broken.
+	 */
+	return arm_pmu_irq_is_nmi();
+}
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 15bd1e34a88e..7b9caa502d33 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -687,6 +687,11 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 	return per_cpu(hw_events->irq, cpu);
 }
 
+bool arm_pmu_irq_is_nmi(void)
+{
+	return has_nmi;
+}
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index c98e4039386d..7b28d65f3f1c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
+#include <linux/nmi.h>
 
 #include <asm/arm_pmuv3.h>
 
@@ -1348,10 +1349,17 @@ static struct platform_driver armv8_pmu_driver = {
 
 static int __init armv8_pmu_driver_init(void)
 {
+	int ret;
+
 	if (acpi_disabled)
-		return platform_driver_register(&armv8_pmu_driver);
+		ret = platform_driver_register(&armv8_pmu_driver);
 	else
-		return arm_pmu_acpi_probe(armv8_pmuv3_pmu_init);
+		ret = arm_pmu_acpi_probe(armv8_pmuv3_pmu_init);
+
+	if (!ret)
+		lockup_detector_retry_init();
+
+	return ret;
 }
 device_initcall(armv8_pmu_driver_init)
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 525b5d64e394..5b00f5cb4cf9 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -171,6 +171,8 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
 #define kvm_host_pmu_init(x)	do { } while(0)
 #endif
 
+bool arm_pmu_irq_is_nmi(void);
+
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 void armpmu_free(struct arm_pmu *pmu);
-- 
2.40.1.698.g37aff9b760-goog

