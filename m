Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C1DC433B4
	for <sparclinux@archiver.kernel.org>; Tue,  4 May 2021 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFDA613D8
	for <sparclinux@archiver.kernel.org>; Tue,  4 May 2021 22:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhEDWGK (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 4 May 2021 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhEDWGJ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 4 May 2021 18:06:09 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC41C06174A
        for <sparclinux@vger.kernel.org>; Tue,  4 May 2021 15:05:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso9693998oti.2
        for <sparclinux@vger.kernel.org>; Tue, 04 May 2021 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUX+fmvBWZ7MZX/eB50i8/ErJ0LDxPwc8AG9r8drP3E=;
        b=rbZN4R3LNUElHNoq86nZOXGZrt/77ppLVA7dfYsuZktEgdzL8Z5lVft97a2Qqc81ZT
         HTsioWhoOv0AtxTWxd4ssatl8Xn9rELCa6fX1sOLMWLfQLeBliCQnVAJp55nq1y3iX36
         KfkjpC9xPq/9dipNYt3q0RoPqVsMR2q13awl/8LY2rjuYvQ+0nBxsCAYaIQoWT8IjHIK
         auE4iv8tVmNW/OJ/EhWt3PB5w6rKfdhtNzFjZGaQr8v851k+jQvNzluu6HQDNHt1H0Kx
         TH4qWjPZQs6LZg6T3ynapkrHbZ+tcuxLKk8SSGpMgcqy4+7IKOXveZp534+A2cOv4IdF
         xTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUX+fmvBWZ7MZX/eB50i8/ErJ0LDxPwc8AG9r8drP3E=;
        b=Tv92Y0+A0Vi2OFMHOC5MNQ0cGr+Fh4dYRz8vHxw5PLwTfdEVmJB/dB3VU7pwyUEwII
         5IBykwGGQqEDpzPTLVSjuZTtaO7JCz6VvwdSk0XsqrjNxtxNRvKBEzx45n4oF1CZJIW8
         nleVCpvI4Jh2A1d/fOXiRaaB/OIC+DATrykuTiDOrZE9sITSgp6uVteoJ6VyMDdLFumD
         3YGCac+NLrTQZUbr2U+R3AvWjEV2eUgwbdGY8DDADDZtA9IAkmJwqqRQ5B0SaexH6Uqg
         stMFsvvt8lsjauiTtTkojlX1S8ZlS4soCjeTW3XCKrhDd7qCp5Gu8yXCgGMcLHJ0ude2
         WZ3w==
X-Gm-Message-State: AOAM532mXSDd772KxtOjE5sW5quePTxRS21kh0PPjx8DYcLqBxdYOn/m
        4QYP272gL6cUAAxI0gzMj/EP7jxQHZ9brAG1L4z8kw==
X-Google-Smtp-Source: ABdhPJxnW/mCtJ4lEreTQ7KO/p9+Ge0zM6xJ1dL9j6kkun07AsqbTc7or7bVSiCMpy/URBG+MwV8nVlTOvskSlBNnv4=
X-Received: by 2002:a9d:60c8:: with SMTP id b8mr21322801otk.17.1620165911656;
 Tue, 04 May 2021 15:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 00:05:00 +0200
Message-ID: <CANpmjNM5sYihM_9P5YHx06BooqLDhK96cMHGKaf61nCcoDJBdw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
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

On Tue, 4 May 2021 at 23:13, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This set of changes sorts out the ABI issues with SIGTRAP TRAP_PERF, and
> hopefully will can get merged before any userspace code starts using the
> new ABI.
>
> The big ideas are:
> - Placing the asserts first to prevent unexpected ABI changes
> - si_trapno becomming ordinary fault subfield.
> - struct signalfd_siginfo is almost full
>
> This set of changes starts out with Marco's static_assert changes and
> additional one of my own that enforces the fact that the alignment of
> siginfo_t is also part of the ABI.  Together these build time
> checks verify there are no unexpected ABI changes in the changes
> that follow.
>
> The field si_trapno is changed to become an ordinary extension of the
> _sigfault member of siginfo.
>
> The code is refactored a bit and then si_perf_type is added along side
> si_perf_data in the _perf subfield of _sigfault of siginfo_t.
>
> Finally the signalfd_siginfo fields are removed as they appear to be
> filling up the structure without userspace actually being able to use
> them.
>
> v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
> v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org
>
> Eric W. Biederman (9):
>       signal: Verify the alignment and size of siginfo_t
>       siginfo: Move si_trapno inside the union inside _si_fault
>       signal: Implement SIL_FAULT_TRAPNO
>       signal: Use dedicated helpers to send signals with si_trapno set
>       signal: Remove __ARCH_SI_TRAPNO
>       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
>       signal: Factor force_sig_perf out of perf_sigtrap
>       signal: Deliver all of the siginfo perf data in _perf
>       signalfd: Remove SIL_FAULT_PERF_EVENT fields from signalfd_siginfo
>
> Marco Elver (3):
>       sparc64: Add compile-time asserts for siginfo_t offsets
>       arm: Add compile-time asserts for siginfo_t offsets
>       arm64: Add compile-time asserts for siginfo_t offsets

I can't seem to see the rest of them in my inbox. LKML also is missing
them: https://lore.kernel.org/linux-api/m1tuni8ano.fsf_-_@fess.ebiederm.org/

Something must have swallowed them. Could you resend?
I'll then test in the morning.

Thanks,
-- Marco
