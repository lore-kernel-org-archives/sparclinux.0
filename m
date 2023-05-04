Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A6C7EE29
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEDWOv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEDWOv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:14:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8F120AB
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:14:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6434e65d808so1243832b3a.3
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238489; x=1685830489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/SVxTc3UaBCcYMvWm7ggGzatNZYd3WDIFJWHr8ve6I=;
        b=X19hszaOFSMqhUUTvYqKnpXKHrV30sSo3SEXBWBDST1p9/syYROS0IIkdVGQ+OBBwc
         UOUV1W8ZrnobxsdA2rBQzkXVu5EgyHEFKYEabCh94CIJFZVhDifB8A+4LlZoZY+RhnMN
         4c+Yj95+6/01UcWsLFOM6meTjnZu2KiTKN6lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238489; x=1685830489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/SVxTc3UaBCcYMvWm7ggGzatNZYd3WDIFJWHr8ve6I=;
        b=FOuIZPNB5LkXskwtndZnDoMW7HPhyJtXGc072hrohlbMZyaB1TaUTdBFKaqoxHfXXr
         yCGk2+7yUmAP2HbuCcRktlsVx1+LYM0I42xSF8LH59Y/QWGM2i+MeBKEDG1GZnc9KjBH
         VZhrT/efIgk0jIrKSwd01hm+zGMPQ8fnRuvS9qhacDJohY6ePzKlukLqEeFuUQJHHCI5
         YY8M8CpZ3L5rHzJTvBLdxlWEYoLD7rDpErHnsVxwHdiugnAZ2TM7WiyRxU1iVKBTSZOe
         Q/9+/LL1swYmfi3UBGVOexxTsGfc+uS4EHT3paw3ohqoqDnqJxdC9n/OxgkV6XBlyrAo
         z+kA==
X-Gm-Message-State: AC+VfDx87YiIfnG/UzO6w76LQuk7q0rmcFt5C4hJzlVj1fz+tqPDkkt1
        8NQR+dPEbi58Ahj4BrTyTcpPeQ==
X-Google-Smtp-Source: ACHHUZ6x6UvTHK1Uwv8WFmoIDk5oLTRQJtGFN81A04pmMS/WLo2rYeSvtpIwG+erMPl2na+euS5YjQ==
X-Received: by 2002:a05:6a00:1407:b0:643:59e7:e601 with SMTP id l7-20020a056a00140700b0064359e7e601mr4271042pfu.26.1683238489665;
        Thu, 04 May 2023 15:14:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:14:49 -0700 (PDT)
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
Subject: [PATCH v4 02/17] watchdog: remove WATCHDOG_DEFAULT
Date:   Thu,  4 May 2023 15:13:34 -0700
Message-ID: <20230504151100.v4.2.I6a729209a1320e0ad212176e250ff945b8f91b2a@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

No reference to WATCHDOG_DEFAULT, remove it.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
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

[1] https://lore.kernel.org/r/20220903093415.15850-2-lecopzer.chen@mediatek.com/

Changes in v4:
- Pulled ("remove WATCHDOG_DEFAULT") into my series for v4.

 kernel/watchdog.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..582d572e1379 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -30,10 +30,8 @@
 static DEFINE_MUTEX(watchdog_mutex);
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
-# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED | NMI_WATCHDOG_ENABLED)
 # define NMI_WATCHDOG_DEFAULT	1
 #else
-# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED)
 # define NMI_WATCHDOG_DEFAULT	0
 #endif
 
-- 
2.40.1.521.gf1e218fcd8-goog

