Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73971C7EE25
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jun 2023 23:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjFGXhX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjFGXhW (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 19:37:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D5F270E
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 16:37:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-777a4c8e8f4so267728939f.3
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181023; x=1688773023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG+ft0QEOw+l4T57sY6QqoB2Q4VLY5mgSyLH0/dKkXM=;
        b=D4RIBPm75r1LHooDIGafpzSRDmUOXXIn1VbeR/MnYdxOtyE5C02jly9JYQVLZHOGZE
         21v4E9z6SjLWZ3hC7k0u9EV2n5okj4l46YKqq2oCJOb6Y7yWkFJO4VHau1puOgJdczIl
         Cr787SuF0j61zGI1Zjbwn61U7gY2V8mJoYISM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181023; x=1688773023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG+ft0QEOw+l4T57sY6QqoB2Q4VLY5mgSyLH0/dKkXM=;
        b=BTfWtIuIJxiV1jRreAv+tUeoA5LXhlo1ZCuUSrHe23UYkKduevgKOmvAYEY2H+u8RD
         FWeMPAtmOImjLCYHbRw33xWYLW8fV3Xij0S8PnltVkxZkTqYZfaG2z2wXJhW7Or8LuxQ
         5b5IH7Ee29p4X57EbIL3FilmUuSfeF+ntYrjSVUhj78aRx2pmxcRJRdpNISt0KFiV6M0
         t+0U7E1i47S7pf5pkeSM2t0xacIll2SpEcbmZXvwDYnXsmqYs4Hh2jFjDvUssfjv1zTF
         qMFa0Nr4XljqChhK9QAD7j1bARNvvqtVlM0wJ0y2jKZo7yF84oEIqIX3Ya6UFzS+nlVd
         NAGg==
X-Gm-Message-State: AC+VfDw9vxA1sYtNptemKnEmrqF6GoQkcfvvjmQH4JUZIsbbAq2SQYVH
        wCOENIhtddoeTDdME9nLt4iZx59FP7ks12Y7KWY=
X-Google-Smtp-Source: ACHHUZ50AvPZfMoECuoiR1PHmO7SQJlOzjVYItKRe4/pvDSHp5RPXpT5aK/NvlY4b6vml1dpbVvFgA==
X-Received: by 2002:a6b:5917:0:b0:77a:c00c:1166 with SMTP id n23-20020a6b5917000000b0077ac00c1166mr4109916iob.15.1686181023740;
        Wed, 07 Jun 2023 16:37:03 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id z9-20020a6b5c09000000b0076c750dc780sm1157911ioh.29.2023.06.07.16.36.55
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:36:56 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33dea7d5424so26165ab.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:36:55 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c4c:b0:33d:8238:80c6 with SMTP id
 d12-20020a056e021c4c00b0033d823880c6mr101962ilg.9.1686181015033; Wed, 07 Jun
 2023 16:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-6-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-6-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTKR42i8hozXSfSHu07TQ7g1TJQs8dqpqGHHraZr+-vQ@mail.gmail.com>
Message-ID: <CAD=FV=VTKR42i8hozXSfSHu07TQ7g1TJQs8dqpqGHHraZr+-vQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] watchdog/sparc64: Rename HAVE_NMI_WATCHDOG to HAVE_HARDLOCKUP_WATCHDOG_SPARC64
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
> ---
>  arch/Kconfig             | 12 ------------
>  arch/sparc/Kconfig       |  2 +-
>  arch/sparc/Kconfig.debug | 12 ++++++++++++
>  include/linux/nmi.h      |  4 ++--
>  kernel/watchdog.c        |  2 +-
>  lib/Kconfig.debug        |  5 +----
>  6 files changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
