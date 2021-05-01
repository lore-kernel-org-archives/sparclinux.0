Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3278CC433ED
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006B7613CA
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 10:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEAKcN (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 1 May 2021 06:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhEAKcN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 1 May 2021 06:32:13 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2122C06138D
        for <sparclinux@vger.kernel.org>; Sat,  1 May 2021 03:31:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so770324otf.12
        for <sparclinux@vger.kernel.org>; Sat, 01 May 2021 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTLAv7JY7b65PTCIkNiaGknpqfuRJEA8yhpseb1KzSE=;
        b=hy8ij/KJANTxBA1iUwcAFbhxh/7nV/TgkTpM7lsxXIsguF7yyduVGajNBCDuZ6ayJi
         6uwjFy/Iu30GsdCwJHKdrTJT58iwk5fqUB4rBOd0qL7voxCQVoAEaUdVenHNEhlCGKRH
         YD4eBSjyusjG95+M03umPg+QYrMRDhPjFjtetKaR0AjgCs1HHIC/gMctrJMJRBDo3Ejr
         vK4g8Nc8S6DNG4Rleg7iZaE+kQFKmUhLZNOtAz4bV7NzRJ5ngeCy/YP3t9/FRUz2xB0Y
         AUwCg4Ud9NJTLIZpZ/JkUewLtLcZjlZDTZkc/bzM+dTOfHA7+KfMG1x4nuavM5ERuvCO
         ps+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTLAv7JY7b65PTCIkNiaGknpqfuRJEA8yhpseb1KzSE=;
        b=NR/PsdLaNwBAjx6/4EbQJ+wew5IIC6s19RXSP5L8o5QMZpd0HxAgU/LkY4yd2Du3h6
         HY52WIAZseU1RjixT6L2GXt5dr/jUh7IrwIHq6NQPYScHKn5nXlSJ/5pTfmyUVKaD774
         76fg7SP1MbbFeZ8pHqvFRukB5twDksgPWq0UowlBl/jt5M78aMBaNOnGvi1RGDs1tL5H
         rQuzcdbjV+NZ7vEGBAztLhcpbaQZOVivnHy47wPf6ES7hMg3a1jeXo24ln6gjHfVLXP8
         E0+TyxjxkodQvdseq0YINWUTCwuL+StjFhG/kgA/slGZK+cC+1vNF3TR0zLNjwPyqlXA
         6QkA==
X-Gm-Message-State: AOAM531S1cZmNa3rgyFjNG39JUJIudsq8Ch/Q4Id/tSmNe0bbORuDYQ0
        x9oqNThbskI+3AxrFyjWh29CBYUzGfklz+FHP6k6Nv2NYpo=
X-Google-Smtp-Source: ABdhPJzhSkL3GKPDZF15lJ0S9j3o4Grx4p016/H5oYlnjubfXOToiXRiBHKo75C0xSAsjEgjJgAEDjvFdHgEyScSBGM=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr7332566otn.233.1619865082626;
 Sat, 01 May 2021 03:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1tunns7yf.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1tunns7yf.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 12:31:10 +0200
Message-ID: <CANpmjNOZj-jRfFH365znJGqDAwdXL4Z2QBuHOtdvN_uNJ8WBSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] siginfo: Move si_trapno inside the union inside _si_fault
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

On Sat, 1 May 2021 at 00:50, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It turns out that linux uses si_trapno very sparingly, and as such it
> can be considered extra information for a very narrow selection of
> signals, rather than information that is present with every fault
> reported in siginfo.
>
> As such move si_trapno inside the union inside of _si_fault.  This
> results in no change in placement, and makes it eaiser to extend
> _si_fault in the future as this reduces the number of special cases.
> In particular with si_trapno included in the union it is no longer a
> concern that the union must be pointer alligned on most architectures
> because the union followes immediately after si_addr which is a
> pointer.
>

Maybe add "Link:
https://lkml.kernel.org/r/CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com"

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Acked-by: Marco Elver <elver@google.com>

By no longer guarding it with __ARCH_SI_TRAPNO we run the risk that it
will be used by something else at some point. Is that intentional?

Thanks,
-- Marco

> ---
>  include/linux/compat.h             | 4 +---
>  include/uapi/asm-generic/siginfo.h | 6 +-----
>  2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index f0d2dd35d408..24462ed63af4 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -214,12 +214,10 @@ typedef struct compat_siginfo {
>                 /* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
>                 struct {
>                         compat_uptr_t _addr;    /* faulting insn/memory ref. */
> -#ifdef __ARCH_SI_TRAPNO
> -                       int _trapno;    /* TRAP # which caused the signal */
> -#endif
>  #define __COMPAT_ADDR_BND_PKEY_PAD  (__alignof__(compat_uptr_t) < sizeof(short) ? \
>                                      sizeof(short) : __alignof__(compat_uptr_t))
>                         union {
> +                               int _trapno;    /* TRAP # which caused the signal */
>                                 /*
>                                  * used when si_code=BUS_MCEERR_AR or
>                                  * used when si_code=BUS_MCEERR_AO
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 03d6f6d2c1fe..2abdf1d19aad 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -63,9 +63,6 @@ union __sifields {
>         /* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
>         struct {
>                 void __user *_addr; /* faulting insn/memory ref. */
> -#ifdef __ARCH_SI_TRAPNO
> -               int _trapno;    /* TRAP # which caused the signal */
> -#endif
>  #ifdef __ia64__
>                 int _imm;               /* immediate value for "break" */
>                 unsigned int _flags;    /* see ia64 si_flags */
> @@ -75,6 +72,7 @@ union __sifields {
>  #define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
>                               sizeof(short) : __alignof__(void *))
>                 union {
> +                       int _trapno;    /* TRAP # which caused the signal */
>                         /*
>                          * used when si_code=BUS_MCEERR_AR or
>                          * used when si_code=BUS_MCEERR_AO
> @@ -150,9 +148,7 @@ typedef struct siginfo {
>  #define si_int         _sifields._rt._sigval.sival_int
>  #define si_ptr         _sifields._rt._sigval.sival_ptr
>  #define si_addr                _sifields._sigfault._addr
> -#ifdef __ARCH_SI_TRAPNO
>  #define si_trapno      _sifields._sigfault._trapno
> -#endif
>  #define si_addr_lsb    _sifields._sigfault._addr_lsb
>  #define si_lower       _sifields._sigfault._addr_bnd._lower
>  #define si_upper       _sifields._sigfault._addr_bnd._upper
> --
> 2.30.1
