Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9FEC433B4
	for <sparclinux@archiver.kernel.org>; Mon,  3 May 2021 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B6561104
	for <sparclinux@archiver.kernel.org>; Mon,  3 May 2021 19:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECTyp (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 3 May 2021 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECTyp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 3 May 2021 15:54:45 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28F6C06174A
        for <sparclinux@vger.kernel.org>; Mon,  3 May 2021 12:53:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t8so6578282oij.0
        for <sparclinux@vger.kernel.org>; Mon, 03 May 2021 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sL1cfgAwusROayggatCngmy+CDfZipZ8K0S97Q3yq6Q=;
        b=CRqyGcRJzr2t7Pmj7oHIyJjjFWQLWJae/kCMd4aaJk17BYeX/DnQGhh392/1rXNiCq
         3+jnOVqKRj2FR+odqa11vu4G+JXB5kSnuoZBhV7IBiWr0MfVSCa9PeXqfPYsewvLvZ6G
         hSOTPzHmojo+8IKA9lYSVlvLKLijZk64DYfy+EjSjuL7laMXS2e2DCbw8j4ZOWq4V/Po
         scljdkDPvwGCxWGA53xZTE2JNExwx17RQiuIJZ18Ul/Vjc3NODdA26x7hYe5rY0GGZsq
         Lur3c5i20XfFU1Y82iznEq14q1DPrpnU/is5Sptlk2NDIxe5jFuPZkwSn8SY7z2JnNLN
         TDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sL1cfgAwusROayggatCngmy+CDfZipZ8K0S97Q3yq6Q=;
        b=cjEcnSW/lrP/keCntwe7ZhtWwqpecT4pq6Sej9RY9+d+enzoHmH4/0PIiBb8ZBR0oo
         78uJyCLQgcoucQGNalKxv+Osg5iS94QpJFwCz5KGycDrYXiKhPSxWII4ISWHrvKWzDfM
         3ahmByY6dG7s0r3fcR4rPhGSsoghV5nEKBxbhUN7ih/GXHH1E4N0bT+A5ueaz/ZrT4ff
         c9FKkm+8bnCNdSDy2dsdw6kaUFEIhOHVnv0+5VjrKop6iWG9RFvNryyOS8msb002IVr+
         bqOUk5qqRmyQa9P+To/+f7idQ2wsf+3tA5YU7/nA0IUySXY7X2lG50fEgIKN7CIAT01Y
         KtqQ==
X-Gm-Message-State: AOAM531HS7E3OSTZfeIsuA9lKM9+/pxwixkwoW1Vjc3qL2zJMpN97PYT
        LKcJxUTQwmQoeAZICm7Ga4mCgKBnuKE3nlVfB4SSzA==
X-Google-Smtp-Source: ABdhPJxWqJOXiH/95U6rrLRMIPGQFk6oJv1bO9Wxu4NNmUUeQHEBRT3D3+oQLsWrAa5qP9iF+z00FCubwSjXwRKUQxQ=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr14657198oif.121.1620071630990;
 Mon, 03 May 2021 12:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m11rarqqx2.fsf_-_@fess.ebiederm.org>
 <CANpmjNNJ_MnNyD4R2+9i24E=9xPHKnwTh6zwWtBYkuAq1Xo6-w@mail.gmail.com>
 <m1wnshm14b.fsf@fess.ebiederm.org> <YI/wJSwQitisM8Xf@hirez.programming.kicks-ass.net>
 <m1sg33ip4w.fsf@fess.ebiederm.org>
In-Reply-To: <m1sg33ip4w.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 3 May 2021 21:53:39 +0200
Message-ID: <CANpmjNNyvOFyEDLPKuGn-pjFTMfLCOBHOQrMocLVpdEG47Ge3A@mail.gmail.com>
Subject: Re: [PATCH 7/3] signal: Deliver all of the perf_data in si_perf
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
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

On Mon, 3 May 2021 at 21:38, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Sun, May 02, 2021 at 01:39:16PM -0500, Eric W. Biederman wrote:
> >
> >> The one thing that this doesn't do is give you a 64bit field
> >> on 32bit architectures.
> >>
> >> On 32bit builds the layout is:
> >>
> >>      int si_signo;
> >>      int si_errno;
> >>      int si_code;
> >>      void __user *_addr;
> >>
> >> So I believe if the first 3 fields were moved into the _sifields union
> >> si_perf could define a 64bit field as it's first member and it would not
> >> break anything else.
> >>
> >> Given that the data field is 64bit that seems desirable.
> >
> > The data field is fundamentally an address, it is internally a u64
> > because the perf ring buffer has u64 alignment and it saves on compat
> > crap etc.
> >
> > So for the 32bit/compat case the high bits will always be 0 and
> > truncating into an unsigned long is fine.
>
> I see why it is fine to truncate the data field into an unsigned long.
>
> Other than technical difficulties in extending siginfo_t is there any
> reason not to define data as a __u64?

No -- like I pointed at earlier, si_perf used to be __u64, but we
can't because of the siginfo_t limitation. What we have now is fine,
and not worth dwelling over given siginfo limitations.

Thanks,
-- Marco
