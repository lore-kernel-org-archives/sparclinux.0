Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E173C43461
	for <sparclinux@archiver.kernel.org>; Sun,  2 May 2021 19:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4AF611C2
	for <sparclinux@archiver.kernel.org>; Sun,  2 May 2021 19:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhEBTOj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 2 May 2021 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhEBTOi (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 2 May 2021 15:14:38 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78FFC06138D
        for <sparclinux@vger.kernel.org>; Sun,  2 May 2021 12:13:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id p6-20020a4adc060000b02901f9a8fc324fso785348oov.10
        for <sparclinux@vger.kernel.org>; Sun, 02 May 2021 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emMfiYi99q3nX4v+CBQmuXsA/kqjvpixR7oLzYPLuiM=;
        b=eRrh8/FTxx8mY93zg7f5u2PqJag/AV+2CsamonnCrPl50D5ybWNE9RjM9IHFNGK0Hp
         tsQCQr9ZC0GehGcA6cOcwWjxeWjJU/S5VN/vJm45DBqcCLu0rlO90skMuIBy2K9DlLkg
         ukIAGtF3hQFZqp6AexAJ9ojqZ6R6plqZsdvVHcD+Q3hnqs3zSlCcUxdIXr8zVrKT0b90
         K9S1dNQqshSjqZqacgx4pkJCgXGhv7suX4I0XIqsmEW7olqA2qVrMj9ulfZezJAI479J
         Sc35Ku4NkEnOxygYrD+m2aeiOpvlD9SRGRymQrSXXTsljf/pKMCvCCY++dEYJEDOAYfq
         T+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emMfiYi99q3nX4v+CBQmuXsA/kqjvpixR7oLzYPLuiM=;
        b=K2EMEF/pIH4MGnUTlN+ic1Ka3DI5F/DPX0RHikhyZev78EQquhGfeDfw3rQLP7xx2t
         fVWWhFK+zE19GlYcifGHtzT4vzZLH6o94rld6YhQPv20RorTVkDpG9tHQNRsZ95XZG72
         QbEg0G5FZrb68Rj4R+kr30QIiWEAFHLAtXAwfuKJMDQpH7I0j5HBWSKlsktNj27/af3t
         RHucvLIdQfCWYfW4dGkBNdwE0ku/FF7+J4TVX4I86mEBOtfK6chhH4GNXX6BExqWDTxu
         hU/9yhBrAANjLw+vWLZJzDYyfMIeOt8pETuNaNZ7WMpfN9BJjaQWAxyLH+ffu+5V6MBT
         6HVg==
X-Gm-Message-State: AOAM530bSYF2zxunM+67IZklbP9msv9mEtnPfMZBTcDIjd/J8BAuO2td
        vdJTHzDtfDhGZafleUsuRTnyfe91wOw5BB1p2GB5WA==
X-Google-Smtp-Source: ABdhPJxwRjSJbo3C+Nwhf9lgspATPfUeP4Li99I0sKmagHuY+vIt3q37BWEwAiuogCr1O2KSyZDFBjA9IZlwBT6otMg=
X-Received: by 2002:a4a:e715:: with SMTP id y21mr2293005oou.54.1619982825669;
 Sun, 02 May 2021 12:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m11rarqqx2.fsf_-_@fess.ebiederm.org>
 <CANpmjNNJ_MnNyD4R2+9i24E=9xPHKnwTh6zwWtBYkuAq1Xo6-w@mail.gmail.com> <m1wnshm14b.fsf@fess.ebiederm.org>
In-Reply-To: <m1wnshm14b.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sun, 2 May 2021 21:13:34 +0200
Message-ID: <CANpmjNNpsdqCp51_P=NCM=fMREhN6HWQL7aiOdyfqu=aUmkR7A@mail.gmail.com>
Subject: Re: [PATCH 7/3] signal: Deliver all of the perf_data in si_perf
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sun, 2 May 2021 at 20:39, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > On Sat, 1 May 2021 at 01:44, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Don't abuse si_errno and deliver all of the perf data in si_perf.
> >>
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> ---
> >
> > Thank you for the fix, this looks cleaner.
> >
> > Just note that this patch needs to include updates to
> > tools/testing/selftests/perf_events. This should do it:
> >>  sed -i 's/si_perf/si_perf.data/g; s/si_errno/si_perf.type/g' tools/testing/selftests/perf_events/*.c
> >
> > Subject: s/perf_data/perf data/ ?
> >
> > For uapi, need to switch to __u32, see below.
>
> Good point.
>
> The one thing that this doesn't do is give you a 64bit field
> on 32bit architectures.
>
> On 32bit builds the layout is:
>
>         int si_signo;
>         int si_errno;
>         int si_code;
>         void __user *_addr;
>
> So I believe if the first 3 fields were moved into the _sifields union
> si_perf could define a 64bit field as it's first member and it would not
> break anything else.
>
> Given that the data field is 64bit that seems desirable.

Yes, it's quite unfortunate -- it was __u64 at first, but then we
noticed it broke 32-bit architectures like arm:
https://lore.kernel.org/linux-arch/20210422191823.79012-1-elver@google.com/

Thanks,
-- Marco
