Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B9C433B4
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 00:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06EBE61409
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 00:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhEAAi1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 20:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhEAAiZ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Apr 2021 20:38:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B5EC06138B
        for <sparclinux@vger.kernel.org>; Fri, 30 Apr 2021 17:37:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v24so4096952oiv.9
        for <sparclinux@vger.kernel.org>; Fri, 30 Apr 2021 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYQeAScJs1TpMXononV3fp1ygIDD0T/s8VaH8jvt3Xw=;
        b=BePQGXKejT78YB+1Qc5q1LCPNsGstYOV9R088g5QlShgvjvM6ixO0lzCO87W+2TSwp
         znK2jDTneTfQHKD5uXShgkoJJolm6Bz5N/EpZXuPhYTS6BFF5IkfvoX18p4FHyHQvY4+
         hXJbJoQq26tEPkPvjcG2/98QNh45edHmhZWqhkxCTc7VTF2opNFtY1Z0MIXNPxlaHsjB
         ZMeloEw7ihZti5Zsu/oJYJLe0bQkNbe20ExgjOelN6ADUadC/pM+rBBH/kZzZq3ZkcwK
         nnnsu4CBGHT3agel86Jlryxeenvqys1N+5c46cXHYT0kybVbeCNf+vY4SGwCaTNp6m1H
         fBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYQeAScJs1TpMXononV3fp1ygIDD0T/s8VaH8jvt3Xw=;
        b=l/psdcwFF0Eic9I6ne1atZHbn2XrGdcrr4XXroebdAg4IurcIQJBtI9AKUz7mJjs7U
         GXoCpRfTnl3we2NQdcpK6BRPhyLE4RRtBhpWK8oSvl/z/iAVce0Vh3Ay98EhvK4fn6UC
         LuhIyvDhQQ0Ci9lz7RJAU7Ovn4B/zPIr7ySYUvz91YSPfbum+IuHmrh+iMTbBkyhmc9y
         p6BDaWE3eHy1IWd5NYaymnjrMUv1OxPZpMOSUqTNi4EMnp8vs7umv1P83KWY3VaovvQo
         qny6DMQ0/vvpoZKzdtdq80ljfHAFev1RTnTkM5qwOW9GaBCqKyvZHvTpt/n/fAPvSbQR
         dyoQ==
X-Gm-Message-State: AOAM533fZMXgropUo6AlGz2N1VlyKuW7pwBvzGrYi9ps4vr2+JFgfNOr
        MIVTexBZdDN5qAPjSuodL1L522gRrsZnCcN4wJQJvQ==
X-Google-Smtp-Source: ABdhPJxIo+BVTYzvdhNqfbqRCIwfel9igFlw7u9W4kJYtv5n3JP2YhvgynpMjQkCwdk9y9SzRO6wrc/4VyE8xKAg5N0=
X-Received: by 2002:aca:408a:: with SMTP id n132mr6087597oia.70.1619829453704;
 Fri, 30 Apr 2021 17:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
In-Reply-To: <m1r1irpc5v.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 02:37:22 +0200
Message-ID: <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] signal: Move si_trapno into the _si_fault union
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

On Sat, 1 May 2021 at 01:48, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Well with 7 patches instead of 3 that was a little more than I thought
> I was going to send.
>
> However that does demonstrate what I am thinking, and I think most of
> the changes are reasonable at this point.
>
> I am very curious how synchronous this all is, because if this code
> is truly synchronous updating signalfd to handle this class of signal
> doesn't really make sense.
>
> If the code is not synchronous using force_sig is questionable.
>
> Eric W. Biederman (7):
>       siginfo: Move si_trapno inside the union inside _si_fault
>       signal: Implement SIL_FAULT_TRAPNO
>       signal: Use dedicated helpers to send signals with si_trapno set
>       signal: Remove __ARCH_SI_TRAPNO
>       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
>       signal: Factor force_sig_perf out of perf_sigtrap
>       signal: Deliver all of the perf_data in si_perf

Thank you for doing this so quickly -- it looks much cleaner. I'll
have a more detailed look next week and also run some tests myself.

At a first glance, you've broken our tests in
tools/testing/selftests/perf_events/ -- needs a
s/si_perf/si_perf.data/, s/si_errno/si_perf.type/

Thanks!

-- Marco
