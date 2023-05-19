Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE9DC77B75
	for <sparclinux@archiver.kernel.org>; Fri, 19 May 2023 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjESRWa (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 May 2023 13:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjESRVx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 May 2023 13:21:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D551B7
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:21:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae54b623c2so31826235ad.3
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516884; x=1687108884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL6x11AHUdbqwPOBex8MH92mOu6poqhjfJN8Bz63N4s=;
        b=Pht+hrXlamhoKc3Sfk+JnwTbwmcG4p0AC6wXT9KK+YLT5G/A8PMg/Kgierf2mtzawr
         ClBv70BUaPRNqYHKjGkk7QBTOalxnZ8r6RtmZDQddTP1/P2XptlY4Z2wVzZmyx2mgkUl
         BcimCZ+ntm13VOGd+9TV47CPKcYCQWDP2CsA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516884; x=1687108884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL6x11AHUdbqwPOBex8MH92mOu6poqhjfJN8Bz63N4s=;
        b=Ne44OSR+fOPndyI2nQU5Id8JqjLWgwy/1f48sc+UIj7s/YMRjS6hvJwBR4VpuV83Ii
         kV+n6y7I61Mb7oIz1Sa5GsVwwL1Qs/a6KctxvYt//MJfZz+D4uxutJ9KLDL+nCdkxolD
         k5iS3ce8FXEhjJKf2GRSAMFRyKQQzdPWT9ZBIERCWc93V36xvi5s18m0Ag2/+r/cJwdQ
         IeYo3BBbWv/vi8Y7qcg1xFhA7D2biGEvEOAIFI3VoAy9cPVhmTlxmYQQty1+v0Ok+hwl
         L0nrxUVCoOuhX37PDa2v3QvXYR7wMULOExGwOhXI6MascqzFtjvoCp8EFz1GJpiStlQW
         kJwg==
X-Gm-Message-State: AC+VfDwlDWhGxP83UWePoxz4eyboLf+nU2lVqAPeYb2kP/xwaC+sES1x
        KLsczjmrrs/5WKSn9Th/gysPRw==
X-Google-Smtp-Source: ACHHUZ42iEc62iH4hoBzId667tClAxoJ0OHdYYIBvBIVMKi1bhk7AD73MYNJ7aE36NwledCLjmXG2w==
X-Received: by 2002:a17:902:e80b:b0:1a1:f5dd:2dce with SMTP id u11-20020a170902e80b00b001a1f5dd2dcemr3490112plg.6.1684516883784;
        Fri, 19 May 2023 10:21:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:21:23 -0700 (PDT)
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
Subject: [PATCH v5 15/18] watchdog/perf: Add a weak function for an arch to detect if perf can use NMIs
Date:   Fri, 19 May 2023 10:18:39 -0700
Message-ID: <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On arm64, NMI support needs to be detected at runtime. Add a weak
function to the perf hardlockup detector so that an architecture can
implement it to detect whether NMIs are available.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While I won't object to this patch landing, I consider it part of the
arm64 perf hardlockup effort. I would be OK with the earlier patches
in the series landing and then not landing ${SUBJECT} patch nor
anything else later.

I'll also note that, as an alternative to this, it would be nice if we
could figure out how to make perf_event_create_kernel_counter() fail
on arm64 if NMIs aren't available. Maybe we could add a "must_use_nmi"
element to "struct perf_event_attr"?

(no changes since v4)

Changes in v4:
- ("Add a weak function for an arch to detect ...") new for v4.

 include/linux/nmi.h    |  1 +
 kernel/watchdog_perf.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 47db14e7da52..eb616fc07c85 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -210,6 +210,7 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
+bool arch_perf_nmi_is_available(void);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 349fcd4d2abc..8ea00c4a24b2 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -234,12 +234,22 @@ void __init hardlockup_detector_perf_restart(void)
 	}
 }
 
+bool __weak __init arch_perf_nmi_is_available(void)
+{
+	return true;
+}
+
 /**
  * watchdog_hardlockup_probe - Probe whether NMI event is available at all
  */
 int __init watchdog_hardlockup_probe(void)
 {
-	int ret = hardlockup_detector_event_create();
+	int ret;
+
+	if (!arch_perf_nmi_is_available())
+		return -ENODEV;
+
+	ret = hardlockup_detector_event_create();
 
 	if (ret) {
 		pr_info("Perf NMI watchdog permanently disabled\n");
-- 
2.40.1.698.g37aff9b760-goog

