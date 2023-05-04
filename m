Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A9C77B7C
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjEDWO6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEDWO5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:14:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FF12085
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:14:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643465067d1so907769b3a.0
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238496; x=1685830496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7chyR54aRty46RzcCdMbqi2QxR3fWS0cburZo/9gxI=;
        b=NQpIfbqEUQKnsAkyEYKExasyztEP9wJ8o+4IEiw9BxrvOoB0l00+ORgkpCBLFkfl+F
         PivQOONxkj4PAVC2WcZaYn5EMh53GyKpOpu34BApx4vjHnolGOvX4v2oyvAKoW8Y73KU
         w1j4yU/Hk37qgrXBksSm+ZQ5W6g5IzmgjL538=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238496; x=1685830496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7chyR54aRty46RzcCdMbqi2QxR3fWS0cburZo/9gxI=;
        b=HjFR2U+/LbiJPyzrTX1qLCzBGp53RAoP2CaW9Riv6Vm/1ukcbSeisbzCv+iPGjBwWz
         Wu7kdPiRYcNPFUDjHQgjHAq7aAvH4RJ/s59XK7LW6HndEpcxDSEcVdV5AVZtTXofcnNJ
         r7QvEHCCfLve6hwFuGeqSigherN01y51krjnrnRVm5JEkRFb51VBJK1HOaEo6/+FkfG/
         Oxih3ySqwfs14wy6dpBstsgDa8usOC2LPyApErjTo7JiIhi9rGntJt30onb8w22Pr5ZQ
         TZfHEoS/AJs2y7dAVPBALqHxhXV/OaQ7e29aawImATdf+rbJAxkV+QK14Gz6RJmlURLT
         78uA==
X-Gm-Message-State: AC+VfDw758iza9EgUeufCjrtG+RWfuor3nLSS7IeTA5T8D9t6iGYzAX2
        UtPPhuL97Ppw8oT78ZvTZRJvZQ==
X-Google-Smtp-Source: ACHHUZ6RrkuuKPBgTlGYVBYmU7JHppwAnr7B5nmjdOCKHM4QBI81WKafubaC+FF4dnrAufHF9KP6jQ==
X-Received: by 2002:a05:6a00:2e06:b0:62d:8376:3712 with SMTP id fc6-20020a056a002e0600b0062d83763712mr4427628pfb.28.1683238496089;
        Thu, 04 May 2023 15:14:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:14:55 -0700 (PDT)
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
Subject: [PATCH v4 04/17] watchdog/perf: Ensure CPU-bound context when creating hardlockup detector event
Date:   Thu,  4 May 2023 15:13:36 -0700
Message-ID: <20230504151100.v4.4.I654063e53782b11d53e736a8ad4897ffd207406a@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

hardlockup_detector_event_create() should create perf_event on the
current CPU. Preemption could not get disabled because
perf_event_create_kernel_counter() allocates memory. Instead,
the CPU locality is achieved by processing the code in a per-CPU
bound kthread.

Add a check to prevent mistakes when calling the code in another
code path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Co-developed-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I yanked this patch from the mailing lists [1] into my series just to
make it easier to avoid conflicts between my series and the one adding
the arm64 perf hardlockup detector, in case someone wanted to test
them both together. This is a nice cleanup and could land together
with the rest of my series if that makes sense.

I changed the patch prefix to match others in my series.

[1] https://lore.kernel.org/r/20220903093415.15850-4-lecopzer.chen@mediatek.com/

Changes in v4:
- Pulled ("Ensure CPU-bound context when creating ...") into my series for v4.

 kernel/watchdog_hld.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..96b717205952 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -165,10 +165,16 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 static int hardlockup_detector_event_create(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
 	struct perf_event_attr *wd_attr;
 	struct perf_event *evt;
 
+	/*
+	 * Preemption is not disabled because memory will be allocated.
+	 * Ensure CPU-locality by calling this in per-CPU kthread.
+	 */
+	WARN_ON(!is_percpu_thread());
+	cpu = raw_smp_processor_id();
 	wd_attr = &wd_hw_attr;
 	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
 
-- 
2.40.1.521.gf1e218fcd8-goog

