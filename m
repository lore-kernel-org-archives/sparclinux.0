Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D20AC7EE21
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDWmc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEDWmb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:42:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AA12E8D
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:42:18 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74e07c2ee30so53473385a.1
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683240137; x=1685832137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKTOrpdPKD9tXXBM+7yvRbp5HwSbEUEOiX00H7sR240=;
        b=OW0I7nStj+B79d83mEchXQ58ny1hwOW5JQ7D0LRRydmx9BIXnlCTSPe6yLb0gi5vw1
         rMq/SUsaZxmbuhJP+HQILsp8895gC8EZFOQI9Q1JM7sJOiWXv5GgiWSIf5T5O1emiH13
         3sY1EiwQBG9XpHf1qKKDrg9tza4JtJ/8nmH+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240137; x=1685832137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKTOrpdPKD9tXXBM+7yvRbp5HwSbEUEOiX00H7sR240=;
        b=N10pEMLJpgrlvYhksThy7/AW22n9utlptpxn+KwWdSf5bgX4Ef0DNOic8I+hpG2lWb
         3EGOKyjpjhV4/zwesBzQlQE4IY49HPd++g+ejhm1utjK4T/dGbsQV4cST/nM1Fx131eZ
         24jkMTTKBlTbhqAzXVLhehMLpk9q6YVb10yS0aM6og5sWD/vtG79VbmdoM83LP8r+Ccl
         ZhOvwJd56AP4YiwvplZQafvmxGYShvx7pmjQedo9abQzorlPUH3cqnKeJZtjQn5m+nX0
         5bCRE8sInpBIAfQ08Zv/5f0uge58JK571W9cuFMJmS9DRjRZ0i0oukqAX4Y2hJxAWgjl
         hxNg==
X-Gm-Message-State: AC+VfDwNiLOLyN1WtTkUdXr1Liz4c60P/93WBVAIyyPj5OL1aJHsGrpH
        eCi8jBGNIS1dkP+aneAFmpb4/U2y0PtwjJ8xM4g=
X-Google-Smtp-Source: ACHHUZ5ZyO61M8ZftO4NpHvgF0BiRvzCBVob2yyxmBBRGIdR1+nnW1h++AQmpqCFA7h4mK5d5c2LLA==
X-Received: by 2002:ac8:5948:0:b0:3f0:ab44:5b09 with SMTP id 8-20020ac85948000000b003f0ab445b09mr8987495qtz.0.1683240137264;
        Thu, 04 May 2023 15:42:17 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id bw13-20020a05622a098d00b003ef13aa5b0bsm44154qtb.82.2023.05.04.15.42.15
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:42:16 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3ef31924c64so912711cf.1
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:42:15 -0700 (PDT)
X-Received: by 2002:ac8:5781:0:b0:3ef:302c:319e with SMTP id
 v1-20020ac85781000000b003ef302c319emr15500qta.8.1683240114116; Thu, 04 May
 2023 15:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220903093415.15850-1-lecopzer.chen@mediatek.com>
In-Reply-To: <20220903093415.15850-1-lecopzer.chen@mediatek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 May 2023 15:41:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=AhZe35_uaZR=qq78kyw89gUf7FYzjGak-2-8-XcxWQ@mail.gmail.com>
Message-ID: <CAD=FV=W=AhZe35_uaZR=qq78kyw89gUf7FYzjGak-2-8-XcxWQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Support hld delayed init based on Pseudo-NMI for
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        davem@davemloft.net, jolsa@redhat.com, jthierry@redhat.com,
        keescook@chromium.org, kernelfans@gmail.com, masahiroy@kernel.org,
        matthias.bgg@gmail.com, maz@kernel.org, mcgrof@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, nixiaoming@huawei.com,
        peterz@infradead.org, pmladek@suse.com, sparclinux@vger.kernel.org,
        sumit.garg@linaro.org, wangqing@vivo.com, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Sat, Sep 3, 2022 at 2:35=E2=80=AFAM Lecopzer Chen <lecopzer.chen@mediate=
k.com> wrote:
>
> As we already used hld internally for arm64 since 2020, there still
> doesn't have a proper commit on the upstream and we badly need it.
>
> This serise rework on 5.17 from [1] and the origin author is
> Pingfan Liu <kernelfans@gmail.com>
> Sumit Garg <sumit.garg@linaro.org>
>
> Qoute from [1]:
>
> > Hard lockup detector is helpful to diagnose unpaired irq
> > enable/disable.
> > But the current watchdog framework can not cope with arm64 hw perf
> > event
> > easily.
>
> > On arm64, when lockup_detector_init()->watchdog_nmi_probe(), PMU is
> > not
> > ready until device_initcall(armv8_pmu_driver_init).  And it is deeply
> > integrated with the driver model and cpuhp. Hence it is hard to push
> > the
> > initialization of armv8_pmu_driver_init() before smp_init().
>
> > But it is easy to take an opposite approach by enabling watchdog_hld
> > to
> > get the capability of PMU async.
> > The async model is achieved by expanding watchdog_nmi_probe() with
> > -EBUSY, and a re-initializing work_struct which waits on a
> > wait_queue_head.
>
> Provide an API - retry_lockup_detector_init() for anyone who needs
> to delayed init lockup detector.
>
> The original assumption is: nobody should use delayed probe after
> lockup_detector_check() (which has __init attribute).
> That is, anyone uses this API must call between lockup_detector_init()
> and lockup_detector_check(), and the caller must have __init attribute
>
> The delayed init flow is:
> 1. lockup_detector_init() -> watchdog_nmi_probe() get non-zero retun,
>    then set allow_lockup_detector_init_retry to true which means it's
>    able to do delayed probe later.
>
> 2. PMU arch code init done, call retry_lockup_detector_init().
>
> 3. retry_lockup_detector_init() queue the work only when
>    allow_lockup_detector_init_retry is true which means nobody should
> call
>    this before lockup_detector_init().
>
> 4. the work lockup_detector_delay_init() is doing without wait event.
>    if probe success, set allow_lockup_detector_init_retry to false.
>
> 5. at late_initcall_sync(), lockup_detector_check() set
>    allow_lockup_detector_init_retry to false first to avoid any later
> retry,
>    and then flush_work() to make sure the __init section won't be freed
>    before the work done.
>
> [1]
> https://lore.kernel.org/lkml/20211014024155.15253-1-kernelfans@gmail.com/
>
> v7:
>   rebase on v6.0-rc3
>
> v6:
>   fix build failed reported by kernel test robot <lkp@intel.com>
> https://lore.kernel.org/lkml/20220614062835.7196-1-lecopzer.chen@mediatek=
.com/
>
> v5:
>   1. rebase on v5.19-rc2
>   2. change to proper schedule api
>   3. return value checking before retry_lockup_detector_init()
> https://lore.kernel.org/lkml/20220613135956.15711-1-lecopzer.chen@mediate=
k.com/
>
> v4:
>   1. remove -EBUSY protocal, let all the non-zero value from
>      watchdog_nmi_probe() be able to retry.
>   2. separate arm64 part patch into hw_nmi_get_sample_period and retry
>      delayed init
>   3. tweak commit msg that we don't have to limit to -EBUSY
>   4. rebase on v5.18-rc4
> https://lore.kernel.org/lkml/20220427161340.8518-1-lecopzer.chen@mediatek=
.com/
>
> v3:
>   1. Tweak commit message in patch 04
>         2. Remove wait event
>   3. s/lockup_detector_pending_init/allow_lockup_detector_init_retry/
>   4. provide api retry_lockup_detector_init()
> https://lore.kernel.org/lkml/20220324141405.10835-1-lecopzer.chen@mediate=
k.com/
>
> v2:
>   1. Tweak commit message in patch 01/02/04/05
>   2. Remove vobose WARN in patch 04 within watchdog core.
>   3. Change from three states variable: detector_delay_init_state to
>      two states variable: allow_lockup_detector_init_retry
>
>      Thanks Petr Mladek <pmladek@suse.com> for the idea.
>      > 1.  lockup_detector_work() called before lockup_detector_check().
>      >     In this case, wait_event() will wait until
>      >     lockup_detector_check()
>      >     clears detector_delay_pending_init and calls wake_up().
>
>      > 2. lockup_detector_check() called before lockup_detector_work().
>      >    In this case, wait_even() will immediately continue because
>      >    it will see cleared detector_delay_pending_init.
>   4. Add comment in code in patch 04/05 for two states variable
> changing.
> https://lore.kernel.org/lkml/20220307154729.13477-1-lecopzer.chen@mediate=
k.com/
>
>
> Lecopzer Chen (5):
>   kernel/watchdog: remove WATCHDOG_DEFAULT
>   kernel/watchdog: change watchdog_nmi_enable() to void
>   kernel/watchdog: Adapt the watchdog_hld interface for async model
>   arm64: add hw_nmi_get_sample_period for preparation of lockup detector
>   arm64: Enable perf events based hard lockup detector
>
> Pingfan Liu (1):
>   kernel/watchdog_hld: Ensure CPU-bound context when creating hardlockup
>     detector event
>
>  arch/arm64/Kconfig               |  2 +
>  arch/arm64/kernel/Makefile       |  1 +
>  arch/arm64/kernel/perf_event.c   | 12 +++++-
>  arch/arm64/kernel/watchdog_hld.c | 39 +++++++++++++++++
>  arch/sparc/kernel/nmi.c          |  8 ++--
>  drivers/perf/arm_pmu.c           |  5 +++
>  include/linux/nmi.h              |  4 +-
>  include/linux/perf/arm_pmu.h     |  2 +
>  kernel/watchdog.c                | 72 +++++++++++++++++++++++++++++---
>  kernel/watchdog_hld.c            |  8 +++-
>  10 files changed, 139 insertions(+), 14 deletions(-)

To leave some breadcrumbs here, I've included all the patches here in
my latest "buddy" hardlockup detector series. I'm hoping that the
cleanup patches that were part of your series can land as part of my
series. I'm not necessarily expecting the the arm64 perf hardlockup
detector patches will land as part of my series, though. See the cover
letter and "after-the-cut" notes on the later patches in my series for
details.

https://lore.kernel.org/r/20230504221349.1535669-1-dianders@chromium.org
