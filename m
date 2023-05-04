Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E598C77B7C
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEDWOs (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEDWOs (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:14:48 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4029112082
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:14:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so921501a12.3
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238486; x=1685830486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1z7mPfi+9kXcDKqT71sJAQGBxu7RyXh4JV2wfNk/es=;
        b=nIjoIkW3p03FUu+3GxCcNYkSzcj/lDeOENMDPI4fWfUDdG7bT08Sb+dJlzfLePSU5E
         mVGDvKwII6sScPmLx8Iom+7xMBMbGZTte6pLYZwgEDCl0uBaz3UERsDasZ//5a7Rt8ID
         KeoANLYDUm1QrguA2OgwX0v7dqA356HU4O/WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238486; x=1685830486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1z7mPfi+9kXcDKqT71sJAQGBxu7RyXh4JV2wfNk/es=;
        b=Sjvm+XfsET4DmcjpCn7XpcSWfP09yscOnazI3C1KvkuLj9WtEJIsq8qU67ioKrZg23
         yt0dEt9v8H+hyVOnCML7M6QCc80rPv4OXaOAYHi1mWOjc0ii9EVzvYhlL8/qrNLSRDSs
         PyZnMb+rSO94Q5BZW91WZQiFzTq1m/u5V9TEjkcr/RXWYtztQ34zmUdWalhoZynnbwYf
         JanykL4c4IkLoerDqGmYGdbCxDF3zJJZVZrrgNv5cId9cB6I3UCDfaskDmYPik8XtAJN
         chuS6hq2cgAWQg1JHqBBemBFScE3VPUSG61/vzD5NwDMceYKbYFCCkxVyqAFadNitcz7
         0dmA==
X-Gm-Message-State: AC+VfDy6hJgPnPqMakyVWn3smHPQn3/GNq6nFFPYQWtYZGZj76CLqY4j
        VX8iIcEOkzVQrmKs1kAE4fsb1A==
X-Google-Smtp-Source: ACHHUZ6srX3RLh0nySv1vg2bjN5I3jzdANZ2xcZbCkodBOlfCv7QBn4Vf3SuhK63bPEngQxlNTdd2A==
X-Received: by 2002:a05:6a20:7f8f:b0:f8:ac26:b899 with SMTP id d15-20020a056a207f8f00b000f8ac26b899mr4830221pzj.0.1683238486722;
        Thu, 04 May 2023 15:14:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:14:46 -0700 (PDT)
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
Subject: [PATCH v4 01/17] watchdog/perf: Define dummy watchdog_update_hrtimer_threshold() on correct config
Date:   Thu,  4 May 2023 15:13:33 -0700
Message-ID: <20230504151100.v4.1.I8cbb2f4fa740528fcfade4f5439b6cdcdd059251@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The real watchdog_update_hrtimer_threshold() is defined in
watchdog_hardlockup_perf.c. That file is included if
CONFIG_HARDLOCKUP_DETECTOR_PERF and the function is defined in that
file if CONFIG_HARDLOCKUP_CHECK_TIMESTAMP.

The dummy version of the function in "nmi.h" didn't get that quite
right. While this doesn't appear to be a huge deal, it's nice to make
it consistent.

Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("Define dummy watchdog_update_hrtimer_threshold() ...") new for v4.

 include/linux/nmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 048c0b9aa623..771d77b62bc1 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -197,7 +197,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
-    defined(CONFIG_HARDLOCKUP_DETECTOR)
+    defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 void watchdog_update_hrtimer_threshold(u64 period);
 #else
 static inline void watchdog_update_hrtimer_threshold(u64 period) { }
-- 
2.40.1.521.gf1e218fcd8-goog

