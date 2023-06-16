Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB881EB64D7
	for <sparclinux@archiver.kernel.org>; Fri, 16 Jun 2023 16:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbjFPQs3 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbjFPQs0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 16 Jun 2023 12:48:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB0135A1
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 09:48:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-518b69d5b5dso1226777a12.1
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686934101; x=1689526101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr5g+LR86poa7vi9trOMIJcQmYHg1BLUYh+fDHbbZ4k=;
        b=PviqPR4eU8OixlT+ozaUE2ieX+aLFF3kvvVaZP2wvFwgDEHuk41T6vbZvfXLGUv/t4
         dwf52z9I95n0hO+Zl3Ei8TZcOYeTMgia8qR/LXkA/GGhLKYwY58Z929kU/7QR9KzxJcO
         b28nc7kmCKCiRREpmM1uYIxLFNFrDykRqXSSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934101; x=1689526101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr5g+LR86poa7vi9trOMIJcQmYHg1BLUYh+fDHbbZ4k=;
        b=aBoi2rcp49dZtEmYywrdzVs4EEP7U0x3z0gFMAusXX/WG3b3lAiO+Dd4A68KOT0RYj
         hkjrxKY9WYBDLqW5JOut7HB04mDq7LMG9LnwQWqrA2k2e2T+abEg7IBf4OVSp7cP6Yq5
         rczwV/KA01DrSnPHwF0aGp/tJKyUDoCWrUupPc6bq6S0ln0uoUhO46SiyTbpRK9a7RFw
         Vtl8+wLFEYQFQrcF+eZfBP2mHPNGsQNUC/eQftF79iC9Rnf65DVbMID7SGi5WIdSpPeZ
         EbzkjlT03fPqirYUvpuvrHJ+dNGHc1RuLwvzwaB89ir/0FGLFbCludf5/LF6P25Ofifo
         PNlA==
X-Gm-Message-State: AC+VfDyhmN3R09tkE1yVPl/1Dpm1AI6QVvP7WVCf4+jaZ/xWY1Yr4bfl
        YelmYsz143XouHciSFHEMFhurSHS9C4ckNOabvAY50Nr
X-Google-Smtp-Source: ACHHUZ7JnZbHp3OuIdKTLOAS5sJuUMXUx+k8MYkS4PdAv+p0M17grZcvQF4B9hWsXwsRgFVGMAc00Q==
X-Received: by 2002:aa7:c3da:0:b0:518:7902:d244 with SMTP id l26-20020aa7c3da000000b005187902d244mr1603645edr.6.1686934100846;
        Fri, 16 Jun 2023 09:48:20 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id n6-20020a056402514600b0051a313a66e8sm1275950edd.45.2023.06.16.09.48.19
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:48:19 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so78a12.1
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 09:48:19 -0700 (PDT)
X-Received: by 2002:a50:999d:0:b0:516:6453:1b76 with SMTP id
 m29-20020a50999d000000b0051664531b76mr240103edb.5.1686934098700; Fri, 16 Jun
 2023 09:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-5-pmladek@suse.com>
In-Reply-To: <20230616150618.6073-5-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Jun 2023 09:48:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=ox4ApMbDL7v=ivNF6x=UyG=dd4MU_Dt0rppNCEwCpw@mail.gmail.com>
Message-ID: <CAD=FV=U=ox4ApMbDL7v=ivNF6x=UyG=dd4MU_Dt0rppNCEwCpw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] watchdog/hardlockup: Make HAVE_NMI_WATCHDOG sparc64-specific
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Fri, Jun 16, 2023 at 8:07=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> There are several hardlockup detector implementations and several Kconfig
> values which allow selection and build of the preferred one.
>
> CONFIG_HARDLOCKUP_DETECTOR was introduced by the commit 23637d477c1f53acb
> ("lockup_detector: Introduce CONFIG_HARDLOCKUP_DETECTOR") in v2.6.36.
> It was a preparation step for introducing the new generic perf hardlockup
> detector.
>
> The existing arch-specific variants did not support the to-be-created
> generic build configurations, sysctl interface, etc. This distinction
> was made explicit by the commit 4a7863cc2eb5f98 ("x86, nmi_watchdog:
> Remove ARCH_HAS_NMI_WATCHDOG and rely on CONFIG_HARDLOCKUP_DETECTOR")
> in v2.6.38.
>
> CONFIG_HAVE_NMI_WATCHDOG was introduced by the commit d314d74c695f967e105
> ("nmi watchdog: do not use cpp symbol in Kconfig") in v3.4-rc1. It replac=
ed
> the above mentioned ARCH_HAS_NMI_WATCHDOG. At that time, it was still use=
d
> by three architectures, namely blackfin, mn10300, and sparc.
>
> The support for blackfin and mn10300 architectures has been completely
> dropped some time ago. And sparc is the only architecture with the histor=
ic
> NMI watchdog at the moment.
>
> And the old sparc implementation is really special. It is always built on
> sparc64. It used to be always enabled until the commit 7a5c8b57cec93196b
> ("sparc: implement watchdog_nmi_enable and watchdog_nmi_disable") added
> in v4.10-rc1.
>
> There are only few locations where the sparc64 NMI watchdog interacts
> with the generic hardlockup detectors code:
>
>   + implements arch_touch_nmi_watchdog() which is called from the generic
>     touch_nmi_watchdog()
>
>   + implements watchdog_hardlockup_enable()/disable() to support
>     /proc/sys/kernel/nmi_watchdog
>
>   + is always preferred over other generic watchdogs, see
>     CONFIG_HARDLOCKUP_DETECTOR
>
>   + includes asm/nmi.h into linux/nmi.h because some sparc-specific
>     functions are needed in sparc-specific code which includes
>     only linux/nmi.h.
>
> The situation became more complicated after the commit 05a4a95279311c3
> ("kernel/watchdog: split up config options") and commit 2104180a53698df5
> ("powerpc/64s: implement arch-specific hardlockup watchdog") in v4.13-rc1=
.
> They introduced HAVE_HARDLOCKUP_DETECTOR_ARCH. It was used for powerpc
> specific hardlockup detector. It was compatible with the perf one
> regarding the general boot, sysctl, and programming interfaces.
>
> HAVE_HARDLOCKUP_DETECTOR_ARCH was defined as a superset of
> HAVE_NMI_WATCHDOG. It made some sense because all arch-specific
> detectors had some common requirements, namely:
>
>   + implemented arch_touch_nmi_watchdog()
>   + included asm/nmi.h into linux/nmi.h
>   + defined the default value for /proc/sys/kernel/nmi_watchdog
>
> But it actually has made things pretty complicated when the generic
> buddy hardlockup detector was added. Before the generic perf detector
> was newer supported together with an arch-specific one. But the buddy
> detector could work on any SMP system. It means that an architecture
> could support both the arch-specific and buddy detector.
>
> As a result, there are few tricky dependencies. For example,
> CONFIG_HARDLOCKUP_DETECTOR depends on:
>
>   ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY) && !=
HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
>
> The problem is that the very special sparc implementation is defined as:
>
>   HAVE_NMI_WATCHDOG && !HAVE_HARDLOCKUP_DETECTOR_ARCH
>
> Another problem is that the meaning of HAVE_NMI_WATCHDOG is far from clea=
r
> without reading understanding the history.
>
> Make the logic less tricky and more self-explanatory by making
> HAVE_NMI_WATCHDOG specific for the sparc64 implementation. And rename it =
to
> HAVE_HARDLOCKUP_DETECTOR_SPARC64.
>
> Note that HARDLOCKUP_DETECTOR_PREFER_BUDDY, HARDLOCKUP_DETECTOR_PERF,
> and HARDLOCKUP_DETECTOR_BUDDY may conflict only with
> HAVE_HARDLOCKUP_DETECTOR_ARCH. They depend on HARDLOCKUP_DETECTOR
> and it is not longer enabled when HAVE_NMI_WATCHDOG is set.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
>
> watchdog/sparc64: Rename HAVE_NMI_WATCHDOG to HAVE_HARDLOCKUP_WATCHDOG_SP=
ARC64
>
> The configuration variable HAVE_NMI_WATCHDOG has a generic name but
> it is selected only for SPARC64.
>
> It should _not_ be used in general because it is not integrated with
> the other hardlockup detectors. Namely, it does not support the hardlocku=
p
> specific command line parameters and systcl interface. Instead, it is
> enabled/disabled together with the softlockup detector by the global
> "watchdog" sysctl.
>
> Rename it to HAVE_HARDLOCKUP_WATCHDOG_SPARC64 to make the special
> behavior more clear.
>
> Also the variable is set only on sparc64. Move the definition
> from arch/Kconfig to arch/sparc/Kconfig.debug.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

I think you goofed up when squashing the patches. You've now got a
second patch subject after your first Signed-off-by and then a second
Signed-off-by... I assume everything after the first Signed-off-by
should be dropped?

Other than that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
