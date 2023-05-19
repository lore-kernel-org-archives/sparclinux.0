Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94416C77B75
	for <sparclinux@archiver.kernel.org>; Fri, 19 May 2023 17:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjESRXs (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 May 2023 13:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjESRXd (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 May 2023 13:23:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002261FFA
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:23:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d426e63baso152440b3a.0
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516943; x=1687108943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxsHOCJ1OWCqFtkIFidXd/8UskEhLhb6o5wuCVwA9p8=;
        b=OH7p/VDVfkRqtQry5WF8WXJan1tlWHxNYzPLBF/QgAce/apppDrBtH88zdeg2YUDrn
         oEEbBSxA6oO7EqfwnD1KW0xenxbDBKV6yCkbgknW2GDJuwnVo4z43vJO2iHn9KOQvBOq
         tR9ZPg63gH7hiikiWlc5iglYnasmBkAqoCqR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516943; x=1687108943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxsHOCJ1OWCqFtkIFidXd/8UskEhLhb6o5wuCVwA9p8=;
        b=RsyIyqLsnLFyijrSmxnzgnH/h3QCm1mUxEmRheOM++thkve4V92vdInck6Uov4Cd41
         fdJPhh+7maR5i7ILF3NMgzVFo4iDcN193ZvtI4C5+ZamLbGbNkLh+M80q3NLkEf1gGTM
         oU9BWKpnCThacNXIY2c+kk1lKY4H38VYxlfAYIo4umkGH1I20Riz6jOCTOnFsqtPpwKk
         06c2INdImpBOAn6CfPDgITX6a++1FqDq46keUAEEHWKaLomXz1nzKLcZ2zf/xxY0gQ+y
         ZXw+w98xMsa/S7bNOgoHI0VDCb+W24Lyg1s2uAAzmu895pkfV+DTda4zhrIYcmlp1bwM
         tDaw==
X-Gm-Message-State: AC+VfDzOzYRZeHsWpfcW6q7J4yvJjswbMjDKFDTpyssNhuR9tu8omByh
        8CDQT347o9FZpzq/FwN0I+GuDkM41qmmAsDHkw0=
X-Google-Smtp-Source: ACHHUZ7gAlBuS1ewnjoyo243DMjdQdzC77rcHdIn7eoVyxIaiw2G3GSUwSbk2ZivV9/DzFzjBHwmQA==
X-Received: by 2002:a05:6a00:14c4:b0:643:9cc0:a3be with SMTP id w4-20020a056a0014c400b006439cc0a3bemr4267894pfu.5.1684516943620;
        Fri, 19 May 2023 10:22:23 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b0063b488f3305sm1045941pfn.155.2023.05.19.10.22.23
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:22:23 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ae3f74c98bso7595ad.1
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:22:23 -0700 (PDT)
X-Received: by 2002:a92:c266:0:b0:338:1993:1194 with SMTP id
 h6-20020a92c266000000b0033819931194mr230509ild.2.1684516922186; Fri, 19 May
 2023 10:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.9.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid> <ZFz4TVOyEU51b898@alley>
In-Reply-To: <ZFz4TVOyEU51b898@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 May 2023 10:21:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VOdFsdSK5X_8v3YFqDWQhDEYfo5Jkut7=G8TB=+KBKrQ@mail.gmail.com>
Message-ID: <CAD=FV=VOdFsdSK5X_8v3YFqDWQhDEYfo5Jkut7=G8TB=+KBKrQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/17] watchdog/hardlockup: Add a "cpu" param to watchdog_hardlockup_check()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        ravi.v.shankar@intel.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Thu, May 11, 2023 at 7:14=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2023-05-04 15:13:41, Douglas Anderson wrote:
> > In preparation for the buddy hardlockup detector where the CPU
> > checking for lockup might not be the currently running CPU, add a
> > "cpu" parameter to watchdog_hardlockup_check().
> >
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -92,14 +92,14 @@ static DEFINE_PER_CPU(unsigned long, hrtimer_interr=
upts_saved);
> >  static DEFINE_PER_CPU(bool, watchdog_hardlockup_processed);
> >  static unsigned long watchdog_hardlockup_dumped_stacks;
> >
> > -static bool watchdog_hardlockup_is_lockedup(void)
> > +static bool watchdog_hardlockup_is_lockedup(unsigned int cpu)
> >  {
> > -     unsigned long hrint =3D __this_cpu_read(hrtimer_interrupts);
> > +     unsigned long hrint =3D per_cpu(hrtimer_interrupts, cpu);
>
> My radar tells me that this should be
> READ_ONCE(per_cpu(hrtimer_interrupts, cpu)) when the value might
> be modified on another CPU. Otherwise, the compiler is allowed
> to split the read into more instructions.
>
> It will be needed for the buddy detector. And it will require
> also incrementing the value in watchdog_hardlockup_interrupt_count()
> an atomic way.
>
> Note that __this_cpu_inc_return() does not guarantee atomicity
> according to my understanding. In theory, the following should
> work because counter will never be incremented in parallel:
>
> static unsigned long watchdog_hardlockup_interrupt_count(void)
> {
>         unsigned long count;
>
>         count =3D __this_cpu_read(hrtimer_interrupts);
>         count++;
>         WRITE_ONCE(*raw_cpu_ptr(hrtimer_interrupts), count);
> }
>
> but it is nasty. A more elegant solution might be using atomic_t
> for hrtimer_interrupts counter.

I switched it over to atomic_t.


> > -     if (__this_cpu_read(hrtimer_interrupts_saved) =3D=3D hrint)
> > +     if (per_cpu(hrtimer_interrupts_saved, cpu) =3D=3D hrint)
> >               return true;
> >
> > -     __this_cpu_write(hrtimer_interrupts_saved, hrint);
> > +     per_cpu(hrtimer_interrupts_saved, cpu) =3D hrint;
>
> IMHO, hrtimer_interrupts_saved might be handled this way.
> The value is read/written only by this function.
>
> The buddy watchdog should see consistent values even when
> the buddy CPU goes offline. This check should never race
> because this CPU should get touched when another buddy
> gets assigned.
>
> Well, it would deserve a comment.

I spent a bunch of time thinking about this too and I agree that for
hrtimer_interrupts_saved we don't need atomic_t nor even
READ_ONCE/WRITE_ONCE. I've add a comment and a note in the commit
message in v5.
