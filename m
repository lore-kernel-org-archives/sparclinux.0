Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDFEC7EE26
	for <sparclinux@archiver.kernel.org>; Fri, 19 May 2023 17:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjESRyR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 May 2023 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjESRyR (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 May 2023 13:54:17 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5111F9
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:54:15 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-438a5069d58so306621137.0
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684518854; x=1687110854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7bXuAl2er6jMvvw+SQdriEgYnLYrf51RQ1JCNcE4RU=;
        b=eAzm6iLaPZhCE36JZBKPfLAGyTaT6pfd7OsVmbd5TEzif1JMXASIWEkkcBRfvUHSoa
         n5SF18OYXwFfKNrDCdo5sIdPAEkrkKL9ir/M+O8CaJor3hyydepYhdnsFqOt7lIbu/L1
         RPrKfzdf7nZU5uJdZZE1tyMko/80Pk5vr4YtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518854; x=1687110854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7bXuAl2er6jMvvw+SQdriEgYnLYrf51RQ1JCNcE4RU=;
        b=DL2wxs/6LcazFpfrJrjhlaLMK1rXdCYvtzb3wagyH9A1bp5GJg6OXxuhPtRTxkoCkn
         hrcq1ScxfhBixeFharnMd1NbYRWD7SEhytV608ApWtKHBlTI5FL11d8bANsKQvlsE3eh
         an9m6t/E/lxUlkKX0g/1k/Dj4WMKpOyTsev8V1MzEfyHZ1EwF38/ucHixYPat9rNUk8n
         0Y5ymC3xBMrL6O5dUExbYgL8Uvbs2qEdObELh8xhlfN8r1WaOkiXWBU+2B7ahGsPP517
         gYzVCN0ztJ+pT3/HLq5vXVoM6INEnK58AGin380WlbCg/2GgJXm0tmVvCAWIurZbbjmX
         L0VA==
X-Gm-Message-State: AC+VfDzA1LSgB+8iNH19X0CegaY5xOGa5Qy9AmWCQGA07tgcEWvVMgk6
        7TLUA3JxlUOu1m+aNc/QiV8y8Pk2EIThXuqW0AE=
X-Google-Smtp-Source: ACHHUZ5DiQs/b0qogqKG0Vsrh8W6mknGYmhTBU8RVvw2WcnHVo+0iM4YYX+LEtCjTYC1XE0ONA89ZQ==
X-Received: by 2002:a67:f60f:0:b0:437:db92:2134 with SMTP id k15-20020a67f60f000000b00437db922134mr86672vso.8.1684518854183;
        Fri, 19 May 2023 10:54:14 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id v15-20020a67c88f000000b0043490d9cb6asm804654vsk.2.2023.05.19.10.54.13
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:54:13 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-456d9652c24so785061e0c.1
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:54:13 -0700 (PDT)
X-Received: by 2002:a05:6602:1548:b0:76c:e93a:e2a with SMTP id
 h8-20020a056602154800b0076ce93a0e2amr7743221iow.8.1684516998834; Fri, 19 May
 2023 10:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CSDZSKA38AEF.FY7J3JXBJX4I@wheely> <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
 <CSGHQJAJHWVS.1UAJOF8P5UXSK@wheely> <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
In-Reply-To: <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 May 2023 10:23:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X53VnS37YXkGUT7W=1ekS1YgznCbOiBQBSHuZLqpHa_A@mail.gmail.com>
Message-ID: <CAD=FV=X53VnS37YXkGUT7W=1ekS1YgznCbOiBQBSHuZLqpHa_A@mail.gmail.com>
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

On Mon, May 8, 2023 at 8:52=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hmmm, but I don't think you really need "all-to-all" checking to get
> the stacktraces you want, do you? Each CPU can be "watching" exactly
> one other CPU, but then when we actually lock up we could check all of
> them and dump stacks on all the ones that are locked up. I think this
> would be a fairly easy improvement for the buddy system. I'll leave it
> out for now just to keep things simple for the initial landing, but it
> wouldn't be hard to add. Then I think the two SMP systems  (buddy vs.
> all-to-all) would be equivalent in terms of functionality?

FWIW, I take back my "this would be fairly easy" comment. :-P ...or,
at least I'll acknowledge that the easy way has some tradeoffs. It
wouldn't be trivially easy to just snoop on the data of the other
buddies because the watching processors aren't necessarily
synchronized with each other.

That being said, if someone really wanted to report on other locked
CPUs before doing a panic() and was willing to delay the panic, it
probably wouldn't be too hard to put in a mode where the CPU that
detects the first lockup could do some extra work to look for lockups.
Maybe it could send a normal IPI to other CPUs and see if they respond
or maybe it could take over monitoring all CPUs and wait one extra
period.

In any case, I'm not planning on implementing this now, but at least
wanted to document thoughts. ;-)

> With my simplistic solution
> of just allowing the buddy detector to be enabled in parallel with a
> perf-based detector then we wouldn't have this level of coordination,
> but I'll assume that's OK for the initial landing.

I dug into this more as well and I also wanted to note that, at least
for now, I'm not going to include support to turn on both the buddy
and perf lockup detectors in the common core. In order to do this and
not have them stomp on each other then I think we need extra
coordination or two copies of the interrupt count / saved interrupt
count and, at least at this point in time, it doesn't seem worth it
for a halfway solution. From everything I've heard there is a push on
many x86 machines to get off the perf lockup detector anyway to free
up the resources. Someone could look at adding this complexity later.

-Doug
