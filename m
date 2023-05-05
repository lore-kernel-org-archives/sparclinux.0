Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A0C77B7F
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 16:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjEEQgG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 5 May 2023 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjEEQgF (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 5 May 2023 12:36:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99014E60
        for <sparclinux@vger.kernel.org>; Fri,  5 May 2023 09:36:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2502346bea0so796926a91.2
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304561; x=1685896561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpDnC2craXa71PgQOtY/fZMYoEOsNHjFRztUygfINOs=;
        b=bxLCoKNjp6sDmXLHLr5RClnFOx9SzoDCcFEkF81F12AKTRh8xOUIdxHaJ12j6O5cH/
         CckmP1nWtZkaacXt5QGEvsmuTHBrFUokZn+lyKFxOPTEs+E6vkMQ4p9dU9trBsZKRRFu
         N4a3SgwoWA+KVi7iuAyfyZX0Kr+2c3FuEu+ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304561; x=1685896561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpDnC2craXa71PgQOtY/fZMYoEOsNHjFRztUygfINOs=;
        b=bSoJ0ZlNO9zLZPT5hU56ZojgVxIWLfrAwVb4TjFIyoa/CsmOpC+YRBvlOctHOtBrQo
         p3XaseQIfTo8n9ygWLKSlDeqZ0eUZane1xn3f8Wg2jDWnwLM+QWsZ3u9fwIj0X9vPf0q
         DYM9eZBsR7S9J+Nn5qSNYVtizateD6h5/aUQ5ZAixA9zbZEgjGPRqLyTzwjkQTXegL4x
         Pq5PSVUEh4afBRX0OiGr6bBvE+SP0a+kXcKKNj/rCqfmLrdKZzWBqQqZFfUcWBUvqjuK
         X2+IqP6w1nrzRoUbpyO9ccg2P96Of/39pYd9lYPfiOYWs/3A+X0yYH7SF6uxOm9HDWFx
         JJ0g==
X-Gm-Message-State: AC+VfDylaNnM6ZKjv1MsFcH2XTIWBLd8L6b3VNtbm/z+ejeuEvMepDHT
        cIDZQFbAGxtc0T/dp4/TKBel9Mu60IxGIwBvGRQ=
X-Google-Smtp-Source: ACHHUZ62hs7yOl6v/AJk7/cIIBXBwfIG60vtKO5SoE4jE4P8SbDV1QVW7zsUOXfsuNcK7E0oOxz60g==
X-Received: by 2002:a17:90b:1c8a:b0:24e:f03:6b8f with SMTP id oo10-20020a17090b1c8a00b0024e0f036b8fmr1787163pjb.48.1683304561109;
        Fri, 05 May 2023 09:36:01 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id ku12-20020a17090b218c00b0023a9564763bsm5281201pjb.29.2023.05.05.09.36.00
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:36:00 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1aae90f5ebcso600225ad.1
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:36:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1981:b0:3ed:210b:e698 with SMTP id
 u1-20020a05622a198100b003ed210be698mr317734qtc.7.1683304539483; Fri, 05 May
 2023 09:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid> <CSDZSKA38AEF.FY7J3JXBJX4I@wheely>
In-Reply-To: <CSDZSKA38AEF.FY7J3JXBJX4I@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:35:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
Message-ID: <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        Colin Cross <ccross@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Thu, May 4, 2023 at 7:36=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that doesn't doesn't need any extra
> > arch-specific support code to detect lockups. Instead of using
> > something arch-specific we will use the buddy system, where each CPU
> > watches out for another one. Specifically, each CPU will use its
> > softlockup hrtimer to check that the next CPU is processing hrtimer
> > interrupts by verifying that a counter is increasing.
>
> Powerpc's watchdog has an SMP checker, did you see it?

No, I wasn't aware of it. Interesting, it seems to basically enable
both types of hardlockup detectors together. If that really catches
more lockups, it seems like we could do the same thing for the buddy
system. If people want, I don't think it would be very hard to make
the buddy system _not_ exclusive of the perf system. Instead of having
the buddy system implement the "weak" functions I could just call the
buddy functions in the right places directly and leave the "weak"
functions for a more traditional hardlockup detector to implement.
Opinions?

Maybe after all this lands, the powerpc watchdog could move to use the
common code? As evidenced by this patch series, there's not really a
reason for the SMP detection to be platform specific.


> It's all to
> all rather than buddy which makes it more complicated but arguably
> bit better functionality.

Can you come up with an example crash where the "all to all" would
work better than the simple buddy system provided by this patch? It
seems like they would be equivalent, but I could be missing something.
Specifically they both need at least one non-locked-up CPU to detect a
problem. If one or more CPUs is locked up then we'll always detect it.
I suppose maybe you could provide a better error message at lockup
time saying that several CPUs were locked up and that could be
helpful. For now, I'd keep the current buddy system the way it is and
if you want to provide a patch improving things to be "all-to-all" in
the future that would be interesting to review.
