Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD12C77B7C
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEDWPe (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEDWPd (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C8120AB
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:15:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6434e65d808so1244212b3a.3
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238531; x=1685830531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb+ov5fy8GT79FMmcyf1ZMUm58eKGi3E0UeboMl9k0k=;
        b=CjMBjXb4dakIH/Hz1W+AbgyxL0xcYhy7OZZf09KX3sDf9yAF4rhCtWuKzwEhAs+5/i
         hEzlyTV4xhw3Mp/uMdYzUq9UGSlBG4bqWtY9NWExnwuQfYOMW8tNfC51A60DvQW7afZn
         h/GwPSH86KKBgViH3tcM+m/6e9fAaR1bB8IPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238531; x=1685830531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb+ov5fy8GT79FMmcyf1ZMUm58eKGi3E0UeboMl9k0k=;
        b=gqJGv4+Au8zqSVMtOZ7Oj5fKV6uIxRXkfqXd/sy8nCQ09R9xWGZ01/KL5/9kcDKDS3
         zA91lICrTxKsvmX8eQhCLTYa0jMM51pMoYZ3LfArPDc82XQ0IgzKVd4nehm7h+gvEo+m
         QIkx7vZYxSCFaeniODDHAJSKtYraXQblT18MUwofh3wHRap9cvUQQsOqT3em4iB/uP4L
         2jLjehWnirsYjsPPT137lXE6ae+JDq/vN2feFR43u1H8eLXAr3fxa1FUeQe9AmGqbuF2
         GmkjZth3jLYsSMO6LBJBIuBcEyP0DzYE2s2qsh5aUOhaL3XkDFXtE18M+3PxKD43FIBD
         lsXQ==
X-Gm-Message-State: AC+VfDzEEoIyCi+Pk4rExydHAX2BBe4TqZjz5L6PkDbbNw8D1Vb9NRxS
        lRsaXMxdERBLQQzJtEKKJuzzdQ==
X-Google-Smtp-Source: ACHHUZ4X6wdGMyW/UcCstp1VEpR79rnk9KRzJXDwHbVx8n04QbMhxm2ST+x4EIRRDKqxPh/P32rORQ==
X-Received: by 2002:a05:6a00:80f:b0:5a8:8535:18b with SMTP id m15-20020a056a00080f00b005a88535018bmr4857970pfk.11.1683238531276;
        Thu, 04 May 2023 15:15:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:30 -0700 (PDT)
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
Subject: [PATCH v4 15/17] watchdog/perf: Adapt the watchdog_perf interface for async model
Date:   Thu,  4 May 2023 15:13:47 -0700
Message-ID: <20230504151100.v4.15.If4ad5dd5d09fb1309cebf8bcead4b6a5a7758ca7@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

When lockup_detector_init()->watchdog_hardlockup_probe(), PMU may be
not ready yet. E.g. on arm64, PMU is not ready until
device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
with the driver model and cpuhp. Hence it is hard to push this
initialization before smp_init().

But it is easy to take an opposite approach and try to initialize
the watchdog once again later.
The delayed probe is called using workqueues. It need to allocate
memory and must be proceed in a normal context.
The delayed probe is able to use if watchdog_hardlockup_probe() returns
non-zero which means the return code returned when PMU is not ready yet.

Provide an API - lockup_detector_retry_init() for anyone who needs
to delayed init lockup detector if they had ever failed at
lockup_detector_init().

The original assumption is: nobody should use delayed probe after
lockup_detector_check() which has __init attribute.
That is, anyone uses this API must call between lockup_detector_init()
and lockup_detector_check(), and the caller must have __init attribute

Reviewed-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I yanked this patch from the mailing lists [1] into my series just to
make it easier to avoid conflicts between my series and the one adding
the arm64 perf hardlockup detector, in case someone wanted to test
them both together.

As part of making this match with my series, I resolved a few
conflicts and did a few renames. I also fixed the kernel test robot
yell [2] by providing a dummy implementation of the retry function if
CONFIG_LOCKUP_DETECTOR wasn't defined. That led me to move the
definition of the function and sanitize the name of the function to
match others around it.

This patch makes less sense without the patches to add support for the
arm64 perf hardlockup detector. Thus, I've put it at the end of the
series.

I removed the "kernel test robot" tag since that didn't really make
sense. Presumably the robot found a problem on a previous version of
the patch, but that's not normally a reason to add the Reported-by.

[1] https://lore.kernel.org/r/20220903093415.15850-5-lecopzer.chen@mediatek.com/
[2] https://lore.kernel.org/r/202209050639.jDaWd49E-lkp@intel.com/

Changes in v4:
- Pulled ("Adapt the watchdog_hld interface ...") into my series for v4.

 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 9caea5ba494d..3cacc5fc16b9 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_LOCKUP_DETECTOR
 void lockup_detector_init(void);
+void lockup_detector_retry_init(void);
 void lockup_detector_soft_poweroff(void);
 void lockup_detector_cleanup(void);
 
@@ -34,6 +35,7 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
+static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 678d55172ef4..55471634d932 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -211,7 +211,13 @@ void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
 
 void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
 
-/* Return 0, if a hardlockup watchdog is available. Error code otherwise */
+/*
+ * Watchdog-detector specific API.
+ *
+ * Return 0 when hardlockup watchdog is available, negative value otherwise.
+ * Note that the negative value means that a delayed probe might
+ * succeed later.
+ */
 int __weak __init watchdog_hardlockup_probe(void)
 {
 	/*
@@ -957,6 +963,62 @@ static void __init watchdog_sysctl_init(void)
 #define watchdog_sysctl_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+static void __init lockup_detector_delay_init(struct work_struct *work);
+static bool allow_lockup_detector_init_retry __initdata;
+
+static struct work_struct detector_work __initdata =
+		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
+
+static void __init lockup_detector_delay_init(struct work_struct *work)
+{
+	int ret;
+
+	ret = watchdog_hardlockup_probe();
+	if (ret) {
+		pr_info("Delayed init of the lockup detector failed: %d\n", ret);
+		pr_info("Hard watchdog permanently disabled\n");
+		return;
+	}
+
+	allow_lockup_detector_init_retry = false;
+
+	nmi_watchdog_available = true;
+	lockup_detector_setup();
+}
+
+/*
+ * lockup_detector_retry_init - retry init lockup detector if possible.
+ *
+ * Retry hardlockup detector init. It is useful when it requires some
+ * functionality that has to be initialized later on a particular
+ * platform.
+ */
+void __init lockup_detector_retry_init(void)
+{
+	/* Must be called before late init calls */
+	if (!allow_lockup_detector_init_retry)
+		return;
+
+	schedule_work(&detector_work);
+}
+
+/*
+ * Ensure that optional delayed hardlockup init is proceed before
+ * the init code and memory is freed.
+ */
+static int __init lockup_detector_check(void)
+{
+	/* Prevent any later retry. */
+	allow_lockup_detector_init_retry = false;
+
+	/* Make sure no work is pending. */
+	flush_work(&detector_work);
+
+	return 0;
+
+}
+late_initcall_sync(lockup_detector_check);
+
 void __init lockup_detector_init(void)
 {
 	if (tick_nohz_full_enabled())
@@ -967,6 +1029,9 @@ void __init lockup_detector_init(void)
 
 	if (!watchdog_hardlockup_probe())
 		nmi_watchdog_available = true;
+	else
+		allow_lockup_detector_init_retry = true;
+
 	lockup_detector_setup();
 	watchdog_sysctl_init();
 }
-- 
2.40.1.521.gf1e218fcd8-goog

