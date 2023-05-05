Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB5C77B7C
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 16:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjEEQqF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 5 May 2023 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEEQqE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 5 May 2023 12:46:04 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6013284
        for <sparclinux@vger.kernel.org>; Fri,  5 May 2023 09:46:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-763c343b716so45175239f.1
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683305163; x=1685897163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFdQlmBZsVXpMFRWa31Nf9CH5lKcpqbN0ffO9NCLDqk=;
        b=BtQeOCXcR/e+JBqbcvxaaQdWbQ7K4G+U72N39aucIcWt2TKM9ysmPS/ywahEzEjlYL
         ZmxdlaXpz8jyVOQvaxjMhIYBt0+GDtnVuYSmligy33ln9C2Njr6dGCziVgRfLqaX9zMz
         2gwDuhv9dLx/0UVwgZfvh0sGBHm37Ql86Os6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305163; x=1685897163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFdQlmBZsVXpMFRWa31Nf9CH5lKcpqbN0ffO9NCLDqk=;
        b=GoUhxwR4OLZ6iz5/FvIPXsHQUvR9b7ywvxr/icLyZcYh42ZQlYfRgryKnMKDQZOTw4
         cGEEIZ3P8mNeZCzhU80lVj6pas0HXRTYsWCUfR9bglwyhEcG6GqeoLXabMaJCBBLc4Fi
         Vl1y48NtY/I6/7ErFoIwzsprid9yHDKJMlnPiUxEgt1A2LxiCYbPYmlncsuC5BeCSj6x
         OQoW+gERsJuWJ80T/Oh1MYVIt6WyrdG1rohrUfhTvHJer2lpaX7i4i3uT6SOl2NRoWlu
         bHTsxEN9kA8GsBHn1UWU8Ku+pQ78bTTX2fkF6PXiAMf27RSYm7LO/R35NyUIFqe6AYLF
         itHw==
X-Gm-Message-State: AC+VfDxkd3ZGN7CaFZA1OMGb7vm6Q2g/H2SeSon2T6XjZIxuAKlXLxBf
        kqKLpOQo2J5o0LyibxFs5uMA+97KaDjmKUgTPqs=
X-Google-Smtp-Source: ACHHUZ53ya9s+KyqaIkP2iI+Rj8HubvX2Z9QD/d3qh72mQnCFDoLd4QnwJ3bTbZwskZ3hQqTNMNNDg==
X-Received: by 2002:a92:4a06:0:b0:32b:7df:f753 with SMTP id m6-20020a924a06000000b0032b07dff753mr1143276ilf.11.1683305162795;
        Fri, 05 May 2023 09:46:02 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id d7-20020a0566380d4700b004165ce4456fsm67943jak.33.2023.05.05.09.46.02
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:46:02 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-33164ec77ccso601795ab.0
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:46:02 -0700 (PDT)
X-Received: by 2002:ac8:5a8e:0:b0:3ef:3361:75d5 with SMTP id
 c14-20020ac85a8e000000b003ef336175d5mr266034qtc.11.1683304721570; Fri, 05 May
 2023 09:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.11.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid> <CSE0GBQQDUAY.1QAJIC3D3OBVU@wheely>
In-Reply-To: <CSE0GBQQDUAY.1QAJIC3D3OBVU@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:38:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVhPpTLPv1fmavGz-iwW1xA2P7_Uu_=GKZ-Ofu=vReZw@mail.gmail.com>
Message-ID: <CAD=FV=VVhPpTLPv1fmavGz-iwW1xA2P7_Uu_=GKZ-Ofu=vReZw@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] watchdog/hardlockup: Rename some "NMI watchdog" constants/function
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, linuxppc-dev@lists.ozlabs.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Thu, May 4, 2023 at 8:07=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > Do a search and replace of:
> > - NMI_WATCHDOG_ENABLED =3D> HARD_WATCHDOG_ENABLED
> > - watchdog_nmi_ =3D> watchdog_hardlockup_
>
> These are just making prefixes inconsistent again.
>
> If you really want to do a prefix, I would call it hardlockup which
> probably best matches existing code and sysctl / boot stuff, and
> concentrate on non-static symbols.

As with other similar patches, I'm happy to drop this and am doing it
at Petr's request.

[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley
