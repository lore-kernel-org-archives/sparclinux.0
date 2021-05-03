Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF5C433ED
	for <sparclinux@archiver.kernel.org>; Mon,  3 May 2021 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A04E61208
	for <sparclinux@archiver.kernel.org>; Mon,  3 May 2021 22:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhECWsn (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 3 May 2021 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhECWsl (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 3 May 2021 18:48:41 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDEC061761
        for <sparclinux@vger.kernel.org>; Mon,  3 May 2021 15:47:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i11so6948642oig.8
        for <sparclinux@vger.kernel.org>; Mon, 03 May 2021 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3yLB+vbpq5Xc9JhKmZutr67bAiFvkUnDMtUXpplUGA=;
        b=OveNxb30rHLgSAzaM0tOpGtIlHylKdXRMEUg4g++/qGr+akviNgcsl9ZS1R/rXYoyp
         zwOveCIwXETnqsCO8OIfxkkHRQhhF4Fj9aHystlJxD1VsKnGjbWz24yFpXAsxp2rO5JY
         eNg84L2UL6R+SBmBR+MX8Ht2EYS/d7upYu5y0cpodgFCtMtSp5ubo0IzWvQ8TMcKmNCq
         CLalcxcOtduKKCdDuFAK3CiwV2RQJ1sWoUVjhloU3Nm5K2DEkk8M2XO+YN0biUXPDPGG
         LtYXy29QGclKlNPbz9XTmvq7I4Gu55+eLr9r4M1aofY1IwvxUDvtCxU+lYJ1eAVPa5rC
         aWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3yLB+vbpq5Xc9JhKmZutr67bAiFvkUnDMtUXpplUGA=;
        b=FIQblvNq8mAFF8eAP9ws8ttXRViKAhmsRtLEv6z5rJE3LC6JXj53f0YQDlYle5XNAc
         cOwkio4aJhFj1vXreIfwF4YDa3OhT/K0KpnIz6mMnpfZ/ML1B9fJTz0vIP/CCKfuxb2l
         x71irKu3TNj3pkcj3MbzfZTcLgLXzkSKAPP3MRYIhsCHjPsNGiPzWlemW/kZXxi8evn6
         Jcs0aDBgRgMi5veJ1qs396r/ObX5KdPWuHSBSPjjW7ASMSNKJjWHEa2LlK/BlQID/tUt
         AHGtm2MEHnO21YRm1ryffKZTGNEVDrZxvg3kSAhUdWUGmHrZPZZ92Ykqh0O2c8vzRMtv
         ObzQ==
X-Gm-Message-State: AOAM533whKS9nDnDqSFaZtZHvCsQlbUVH+puRF9AOLfqf4WZEUnaKsC4
        4ixuVxfXj60zOpIFfY60kx/eUy2v2yXkf5lPZeRMGw==
X-Google-Smtp-Source: ABdhPJxXjygNqNo+DUUJipEoWFZJ3Rjm/JQsG3j/6+Eb309MKSMe1ONNWrgQJbAjkUptHOIkbNRpxHmAJ/M/fQucoBI=
X-Received: by 2002:aca:44d6:: with SMTP id r205mr15201349oia.172.1620082067206;
 Mon, 03 May 2021 15:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <m14kfjh8et.fsf_-_@fess.ebiederm.org> <20210503203814.25487-1-ebiederm@xmission.com>
 <20210503203814.25487-10-ebiederm@xmission.com> <m1o8drfs1m.fsf@fess.ebiederm.org>
In-Reply-To: <m1o8drfs1m.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 4 May 2021 00:47:35 +0200
Message-ID: <CANpmjNNOK6Mkxkjx5nD-t-yPQ-oYtaW5Xui=hi3kpY_-Y0=2JA@mail.gmail.com>
Subject: Re: [PATCH 10/12] signal: Redefine signinfo so 64bit fields are possible
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

On Mon, 3 May 2021 at 23:04, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Eric W. Beiderman" <ebiederm@xmission.com> writes:
> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > The si_perf code really wants to add a u64 field.  This change enables
> > that by reorganizing the definition of siginfo_t, so that a 64bit
> > field can be added without increasing the alignment of other fields.

If you can, it'd be good to have an explanation for this, because it's
not at all obvious -- some future archeologist will wonder how we ever
came up with this definition of siginfo...

(I see the trick here is that before the union would have changed
alignment, introducing padding after the 3 ints -- but now because the
3 ints are inside the union the union's padding no longer adds padding
for these ints.  Perhaps you can explain it better than I can. Also
see below.)

> I decided to include this change because it is not that complicated,
> and it allows si_perf_data to have the definition that was originally
> desired.

Neat, and long-term I think this seems to be worth having. Sooner or
later something else might want __u64, too.

But right now, due to the slight increase in complexity, we need to
take extra care ensuring nothing broke -- at a high-level I see why
this seems to be safe.

> If this looks difficult to make in the userspace definitions,
> or is otherwise a problem I don't mind dropping this change.  I just
> figured since it was not too difficult and we are changing things
> anyway I should try for everything.

Languages that support inheritance might end up with the simpler
definition here (and depending on which fields they want to access,
they'd have to cast the base siginfo into the one they want). What
will become annoying is trying to describe siginfo_t.

I will run some tests in the morning.

Thanks,
-- Marco

[...]
> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index e663bf117b46..1fcede623a73 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -29,15 +29,33 @@ typedef union sigval {
> >  #define __ARCH_SI_ATTRIBUTES
> >  #endif
> >
> > +#ifndef __ARCH_HAS_SWAPPED_SIGINFO
> > +#define ___SIGINFO_COMMON    \
> > +     int     si_signo;       \
> > +     int     si_errno;       \
> > +     int     si_code
> > +#else
> > +#define ___SIGINFO_COMMON    \
> > +     int     si_signo;       \
> > +     int     si_code;        \
> > +     int     si_errno
> > +#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
> > +
> > +#define __SIGINFO_COMMON     \
> > +     ___SIGINFO_COMMON;      \
> > +     int     _common_pad[__alignof__(void *) != __alignof(int)]

Just to verify my understanding of _common_pad: this is again a legacy
problem, right? I.e. if siginfo was designed from the start like this,
we wouldn't need the _common_pad.


While this looks quite daunting, this is effectively turning siginfo
from a struct with a giant union, into lots of smaller structs, each
of which share a common header a'la inheritance -- until now the
distinction didn't matter, but it starts to matter as soon as
alignment of one child-struct would affect the offsets of another
child-struct (i.e. the old version). Right?

I was wondering if it would make things look cleaner if the above was
encapsulated in a struct, say __sicommon? Then the outermost union
would use 'struct __sicommon _sicommon' and we need #defines for
si_signo, si_code, and si_errno.

Or would it break alignment somewhere?

I leave it to your judgement -- just an idea.

> >  union __sifields {
> >       /* kill() */
> >       struct {
> > +             __SIGINFO_COMMON;
> >               __kernel_pid_t _pid;    /* sender's pid */
> >               __kernel_uid32_t _uid;  /* sender's uid */
> >       } _kill;
> >
> >       /* POSIX.1b timers */
> >       struct {
> > +             __SIGINFO_COMMON;
> >               __kernel_timer_t _tid;  /* timer id */
> >               int _overrun;           /* overrun count */
> >               sigval_t _sigval;       /* same as below */
> > @@ -46,6 +64,7 @@ union __sifields {
> >
> >       /* POSIX.1b signals */
> >       struct {
> > +             __SIGINFO_COMMON;
> >               __kernel_pid_t _pid;    /* sender's pid */
> >               __kernel_uid32_t _uid;  /* sender's uid */
> >               sigval_t _sigval;
> > @@ -53,6 +72,7 @@ union __sifields {
> >
> >       /* SIGCHLD */
> >       struct {
> > +             __SIGINFO_COMMON;
> >               __kernel_pid_t _pid;    /* which child */
> >               __kernel_uid32_t _uid;  /* sender's uid */
> >               int _status;            /* exit code */
> > @@ -62,6 +82,7 @@ union __sifields {
> >
> >       /* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
> >       struct {
> > +             __SIGINFO_COMMON;
> >               void __user *_addr; /* faulting insn/memory ref. */
> >  #ifdef __ia64__
> >               int _imm;               /* immediate value for "break" */
> > @@ -97,35 +118,28 @@ union __sifields {
> >
> >       /* SIGPOLL */
> >       struct {
> > +             __SIGINFO_COMMON;
> >               __ARCH_SI_BAND_T _band; /* POLL_IN, POLL_OUT, POLL_MSG */
> >               int _fd;
> >       } _sigpoll;
> >
> >       /* SIGSYS */
> >       struct {
> > +             __SIGINFO_COMMON;
> >               void __user *_call_addr; /* calling user insn */
> >               int _syscall;   /* triggering system call number */
> >               unsigned int _arch;     /* AUDIT_ARCH_* of syscall */
> >       } _sigsys;
> >  };
> >
> > -#ifndef __ARCH_HAS_SWAPPED_SIGINFO
> > -#define __SIGINFO                    \
> > -struct {                             \
> > -     int si_signo;                   \
> > -     int si_errno;                   \
> > -     int si_code;                    \
> > -     union __sifields _sifields;     \
> > -}
> > -#else
> > +
> >  #define __SIGINFO                    \
> > -struct {                             \
> > -     int si_signo;                   \
> > -     int si_code;                    \
> > -     int si_errno;                   \
> > +union {                                      \
> > +     struct {                        \
> > +             __SIGINFO_COMMON;       \
> > +     };                              \
> >       union __sifields _sifields;     \
> >  }
> > -#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
> >
> >  typedef struct siginfo {
> >       union {
