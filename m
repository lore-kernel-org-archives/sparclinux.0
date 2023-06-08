Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C0DC7EE25
	for <sparclinux@archiver.kernel.org>; Thu,  8 Jun 2023 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFHNzl (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjFHNzj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 8 Jun 2023 09:55:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3156E62
        for <sparclinux@vger.kernel.org>; Thu,  8 Jun 2023 06:55:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7747df5b674so22096039f.3
        for <sparclinux@vger.kernel.org>; Thu, 08 Jun 2023 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686232537; x=1688824537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Vs9lje4ue6a9YND5XSnEpnS9VI2Lo/geXINpFnbB8=;
        b=oVg83mrTBUl29PTk+RqO5MA1BbM29G9oM3VedLfG6Qy1nJ9HCw3ztfODFjNfW/5Foj
         PV9ypqz1v+8NtZyWCWnd+W4r6KFZUVomawer+u+FDGofP56S8HQjCx39B7+Wj2Mltud4
         3FUSID/L+JQ3Q0AHzm5LxcJ0wqiK8FdELAXCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232537; x=1688824537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Vs9lje4ue6a9YND5XSnEpnS9VI2Lo/geXINpFnbB8=;
        b=XXkdLGpv6IEN7F0yyTqh9rLSAPhlB6ZLk+bV+GWXZFnu4OJgHL8h7dOri8oCWO1NgS
         HAixzSaFgdhAyskTIjbTUceW/Dm1+LZ5ga3kqg617yvQQVqJiv6w6gRzH9DENb9XSH3e
         QMgGXbuFi9W13aGUshZkRctIjPMGuEk+1G3XuT5AKT4gYI6iK98KiQLEoaS7j5VEO0bx
         RQWsKf1b9Bumy2Gta7mfIYTIuVs7oNpsuPZcIEyxI6KrxtH/IQSUskEXzVKJpkFKIVGv
         GzMCO/BnD0nqzqoDae4DeGydjJgCjFRINtZnlbpP5qA9bcIaQs4HBgrhyMrNUuFXVX9d
         va7w==
X-Gm-Message-State: AC+VfDzpNIKEnZdL6CMO3Z8pOqvHYQW+m7Kp7MSI7km6r8ETGVnKVg4/
        08ryXeB5SazwaaBe5pQ0nV/QcAckXe8ZU9NGCuE=
X-Google-Smtp-Source: ACHHUZ4WqpIhd+WxwSkarikNkr5kNJNe0914hl1BjTM/RBunFbStXSM+omr96cuzVaGJv2ZnFbN4HA==
X-Received: by 2002:a05:6602:2097:b0:77a:c494:b4c9 with SMTP id a23-20020a056602209700b0077ac494b4c9mr4147491ioa.20.1686232537073;
        Thu, 08 Jun 2023 06:55:37 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id j4-20020a02a684000000b0040fb2ba7357sm301796jam.4.2023.06.08.06.55.35
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:55:35 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33d928a268eso121345ab.0
        for <sparclinux@vger.kernel.org>; Thu, 08 Jun 2023 06:55:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a82:b0:32f:7715:4482 with SMTP id
 k2-20020a056e021a8200b0032f77154482mr109894ilv.4.1686232535228; Thu, 08 Jun
 2023 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com> <ZIG1Qi0iUjTKICQM@alley>
In-Reply-To: <ZIG1Qi0iUjTKICQM@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Jun 2023 06:55:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
Message-ID: <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] watchdog/hardlockup: Make the config checks more straightforward
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

On Thu, Jun 8, 2023 at 4:02=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> > >  config HARDLOCKUP_DETECTOR
> > >         bool "Detect Hard Lockups"
> > >         depends on DEBUG_KERNEL && !S390
> > > -       depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCK=
UP_DETECTOR_ARCH
> > > +       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP=
_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> >
> > Adding the dependency to buddy (see ablove) would simplify the above
> > to just this:
> >
> > depends on HAVE_HARDLOCKUP_DETECTOR_PERF ||
> > HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
>
> This is exactly what I do not want. It would just move the check
> somewhere else. But it would make the logic harder to understand.

Hmmm. To me, it felt easier to understand by moving this into the
"HAVE_HARDLOCKUP_DETECTOR_BUDDY". To me it was pretty easy to say "if
an architecture defined its own arch-specific watchdog then buddy
can't be enabled" and that felt like it fit cleanly within the
"HAVE_HARDLOCKUP_DETECTOR_BUDDY" definition. It got rid of _a lot_ of
other special cases / checks elsewhere and felt quite a bit cleaner to
me. I only had to think about the conflict between the "buddy" and
"nmi" watchdogs once when I understood
"HAVE_HARDLOCKUP_DETECTOR_BUDDY".


> > As per above, it's simply a responsibility of architectures not to
> > define that they have both "perf" if they have the NMI watchdog, so
> > it's just buddy to worry about.
>
> Where is this documented, please?
> Is it safe to assume this?

It's not well documented and I agree that it could be improved. Right
now, HAVE_NMI_WATCHDOG is documented to say that the architecture
"defines its own arch_touch_nmi_watchdog()". Looking before my
patches, you can see that "kernel/watchdog_hld.c" (the "perf" detector
code) unconditionally defines arch_touch_nmi_watchdog(). That would
give you a linker error.


> I would personally prefer to ensure this by the config check.
> It is even better than documentation because nobody reads
> documentation ;-)

Sure. IMO this should be documented as close as possible to the root
of the problem. Make "HAVE_NMI_WATCHDOG" depend on
"!HAVE_HARDLOCKUP_DETECTOR_PERF". That expresses that an architecture
is not allowed to declare that it has both.
