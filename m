Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA4C7EE22
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjEDWPh (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjEDWPg (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD812082
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:15:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643912bca6fso891483b3a.0
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238534; x=1685830534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCs/9iBvrEyNVZzCTd/A2GImby0Xt44Wx/SBN2PNOfk=;
        b=oDB8u/9LgZXTgfCbjSWldZ8zjTY8Hxa2hGJSeLMG4PHF6mKOyi8FbO3jLxusmGF0cQ
         afxWbKqAVpaGKTTc1cRHpYz45IHwPP4EFUDxE9jllcihicq1oXwWm5EFpEeyS4LQQXP9
         it00pvupIn6NVZAAmhwrwR73a1tsmKRuebldI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238534; x=1685830534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCs/9iBvrEyNVZzCTd/A2GImby0Xt44Wx/SBN2PNOfk=;
        b=KjKk/0gUAL/AFsGSZxuE5dCAwrdHkFiM74fTqUMhYQMblBtZVC3eYhnsZv3c5L9GmE
         pwNdbUzajUoqZHazDW7IXIX8BZJ342rRQwbMYSJuILhcD2WPGPckdmG0LV6TvC6gc5UO
         QDn4KuVG77KSbzDblGCXJSFQb274aRksL6aegbw2XARDopv9oQ7qQQxQWef+VQw2Eqer
         PuChjM5nsGRyBsacgZCdsZLuk82wb1uTUK5cRq7l7JYE3aYfnN36qALSwV10PKA1O55m
         pRPPqMWd4rn+QnF5D6p68FrjR6AR28Tm0j3w+wDQruksn2B3ucvSec/HYDCauwnCVtNJ
         Q5LQ==
X-Gm-Message-State: AC+VfDzFip5MGEXYkFSOZMK0Br2mVT247dyEPM+yPnktqT91YpTwe3Do
        Uu66YxEZLkE7bd9lf8rv0uZYdw==
X-Google-Smtp-Source: ACHHUZ4bjw0v8Xh/Woiy1NQGEjRjWjT2i7Xc46n+u6XewoR1B1k66XrwvIaSaiBkKMffZjH8lkWATQ==
X-Received: by 2002:a05:6a00:c94:b0:643:cb0:2bbe with SMTP id a20-20020a056a000c9400b006430cb02bbemr4970419pfv.15.1683238534258;
        Thu, 04 May 2023 15:15:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 16/17] arm64: add hw_nmi_get_sample_period for preparation of lockup detector
Date:   Thu,  4 May 2023 15:13:48 -0700
Message-ID: <20230504151100.v4.16.Ia9d02578e89c3f44d3cb12eec8b0176603c8ab2f@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

Set safe maximum CPU frequency to 5 GHz in case a particular platform
doesn't implement cpufreq driver.
Although, architecture doesn't put any restrictions on
maximum frequency but 5 GHz seems to be safe maximum given the available
Arm CPUs in the market which are clocked much less than 5 GHz.

On the other hand, we can't make it much higher as it would lead to
a large hard-lockup detection timeout on parts which are running
slower (eg. 1GHz on Developerbox) and doesn't possess a cpufreq driver.

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

The only change I made here was to remove an extra blank line that
checkpatch complained about.

As mentioned in the cover letter, I'm not really expecting this patch
to land together with the patches for the buddy detector. I included
it with my series simply for convenience of testing both series
together.

NOTE: the previous patch posted by Lecopzer pointed to Sumit's
patch [2] in the commit text but provided no context. I moved it to
this "after the cut" note.

[1] https://lore.kernel.org/r/20220903093415.15850-6-lecopzer.chen@mediatek.com/
[2] http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org

Changes in v4:
- Pulled ("add hw_nmi_get_sample_period for ...") into my series for v4.

 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/watchdog_hld.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ceba6792f5b3..f8e2645406a4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..2401eb1b7e55
--- /dev/null
+++ b/arch/arm64/kernel/watchdog_hld.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpufreq.h>
+
+/*
+ * Safe maximum CPU frequency in case a particular platform doesn't implement
+ * cpufreq driver. Although, architecture doesn't put any restrictions on
+ * maximum frequency but 5 GHz seems to be safe maximum given the available
+ * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
+ * hand, we can't make it much higher as it would lead to a large hard-lockup
+ * detection timeout on parts which are running slower (eg. 1GHz on
+ * Developerbox) and doesn't possess a cpufreq driver.
+ */
+#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long max_cpu_freq;
+
+	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+	if (!max_cpu_freq)
+		max_cpu_freq = SAFE_MAX_CPU_FREQ;
+
+	return (u64)max_cpu_freq * watchdog_thresh;
+}
-- 
2.40.1.521.gf1e218fcd8-goog

