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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD5C433B4
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 10:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD718613DC
	for <sparclinux@archiver.kernel.org>; Sat,  1 May 2021 10:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhEAKe6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 1 May 2021 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhEAKez (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 1 May 2021 06:34:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67024C06138B
        for <sparclinux@vger.kernel.org>; Sat,  1 May 2021 03:34:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 103-20020a9d0d700000b02902a5baf33f37so348347oti.9
        for <sparclinux@vger.kernel.org>; Sat, 01 May 2021 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCan+6xptMFqGkbIIPn1nwIIm9+SRi9i6mWKGsgGhAU=;
        b=UWGMH/nVDvcINlx4QrLJbQfDpg7ZCA/4MH41cC10w5jRUrFQhUVXZsLqvqHeGW19qW
         xhx0Odv3ZQ/ExTt8yWnNe7VP55kAeS3Op0WY5Csu31R7T0Wi2rQpER7XhlT5y6XTFNE3
         BVueuV0oPH/OGvQMGG/PrivMOEMBYTzB82jBNK8dbdKF0yLWvik21rliXWNGLTIgNPlL
         wdY0Aj5OQ55kFq6QLP0RhuBUt/a2T24B/FiC488jTTIBYlkQG1bPn53xCS/SrBB9XixT
         V1L6RX0f0+bW9q/P55FWVhQFoZZgWW/y45rdLwfzurJe17yAFBAHrBU6vPzkZg7z7awF
         5Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCan+6xptMFqGkbIIPn1nwIIm9+SRi9i6mWKGsgGhAU=;
        b=tgC3D9NULz56qGiAd8SRt8be8H2GizdryaZwDEb7lYEF7xZ174MY2iNiu45eS23FGz
         EyXNaA8/gVAUVfqp43kP47djGhh5QAeE589C9UKidmmlzmsf85RRKzRqP9IzSw0zOSKA
         60Njy5I7gnGKP99te6GFUvNlux+pDA9mSkXpsbColUU4IvN8m9V5zOhIrFydKLSPgQE4
         vYfAwsEW3t/ZsZojsjyO6C85/jjg4awpI4+IuE5WPI26qZ2pTlGpPT+PJmIJaPJXVLhJ
         TuC/Q2csCL3LdWFr4dgg2bRenfQ2DyRajETrm4pZtBee281ElfpDOplK/P6fp3AMEscI
         xEcw==
X-Gm-Message-State: AOAM532PEAduRSOIV/uxHEeRafN8gGggO61xMMTEU+lCYDL36b/QVM41
        1SdijqgGno0XJZ2XJRqiaiBle7wdWhnwotT4F6xAWQ==
X-Google-Smtp-Source: ABdhPJy1MvY2a7/kycfqy83Ks3Lj9IAWBx4Z0v17e+oXLsYz+vYG3fbuw+w7d3/8DHojuQ+i2zmKcGwBxHfgSotrgpg=
X-Received: by 2002:a9d:60c8:: with SMTP id b8mr7228167otk.17.1619865244678;
 Sat, 01 May 2021 03:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1eeers7q7.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1eeers7q7.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 12:33:53 +0200
Message-ID: <CANpmjNPztuttUqN3=Z4r7GPCyGu76CWNK-oYhxtByAx5OP_2rg@mail.gmail.com>
Subject: Re: [PATCH 3/3] signal: Use dedicated helpers to send signals with
 si_trapno set
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

On Sat, 1 May 2021 at 00:55, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Now that si_trapno is no longer expected to be present for every fault
> reported using siginfo on alpha and sparc remove the trapno parameter
> from force_sig_fault, force_sig_fault_to_task and send_sig_fault.
>
> Add two new helpers force_sig_fault_trapno and send_sig_fault_trapno
> for those signals where trapno is expected to be set.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/alpha/kernel/osf_sys.c      |  2 +-
>  arch/alpha/kernel/signal.c       |  4 +--
>  arch/alpha/kernel/traps.c        | 24 ++++++++---------
>  arch/alpha/mm/fault.c            |  4 +--
>  arch/sparc/kernel/process_64.c   |  2 +-
>  arch/sparc/kernel/sys_sparc_32.c |  2 +-
>  arch/sparc/kernel/sys_sparc_64.c |  2 +-
>  arch/sparc/kernel/traps_32.c     | 22 ++++++++--------
>  arch/sparc/kernel/traps_64.c     | 44 ++++++++++++++------------------
>  arch/sparc/kernel/unaligned_32.c |  2 +-
>  arch/sparc/mm/fault_32.c         |  2 +-
>  arch/sparc/mm/fault_64.c         |  2 +-
>  include/linux/sched/signal.h     | 12 +++------
>  kernel/signal.c                  | 41 +++++++++++++++++++++--------
>  14 files changed, 88 insertions(+), 77 deletions(-)

This still breaks sparc64:

> sparc64-linux-gnu-ld: arch/sparc/kernel/traps_64.o: in function `bad_trap':
> (.text+0x2a4): undefined reference to `force_sig_fault_trapno'

[...]
> +#if IS_ENABLED(SPARC)

This should be 'IS_ENABLED(CONFIG_SPARC)'.

> +int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno)
> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = sig;
> +       info.si_errno = 0;
> +       info.si_code  = code;
> +       info.si_addr  = addr;
> +       info.si_trapno = trapno;
> +       return force_sig_info(&info);
> +}
> +#endif
> +
> +#if IS_ENABLED(ALPHA)

CONFIG_ALPHA


> +int send_sig_fault_trapno(int sig, int code, void __user *addr, int trapno,
> +                         struct task_struct *t)
> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = sig;
> +       info.si_errno = 0;
> +       info.si_code  = code;
> +       info.si_addr  = addr;
> +       info.si_trapno = trapno;
> +       return send_sig_info(info.si_signo, &info, t);
> +}
> +#endif
> +
>  /* For the crazy architectures that include trap information in
>   * the errno field, instead of an actual errno value.
>   */
> --
> 2.30.1
>
