Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE08C433B4
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C2561090
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 16:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhEAQ1V (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 1 May 2021 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhEAQ1U (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 1 May 2021 12:27:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679CC06138D
        for <sparclinux@vger.kernel.org>; Sat,  1 May 2021 09:26:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l17so1251079oil.11
        for <sparclinux@vger.kernel.org>; Sat, 01 May 2021 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64NGINXN7ynqOlzs0BXPYhgqQOU3tvwvuitkM9gE7fk=;
        b=ZOy4ilx8G6e/EJLATpOC/TY/fj94iX8L+cJ9hsNgXo2Fwdw1iGCYFuJEtRcc8/4UsI
         3MDk5B6mxWDQuvRwmUkpVPa36usLK7yRP0rwQ25RDhqsA016eNkML3Uf92soKyMHPpK5
         HvbnVIEPJ339ufd7qHJbUdQWNgYAoUnaRNJBREhUkPl0m0wqrFS+U6A+Wf5OFWlACIen
         CiPQ7B/FlCGlplOU708S9fT01eLuThQFIsksO8AMlFq+nBhn8YcEpPCQU7Ooqg550ROE
         44vcQnb7GJK3P8in+Cb6BbsdwDrG62T2Yw3LbRiUDeaTrxe4/StG3eL4Trd+iWfdBUKc
         Ffow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64NGINXN7ynqOlzs0BXPYhgqQOU3tvwvuitkM9gE7fk=;
        b=uHJC+mUTL86/j8yiRIsBNgQcvAkzHjdAFeTwojBGwpfJzH4QUFgU00S30OTHI2srOY
         nwRzU2IZZo2kWdIM7n+ZuYvwY4s/o1hVUCBaexDvafc7DQxIylbYry0HRmEswvgOW2zD
         lue0PWq/cD546PdeuUIMPJLZHOkDkesNtgRds53+rX7MCg/KQBFnVTH+7UI6GmtCdVl3
         aX7UD+cj1xWXZ0I+e9ZN0ZVtHs4EfvO9VMOyeM83G2fu4NItHbknSwN5hoNTUNWztXSe
         6Q+rhECP1Rlfq92/UtMziBmLqFVEovuSkpIzLs7xbL9Zioj7eIXAj01cqPYF9nQwmfl1
         Nwfg==
X-Gm-Message-State: AOAM533uIYX8M8+oN3Xmin169Ji5LWmndNSQEi+oE7vGoHudU1BTZoS+
        2Cf93Km7VwuVELgViZiybcRiUdC5ZsuAsvw5PAsYVg==
X-Google-Smtp-Source: ABdhPJwK3vxrHpc74PcP54SlShb5rcBnkDMbWtN/Ywx+yZThHR0NVpaPVicFg1bqnl0bVxyrrx7FOb+J1Ci4wM4Z36I=
X-Received: by 2002:aca:408a:: with SMTP id n132mr8271992oia.70.1619886388654;
 Sat, 01 May 2021 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org> <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
In-Reply-To: <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 18:26:17 +0200
Message-ID: <CANpmjNMtM7JyxTiA-QpEmqd0MuQ+uZTjfZ3+_r4D=rrGpFU8RA@mail.gmail.com>
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

On Sat, 1 May 2021 at 02:37, Marco Elver <elver@google.com> wrote:
> On Sat, 1 May 2021 at 01:48, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Well with 7 patches instead of 3 that was a little more than I thought
> > I was going to send.
> >
> > However that does demonstrate what I am thinking, and I think most of
> > the changes are reasonable at this point.
> >
> > I am very curious how synchronous this all is, because if this code
> > is truly synchronous updating signalfd to handle this class of signal
> > doesn't really make sense.

Just a note on this: the reason for adding signalfd support was based
on the comment at SIL_FAULT_PKUERR:

>                 /*
>                   * Fall through to the SIL_FAULT case.  Both SIL_FAULT_BNDERR
>                   * and SIL_FAULT_PKUERR are only generated by faults that
>                   * deliver them synchronously to userspace.  In case someone
>                   * injects one of these signals and signalfd catches it treat
>                   * it as SIL_FAULT.
>                   */

The same would hold for SIL_FAULT_PERF_EVENT, where somebody injects
(re-injects perhaps?) such an event. But otherwise, yes,
non-synchronous handling of SIGTRAP/TRAP_PERF is pretty useless for
almost all usecases I can think of.

Thanks,
-- Marco
