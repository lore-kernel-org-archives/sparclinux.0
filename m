Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD22C7EE2F
	for <sparclinux@archiver.kernel.org>; Sat, 27 May 2023 01:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbjE0Bmq (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 May 2023 21:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbjE0Bmn (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 26 May 2023 21:42:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C9E6C
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso1223281b3a.1
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151741; x=1687743741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pTZ8PdJlA6i+SWNusBTmTzOcCRT41PhrexiQIb/AKs=;
        b=dGhxmHD/CSkrIECymGSZJgjulMjULoIls2yt2guqhtavg8UVpzegqrUgkex1Az5eH9
         7o8tE1sfBCLwp5jGYATbBDjOwYfBLu2wLAWmL4Fu2votApVdW9ieYsPlWvXbTAoEZCRx
         IE9pmuxtKBeT5vr2dhEgDDxn0u6fSztfVGgQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151741; x=1687743741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pTZ8PdJlA6i+SWNusBTmTzOcCRT41PhrexiQIb/AKs=;
        b=jKECR61AM01j759cBGccoobiMjrYB/ZRnCGQCeLJvrpzFz4Iw/G4SspxA4YI/Ezc2z
         5cKlL6sxxZSBy3b7tE19QZnSMnYbKnGv4MJAy4//ADovj7vnA5DHyJllnn7ZuTnN9lQN
         KnY7kFU52a7Ffa51eBNWnJp+BSj9Qqb7/Xv+Ev7XhY+XoccKuBpHz4G5I2Bjt9Cz3aT0
         GbPhV9NLOnbX4XGqY6qG61gM4w2VgsumkApxPjCfRsM9BEUPyt8Zg4jdafEeUzf0SSrH
         vbxVyOFR1jYk6XgV33OvISs8ZbdLO0ktthgKYAZ7+43j58LO3ijQiZNem972OLPxaXdb
         +l2Q==
X-Gm-Message-State: AC+VfDw5JR6cd9/BuujFjRO5XIUxxiUEc5zFAq3xeOUfEaaujT3+9JoP
        57C7BiiI+zF4g24iRNEF21GGWw==
X-Google-Smtp-Source: ACHHUZ5UUsITWZmTwpdRkqyumpngtWqGIdFge6BCERd9qHLdsT3GhYY3Nylr4mH6Rilg/sSJVj2BfQ==
X-Received: by 2002:a05:6a00:139c:b0:64c:ae1c:33ac with SMTP id t28-20020a056a00139c00b0064cae1c33acmr7231420pfg.25.1685151741546;
        Fri, 26 May 2023 18:42:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 03/10] watchdog/hardlockup: Don't use raw_cpu_ptr() in watchdog_hardlockup_kick()
Date:   Fri, 26 May 2023 18:41:33 -0700
Message-ID: <20230526184139.3.I660e103077dcc23bb29aaf2be09cb234e0495b2d@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In the patch ("watchdog/hardlockup: add a "cpu" param to
watchdog_hardlockup_check()") there was no reason to use
raw_cpu_ptr(). Using this_cpu_ptr() works fine.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 62230f5b8878..32dac8028753 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -133,7 +133,7 @@ static bool is_hardlockup(unsigned int cpu)
 
 static unsigned long watchdog_hardlockup_kick(void)
 {
-	return atomic_inc_return(raw_cpu_ptr(&hrtimer_interrupts));
+	return atomic_inc_return(this_cpu_ptr(&hrtimer_interrupts));
 }
 
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
-- 
2.41.0.rc0.172.g3f132b7071-goog

