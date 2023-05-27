Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE20C77B73
	for <sparclinux@archiver.kernel.org>; Sat, 27 May 2023 01:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjE0Bm2 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 May 2023 21:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242713AbjE0Bm1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 26 May 2023 21:42:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8FE46
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so1221689b3a.0
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151736; x=1687743736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Wyvy6HPwlh6VYOHfNA0dxsOkmR5hf4tUOLdIYH19M=;
        b=jVupxr9tkpNoY2DPpNO8ve9RV3dt+XdDWaO2WoRtWo7O726zDUiL2HAAxcH6LHl3N4
         zg+XiJ3Z3hMClz9oQWCKKIy9P9nGkLhMbC/8iyvrxOUDtLp+WDuMwpTv3zKUdQXrfkDP
         KJUkxWt47+5T+11hbTnQ8sD/sndKaFgdvy0fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151736; x=1687743736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8Wyvy6HPwlh6VYOHfNA0dxsOkmR5hf4tUOLdIYH19M=;
        b=I53oWJmeLT/NrJMyW6+QB4xuOn7kjB1SKfpm4yjBjyTm0K/4OLGOQRIut5oeqdzl1L
         X00jNFS6fJRFaq/8JxSEr1DbPSErgCvh/IzGIQUZIpud+bdeF6xAuFkpcAArFM7o7jTm
         CGvfPFXnLhLFizjAgwlHEVVx7JGMvhasX0V4GsoCrSxsIYSUHHM29mfVfoQDclxh02SL
         QWvBdhbgQO81jgicrTBkpwhPV+vIfybJz2sAZWCWNx/0Dd/niKb5ZXT30AOeN9peUKp+
         SRwo64z0PSuva9pGQTdEFkz+mDmWBEqfRbnBzupd5IjWvg3wFKILiM6PSLX9cG4htn5q
         dQgA==
X-Gm-Message-State: AC+VfDwbPwjfKZ8QVyJU6uim+WrxCgwTR5U2caRTDdf7w0r2ZUQsoFFr
        sSGiqo7G+zSnunrMq81mj6QQvQ==
X-Google-Smtp-Source: ACHHUZ4GAy/oEImCC0hpOXpTjNUo0Dhy+rQj32IqoVkt1EVytgp7ZHhTjG/XebwId5tT/CXJZBdMDQ==
X-Received: by 2002:a05:6a00:190e:b0:63b:8afe:a4dc with SMTP id y14-20020a056a00190e00b0063b8afea4dcmr5524785pfi.30.1685151736256;
        Fri, 26 May 2023 18:42:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:15 -0700 (PDT)
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
Subject: [PATCH 00/10] watchdog: Cleanup / fixes after buddy series v5 reviews
Date:   Fri, 26 May 2023 18:41:30 -0700
Message-ID: <20230527014153.2793931-1-dianders@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org


This patch series attempts to finish resolving the feedback received
from Petr Mladek on the v5 series I posted. Andrew has already landed
v5 so I'm posting this as additional patches.

Probably the only thing that wasn't fully as clean as Petr requested
was the Kconfig stuff. I couldn't find a better way to express it
without a more major overhaul. In the very least, I renamed "NON_ARCH"
to "PERF_OR_BUDDY" in the hopes that will make it marginally better.

Nothing in this series is terribly critical and even the bugfixes are
small. However, it does cleanup a few things that were pointed out in
review.


Douglas Anderson (10):
  watchdog/hardlockup: Keep kernel.nmi_watchdog sysctl as 0444 if probe
    fails
  watchdog/hardlockup: HAVE_NMI_WATCHDOG must implement
    watchdog_hardlockup_probe()
  watchdog/hardlockup: Don't use raw_cpu_ptr() in
    watchdog_hardlockup_kick()
  watchdog/hardlockup: In watchdog_hardlockup_check() use cpumask_copy()
  watchdog/hardlockup: remove softlockup comment in touch_nmi_watchdog()
  watchdog/buddy: Cleanup how watchdog_buddy_check_hardlockup() is
    called
  watchdog/buddy: Don't copy the cpumask in watchdog_next_cpu()
  watchdog/buddy: Simplify the dependency for
    HARDLOCKUP_DETECTOR_PREFER_BUDDY
  watchdog/hardlockup: Move SMP barriers from common code to buddy code
  watchdog/hardlockup: Rename HAVE_HARDLOCKUP_DETECTOR_NON_ARCH to
    ..._PERF_OR_BUDDY

 arch/Kconfig            |  3 +-
 arch/sparc/kernel/nmi.c |  5 +++
 include/linux/nmi.h     | 14 ++-------
 kernel/watchdog.c       | 68 ++++++++++++++++++-----------------------
 kernel/watchdog_buddy.c | 28 ++++++++++++++---
 lib/Kconfig.debug       | 14 ++++-----
 6 files changed, 70 insertions(+), 62 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog

