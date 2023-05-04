Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E199AC77B73
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEDWPa (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjEDWP3 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95688120AC
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:15:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643846c006fso1253884b3a.0
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238525; x=1685830525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+IwiO6BkZ386rQ6tL2riT/uUs/ukO+qpqxYGZg6Wtg=;
        b=RChb5tdEiUErPRm6Am0LrV9QKD9AKFEMsEq8ugriWkS2t2zfoJlG8fWH0vFeo/bhvt
         Y1YxG83D08cWbF978ljkScvrm24zk31mBCEdISAP0n58kvInAzGB3QVSrQ/R04/ezM5S
         547+ba/9aeEKVDXEKb1QgKyc6+agJHBDd3cyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238525; x=1685830525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+IwiO6BkZ386rQ6tL2riT/uUs/ukO+qpqxYGZg6Wtg=;
        b=XDEGbiRGSeb84spqQsqsf85LBOreSuwotK+EgnsMbtCsMsIb4ePRNaKjRpw8L72pBB
         p6cC0SZGC19XYV3dCyOSFFvoM6c3EE2+C/dR4yNjPtfFTuQpa+EJd+hXYHRPcH+TNhpC
         HSOfmsJGGakaem4rXwUSqvrSPB0N22XV/W5GzcAbO3M9bpJThhP+oNtUHMAvnh/pPOik
         LkJ2YzwSTUjD/kA0Xj8jKpgA0KSWbO8X1K7+8Lvi3iP6tKXhFjckNIqVhqoo32f3bmto
         SjJmP7wfkw23d/uG59oREqEulKeh6HK0ITyQURGPnDWvtR8S8gJ5PdCQ8PxdxR+8lDyY
         MoOg==
X-Gm-Message-State: AC+VfDx/82cfFiE/k9tNcTfYScgCCwd9Bgy8XUkpQz9D9VO1j8NkU/TG
        S8BAZRj2p305CDvbaUVq247njw==
X-Google-Smtp-Source: ACHHUZ6AuMOi7MOxZ52sSloOqCaLgLbh3Pvjc9+HvZIsFIUXihxHsWDuBIFX2bu4Qb79AtBjV1TAVg==
X-Received: by 2002:a05:6a20:1604:b0:f6:5a75:7d44 with SMTP id l4-20020a056a20160400b000f65a757d44mr4856999pzj.12.1683238524979;
        Thu, 04 May 2023 15:15:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:24 -0700 (PDT)
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
        Colin Cross <ccross@android.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using secondary (buddy) CPUs
Date:   Thu,  4 May 2023 15:13:45 -0700
Message-ID: <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Colin Cross <ccross@android.com>

Implement a hardlockup detector that doesn't doesn't need any extra
arch-specific support code to detect lockups. Instead of using
something arch-specific we will use the buddy system, where each CPU
watches out for another one. Specifically, each CPU will use its
softlockup hrtimer to check that the next CPU is processing hrtimer
interrupts by verifying that a counter is increasing.

NOTE: unlike the other hard lockup detectors, the buddy one can't
easily show what's happening on the CPU that locked up just by doing a
simple backtrace. It relies on some other mechanism in the system to
get information about the locked up CPUs. This could be support for
NMI backtraces like [1], it could be a mechanism for printing the PC
of locked CPUs at panic time like [2] / [3], or it could be something
else. Even though that means we still rely on arch-specific code, this
arch-specific code seems to often be implemented even on architectures
that don't have a hardlockup detector.

This style of hardlockup detector originated in some downstream
Android trees and has been rebased on / carried in ChromeOS trees for
quite a long time for use on arm and arm64 boards. Historically on
these boards we've leveraged mechanism [2] / [3] to get information
about hung CPUs, but we could move to [1].

Although the original motivation for the buddy system was for use on
systems without an arch-specific hardlockup detector, it can still be
useful to use even on systems that _do_ have an arch-specific
hardlockup detector. On x86, for instance, there is a 24-part patch
series [4] in progress switching the arch-specific hard lockup
detector from a scarce perf counter to a less-scarce hardware
resource. Potentially the buddy system could be a simpler alternative
to free up the perf counter but still get hard lockup detection.

Overall, pros (+) and cons (-) of the buddy system compared to an
arch-specific hardlockup detector (which might be implemented using
perf):
+ The buddy system is usable on systems that don't have an
  arch-specific hardlockup detector, like arm32 and arm64 (though it's
  being worked on for arm64 [5]).
+ The buddy system may free up scarce hardware resources.
+ If a CPU totally goes out to lunch (can't process NMIs) the buddy
  system could still detect the problem (though it would be unlikely
  to be able to get a stack trace).
+ The buddy system uses the same timer function to pet the hardlockup
  detector on the running CPU as it uses to detect hardlockups on
  other CPUs. Compared to other hardlockup detectors, this means it
  generates fewer interrupts and thus is likely better able to let
  CPUs stay idle longer.
- If all CPUs are hard locked up at the same time the buddy system
  can't detect it.
- If we don't have SMP we can't use the buddy system.
- The buddy system needs an arch-specific mechanism (possibly NMI
  backtrace) to get info about the locked up CPU.

[1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.org
[2] https://issuetracker.google.com/172213129
[3] https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
[4] https://lore.kernel.org/lkml/20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com/
[5] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecopzer.chen@mediatek.com/

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch has been rebased in ChromeOS kernel trees many times, and
each time someone had to do work on it they added their
Signed-off-by. I've included those here. I've also left the author as
Colin Cross since the core code is still his, even if it's now been
reorganized a lot.

Changes in v4:
- Reworked atop a whole pile of cleanups, as suggested by Petr.

Changes in v3:
- Added a note in commit message about the effect on idle.
- Cleaned up commit message pros/cons to be complete sentences.
- More cpu => CPU (in Kconfig and comments).
- No code changes other than comments.

Changes in v2:
- No code changes.
- Reworked description and Kconfig based on v1 discussion.
- cpu => CPU (in commit message).

 include/linux/nmi.h     |  9 +++-
 kernel/Makefile         |  1 +
 kernel/watchdog.c       | 29 +++++++++----
 kernel/watchdog_buddy.c | 93 +++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug       | 52 +++++++++++++++++++++--
 5 files changed, 173 insertions(+), 11 deletions(-)
 create mode 100644 kernel/watchdog_buddy.c

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 094a0e7ed97d..90aa33317b4c 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -87,8 +87,9 @@ extern unsigned int hardlockup_panic;
 static inline void hardlockup_detector_disable(void) {}
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER)
 void arch_touch_nmi_watchdog(void);
+void watchdog_hardlockup_touch_cpu(unsigned int cpu);
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #elif !defined(CONFIG_HAVE_NMI_WATCHDOG)
 static inline void arch_touch_nmi_watchdog(void) { }
@@ -118,6 +119,12 @@ void watchdog_hardlockup_disable(unsigned int cpu);
 
 void lockup_detector_reconfigure(void);
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
+void watchdog_buddy_check_hardlockup(unsigned long hrtimer_interrupts);
+#else
+static inline void watchdog_buddy_check_hardlockup(unsigned long hrtimer_interrupts) {}
+#endif
+
 /**
  * touch_hardlockup_watchdog - manually pet the hardlockup watchdog.
  *
diff --git a/kernel/Makefile b/kernel/Makefile
index 406ccccc4dd3..3f4f7975a8b8 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_BUDDY) += watchdog_buddy.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_perf.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index e21896a0a9d5..678d55172ef4 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -85,7 +85,7 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
 
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER)
 
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
@@ -106,6 +106,14 @@ notrace void arch_touch_nmi_watchdog(void)
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
+void watchdog_hardlockup_touch_cpu(unsigned int cpu)
+{
+	per_cpu(watchdog_hardlockup_touch, cpu) = true;
+
+	/* Match with smp_rmb() in watchdog_hardlockup_check() */
+	smp_wmb();
+}
+
 static bool watchdog_hardlockup_is_lockedup(unsigned int cpu)
 {
 	unsigned long hrint = per_cpu(hrtimer_interrupts, cpu);
@@ -118,13 +126,16 @@ static bool watchdog_hardlockup_is_lockedup(unsigned int cpu)
 	return false;
 }
 
-static void watchdog_hardlockup_interrupt_count(void)
+static unsigned long watchdog_hardlockup_interrupt_count(void)
 {
-	__this_cpu_inc(hrtimer_interrupts);
+	return __this_cpu_inc_return(hrtimer_interrupts);
 }
 
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
+	/* Match with smp_wmb() in watchdog_hardlockup_touch_cpu() */
+	smp_rmb();
+
 	if (__this_cpu_read(watchdog_hardlockup_touch)) {
 		__this_cpu_write(watchdog_hardlockup_touch, false);
 		return;
@@ -183,11 +194,11 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	}
 }
 
-#else /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
+#else /* CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER */
 
-static inline void watchdog_hardlockup_interrupt_count(void) { }
+static inline unsigned long watchdog_hardlockup_interrupt_count(void) { return 0; }
 
-#endif /* !CONFIG_HARDLOCKUP_DETECTOR_PERF */
+#endif /* !CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER */
 
 /*
  * These functions can be overridden based on the configured hardlockdup detector.
@@ -446,12 +457,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
+	unsigned long hrtimer_interrupts;
 
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
 
 	/* kick the hardlockup detector */
-	watchdog_hardlockup_interrupt_count();
+	hrtimer_interrupts = watchdog_hardlockup_interrupt_count();
+
+	/* test for hardlockups */
+	watchdog_buddy_check_hardlockup(hrtimer_interrupts);
 
 	/* kick the softlockup detector */
 	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
new file mode 100644
index 000000000000..fee45af2e5bd
--- /dev/null
+++ b/kernel/watchdog_buddy.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/nmi.h>
+#include <linux/percpu-defs.h>
+
+static cpumask_t __read_mostly watchdog_cpus;
+
+static unsigned int watchdog_next_cpu(unsigned int cpu)
+{
+	cpumask_t cpus = watchdog_cpus;
+	unsigned int next_cpu;
+
+	next_cpu = cpumask_next(cpu, &cpus);
+	if (next_cpu >= nr_cpu_ids)
+		next_cpu = cpumask_first(&cpus);
+
+	if (next_cpu == cpu)
+		return nr_cpu_ids;
+
+	return next_cpu;
+}
+
+int __init watchdog_hardlockup_probe(void)
+{
+	return 0;
+}
+
+void watchdog_hardlockup_enable(unsigned int cpu)
+{
+	unsigned int next_cpu;
+
+	/*
+	 * The new CPU will be marked online before the hrtimer interrupt
+	 * gets a chance to run on it. If another CPU tests for a
+	 * hardlockup on the new CPU before it has run its the hrtimer
+	 * interrupt, it will get a false positive. Touch the watchdog on
+	 * the new CPU to delay the check for at least 3 sampling periods
+	 * to guarantee one hrtimer has run on the new CPU.
+	 */
+	watchdog_hardlockup_touch_cpu(cpu);
+
+	/*
+	 * We are going to check the next CPU. Our watchdog_hrtimer
+	 * need not be zero if the CPU has already been online earlier.
+	 * Touch the watchdog on the next CPU to avoid false positive
+	 * if we try to check it in less then 3 interrupts.
+	 */
+	next_cpu = watchdog_next_cpu(cpu);
+	if (next_cpu < nr_cpu_ids)
+		watchdog_hardlockup_touch_cpu(next_cpu);
+
+	cpumask_set_cpu(cpu, &watchdog_cpus);
+}
+
+void watchdog_hardlockup_disable(unsigned int cpu)
+{
+	unsigned int next_cpu = watchdog_next_cpu(cpu);
+
+	/*
+	 * Offlining this CPU will cause the CPU before this one to start
+	 * checking the one after this one. If this CPU just finished checking
+	 * the next CPU and updating hrtimer_interrupts_saved, and then the
+	 * previous CPU checks it within one sample period, it will trigger a
+	 * false positive. Touch the watchdog on the next CPU to prevent it.
+	 */
+	if (next_cpu < nr_cpu_ids)
+		watchdog_hardlockup_touch_cpu(next_cpu);
+
+	cpumask_clear_cpu(cpu, &watchdog_cpus);
+}
+
+void watchdog_buddy_check_hardlockup(unsigned long hrtimer_interrupts)
+{
+	unsigned int next_cpu;
+
+	/*
+	 * Test for hardlockups every 3 samples. The sample period is
+	 *  watchdog_thresh * 2 / 5, so 3 samples gets us back to slightly over
+	 *  watchdog_thresh (over by 20%).
+	 */
+	if (hrtimer_interrupts % 3 != 0)
+		return;
+
+	/* check for a hardlockup on the next CPU */
+	next_cpu = watchdog_next_cpu(smp_processor_id());
+	if (next_cpu >= nr_cpu_ids)
+		return;
+
+	watchdog_hardlockup_check(next_cpu, NULL);
+}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 39d1d93164bd..a80f6b8a21eb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1025,10 +1025,55 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
 
 	  Say N if unsure.
 
-config HARDLOCKUP_DETECTOR_PERF
+# Both the "perf" and "buddy" hardlockup detectors count hrtimer
+# interrupts. This config enables functions managing this common code.
+config HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 	bool
 	select SOFTLOCKUP_DETECTOR
 
+config HARDLOCKUP_DETECTOR_PERF
+	bool
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF
+	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+
+config HARDLOCKUP_DETECTOR_BUDDY
+	bool
+	depends on SMP
+	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+
+# For hardlockup detectors you can have one directly provided by the arch
+# or use a "non-arch" one. If you're using a "non-arch" one that is
+# further divided the perf hardlockup detector (which, confusingly, needs
+# arch-provided perf support) and the buddy hardlockup detector (which just
+# needs SMP). In either case, using the "non-arch" code conflicts with
+# the NMI watchdog code (which is sometimes used directly and sometimes used
+# by the arch-provided hardlockup detector).
+config HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
+	bool
+	depends on (HAVE_HARDLOCKUP_DETECTOR_PERF || SMP) && !HAVE_NMI_WATCHDOG
+	default y
+
+config HARDLOCKUP_DETECTOR_PREFER_BUDDY
+	bool "Prefer the buddy CPU hardlockup detector"
+	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH && HAVE_HARDLOCKUP_DETECTOR_PERF && SMP
+	help
+	  Say Y here to prefer the buddy hardlockup detector over the perf one.
+
+	  With the buddy detector, each CPU uses its softlockup hrtimer
+	  to check that the next CPU is processing hrtimer interrupts by
+	  verifying that a counter is increasing.
+
+	  This hardlockup detector is useful on systems that don't have
+	  an arch-specific hardlockup detector or if resources needed
+	  for the hardlockup detector are better used for other things.
+
+# This will select the appropriate non-arch hardlockdup detector
+config HARDLOCKUP_DETECTOR_NON_ARCH
+	bool
+	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
+	select HARDLOCKUP_DETECTOR_BUDDY if !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
+	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
+
 #
 # Enables a timestamp based low pass filter to compensate for perf based
 # hard lockup detection which runs too fast due to turbo modes.
@@ -1043,9 +1088,10 @@ config HARDLOCKUP_CHECK_TIMESTAMP
 config HARDLOCKUP_DETECTOR
 	bool "Detect Hard Lockups"
 	depends on DEBUG_KERNEL && !S390
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_ARCH
+	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select LOCKUP_DETECTOR
-	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF
+	select HARDLOCKUP_DETECTOR_NON_ARCH if HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
+
 	help
 	  Say Y here to enable the kernel to act as a watchdog to detect
 	  hard lockups.
-- 
2.40.1.521.gf1e218fcd8-goog

