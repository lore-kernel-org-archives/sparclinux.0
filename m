Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A0C7EE25
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jun 2023 23:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjFGXej (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFGXeh (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 19:34:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15902689
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 16:34:36 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-775ebe161c5so359484939f.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686180874; x=1688772874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKEziAGkCW2jO8QMx9VTvzfLmO/bLdAIdfdMBgrtF0Q=;
        b=F6wdPzX5FUDEq0AnubAA0X0oRetMIiPWDnCmAd7XJ7qbkBXIQqOUAfDYB/XoT80xhV
         3geAQrbCc6Er52EjNMUsfbQc3ILUnH0//avnz8c5O+0MdNWqhWcsMkG8UX69MmVNxvFJ
         vkkbkVW1pnxPONFY6dZLVQpGAhXMjj2z4mswI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180874; x=1688772874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKEziAGkCW2jO8QMx9VTvzfLmO/bLdAIdfdMBgrtF0Q=;
        b=knIr5Z4+eX4CzyC+yf7baLwHbF2LFC4UDvk2keiAY7Tb9ld7VnJNPfLuzn6c9bokUF
         VtdzzDrxeJhqGKE2ow80amrC1TTVAdfLAqJHNNi49yLFgJnq80JyplA3BUjwVugKY2cX
         D7EZ2zwWEilVvAtBNf/eAHPO/lIUux0nTe9SZTADnKwMJZ+nmfTHsx58Qp4ZL+ry9F2t
         28R6bJ0MeXhqQM8eWlvDB59RZHtEKAgP237Qq7lYFSEQH0vZm7E0dLdio1b4yqeUKIcp
         Rz8giwWRAY0bPRWgwzY4dPovBg70jbF2W3LvuuygzBQPB60C/4J/W6YlEsjN7FmnFomQ
         HGew==
X-Gm-Message-State: AC+VfDynU7+j8aoocnGCVle2tcQnWEbeoszOlz2nMZzksEM7p5PLMeMB
        PP1znJXMan+JV2fPyAR7M3yBdMt9KvxykEnF/00=
X-Google-Smtp-Source: ACHHUZ54nwRPFs1xhPCSYTnMEUHPug8HW9248TnGdxKsxeCcjAN1uGPteR1VHt7hm75SqZZDXJqd7w==
X-Received: by 2002:a5d:8611:0:b0:77a:c494:b4be with SMTP id f17-20020a5d8611000000b0077ac494b4bemr3202731iol.19.1686180874163;
        Wed, 07 Jun 2023 16:34:34 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id q8-20020a0566380ec800b0041f4c9f2064sm2849660jas.178.2023.06.07.16.34.33
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:34:33 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33dea7d5424so25985ab.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:34:33 -0700 (PDT)
X-Received: by 2002:a92:c26d:0:b0:338:9f6a:d54a with SMTP id
 h13-20020a92c26d000000b003389f6ad54amr93121ild.24.1686180872621; Wed, 07 Jun
 2023 16:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-2-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-2-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:34:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4Sp=ZE4DWob-W0NzRm00K7wOWxyyCCaHUHNPPinsjhg@mail.gmail.com>
Message-ID: <CAD=FV=X4Sp=ZE4DWob-W0NzRm00K7wOWxyyCCaHUHNPPinsjhg@mail.gmail.com>
Subject: Re: [PATCH 1/7] watchdog/hardlockup: Sort hardlockup detector related
 config values a logical way
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
> There are four possible variants of hardlockup detectors:
>
>   + buddy: available when SMP is set.
>
>   + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.
>
>   + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.
>
>   + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
>         and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> Only one hardlockup detector can be compiled in. The selection is done
> using quite complex dependencies between several CONFIG variables.
> The following patches will try to make it more straightforward.
>
> As a first step, reorder the definitions of the various CONFIG variables.
> The logical order is:
>
>    1. HAVE_* variables define available variants. They are typically
>       defined in the arch/ config files.
>
>    2. HARDLOCKUP_DETECTOR y/n variable defines whether the hardlockup
>       detector is enabled at all.
>
>    3. HARDLOCKUP_DETECTOR_PREFER_BUDDY y/n variable defines whether
>       the buddy detector should be preferred over the perf one.
>       Note that the arch specific variants are always preferred when
>       available.
>
>    4. HARDLOCKUP_DETECTOR_PERF/BUDDY variables define whether the given
>       detector is enabled in the end.
>
>    5. HAVE_HARDLOCKUP_DETECTOR_NON_ARCH and HARDLOCKUP_DETECTOR_NON_ARCH
>       are temporary variables that are going to be removed in
>       a followup patch.
>
> The patch just shuffles the definitions. It should not change the existin=
g
> behavior.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/Kconfig.debug | 112 +++++++++++++++++++++++-----------------------
>  1 file changed, 56 insertions(+), 56 deletions(-)

I don't really have any strong opinions, so I'm fine with this. In
general I think the ordering I picked tried to match the existing
"style" which generally tried to list configs and then select them
below. To me the existing style makes more sense when thinking about
writing C code without having to put a pile of prototypes at the top
of your file: you define things higher in the file and reference them
below. For instance, the old style (before any of my patches) had:

config SOFTLOCKUP_DETECTOR:
  ... blah blah blah ...

config HARDLOCKUP_DETECTOR_PERF:
  select SOFTLOCKUP_DETECTOR

config HARDLOCKUP_DETECTOR:
  ... blah blah blah ...
  select LOCKUP_DETECTOR
  select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF

Your new style seems to be the opposite of that.

-Doug
