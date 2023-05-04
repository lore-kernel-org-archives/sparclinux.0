Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C137CC77B7C
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjEDWPW (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEDWPV (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB230120AC
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:15:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6434e65d808so1244081b3a.3
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238518; x=1685830518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+qgr9NPJGRKeZ2d/dxWaM/f3ro5RZR07kizkKPd5wY=;
        b=EuICYhk97DSFRkZuW9CQpMK+vzmqJIxZBFAC3weye10VIHwkOLuKXcH4zdUO2fkh8u
         tGu+f6LTbBWuYZyA0HooKjohl6C2ifP5WYxBn4WOmnUNQjIM9zA1mmXi22Xy4lCawOZQ
         mixx3An4IDYGxL6auK7sNaZOmwAzxobXmXc3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238518; x=1685830518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+qgr9NPJGRKeZ2d/dxWaM/f3ro5RZR07kizkKPd5wY=;
        b=Z3kwEcX2spd0iPhg2JsToIEqRm2IL5VY/PuKkgcAezF68l9xiPr1XMErSU9+pU3BjI
         ljkVh9z6XFtprALGn6NaUHXD0pcamhtV3/zLpFEIQ/u59pyHgedOY73ShSDcFCjGM+bD
         xmljwyh6latRyWaAQli44EEiOf+FHpmhv2OPYDEm2yhLHHzpf9Gpr1QJ0+TlNDkw7W5C
         yDx+fhFWhf0dx9Qbp9dhS947aK/OHjWNjNQXnqj8E+RWqRz4KiPZx0qutdA+rK+3a3Zr
         fKugeJn54sIoCc1H0RiXi9v6jbzjGjJCfdE3Wr35Tsr2SIi63lWrlhspW0jSKI1nCaf9
         w+1A==
X-Gm-Message-State: AC+VfDyq372KweAcZrU1sIyhL9Fl7k945kfoJa1xlkjus7Ia++ivUWP+
        Xk1fPCWtjC4N+egwQ2aKlpfDiQ==
X-Google-Smtp-Source: ACHHUZ4FP/GToLc9ozedaHHVtkAACNvi5upQAH/t/Q1DA+8Ihx3C0ZU6i5LxTt5j1LEokyObXVEXWw==
X-Received: by 2002:a05:6a00:230b:b0:63d:2d7d:b6f2 with SMTP id h11-20020a056a00230b00b0063d2d7db6f2mr4429958pfh.4.1683238518527;
        Thu, 04 May 2023 15:15:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:17 -0700 (PDT)
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
Subject: [PATCH v4 11/17] watchdog/hardlockup: Rename some "NMI watchdog" constants/function
Date:   Thu,  4 May 2023 15:13:43 -0700
Message-ID: <20230504151100.v4.11.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Do a search and replace of:
- NMI_WATCHDOG_ENABLED => HARD_WATCHDOG_ENABLED
- watchdog_nmi_ => watchdog_hardlockup_

Then update a few comments near where names were changed.

This is specifically to make it less confusing when we want to
introduce the buddy hardlockup detector, which isn't using NMIs.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("Rename some "NMI watchdog" constants/function ...") new for v4.

 arch/powerpc/include/asm/nmi.h            |  4 +-
 arch/powerpc/kernel/watchdog.c            | 12 ++---
 arch/powerpc/platforms/pseries/mobility.c |  4 +-
 arch/sparc/kernel/nmi.c                   |  4 +-
 include/linux/nmi.h                       | 14 +++---
 kernel/watchdog.c                         | 60 +++++++++++------------
 kernel/watchdog_perf.c                    |  2 +-
 7 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index c3c7adef74de..43bfd4de868f 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -5,10 +5,10 @@
 #ifdef CONFIG_PPC_WATCHDOG
 extern void arch_touch_nmi_watchdog(void);
 long soft_nmi_interrupt(struct pt_regs *regs);
-void watchdog_nmi_set_timeout_pct(u64 pct);
+void watchdog_hardlockup_set_timeout_pct(u64 pct);
 #else
 static inline void arch_touch_nmi_watchdog(void) {}
-static inline void watchdog_nmi_set_timeout_pct(u64 pct) {}
+static inline void watchdog_hardlockup_set_timeout_pct(u64 pct) {}
 #endif
 
 #ifdef CONFIG_NMI_IPI
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index dbcc4a793f0b..27d1f0dba5b3 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -438,7 +438,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
 	int cpu = smp_processor_id();
 
-	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
+	if (!(watchdog_enabled & HARD_WATCHDOG_ENABLED))
 		return HRTIMER_NORESTART;
 
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
@@ -479,7 +479,7 @@ static void start_watchdog(void *arg)
 		return;
 	}
 
-	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
+	if (!(watchdog_enabled & HARD_WATCHDOG_ENABLED))
 		return;
 
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
@@ -546,7 +546,7 @@ static void watchdog_calc_timeouts(void)
 	wd_timer_period_ms = watchdog_thresh * 1000 * 2 / 5;
 }
 
-void watchdog_nmi_stop(void)
+void watchdog_hardlockup_stop(void)
 {
 	int cpu;
 
@@ -554,7 +554,7 @@ void watchdog_nmi_stop(void)
 		stop_watchdog_on_cpu(cpu);
 }
 
-void watchdog_nmi_start(void)
+void watchdog_hardlockup_start(void)
 {
 	int cpu;
 
@@ -566,7 +566,7 @@ void watchdog_nmi_start(void)
 /*
  * Invoked from core watchdog init.
  */
-int __init watchdog_nmi_probe(void)
+int __init watchdog_hardlockup_probe(void)
 {
 	int err;
 
@@ -582,7 +582,7 @@ int __init watchdog_nmi_probe(void)
 }
 
 #ifdef CONFIG_PPC_PSERIES
-void watchdog_nmi_set_timeout_pct(u64 pct)
+void watchdog_hardlockup_set_timeout_pct(u64 pct)
 {
 	pr_info("Set the NMI watchdog timeout factor to %llu%%\n", pct);
 	WRITE_ONCE(wd_timeout_pct, pct);
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 643d309d1bd0..9475388235a3 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -758,7 +758,7 @@ static int pseries_migrate_partition(u64 handle)
 		goto out;
 
 	if (factor)
-		watchdog_nmi_set_timeout_pct(factor);
+		watchdog_hardlockup_set_timeout_pct(factor);
 
 	ret = pseries_suspend(handle);
 	if (ret == 0) {
@@ -774,7 +774,7 @@ static int pseries_migrate_partition(u64 handle)
 		pseries_cancel_migration(handle, ret);
 
 	if (factor)
-		watchdog_nmi_set_timeout_pct(0);
+		watchdog_hardlockup_set_timeout_pct(0);
 
 out:
 	vas_migration_handler(VAS_RESUME);
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 5dcf31f7e81f..9d9e29b75c43 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -282,7 +282,7 @@ __setup("nmi_watchdog=", setup_nmi_watchdog);
  * sparc specific NMI watchdog enable function.
  * Enables watchdog if it is not enabled already.
  */
-void watchdog_nmi_enable(unsigned int cpu)
+void watchdog_hardlockup_enable(unsigned int cpu)
 {
 	if (atomic_read(&nmi_active) == -1) {
 		pr_warn("NMI watchdog cannot be enabled or disabled\n");
@@ -303,7 +303,7 @@ void watchdog_nmi_enable(unsigned int cpu)
  * sparc specific NMI watchdog disable function.
  * Disables watchdog if it is not disabled already.
  */
-void watchdog_nmi_disable(unsigned int cpu)
+void watchdog_hardlockup_disable(unsigned int cpu)
 {
 	if (atomic_read(&nmi_active) == -1)
 		pr_warn_once("NMI watchdog cannot be enabled or disabled\n");
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 94ff84e1c8ec..4ff48f189ab1 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -75,9 +75,9 @@ static inline void reset_hung_task_detector(void) { }
  * handled differently because its value is not boolean, and the lockup
  * detectors are 'suspended' while 'watchdog_thresh' is equal zero.
  */
-#define NMI_WATCHDOG_ENABLED_BIT   0
+#define HARD_WATCHDOG_ENABLED_BIT  0
 #define SOFT_WATCHDOG_ENABLED_BIT  1
-#define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
+#define HARD_WATCHDOG_ENABLED     (1 << HARD_WATCHDOG_ENABLED_BIT)
 #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
@@ -120,11 +120,11 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 # endif
 #endif
 
-void watchdog_nmi_stop(void);
-void watchdog_nmi_start(void);
-int watchdog_nmi_probe(void);
-void watchdog_nmi_enable(unsigned int cpu);
-void watchdog_nmi_disable(unsigned int cpu);
+void watchdog_hardlockup_stop(void);
+void watchdog_hardlockup_start(void);
+int watchdog_hardlockup_probe(void);
+void watchdog_hardlockup_enable(unsigned int cpu);
+void watchdog_hardlockup_disable(unsigned int cpu);
 
 void lockup_detector_reconfigure(void);
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9c17090611f2..8e11b2b69e2c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -193,40 +193,40 @@ static inline void watchdog_hardlockup_interrupt_count(void) { }
  * These functions can be overridden if an architecture implements its
  * own hardlockup detector.
  *
- * watchdog_nmi_enable/disable can be implemented to start and stop when
+ * watchdog_hardlockup_enable/disable can be implemented to start and stop when
  * softlockup watchdog start and stop. The arch must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-void __weak watchdog_nmi_enable(unsigned int cpu)
+void __weak watchdog_hardlockup_enable(unsigned int cpu)
 {
 	hardlockup_detector_perf_enable();
 }
 
-void __weak watchdog_nmi_disable(unsigned int cpu)
+void __weak watchdog_hardlockup_disable(unsigned int cpu)
 {
 	hardlockup_detector_perf_disable();
 }
 
-/* Return 0, if a NMI watchdog is available. Error code otherwise */
-int __weak __init watchdog_nmi_probe(void)
+/* Return 0, if a hardlockup watchdog is available. Error code otherwise */
+int __weak __init watchdog_hardlockup_probe(void)
 {
 	return hardlockup_detector_perf_init();
 }
 
 /**
- * watchdog_nmi_stop - Stop the watchdog for reconfiguration
+ * watchdog_hardlockup_stop - Stop the watchdog for reconfiguration
  *
  * The reconfiguration steps are:
- * watchdog_nmi_stop();
+ * watchdog_hardlockup_stop();
  * update_variables();
- * watchdog_nmi_start();
+ * watchdog_hardlockup_start();
  */
-void __weak watchdog_nmi_stop(void) { }
+void __weak watchdog_hardlockup_stop(void) { }
 
 /**
- * watchdog_nmi_start - Start the watchdog after reconfiguration
+ * watchdog_hardlockup_start - Start the watchdog after reconfiguration
  *
- * Counterpart to watchdog_nmi_stop().
+ * Counterpart to watchdog_hardlockup_stop().
  *
  * The following variables have been updated in update_variables() and
  * contain the currently valid configuration:
@@ -234,13 +234,13 @@ void __weak watchdog_nmi_stop(void) { }
  * - watchdog_thresh
  * - watchdog_cpumask
  */
-void __weak watchdog_nmi_start(void) { }
+void __weak watchdog_hardlockup_start(void) { }
 
 /**
  * lockup_detector_update_enable - Update the sysctl enable bit
  *
- * Caller needs to make sure that the NMI/perf watchdogs are off, so this
- * can't race with watchdog_nmi_disable().
+ * Caller needs to make sure that the hard watchdogs are off, so this
+ * can't race with watchdog_hardlockup_disable().
  */
 static void lockup_detector_update_enable(void)
 {
@@ -248,7 +248,7 @@ static void lockup_detector_update_enable(void)
 	if (!watchdog_user_enabled)
 		return;
 	if (nmi_watchdog_available && nmi_watchdog_user_enabled)
-		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
+		watchdog_enabled |= HARD_WATCHDOG_ENABLED;
 	if (soft_watchdog_user_enabled)
 		watchdog_enabled |= SOFT_WATCHDOG_ENABLED;
 }
@@ -552,8 +552,8 @@ static void watchdog_enable(unsigned int cpu)
 	/* Initialize timestamp */
 	update_touch_ts();
 	/* Enable the perf event */
-	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
-		watchdog_nmi_enable(cpu);
+	if (watchdog_enabled & HARD_WATCHDOG_ENABLED)
+		watchdog_hardlockup_enable(cpu);
 }
 
 static void watchdog_disable(unsigned int cpu)
@@ -563,11 +563,11 @@ static void watchdog_disable(unsigned int cpu)
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
 	/*
-	 * Disable the perf event first. That prevents that a large delay
-	 * between disabling the timer and disabling the perf event causes
-	 * the perf NMI to detect a false positive.
+	 * Disable the hardlockup detector first. That prevents that a large
+	 * delay between disabling the timer and disabling the hardlockup
+	 * detector causes a false positive.
 	 */
-	watchdog_nmi_disable(cpu);
+	watchdog_hardlockup_disable(cpu);
 	hrtimer_cancel(hrtimer);
 	wait_for_completion(this_cpu_ptr(&softlockup_completion));
 }
@@ -623,7 +623,7 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 static void __lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
-	watchdog_nmi_stop();
+	watchdog_hardlockup_stop();
 
 	softlockup_stop_all();
 	set_sample_period();
@@ -631,7 +631,7 @@ static void __lockup_detector_reconfigure(void)
 	if (watchdog_enabled && watchdog_thresh)
 		softlockup_start_all();
 
-	watchdog_nmi_start();
+	watchdog_hardlockup_start();
 	cpus_read_unlock();
 	/*
 	 * Must be called outside the cpus locked section to prevent
@@ -672,9 +672,9 @@ static __init void lockup_detector_setup(void)
 static void __lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
-	watchdog_nmi_stop();
+	watchdog_hardlockup_stop();
 	lockup_detector_update_enable();
-	watchdog_nmi_start();
+	watchdog_hardlockup_start();
 	cpus_read_unlock();
 }
 void lockup_detector_reconfigure(void)
@@ -731,10 +731,10 @@ static void proc_watchdog_update(void)
  *
  * caller             | table->data points to      | 'which'
  * -------------------|----------------------------|--------------------------
- * proc_watchdog      | watchdog_user_enabled      | NMI_WATCHDOG_ENABLED |
+ * proc_watchdog      | watchdog_user_enabled      | HARD_WATCHDOG_ENABLED |
  *                    |                            | SOFT_WATCHDOG_ENABLED
  * -------------------|----------------------------|--------------------------
- * proc_nmi_watchdog  | nmi_watchdog_user_enabled  | NMI_WATCHDOG_ENABLED
+ * proc_nmi_watchdog  | nmi_watchdog_user_enabled  | HARD_WATCHDOG_ENABLED
  * -------------------|----------------------------|--------------------------
  * proc_soft_watchdog | soft_watchdog_user_enabled | SOFT_WATCHDOG_ENABLED
  */
@@ -768,7 +768,7 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 int proc_watchdog(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return proc_watchdog_common(NMI_WATCHDOG_ENABLED|SOFT_WATCHDOG_ENABLED,
+	return proc_watchdog_common(HARD_WATCHDOG_ENABLED|SOFT_WATCHDOG_ENABLED,
 				    table, write, buffer, lenp, ppos);
 }
 
@@ -780,7 +780,7 @@ int proc_nmi_watchdog(struct ctl_table *table, int write,
 {
 	if (!nmi_watchdog_available && write)
 		return -ENOTSUPP;
-	return proc_watchdog_common(NMI_WATCHDOG_ENABLED,
+	return proc_watchdog_common(HARD_WATCHDOG_ENABLED,
 				    table, write, buffer, lenp, ppos);
 }
 
@@ -944,7 +944,7 @@ void __init lockup_detector_init(void)
 	cpumask_copy(&watchdog_cpumask,
 		     housekeeping_cpumask(HK_TYPE_TIMER));
 
-	if (!watchdog_nmi_probe())
+	if (!watchdog_hardlockup_probe())
 		nmi_watchdog_available = true;
 	lockup_detector_setup();
 	watchdog_sysctl_init();
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 547917ebd5d3..aadc52b79f5b 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -215,7 +215,7 @@ void __init hardlockup_detector_perf_restart(void)
 
 	lockdep_assert_cpus_held();
 
-	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
+	if (!(watchdog_enabled & HARD_WATCHDOG_ENABLED))
 		return;
 
 	for_each_online_cpu(cpu) {
-- 
2.40.1.521.gf1e218fcd8-goog

