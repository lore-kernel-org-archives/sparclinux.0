Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7DC7EE22
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjEDWPY (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEDWPW (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576F12082
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:15:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-642f5394651so996109b3a.3
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238521; x=1685830521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpNx2mefmmTFSIK86nVDDorYanqvx1+R+XQHbD6HO+g=;
        b=WPcSR3R7jjK9WrSlZYb1jvNciRB2tdefqvLGeYiNPDqqWmjVz76xSEIkx9VYfhmfMR
         hY1BRmupeZu5pqlCKLwiWpnysWXfjKKqOEd3mfitJulaCUffZuMC9LYQGtee8IH2dMLT
         euN8Ii5incOonQ2VMHl1cexqG3i6r/ETrbuH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238521; x=1685830521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpNx2mefmmTFSIK86nVDDorYanqvx1+R+XQHbD6HO+g=;
        b=GJg6KexqU37zJyMMttgUqB9fjHol4iaO1vOerNeAhUp0Wvb3WTHGWzfkIFp5/+KzuL
         42cHTbv+G3OGnLUnCC+tmBUac38wObaLoedbo++FD1fz+UDl9OXC4lCJnnA5d4SWTuFg
         FHNCte8hHxk+jlDHnTLnIV51fu/e4P8/n+bziqC5p/XPx0eB7OTuR3OScLbbRzUzDJS4
         4pryRiW4L4UVtxBI8Giu+wJ6m2BwRScJXIbcn3s+v5rh3cFEzXIQyHNAsbgbQ+RfmWxZ
         Sa1+aY1l4rlgNYKlFb+t7VUOE/Wq8cF/iXG/+MWnhj56X+xH1CsqjTf99mpZ47VZupOR
         lddg==
X-Gm-Message-State: AC+VfDyi6PNB4bX7DtaO6WUiLFBYRrcosEK/EqN9A6OeAfN0nKucEcKC
        mzIG8rcu32Mz30sxjGJf36uZZQ==
X-Google-Smtp-Source: ACHHUZ5AX06YNKlkJIQ1gYhAYjAuz3cGg3jKF0Ccmbxhyk2anQXzj3z0TcEAc0/o771Fvgq/6YT5Uw==
X-Received: by 2002:a05:6a00:2352:b0:63f:158a:6e7b with SMTP id j18-20020a056a00235200b0063f158a6e7bmr5043905pfj.6.1683238521355;
        Thu, 04 May 2023 15:15:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:20 -0700 (PDT)
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
Subject: [PATCH v4 12/17] watchdog/hardlockup: Have the perf hardlockup use __weak functions more cleanly
Date:   Thu,  4 May 2023 15:13:44 -0700
Message-ID: <20230504151100.v4.12.I847d9ec852449350997ba00401d2462a9cb4302b@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The fact that there watchdog_hardlockup_enable(),
watchdog_hardlockup_disable(), and watchdog_hardlockup_probe() are
declared __weak means that the configured hardlockup detector can
define non-weak versions of those functions if it needs to. Instead of
doing this, the perf hardlockup detector hooked itself into the
default __weak implementation, which was a bit awkward. Clean this up.

From comments, it looks as if the original design was done because the
__weak function were expected to implemented by the architecture and
not by the configured hardlockup detector. This got awkward when we
tried to add the buddy lockup detector which was not arch-specific but
wanted to hook into those same functions.

This is not expected to have any functional impact.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("Have the perf hardlockup use __weak ...") new for v4.

 include/linux/nmi.h    | 10 ----------
 kernel/watchdog.c      | 30 ++++++++++++++++++------------
 kernel/watchdog_perf.c | 20 ++++++++++++++------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 4ff48f189ab1..094a0e7ed97d 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -103,21 +103,11 @@ static inline void arch_touch_nmi_watchdog(void) { }
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
-extern void hardlockup_detector_perf_disable(void);
-extern void hardlockup_detector_perf_enable(void);
 extern void hardlockup_detector_perf_cleanup(void);
-extern int hardlockup_detector_perf_init(void);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
-static inline void hardlockup_detector_perf_disable(void) { }
-static inline void hardlockup_detector_perf_enable(void) { }
 static inline void hardlockup_detector_perf_cleanup(void) { }
-# if !defined(CONFIG_HAVE_NMI_WATCHDOG)
-static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
-# else
-static inline int hardlockup_detector_perf_init(void) { return 0; }
-# endif
 #endif
 
 void watchdog_hardlockup_stop(void);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e11b2b69e2c..e21896a0a9d5 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -190,27 +190,33 @@ static inline void watchdog_hardlockup_interrupt_count(void) { }
 #endif /* !CONFIG_HARDLOCKUP_DETECTOR_PERF */
 
 /*
- * These functions can be overridden if an architecture implements its
- * own hardlockup detector.
+ * These functions can be overridden based on the configured hardlockdup detector.
  *
  * watchdog_hardlockup_enable/disable can be implemented to start and stop when
- * softlockup watchdog start and stop. The arch must select the
+ * softlockup watchdog start and stop. The detector must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-void __weak watchdog_hardlockup_enable(unsigned int cpu)
-{
-	hardlockup_detector_perf_enable();
-}
+void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
 
-void __weak watchdog_hardlockup_disable(unsigned int cpu)
-{
-	hardlockup_detector_perf_disable();
-}
+void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
 
 /* Return 0, if a hardlockup watchdog is available. Error code otherwise */
 int __weak __init watchdog_hardlockup_probe(void)
 {
-	return hardlockup_detector_perf_init();
+	/*
+	 * If CONFIG_HAVE_NMI_WATCHDOG is defined then an architecture
+	 * is assumed to have the hard watchdog available and we return 0.
+	 */
+	if (IS_ENABLED(CONFIG_HAVE_NMI_WATCHDOG))
+		return 0;
+
+	/*
+	 * Hardlockup detectors other than those using CONFIG_HAVE_NMI_WATCHDOG
+	 * are required to implement a non-weak version of this probe function
+	 * to tell whether they are available. If they don't override then
+	 * we'll return -ENODEV.
+	 */
+	return -ENODEV;
 }
 
 /**
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index aadc52b79f5b..a55a6eab1b3a 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -132,10 +132,14 @@ static int hardlockup_detector_event_create(void)
 }
 
 /**
- * hardlockup_detector_perf_enable - Enable the local event
+ * watchdog_hardlockup_enable - Enable the local event
+ *
+ * @cpu: The CPU to enable hard lockup on.
  */
-void hardlockup_detector_perf_enable(void)
+void watchdog_hardlockup_enable(unsigned int cpu)
 {
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
 	if (hardlockup_detector_event_create())
 		return;
 
@@ -147,12 +151,16 @@ void hardlockup_detector_perf_enable(void)
 }
 
 /**
- * hardlockup_detector_perf_disable - Disable the local event
+ * watchdog_hardlockup_disable - Disable the local event
+ *
+ * @cpu: The CPU to enable hard lockup on.
  */
-void hardlockup_detector_perf_disable(void)
+void watchdog_hardlockup_disable(unsigned int cpu)
 {
 	struct perf_event *event = this_cpu_read(watchdog_ev);
 
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
 	if (event) {
 		perf_event_disable(event);
 		this_cpu_write(watchdog_ev, NULL);
@@ -227,9 +235,9 @@ void __init hardlockup_detector_perf_restart(void)
 }
 
 /**
- * hardlockup_detector_perf_init - Probe whether NMI event is available at all
+ * watchdog_hardlockup_probe - Probe whether NMI event is available at all
  */
-int __init hardlockup_detector_perf_init(void)
+int __init watchdog_hardlockup_probe(void)
 {
 	int ret = hardlockup_detector_event_create();
 
-- 
2.40.1.521.gf1e218fcd8-goog

