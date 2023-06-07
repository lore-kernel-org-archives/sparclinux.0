Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8EC7EE25
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jun 2023 23:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjFGXhe (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjFGXhb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 19:37:31 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6790726A5
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 16:37:12 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33d22754450so10070595ab.0
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181030; x=1688773030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+jSOn4aArekcx3+zLzXPOVm14+fmJKsE3biZ6If6cY=;
        b=H/7mUDazv1m3+RWdJPLYTJ4CX3U6crtsCd8hmF7RGNV0igyhCLouuz+T30DF3jzjo3
         63kb9BxZ6DLWqQ2e2hJtjJfX2iwLwhLPWOUCd/DxYyiaWua5FWpLLQUHAT7B9DprHYUI
         Hl84bt00QZvbUjS6vjxhhZj224q5BoMet4nms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181030; x=1688773030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+jSOn4aArekcx3+zLzXPOVm14+fmJKsE3biZ6If6cY=;
        b=L0g9UZFwXUfKxLa4kWgx7j5ekxveBrb7iWixHoBdyso2mBhR9PRN2ApaH/VyZdlbXQ
         p25jeV70bbnKvf9KQB+koe0VITljVIknaYPgmIMQIkQdKAInbE+jIGNBK6gYmjhrJ9Bm
         zkcROKH8dseDo5DRseYeTzFAfe7hVA+BxSO3fVe1bA2N9uMlzSR66Sfcj57lJmXTP7Bk
         aUWr+6t8mHwM09gCy9MWu2yVs2mP0JFPKmBHxfNopDW7blBD8qWylUgde+ZfIRmrh0kf
         oCQ6NlcsE2b10vdl1p5NnWA9zpesnFeFemRslG0PPpRC++1VcG6bWT9EsePI3CpmHaWq
         3vGg==
X-Gm-Message-State: AC+VfDxwDS+veVIXB0XmBUuDWjZ52kTCnMmSnnI8Uuw5ycw/0e/p93zO
        voPmr2EbaZLaNZJm9YjMR+axRMaEIX8MG1jrEO4=
X-Google-Smtp-Source: ACHHUZ7gAl8j1c/3x6Nth7+7vFZVb1XugM3aupVdZBUzPReVoBPzcOoceOMRXOyvuX2q2gDbWlsgvw==
X-Received: by 2002:a92:c507:0:b0:33b:b6b9:a79d with SMTP id r7-20020a92c507000000b0033bb6b9a79dmr8687348ilg.31.1686181030199;
        Wed, 07 Jun 2023 16:37:10 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id d16-20020a92d5d0000000b00316e39f1285sm26774ilq.82.2023.06.07.16.37.02
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:05 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so56645ab.0
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:37:02 -0700 (PDT)
X-Received: by 2002:a05:6e02:170c:b0:33c:a46c:23b3 with SMTP id
 u12-20020a056e02170c00b0033ca46c23b3mr99141ill.1.1686181022226; Wed, 07 Jun
 2023 16:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-7-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-7-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-H9z20zT8Oop5+Hnf-S3QgiotzQ=f3LGvN6AiLUxi=Q@mail.gmail.com>
Message-ID: <CAD=FV=V-H9z20zT8Oop5+Hnf-S3QgiotzQ=f3LGvN6AiLUxi=Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] watchdog/sparc64: Define HARDLOCKUP_DETECTOR_SPARC64
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

On Wed, Jun 7, 2023 at 8:26=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> The HAVE_ prefix means that the code could be enabled. Add another
> variable for HAVE_HARDLOCKUP_DETECTOR_SPARC64 without this prefix.
> It will be set when it should be built. It will make it compatible
> with the other hardlockup detectors.
>
> Before, it is far from obvious that the SPARC64 variant is actually used:
>
> $> make ARCH=3Dsparc64 defconfig
> $> grep HARDLOCKUP_DETECTOR .config
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=3Dy
>
> After, it is more clear:
>
> $> make ARCH=3Dsparc64 defconfig
> $> grep HARDLOCKUP_DETECTOR .config
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=3Dy
> CONFIG_HARDLOCKUP_DETECTOR_SPARC64=3Dy
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/sparc/Kconfig.debug | 10 +++++++++-
>  include/linux/nmi.h      |  4 ++--
>  kernel/watchdog.c        |  2 +-
>  lib/Kconfig.debug        |  2 +-
>  4 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
