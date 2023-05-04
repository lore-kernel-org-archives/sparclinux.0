Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB6AC7EE22
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjEDWPP (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDWPN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D9E11DB1
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:15:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6439df6c268so83826b3a.0
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238512; x=1685830512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs9dVqDn19dbFuBLpnSq6u/1X9XncQ7793Pg3nTbXSY=;
        b=YJROINNmnTriLPHEMGRffEEU5u5jgOZI+OjH5ib5+xogbKCty4xGU/gxTjvwZlF0Wq
         Y41ByV3ME3y2zIqQvZlfm5TvuytZulDOsfyDEiZk5uPDq5w5r51Z0+JrQfSi+OMn98zN
         vTuEboyeGfy9khGK+oRTXwvq0syqveXf6UD30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238512; x=1685830512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs9dVqDn19dbFuBLpnSq6u/1X9XncQ7793Pg3nTbXSY=;
        b=hASS6epIdoDkNhnkSzQwA+SZEeuPZ7ufIddpEBRP09jLzW/XsYbbsN6ljJNUzl9Cqc
         XXTWdW5e9v5BpHeTHS5f+7CN7Ox94vhmr4eyDaYPdRdS7JDNH7sXU2cucmW7aiBxgh4q
         Pf1pUggHo0kQxVCyEKh4rk2WNgaZ8e3N8XZNaMaYQK78uvirjgW2Doo0cRJQkut3ZV1f
         mRQbD5fTBoDuImIB7goeMB34CQINoLowl3GvUMG198lLbuCr3XBkjY9Xutw6B6XzDCRk
         0OJs9r/v60hZw9+OK2JzjY1Pz08myJfXHXMn0KkCUkz5NKxM9SsT7lknH41tRiyWltRM
         UUpg==
X-Gm-Message-State: AC+VfDyDucqYF4dXtw0Q2nXrMjQZOwW0yYMRpc1hiskhxN8+Cv8T6thG
        lt9TXJ37BPIdq1j9/IeHJu9GwA==
X-Google-Smtp-Source: ACHHUZ4Ssrt4fd2DGpbw/dz7xZl+zekrUKqrX4nrV4w3MwOPjKkeowMi5feC+Af+mzM8p4SVwo3IHQ==
X-Received: by 2002:a05:6a00:2284:b0:643:9b40:103e with SMTP id f4-20020a056a00228400b006439b40103emr1621714pfe.30.1683238512076;
        Thu, 04 May 2023 15:15:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:11 -0700 (PDT)
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
Subject: [PATCH v4 09/17] watchdog/hardlockup: Add a "cpu" param to watchdog_hardlockup_check()
Date:   Thu,  4 May 2023 15:13:41 -0700
Message-ID: <20230504151100.v4.9.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In preparation for the buddy hardlockup detector where the CPU
checking for lockup might not be the currently running CPU, add a
"cpu" parameter to watchdog_hardlockup_check().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("Add a "cpu" param to watchdog_hardlockup_check()") new for v4.

 include/linux/nmi.h    |  2 +-
 kernel/watchdog.c      | 47 ++++++++++++++++++++++++++++--------------
 kernel/watchdog_perf.c |  2 +-
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index c6cb9bc5dc80..2c9ea1ba285c 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -88,7 +88,7 @@ static inline void hardlockup_detector_disable(void) {}
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
-void watchdog_hardlockup_check(struct pt_regs *regs);
+void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #endif
 
 #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f46669c1671d..367bea0167a5 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -92,14 +92,14 @@ static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static DEFINE_PER_CPU(bool, watchdog_hardlockup_processed);
 static unsigned long watchdog_hardlockup_dumped_stacks;
 
-static bool watchdog_hardlockup_is_lockedup(void)
+static bool watchdog_hardlockup_is_lockedup(unsigned int cpu)
 {
-	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
+	unsigned long hrint = per_cpu(hrtimer_interrupts, cpu);
 
-	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
+	if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
 		return true;
 
-	__this_cpu_write(hrtimer_interrupts_saved, hrint);
+	per_cpu(hrtimer_interrupts_saved, cpu) = hrint;
 
 	return false;
 }
@@ -109,7 +109,7 @@ static void watchdog_hardlockup_interrupt_count(void)
 	__this_cpu_inc(hrtimer_interrupts);
 }
 
-void watchdog_hardlockup_check(struct pt_regs *regs)
+void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
 	/*
 	 * Check for a hardlockup by making sure the CPU's timer
@@ -117,35 +117,50 @@ void watchdog_hardlockup_check(struct pt_regs *regs)
 	 * fired multiple times before we overflow'd. If it hasn't
 	 * then this is a good indication the cpu is stuck
 	 */
-	if (watchdog_hardlockup_is_lockedup()) {
+	if (watchdog_hardlockup_is_lockedup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
+		struct cpumask backtrace_mask = *cpu_online_mask;
 
 		/* Only handle hardlockups once. */
-		if (__this_cpu_read(watchdog_hardlockup_processed))
+		if (per_cpu(watchdog_hardlockup_processed, cpu))
 			return;
 
-		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", this_cpu);
+		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
 		print_modules();
 		print_irqtrace_events(current);
-		if (regs)
+		if (regs) {
 			show_regs(regs);
-		else
-			dump_stack();
+			cpumask_clear_cpu(cpu, &backtrace_mask);
+		} else {
+			/*
+			 * If the locked up CPU is different than the CPU we're
+			 * running on then we'll try to backtrace the CPU that
+			 * locked up and then exclude it from later backtraces.
+			 * If that fails or if we're running on the locked up
+			 * CPU, just do a normal backtrace.
+			 */
+			if (cpu != this_cpu && trigger_single_cpu_backtrace(cpu)) {
+				cpumask_clear_cpu(cpu, &backtrace_mask);
+			} else {
+				dump_stack();
+				cpumask_clear_cpu(this_cpu, &backtrace_mask);
+			}
+		}
 
 		/*
-		 * Perform all-CPU dump only once to avoid multiple hardlockups
-		 * generating interleaving traces
+		 * Perform multi-CPU dump only once to avoid multiple
+		 * hardlockups generating interleaving traces
 		 */
 		if (sysctl_hardlockup_all_cpu_backtrace &&
 		    !test_and_set_bit(0, &watchdog_hardlockup_dumped_stacks))
-			trigger_allbutself_cpu_backtrace();
+			trigger_cpumask_backtrace(&backtrace_mask);
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-		__this_cpu_write(watchdog_hardlockup_processed, true);
+		per_cpu(watchdog_hardlockup_processed, cpu) = true;
 	} else {
-		__this_cpu_write(watchdog_hardlockup_processed, false);
+		per_cpu(watchdog_hardlockup_processed, cpu) = false;
 	}
 }
 
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 5f3651b87ee7..9be90b2a2ea7 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -120,7 +120,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	if (!watchdog_check_timestamp())
 		return;
 
-	watchdog_hardlockup_check(regs);
+	watchdog_hardlockup_check(smp_processor_id(), regs);
 }
 
 static int hardlockup_detector_event_create(void)
-- 
2.40.1.521.gf1e218fcd8-goog

