Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66EBC433B4
	for <sparclinux@archiver.kernel.org>; Fri, 30 Apr 2021 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811956146D
	for <sparclinux@archiver.kernel.org>; Fri, 30 Apr 2021 18:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhD3SM2 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhD3SM1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Apr 2021 14:12:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D581EC06174A
        for <sparclinux@vger.kernel.org>; Fri, 30 Apr 2021 11:11:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso10196092otn.3
        for <sparclinux@vger.kernel.org>; Fri, 30 Apr 2021 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vf2+S1x6r/e/FcKWzWWIRvMeVi3Dg4asX+PnCt1Zm1M=;
        b=BdzY8EOhoBQLTLtrVJMYviKEWJlUGJb4q8AoIXnB9KZMggfTz9LDL3Lr9vOR6ZpH13
         y4UMwzaN2tWVSm3h9bLgXcM8pjfp/EWXhNMJzrw8JweoLuSnFXFmmEut+vxb/RpxKPFk
         KS8edKMlFL6AF99NnjkC5H5mybGYPAnJRFUM+os1Iy+nppzVamfYx1Slf1+v2+c3Ymio
         7ozrLVU/NDeeaM+/u0eQEw1IRf/WQ5xzq9Py5Crg0CPc7EcRbocZ505dcbP5QGk1U6xg
         GfqvB0CkXG42IOxTtquxQhWDBUp/sPEvlwrY91NI2vjO2AiVjmJqAaj8vT2Bml6fltMM
         VmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vf2+S1x6r/e/FcKWzWWIRvMeVi3Dg4asX+PnCt1Zm1M=;
        b=APORxyQbool6UbBH9SgdUIu1HJNyXsbUggdx+G77YnFpAE08ahlEJy6D0OrBwCqXcH
         DbABlMjIRfdO0aGvaRfrCELQmzKwb1AVanUnb57kesNPAEym/wTfTNk2KQdwuJJzFRJe
         g7Xn0YqNF2HcEHPUURj3SYIgbpgizpIvOo8UMUu3B3e8G6MBJJ3gdz3j483kB8z1Lruk
         D1/5LhBa0nl/DpP7anbqxtg9250Xk0Tf57D1DHZiA26xqq5pDUqAzF1FzRY9XoWWgOwt
         lkjBPJ40qyI3HtqHTclwJKAxvCSCoVoGLOFNkY/1WmIl3JKqVtd14HOUvIQYDKq8ntAs
         9qmg==
X-Gm-Message-State: AOAM532MMEd3z/8mvTkKWY6e0qLUG7eIlwgahUxb0W/8wN2/H4KWp6ur
        E9Ok6MZCZrapwEfesV9949I2f05EL+1hL808W8lwgQ==
X-Google-Smtp-Source: ABdhPJw6A5NO8ufHNyJhyR5vHTtTeI1hfXYafTfJa00BpLpdODn4quTFm5wLD0i7Z8HZs3TwO1SDIchfi3B9nR+H06Y=
X-Received: by 2002:a9d:60c8:: with SMTP id b8mr4635783otk.17.1619806298042;
 Fri, 30 Apr 2021 11:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190734.624918-1-elver@google.com> <m1im43zn2g.fsf@fess.ebiederm.org>
In-Reply-To: <m1im43zn2g.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Apr 2021 20:11:26 +0200
Message-ID: <CANpmjNMxehkR+NHyJpqfSBYo9Ru7Hbs8j7c=G0Q5+966orQunw@mail.gmail.com>
Subject: Re: [PATCH 1/3] sparc64: Add compile-time asserts for siginfo_t offsets
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, 30 Apr 2021 at 19:42, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > To help catch ABI breaks at compile-time, add compile-time assertions to
> > verify the siginfo_t layout. Unlike other architectures, sparc64 is
> > special, because it is one of few architectures requiring si_trapno.
> > ABI breaks around that field would only be caught here.
>
> Arnd Bergman recently pointed out that we can move si_trapno into the
> union and make it specific to a handful of signals.  Like we do other
> items in the union.
>
> Given that the code of perf_sigtrap is pretty much broken if si_trapno
> needs to be filled out.  I think we should make that change before
> we set this ABI in stone like this.
>
> Otherwise this looks good.

Thanks, that's reasonable -- I'll reply to the other thread in a few minutes.

-- Marco

> Eric
>
> > Link: https://lkml.kernel.org/r/m11rat9f85.fsf@fess.ebiederm.org
> > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  arch/sparc/kernel/signal32.c  | 34 ++++++++++++++++++++++++++++++++++
> >  arch/sparc/kernel/signal_64.c | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> > index e9695a06492f..778ed5c26d4a 100644
> > --- a/arch/sparc/kernel/signal32.c
> > +++ b/arch/sparc/kernel/signal32.c
> > @@ -745,3 +745,37 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
> >  out:
> >       return ret;
> >  }
> > +
> > +/*
> > + * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
> > + * changes likely come with new fields that should be added below.
> > + */
> > +static_assert(NSIGILL        == 11);
> > +static_assert(NSIGFPE        == 15);
> > +static_assert(NSIGSEGV       == 9);
> > +static_assert(NSIGBUS        == 5);
> > +static_assert(NSIGTRAP       == 6);
> > +static_assert(NSIGCHLD       == 6);
> > +static_assert(NSIGSYS        == 2);
> > +static_assert(offsetof(compat_siginfo_t, si_signo)   == 0x00);
> > +static_assert(offsetof(compat_siginfo_t, si_errno)   == 0x04);
> > +static_assert(offsetof(compat_siginfo_t, si_code)    == 0x08);
> > +static_assert(offsetof(compat_siginfo_t, si_pid)     == 0x0c);
> > +static_assert(offsetof(compat_siginfo_t, si_uid)     == 0x10);
> > +static_assert(offsetof(compat_siginfo_t, si_tid)     == 0x0c);
> > +static_assert(offsetof(compat_siginfo_t, si_overrun) == 0x10);
> > +static_assert(offsetof(compat_siginfo_t, si_status)  == 0x14);
> > +static_assert(offsetof(compat_siginfo_t, si_utime)   == 0x18);
> > +static_assert(offsetof(compat_siginfo_t, si_stime)   == 0x1c);
> > +static_assert(offsetof(compat_siginfo_t, si_value)   == 0x14);
> > +static_assert(offsetof(compat_siginfo_t, si_int)     == 0x14);
> > +static_assert(offsetof(compat_siginfo_t, si_ptr)     == 0x14);
> > +static_assert(offsetof(compat_siginfo_t, si_addr)    == 0x0c);
> > +static_assert(offsetof(compat_siginfo_t, si_trapno)  == 0x10);
> > +static_assert(offsetof(compat_siginfo_t, si_addr_lsb)        == 0x14);
> > +static_assert(offsetof(compat_siginfo_t, si_lower)   == 0x18);
> > +static_assert(offsetof(compat_siginfo_t, si_upper)   == 0x1c);
> > +static_assert(offsetof(compat_siginfo_t, si_pkey)    == 0x18);
> > +static_assert(offsetof(compat_siginfo_t, si_perf)    == 0x14);
> > +static_assert(offsetof(compat_siginfo_t, si_band)    == 0x0c);
> > +static_assert(offsetof(compat_siginfo_t, si_fd)              == 0x10);
> > diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> > index a0eec62c825d..c9bbf5f29078 100644
> > --- a/arch/sparc/kernel/signal_64.c
> > +++ b/arch/sparc/kernel/signal_64.c
> > @@ -556,3 +556,36 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
> >       user_enter();
> >  }
> >
> > +/*
> > + * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
> > + * changes likely come with new fields that should be added below.
> > + */
> > +static_assert(NSIGILL        == 11);
> > +static_assert(NSIGFPE        == 15);
> > +static_assert(NSIGSEGV       == 9);
> > +static_assert(NSIGBUS        == 5);
> > +static_assert(NSIGTRAP       == 6);
> > +static_assert(NSIGCHLD       == 6);
> > +static_assert(NSIGSYS        == 2);
> > +static_assert(offsetof(siginfo_t, si_signo)  == 0x00);
> > +static_assert(offsetof(siginfo_t, si_errno)  == 0x04);
> > +static_assert(offsetof(siginfo_t, si_code)   == 0x08);
> > +static_assert(offsetof(siginfo_t, si_pid)    == 0x10);
> > +static_assert(offsetof(siginfo_t, si_uid)    == 0x14);
> > +static_assert(offsetof(siginfo_t, si_tid)    == 0x10);
> > +static_assert(offsetof(siginfo_t, si_overrun)        == 0x14);
> > +static_assert(offsetof(siginfo_t, si_status) == 0x18);
> > +static_assert(offsetof(siginfo_t, si_utime)  == 0x20);
> > +static_assert(offsetof(siginfo_t, si_stime)  == 0x28);
> > +static_assert(offsetof(siginfo_t, si_value)  == 0x18);
> > +static_assert(offsetof(siginfo_t, si_int)    == 0x18);
> > +static_assert(offsetof(siginfo_t, si_ptr)    == 0x18);
> > +static_assert(offsetof(siginfo_t, si_addr)   == 0x10);
> > +static_assert(offsetof(siginfo_t, si_trapno) == 0x18);
> > +static_assert(offsetof(siginfo_t, si_addr_lsb)       == 0x20);
> > +static_assert(offsetof(siginfo_t, si_lower)  == 0x28);
> > +static_assert(offsetof(siginfo_t, si_upper)  == 0x30);
> > +static_assert(offsetof(siginfo_t, si_pkey)   == 0x28);
> > +static_assert(offsetof(siginfo_t, si_perf)   == 0x20);
> > +static_assert(offsetof(siginfo_t, si_band)   == 0x10);
> > +static_assert(offsetof(siginfo_t, si_fd)     == 0x14);
