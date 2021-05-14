Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD61C433B4
	for <sparclinux@archiver.kernel.org>; Fri, 14 May 2021 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0BA613AA
	for <sparclinux@archiver.kernel.org>; Fri, 14 May 2021 19:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhENTPg (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 14 May 2021 15:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhENTPe (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 14 May 2021 15:15:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CECC061574
        for <sparclinux@vger.kernel.org>; Fri, 14 May 2021 12:14:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2so44472854lft.4
        for <sparclinux@vger.kernel.org>; Fri, 14 May 2021 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHGE/SI1tO0CAdU9DspiMRu/IcggidAjeljmucgj+1U=;
        b=FHhNFP0HjOwmcUgJGOwZ/2fTGf6YloAj1IJt9cgCeCY5gct1ms0aePvfJ+p26Am9aT
         BgrkbekSovaMhMO5v4pdqS8eAlzBpMJLm9klgoPAMR35d4hkcz4CXmBtjJs+Fzkwi9i+
         rg2vQHNDh6q1olgYalhfdAxn+xT9pYxV7ONgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHGE/SI1tO0CAdU9DspiMRu/IcggidAjeljmucgj+1U=;
        b=IZ1is4jc9yFF4HBCiXfyWEc2ND0safEOa+lVhDYHuxplHN2IA2LFdGNULhOYFUHY6x
         aDj7MoLyahVzW5/YD2Heim+z+p5Vy6NMsM8t8CBVO2rVQ8/1u1+eMsqHE7M64aK0/FYB
         N9oxXCZTZuPVGC10q/kd/g8WHn+17edWem3DVpQ1HtjevDZE5zw1+wFrnf3eIk5X0Ya/
         dloyPGK3nnUfKfnFGCpNWvGaBxHXm0pFu7gqFiUL7uFRQU/9eN9SXB4fprauf8VuH833
         d8FuM+6a63o1uTi+FbkX5Xd7uFNZ2RitAssoXQSywBqybFqpIgGRhHsB+coLjNfEurR9
         KTEg==
X-Gm-Message-State: AOAM533jZ9rPIqrcmNf5ceXfjjLYSax00nllcNjtO+9TQueCtew5t6YU
        9Xhvm8mizyRL31/9YM5zFg1LAgZS+QY9epCwrvE=
X-Google-Smtp-Source: ABdhPJwuJeLhs9h7qdrdUJEWfKTMA1WAg3UIWdlcsdW8YpGIKUkX9Zj7RjA8Xeqe3JK8ZkYCpWmGjg==
X-Received: by 2002:a05:6512:3196:: with SMTP id i22mr32942385lfe.492.1621019660327;
        Fri, 14 May 2021 12:14:20 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d13sm115536lfs.100.2021.05.14.12.14.18
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 12:14:19 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id w15so39036170ljo.10
        for <sparclinux@vger.kernel.org>; Fri, 14 May 2021 12:14:18 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr38227020lji.465.1621019658636;
 Fri, 14 May 2021 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org> <m1a6oxewym.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1a6oxewym.fsf_-_@fess.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 12:14:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
Message-ID: <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc2
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
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, May 13, 2021 at 9:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the for-v5.13-rc2 branch from the git tree:

I really don't like this tree.

The immediate cause for "no" is the silly

 #if IS_ENABLED(CONFIG_SPARC)

and

 #if IS_ENABLED(CONFIG_ALPHA)

code in kernel/signal.c. It has absolutely zero business being there,
when those architectures have a perfectly fine arch/*/kernel/signal.c
file where that code would make much more sense *WITHOUT* any odd
preprocessor games.

But there are other oddities too, like the new

    send_sig_fault_trapno(SIGFPE, si_code, (void __user *) regs->pc,
0, current);

in the alpha code, which fundamentally seems bogus: using
send_sig_fault_trapno() with a '0' for trapno seems entirely
incorrect, since the *ONLY* point of that function is to set si_trapno
to something non-zero.

So it would seem that a plain send_sig_fault() without that 0 would be
the right thing to do.

This also mixes in a lot of other stuff than just the fixes. Which
would have been ok during the merge window, but I'm definitely not
happy about it now.

             Linus
