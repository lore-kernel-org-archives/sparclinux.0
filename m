Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2EC77B75
	for <sparclinux@archiver.kernel.org>; Fri, 19 May 2023 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjESRUk (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 May 2023 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjESRUj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 May 2023 13:20:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2FD13D
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:20:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2533b600d35so3417788a91.1
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516836; x=1687108836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcKzcYzYTZLG2nDvQef2x8WAMRY3aTirA8QisUYpW0A=;
        b=La2URlLW5xfUppCkz6BkzZUabLIBjUwielPNciYlED4YjCMdp7hku1DktWBt4Xha06
         iwgsRmn9zaJFpDA3vzA9Dq4dm7Jgh73iITo2Le8ppleJ2cpFMiL/PECgfF7ZaZQTGYco
         +zstxAQ6sVkkJeMZ9E5zOHfVA8uyGsQwbbXRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516836; x=1687108836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcKzcYzYTZLG2nDvQef2x8WAMRY3aTirA8QisUYpW0A=;
        b=inxdxge2P3eQoHT6dWB8DUKWiFxBOBbF/2X/HnwUJvSGzzz5wnMOXnY5XRqe9XP7UD
         SQGBjX/LkYEKOFwzCm8gm3XmrvgFuFMsLq0uEAAzM9z4XzuILIo1Vj6NghVonQd/30mM
         JoWbdPqVH9xNTmYyb61aowvd7hq3d+QexEWqEg4fn+IypSXzHwWhtmvxAHBjq5szTQDs
         1SopMcIJZhSSar95t6+U/smyZLAfAaavFYub/3rypMPwb8+d6YQf3oCLggvCHQbrasKn
         DJ4JIeekqayYj1par3ZPr9OdtTiwuZhBWaZJevMnw26HrOv5znCEgdZnP4K6N5TOU3Rc
         7aUg==
X-Gm-Message-State: AC+VfDwfsEDKxgRsul2Q+AYg/eeSfXDEOfi6c2nbXIjFFazW0eHQstLh
        plPjrSPrz+QNDXyqVqYX/gPCpA==
X-Google-Smtp-Source: ACHHUZ4hDUeMHVYrX2euzNv2R/s3WP9WbOBP1pwBAIY9hCSu2995yvMlGen/TKfGIcJ0wTAtmE7fHQ==
X-Received: by 2002:a17:90a:c789:b0:253:3ed3:b212 with SMTP id gn9-20020a17090ac78900b002533ed3b212mr2491137pjb.20.1684516836306;
        Fri, 19 May 2023 10:20:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:20:35 -0700 (PDT)
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
Subject: [PATCH v5 00/18] watchdog/hardlockup: Add the buddy hardlockup detector
Date:   Fri, 19 May 2023 10:18:24 -0700
Message-ID: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

This patch series adds the "buddy" hardlockup detector. In brief, the
buddy hardlockup detector can detect hardlockups without arch-level
support by having CPUs checkup on a "buddy" CPU periodically. All the
details are in the patch ("watchdog/hardlockup: detect hard lockups
using secondary (buddy) CPUs") and I encourage folks to reply to that
patch for general comments about this approach.

Note that in v3, this was a single patch [1]. It's now exploded into a
much larger series. The much larger series does a bunch of cleanup
that Petr requested in response to v3 [2] [3]. This new series ends up
sharing a lot more code with the perf lockup detector. It also tries
to bring a little sanity to some of the naming we had.

v5 of this series attempts to resolve comments made against v4. It
also fixes a bug that I had introduced between v3 and v4 where
watchdog_hardlockup_check() was reading watchdog_hardlockup_touch from
the wrong CPU. As somewhat expected there was debate about some of the
naming in the v4 responses. I've mostly tended to stick with Petr
Mladek's opinions here.

The fact that this series now touches across the whole lockup detector
codebase also caused conflicts with the series trying to add a arm64
perf-based hardlockup detector. That was a bit incovenient for me
since I was testing on arm64 and wanted to make sure that the perf
and buddy hardlockup detectors both compiled and worked. Because of
this, I've pulled the latest arm64 perf-based lockup detector patches
into my series. Specifically:
- Patches #1 - #3 of the arm64 perf-based lockup detector patches were
  generic cleanups. I added them early in my series. IMO these should
  just land.
- Patches #4 - #6 of the arm64 perf-based lockup detector patches were
  less generic but still caused conflict with my series. I tacked them
  to the end of my series after adapting them to my changes. However,
  I don't really consider them part of this series and I'd be OK if
  the series landed without them. For use cases I'm aware of the buddy
  system is sufficient and I see no urgent need to land the arm64 perf
  hardlockup support, though I also don't have any strong objections
  to the patches.

I will note that this patch series currently has no conflicts with the
other patch series I posed recently adding support for pseudo-NMI
based backtraces [5] and the two patches series are meant to work
together.

Given the new design of this patch series, testing all combinations is
fairly difficult. I've attempted to make sure that all combinations of
CONFIG_ options are good, but it wouldn't surprise me if I missed
something. I apologize in advance and I'll do my best to fix any
problems that are found.

I'll also note that the CC list is pretty giant. Some of this is based
on get_maintainers and some of this is people I thought might be
interested. Now that this series is touching so many files, I've
stopped auto-CCing everyone that get_maintainers suggests. I'll reply
to v3 and point at this patch to make sure folks are aware of it, but
if I stopped CCing you and you want back on then please yell.

As far as I can tell, there's no true MAINTAINER listed for the
existing watchdog code. Assuming people don't hate this, maybe it
would go through Andrew Morton's tree? There is now some arch-specific
code for sparc and powerpc, but it's all still watchdog code so
hopefully that would still be fine to go through the same tree.

[1] https://lore.kernel.org/r/20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid
[2] https://lore.kernel.org/r/ZFEqynvf5nqkzEvQ@alley
[3] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley
[4] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecopzer.chen@mediatek.com/
[5] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.org

Changes in v5:
- ("More properly prevent false ...") promoted to its own patch for v5.
- Add Nicholas's explanation of why this didn't break builds.
- Don't dump stack on the buddy CPU if we fail to backtrace the hung CPU.
- Fixed wrong __this_cpu to per_cpu (oops).
- Found a few more names / comments to change.
- Move side effect (timestamp check ordering) to its own patch.
- No longer rename touch_nmi_watchdog(), just add comments.
- Tried to make names more consistent as per v4 feedback.
- Use atomic_t for hrtimer_interrupts.
- watchdog_hardlockup_dumped_stacks => watchdog_hardlockup_all_cpu_dumped
- watchdog_hardlockup_interrupt_count() => watchdog_hardlockup_kick()
- watchdog_hardlockup_is_lockedup() => is_hardlockup()
- watchdog_hardlockup_perf.c => kernel/watchdog_hld.c in description.
- watchdog_hardlockup_processed => watchdog_hardlockup_warned
- watchdog_hardlockup_touch => watchdog_hardlockup_touched.

Changes in v4:
- ("Add a "cpu" param to watchdog_hardlockup_check()") new for v4.
- ("Add a weak function for an arch to detect ...") new for v4.
- ("Define dummy watchdog_update_hrtimer_threshold() ...") new for v4.
- ("Have the perf hardlockup use __weak ...") new for v4.
- ("Move perf hardlockup checking/panic ...") new for v4.
- ("Move perf hardlockup watchdog petting to watchdog.c") new for v4.
- ("Rename some "NMI watchdog" constants/function ...") new for v4.
- ("Rename touch_nmi_watchdog() to ...") new for v4.
- ("Rename watchdog_hld.c to watchdog_perf.c") new for v4.
- ("Style changes to watchdog_hardlockup_check ...") new for v4.
- Pulled ("Adapt the watchdog_hld interface ...") into my series for v4.
- Pulled ("Enable perf events based hard ...") into my series for v4.
- Pulled ("Ensure CPU-bound context when creating ...") into my series for v4.
- Pulled ("add hw_nmi_get_sample_period for ...") into my series for v4.
- Pulled ("change watchdog_nmi_enable() to void") into my series for v4.
- Pulled ("remove WATCHDOG_DEFAULT") into my series for v4.
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

Douglas Anderson (13):
  watchdog/perf: Define dummy watchdog_update_hrtimer_threshold() on
    correct config
  watchdog/perf: More properly prevent false positives with turbo modes
  watchdog/hardlockup: Add comments to touch_nmi_watchdog()
  watchdog/perf: Rename watchdog_hld.c to watchdog_perf.c
  watchdog/hardlockup: Move perf hardlockup checking/panic to common
    watchdog.c
  watchdog/hardlockup: Style changes to watchdog_hardlockup_check() /
    is_hardlockup()
  watchdog/hardlockup: Add a "cpu" param to watchdog_hardlockup_check()
  watchdog/hardlockup: Move perf hardlockup watchdog petting to
    watchdog.c
  watchdog/hardlockup: Rename some "NMI watchdog" constants/function
  watchdog/hardlockup: Have the perf hardlockup use __weak functions
    more cleanly
  watchdog/hardlockup: detect hard lockups using secondary (buddy) CPUs
  watchdog/perf: Add a weak function for an arch to detect if perf can
    use NMIs
  arm64: Enable perf events based hard lockup detector

Lecopzer Chen (4):
  watchdog: remove WATCHDOG_DEFAULT
  watchdog/hardlockup: change watchdog_nmi_enable() to void
  watchdog/perf: Adapt the watchdog_perf interface for async model
  arm64: add hw_nmi_get_sample_period for preparation of lockup detector

Pingfan Liu (1):
  watchdog/perf: Ensure CPU-bound context when creating hardlockup
    detector event

 arch/arm64/Kconfig                         |   2 +
 arch/arm64/kernel/Makefile                 |   1 +
 arch/arm64/kernel/watchdog_hld.c           |  36 +++
 arch/powerpc/include/asm/nmi.h             |   4 +-
 arch/powerpc/kernel/watchdog.c             |  12 +-
 arch/powerpc/platforms/pseries/mobility.c  |   4 +-
 arch/sparc/kernel/nmi.c                    |  10 +-
 drivers/perf/arm_pmu.c                     |   5 +
 drivers/perf/arm_pmuv3.c                   |  12 +-
 include/linux/nmi.h                        |  73 +++--
 include/linux/perf/arm_pmu.h               |   2 +
 kernel/Makefile                            |   3 +-
 kernel/watchdog.c                          | 344 +++++++++++++++------
 kernel/watchdog_buddy.c                    |  93 ++++++
 kernel/{watchdog_hld.c => watchdog_perf.c} | 105 +++----
 lib/Kconfig.debug                          |  52 +++-
 16 files changed, 550 insertions(+), 208 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c
 create mode 100644 kernel/watchdog_buddy.c
 rename kernel/{watchdog_hld.c => watchdog_perf.c} (72%)

-- 
2.40.1.698.g37aff9b760-goog

