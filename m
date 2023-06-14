Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94E1EB64D8
	for <sparclinux@archiver.kernel.org>; Wed, 14 Jun 2023 13:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbjFNNri (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbjFNNrh (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 14 Jun 2023 09:47:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114439C
        for <sparclinux@vger.kernel.org>; Wed, 14 Jun 2023 06:47:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977cc662f62so100206966b.3
        for <sparclinux@vger.kernel.org>; Wed, 14 Jun 2023 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686750453; x=1689342453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76di/i2mInmVCxeVKqtSRBrcXSBLthtuA5QqmKpv0gg=;
        b=jlp8OxtI66wmx6ofvYbecBCQapH2lREmqablzfBh+9OExysu5k9h76l1tCeV8/J90c
         4Z1ZouQnIxyCpFC63R+Y2e/3+b2Jxk5JrOBGOCsPtQ8f8vMjLIC0eQU8nmbwpRYwQPz+
         zcnti9QTI56yIvgkrHHGpaaUQcJKbnO76la6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750453; x=1689342453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76di/i2mInmVCxeVKqtSRBrcXSBLthtuA5QqmKpv0gg=;
        b=W3luzqw75VPUMhURcJsZcjqLjZtUXEWzZHouzR5z53azjUOFswjWZ3uQELYmM4MAcd
         T09wJBmm7WB28fT4E1RwtahaeoTWJT3gSvodXZsVcyw7O6dbHL+ijINBcZoShUM6CGc/
         ltWYniMKnyF4fZbZ23bU09fL+DjrxhQ53WbzfZu/hREC1e57thZDw547PU5njFgd52jm
         UAU/OrlZM/e3Zh8JMBxLcFH77Y+siUb/97NEd3g6mHqTqCj8Tfxbi0VWqXtegDIqI+U0
         q30xISotWiq3efV3qxO4PsIO5YolXkBY5D9c/ZdwZ7kDr0x2hASaa5fjgZTlhqWO2+Mp
         3wFQ==
X-Gm-Message-State: AC+VfDyD+JZWC7UeJHDAFbIp+VwXY6NkMcZzzoRp1TazfBawuda6T960
        gH4TGUa+0nCCPpz2qhRXX2gsnBFikjT3M+ozeO0hnjcK
X-Google-Smtp-Source: ACHHUZ4PqzLQtEz5XmoJlTgC6AEMD4An3nZgJiz4OjM6k+bPAQ9xHCLm9n4WMSfVcPYFZkg3OSLJQg==
X-Received: by 2002:a17:907:31c6:b0:974:62d1:e942 with SMTP id xf6-20020a17090731c600b0097462d1e942mr15401149ejb.21.1686750452882;
        Wed, 14 Jun 2023 06:47:32 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090635ca00b00961277a426dsm7985451ejb.205.2023.06.14.06.47.31
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:47:32 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so8282a12.1
        for <sparclinux@vger.kernel.org>; Wed, 14 Jun 2023 06:47:31 -0700 (PDT)
X-Received: by 2002:a50:9f82:0:b0:50b:c48c:8a25 with SMTP id
 c2-20020a509f82000000b0050bc48c8a25mr104476edf.6.1686750451172; Wed, 14 Jun
 2023 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
 <ZIG1Qi0iUjTKICQM@alley> <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
 <ZImWd62fXjsZildv@alley>
In-Reply-To: <ZImWd62fXjsZildv@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Jun 2023 06:47:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WP39nUmdeNjjTGx-XWhS4AgG5haHCfYjFUCEKckYVZDA@mail.gmail.com>
Message-ID: <CAD=FV=WP39nUmdeNjjTGx-XWhS4AgG5haHCfYjFUCEKckYVZDA@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 3:29=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> It seems that we have entered into a bike shedding mode.
> The following questions come to my mind:
>
>    1. Does this patchset improve the current state?
>
>    2. Maybe, it is not black&white. Is it possible to summarize
>       what exactly got better and what got worse?
>
> Maybe, there is no need to do bike-shedding about every step
> if the final result is reasonable and the steps are not
> completely wrong.
>
> I just followed my intuition and tried to do some changes step
> by step. I got lost many times so maybe the steps are not
> ideal. Anyway, the steps helped me to understand the logic
> and stay reasonably confident that they did not change
> the behavior.
>
> I could rework the patchset. But I first need to know what
> exactly is bad in the result. And eventually if there is more
> logical way how to end there.

Sure. I still feel like the end result of the CONFIG options after
your whole patchset is easier to understand / cleaner by adjusting the
dependencies as I have suggested. That being said, I agree that it is
the type of thing that can be more a matter of personal preference. I
do agree that, even if you don't take my suggestion of adjusting the
dependencies, the end result of your patchset still makes things
better than they were.

...so if you really feel strongly that things are more understandable
with the dependencies specified as you have, I won't stand in the way.
I still think you need a v2, though, just to address other nits.

-Doug
