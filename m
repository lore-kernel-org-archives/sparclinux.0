Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79663C433ED
	for <sparclinux@archiver.kernel.org>; Wed,  5 May 2021 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535346139A
	for <sparclinux@archiver.kernel.org>; Wed,  5 May 2021 17:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhEER4t (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 5 May 2021 13:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhEER4i (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 5 May 2021 13:56:38 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36BC026CD3
        for <sparclinux@vger.kernel.org>; Wed,  5 May 2021 10:27:23 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so2373254otp.11
        for <sparclinux@vger.kernel.org>; Wed, 05 May 2021 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M03sKOxWmfO4zIIvVJvRTj0HkcVDUTsP1sbeJa/EAZM=;
        b=EcCh/rMi5KmwfiXTgOVzyoVd8i5hjF3UHvLH4vJc8mPzzFhcP98szei1CE0cr+uBHk
         tOnj6ZEGDl8PKnDih4+zjCEEkGUN81/KH8KOEYAylIhzmV/k3AfJtBZ4VafnmGpRxjjK
         NQ9DFyme0g0Qonmj5S4uIBUoVOVdq7mo68xbItQuRZSmbSayf8jf6oDQapdeX1Z4nbQI
         ehxiyMgSb51cECe3YmG0xyZ4Re+lNR8tmtbLVPPAg4HRhLAFpVKklUYKhsoPX4wEbXKR
         bfEXh6gC4Sq3ILqJd1c6EVAq0VbUFrXHhNdPvbB868DHKkenWUrnj/RZ0oT2XugfN5yf
         fCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M03sKOxWmfO4zIIvVJvRTj0HkcVDUTsP1sbeJa/EAZM=;
        b=FK2XjiLXrHQ3FEAAsPMZ3SN4l/OjeXJdQbI4Y4PnsY6KZplqYeWlrqqaQ5xk31C7Kq
         PSpdWn9v16Xe4P25/0waY2XXH9Z84Udh8fk1tp5P9piryh/ov3JsBm2r+S7wGsDSzQM+
         xNCk+xNtOVcf6wc4CfiGtVD7z7K19UpL7zhyPQr2qN+GSojDTLTVO/dFl2iBRHUT3G0T
         0+vHoUGx53oA70Uay9sQeeS12SR3uJr+y9gC93b/KQuTugs8W4nFeicn2I5SDrzbSD7P
         FbyvbS0RKzOQUeQmAbKC/M2IJPWXhiOxuT9ah4QUJev5zfLLz1Mxq3Hw4hvo5eL1SE96
         p0mA==
X-Gm-Message-State: AOAM532J2hRrdjxpxZef4uRRT/QqifEVZe/ZxUU8UV6neWWIVBOTu2q3
        Wxn9mLkIcucODi8A0NCl0U8MYjvOsYG7KwFllQCgrQ==
X-Google-Smtp-Source: ABdhPJwnM0M9EJ6eW6nI6X71rFRhMc4rEfbYRTx7ndnQbKdg/JyLCc6Zt9WXMv5yti6eJtKneFxV80R7JjkXaKj5N6M=
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr23870964ott.251.1620235642416;
 Wed, 05 May 2021 10:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org> <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-9-ebiederm@xmission.com>
In-Reply-To: <20210505141101.11519-9-ebiederm@xmission.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:26:00 +0200
Message-ID: <CANpmjNPmPWymJ9ZsQWys9wC3okt5M5fj7edp7ejk8RpTTMsxew@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] signal: Rename SIL_PERF_EVENT
 SIL_FAULT_PERF_EVENT for consistency
To:     "Eric W. Beiderman" <ebiederm@xmission.com>
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

On Wed, 5 May 2021 at 16:11, Eric W. Beiderman <ebiederm@xmission.com> wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> It helps to know which part of the siginfo structure the siginfo_layout
> value is talking about.
>
> v1: https://lkml.kernel.org/r/m18s4zs7nu.fsf_-_@fess.ebiederm.org
> Acked-by: Marco Elver <elver@google.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>



> ---
>  fs/signalfd.c          |  2 +-
>  include/linux/signal.h |  2 +-
>  kernel/signal.c        | 10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index e87e59581653..83130244f653 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -132,7 +132,7 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                 new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_perf = kinfo->si_perf;
>                 break;
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 5160fd45e5ca..ed896d790e46 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -44,7 +44,7 @@ enum siginfo_layout {
>         SIL_FAULT_MCEERR,
>         SIL_FAULT_BNDERR,
>         SIL_FAULT_PKUERR,
> -       SIL_PERF_EVENT,
> +       SIL_FAULT_PERF_EVENT,
>         SIL_CHLD,
>         SIL_RT,
>         SIL_SYS,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7eaa8d84db4c..697c5fe58db8 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1198,7 +1198,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>         case SIL_SYS:
>                 ret = false;
>                 break;
> @@ -2553,7 +2553,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 ksig->info.si_addr = arch_untagged_si_addr(
>                         ksig->info.si_addr, ksig->sig, ksig->info.si_code);
>                 break;
> @@ -3243,7 +3243,7 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>                                 layout = SIL_FAULT_PKUERR;
>  #endif
>                         else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
> -                               layout = SIL_PERF_EVENT;
> +                               layout = SIL_FAULT_PERF_EVENT;
>                 }
>                 else if (si_code <= NSIGPOLL)
>                         layout = SIL_POLL;
> @@ -3365,7 +3365,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_pkey = from->si_pkey;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_perf = from->si_perf;
>                 break;
> @@ -3441,7 +3441,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 to->si_addr = compat_ptr(from->si_addr);
>                 to->si_pkey = from->si_pkey;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = compat_ptr(from->si_addr);
>                 to->si_perf = from->si_perf;
>                 break;
> --
> 2.30.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210505141101.11519-9-ebiederm%40xmission.com.
