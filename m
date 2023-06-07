Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA39C77B7A
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jun 2023 23:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjFGXnO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFGXnN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 19:43:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D06210A
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 16:43:12 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a1fa977667so18422fac.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181391; x=1688773391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GavxFaHwlTnRx3gt9uObRrogsyEG4oEATw/XGEuAuMI=;
        b=NvCZkbr9GHpuCiMmCnCC/D5UgDJfJUrUCAFOwphlEMCu29HC7TvakQKU1fq2I+z/Gf
         2AOHhaC5uepNMgwPPbfO2OozzVH8xJhG/gGMSuvTOTZ/FMrsWrTFrmziYTj5aTc/VBEW
         +TehcevNGkdXq2IysjugM8pqcig77s4rZvLN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181391; x=1688773391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GavxFaHwlTnRx3gt9uObRrogsyEG4oEATw/XGEuAuMI=;
        b=eSwJQZ3oK+fqbn/vK2NqhRQyKU9LI21fCTbVAOYYN7o+83qA4j4hX+btwdP/a++5qv
         iTfu90sh3I+U/DZ16apEpdLeLIDji3fblmX4v4L3o5CW5KsGeH4ksdemrn39KWEJPG7H
         XSqezq83ucioeTlVswe/1lLuwvHLyO+RgKCgqHbypXXxexomea4O/VBf2AyRcEjq2cd+
         waJvv59SdrGMkOmBodBD12YI97TcUiA6SLSMzPTg8bVyzlSONnBmfqpjwRQN0qio3n9f
         xEKza35KvXuN62nbfGKc2F+QJcRmEcpBRB5UElDW++hDlGVIFaiDlVWR7dihydLSbYyc
         sOCA==
X-Gm-Message-State: AC+VfDwiNr/lTy9ZdeoTENBiLISBMOv+lYsKqRqgGRqgVZvc1h6eNugD
        rQevHTLAHi0S2DrKOPodXT2qHC49YNVUWwpgkJ0=
X-Google-Smtp-Source: ACHHUZ63+VmbdJVv+sscF+HL92xMxPwyguKR3pnnP2nETDmZquMNEexy/kcAy+PQRQS7/CLoV9farg==
X-Received: by 2002:a05:6870:3882:b0:196:6493:d0ac with SMTP id y2-20020a056870388200b001966493d0acmr5410973oan.59.1686181391191;
        Wed, 07 Jun 2023 16:43:11 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id hb12-20020a056870780c00b0019f73803559sm104671oab.37.2023.06.07.16.43.10
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:43:10 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-38dec65ab50so42957b6e.2
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:43:10 -0700 (PDT)
X-Received: by 2002:a5e:a611:0:b0:777:aa56:f5e9 with SMTP id
 q17-20020a5ea611000000b00777aa56f5e9mr11095206ioi.16.1686180931677; Wed, 07
 Jun 2023 16:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-4-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-4-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:35:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvUAeKFAcOD_xaT2to45=CCiKJMRbi-uxgrZ4mWN7hZg@mail.gmail.com>
Message-ID: <CAD=FV=XvUAeKFAcOD_xaT2to45=CCiKJMRbi-uxgrZ4mWN7hZg@mail.gmail.com>
Subject: Re: [PATCH 3/7] watchdog/hardlockup: Declare arch_touch_nmi_watchdog()
 only in linux/nmi.h
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

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> arch_touch_nmi_watchdog() needs a different implementation for various
> hardlockup detector implementations. And it does nothing when
> any hardlockup detector is not build at all.

s/build/built/


> arch_touch_nmi_watchdog() has to be declared in linux/nmi.h. It is done
> directly in this header file for the perf and buddy detectors. And it
> is done in the included asm/linux.h for arch specific detectors.
>
> The reason probably is that the arch specific variants build the code
> using another conditions. For example, powerpc64/sparc64 builds the code
> when CONFIG_PPC_WATCHDOG is enabled.
>
> Another reason might be that these architectures define more functions
> in asm/nmi.h anyway.
>
> However the generic code actually knows the information. The config
> variables HAVE_NMI_WATCHDOG and HAVE_HARDLOCKUP_DETECTOR_ARCH are used
> to decide whether to build the buddy detector.
>
> In particular, CONFIG_HARDLOCKUP_DETECTOR is set only when a generic
> or arch-specific hardlockup detector is built. The only exception
> is sparc64 which ignores the global HARDLOCKUP_DETECTOR switch.
>
> The information about sparc64 is a bit complicated. The hardlockup
> detector is built there when CONFIG_HAVE_NMI_WATCHDOG is set and
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> People might wonder whether this change really makes things easier.
> The motivation is:
>
>   + The current logic in linux/nmi.h is far from obvious.
>     For example, arch_touch_nmi_watchdog() is defined as {} when
>     neither CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER nor
>     CONFIG_HAVE_NMI_WATCHDOG is defined.
>
>   + The change synchronizes the checks in lib/Kconfig.debug and
>     in the generic code.
>
>   + It is a step that will help cleaning HAVE_NMI_WATCHDOG related
>     checks.
>
> The change should not change the existing behavior.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/powerpc/include/asm/nmi.h |  2 --
>  arch/sparc/include/asm/nmi.h   |  1 -
>  include/linux/nmi.h            | 13 ++++++++++---
>  3 files changed, 10 insertions(+), 6 deletions(-)

This looks right and is a nice cleanup.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
