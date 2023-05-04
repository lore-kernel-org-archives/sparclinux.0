Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F3C7EE22
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjEDWPI (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEDWPH (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6712082
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:15:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso15802020b3a.0
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238506; x=1685830506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpsfA6UKB47krdPEGD/PrzVbXvpRWznF4QQZA2MqbCU=;
        b=Z0Cg9qHletOFAvqqVmZw7+26EFSWZpwbZiJS2V2FzLapfu8jT4QeFu5W5+Xv1jW0Oq
         GuoA3ZwWRVBan5ARtRKt+4DdoQDQBVFcxWi+ugzNZIgxtDb+wtJKzKidIFwdlM1tvBKd
         TTJJddtrSqAKaOI+ubOmwuYJysH9mu4yCN9nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238506; x=1685830506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpsfA6UKB47krdPEGD/PrzVbXvpRWznF4QQZA2MqbCU=;
        b=UQ0+MPStnJKHR8tx4Blq4KYOJsEtgeDG3C6juphJ10fmhtyJXUHgYo4L8ktvohHGJ9
         dtCU1VKsLZVq2kPh4+Fn+CBLGaTxbTu2LflpYMRgdCaBBD2ZmfQUcOY+MIFR3Asr+XBV
         cg1pQtaTo/0StTL9TiD5bQEWuVPs60DU0fjxv+ZHZqA8GlpWiZHclex6mG1pjd1YEiDK
         ndRDsx9mzzP1BVTnZ2qlaARQ/5OmspEl38jq2Ckn+RF1oAr02a1tzeTsQOf9NedYnLda
         Og+9xkVsUU+qTa5Qzvl4HHi1qRiuFpWuG39F2lRnypsHJS52U/tVfpYa6Qfsq/oAUs7W
         05zA==
X-Gm-Message-State: AC+VfDyuxxB5DH2GCcT4Jt2T8I+8/MrUJTu6z7sh40W/CVHfqNn/tnAn
        9orzpFgUAXU+Vu35tBiBkQK77g==
X-Google-Smtp-Source: ACHHUZ64Z5QeW0ZZuBfj8VjVBHEXIEO7+gyHgZ2DgxLg3p6tdlwuBFv++p3xyyGQU6N9iOTo3WaeRQ==
X-Received: by 2002:a05:6a20:938b:b0:f2:2185:8575 with SMTP id x11-20020a056a20938b00b000f221858575mr3718625pzh.23.1683238505737;
        Thu, 04 May 2023 15:15:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:04 -0700 (PDT)
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
Subject: [PATCH v4 07/17] watchdog/hardlockup: Move perf hardlockup checking/panic to common watchdog.c
Date:   Thu,  4 May 2023 15:13:39 -0700
Message-ID: <20230504151100.v4.7.Id4133d3183e798122dc3b6205e7852601f289071@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The perf hardlockup detector works by looking at interrupt counts and
seeing if they change from run to run. The interrupt counts are
managed by the common watchdog code via its watchdog_timer_fn().

Currently the API between the perf detector and the common code is a
function: is_hardlockup(). When the hard lockup detector sees that
function return true then it handles printing out debug info and
inducing a panic if necessary.

Let's change the API a little bit in preparation for the buddy
hardlockup detector. The buddy hardlockup detector wants to print
nearly the same debug info and have nearly the same panic
behavior. That means we want to move all that code to the common
file. For now, the code in the common file will only be there if the
perf hardlockup detector is enabled, but eventually it will be
selected by a common config.

Right now, this _just_ moves the code from the perf detector file to
the common file and changes the names. It doesn't make the changes
that the buddy hardlockup detector will need and doesn't do any style
cleanups. A future patch will do cleanup to make it more obvious what
changed.

With the above, we no longer have any callers of is_hardlockup()
outside of the "watchdog.c" file, so we can remove it from the header,
make it static, move it to the same "#ifdef" block as our new
watchdog_hardlockup_check(), and rename it to make it obvious it's
just for hardlockup detectors. While doing this, it can be noted that
even if no hardlockup detectors were configured the existing code used
to still have the code for counting/checking "hrtimer_interrupts" even
if the perf hardlockup detector wasn't configured. We didn't need to
do that, so move all the "hrtimer_interrupts" counting to only be
there if the perf hardlockup detector is configured as well.

This change is expected to be a no-op.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("Move perf hardlockup checking/panic ...") new for v4.

 include/linux/nmi.h    |  5 ++-
 kernel/watchdog.c      | 92 +++++++++++++++++++++++++++++++++---------
 kernel/watchdog_perf.c | 42 +------------------
 3 files changed, 78 insertions(+), 61 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 35d09d70f394..c6cb9bc5dc80 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -15,7 +15,6 @@
 void lockup_detector_init(void);
 void lockup_detector_soft_poweroff(void);
 void lockup_detector_cleanup(void);
-bool is_hardlockup(void);
 
 extern int watchdog_user_enabled;
 extern int nmi_watchdog_user_enabled;
@@ -88,6 +87,10 @@ extern unsigned int hardlockup_panic;
 static inline void hardlockup_detector_disable(void) {}
 #endif
 
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+void watchdog_hardlockup_check(struct pt_regs *regs);
+#endif
+
 #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
 # define NMI_WATCHDOG_SYSCTL_PERM	0644
 #else
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index c705a18b26bf..2d319cdf64b9 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -85,6 +85,78 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
 
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+
+static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
+static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+static DEFINE_PER_CPU(bool, hard_watchdog_warn);
+static unsigned long hardlockup_allcpu_dumped;
+
+static bool watchdog_hardlockup_is_lockedup(void)
+{
+	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
+
+	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
+		return true;
+
+	__this_cpu_write(hrtimer_interrupts_saved, hrint);
+	return false;
+}
+
+static void watchdog_hardlockup_interrupt_count(void)
+{
+	__this_cpu_inc(hrtimer_interrupts);
+}
+
+void watchdog_hardlockup_check(struct pt_regs *regs)
+{
+	/* check for a hardlockup
+	 * This is done by making sure our timer interrupt
+	 * is incrementing.  The timer interrupt should have
+	 * fired multiple times before we overflow'd.  If it hasn't
+	 * then this is a good indication the cpu is stuck
+	 */
+	if (watchdog_hardlockup_is_lockedup()) {
+		int this_cpu = smp_processor_id();
+
+		/* only print hardlockups once */
+		if (__this_cpu_read(hard_watchdog_warn) == true)
+			return;
+
+		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
+			 this_cpu);
+		print_modules();
+		print_irqtrace_events(current);
+		if (regs)
+			show_regs(regs);
+		else
+			dump_stack();
+
+		/*
+		 * Perform all-CPU dump only once to avoid multiple hardlockups
+		 * generating interleaving traces
+		 */
+		if (sysctl_hardlockup_all_cpu_backtrace &&
+				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
+			trigger_allbutself_cpu_backtrace();
+
+		if (hardlockup_panic)
+			nmi_panic(regs, "Hard LOCKUP");
+
+		__this_cpu_write(hard_watchdog_warn, true);
+		return;
+	}
+
+	__this_cpu_write(hard_watchdog_warn, false);
+	return;
+}
+
+#else /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
+
+static inline void watchdog_hardlockup_interrupt_count(void) { }
+
+#endif /* !CONFIG_HARDLOCKUP_DETECTOR_PERF */
+
 /*
  * These functions can be overridden if an architecture implements its
  * own hardlockup detector.
@@ -176,8 +248,6 @@ static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
 static DEFINE_PER_CPU(unsigned long, watchdog_report_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
 static int __init nowatchdog_setup(char *str)
@@ -312,22 +382,6 @@ static int is_softlockup(unsigned long touch_ts,
 }
 
 /* watchdog detector functions */
-bool is_hardlockup(void)
-{
-	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
-
-	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
-		return true;
-
-	__this_cpu_write(hrtimer_interrupts_saved, hrint);
-	return false;
-}
-
-static void watchdog_interrupt_count(void)
-{
-	__this_cpu_inc(hrtimer_interrupts);
-}
-
 static DEFINE_PER_CPU(struct completion, softlockup_completion);
 static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
 
@@ -359,7 +413,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		return HRTIMER_NORESTART;
 
 	/* kick the hardlockup detector */
-	watchdog_interrupt_count();
+	watchdog_hardlockup_interrupt_count();
 
 	/* kick the softlockup detector */
 	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index c3d8ceb149da..5f3651b87ee7 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -20,13 +20,11 @@
 #include <asm/irq_regs.h>
 #include <linux/perf_event.h>
 
-static DEFINE_PER_CPU(bool, hard_watchdog_warn);
 static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
 static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
 static DEFINE_PER_CPU(struct perf_event *, dead_event);
 static struct cpumask dead_events_mask;
 
-static unsigned long hardlockup_allcpu_dumped;
 static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
 notrace void arch_touch_nmi_watchdog(void)
@@ -122,45 +120,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	if (!watchdog_check_timestamp())
 		return;
 
-	/* check for a hardlockup
-	 * This is done by making sure our timer interrupt
-	 * is incrementing.  The timer interrupt should have
-	 * fired multiple times before we overflow'd.  If it hasn't
-	 * then this is a good indication the cpu is stuck
-	 */
-	if (is_hardlockup()) {
-		int this_cpu = smp_processor_id();
-
-		/* only print hardlockups once */
-		if (__this_cpu_read(hard_watchdog_warn) == true)
-			return;
-
-		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
-			 this_cpu);
-		print_modules();
-		print_irqtrace_events(current);
-		if (regs)
-			show_regs(regs);
-		else
-			dump_stack();
-
-		/*
-		 * Perform all-CPU dump only once to avoid multiple hardlockups
-		 * generating interleaving traces
-		 */
-		if (sysctl_hardlockup_all_cpu_backtrace &&
-				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
-			trigger_allbutself_cpu_backtrace();
-
-		if (hardlockup_panic)
-			nmi_panic(regs, "Hard LOCKUP");
-
-		__this_cpu_write(hard_watchdog_warn, true);
-		return;
-	}
-
-	__this_cpu_write(hard_watchdog_warn, false);
-	return;
+	watchdog_hardlockup_check(regs);
 }
 
 static int hardlockup_detector_event_create(void)
-- 
2.40.1.521.gf1e218fcd8-goog

