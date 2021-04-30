Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAFCC43460
	for <sparclinux@archiver.kernel.org>; Fri, 30 Apr 2021 17:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D24961469
	for <sparclinux@archiver.kernel.org>; Fri, 30 Apr 2021 17:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhD3RnP (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 13:43:15 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56792 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3RnO (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Apr 2021 13:43:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcX9h-00C12U-B1; Fri, 30 Apr 2021 11:42:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcX9f-006Y7x-7J; Fri, 30 Apr 2021 11:42:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        davem@davemloft.net, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20210429190734.624918-1-elver@google.com>
Date:   Fri, 30 Apr 2021 12:42:15 -0500
In-Reply-To: <20210429190734.624918-1-elver@google.com> (Marco Elver's message
        of "Thu, 29 Apr 2021 21:07:32 +0200")
Message-ID: <m1im43zn2g.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcX9f-006Y7x-7J;;;mid=<m1im43zn2g.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xpTyeVtWIoPQ2FBsR3t2FfJi/LIl7zG4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] sparc64: Add compile-time asserts for siginfo_t offsets
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Marco Elver <elver@google.com> writes:

> To help catch ABI breaks at compile-time, add compile-time assertions to
> verify the siginfo_t layout. Unlike other architectures, sparc64 is
> special, because it is one of few architectures requiring si_trapno.
> ABI breaks around that field would only be caught here.

Arnd Bergman recently pointed out that we can move si_trapno into the
union and make it specific to a handful of signals.  Like we do other
items in the union.

Given that the code of perf_sigtrap is pretty much broken if si_trapno
needs to be filled out.  I think we should make that change before
we set this ABI in stone like this.

Otherwise this looks good.

Eric

> Link: https://lkml.kernel.org/r/m11rat9f85.fsf@fess.ebiederm.org
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/sparc/kernel/signal32.c  | 34 ++++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/signal_64.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index e9695a06492f..778ed5c26d4a 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -745,3 +745,37 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
>  out:
>  	return ret;
>  }
> +
> +/*
> + * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
> + * changes likely come with new fields that should be added below.
> + */
> +static_assert(NSIGILL	== 11);
> +static_assert(NSIGFPE	== 15);
> +static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGBUS	== 5);
> +static_assert(NSIGTRAP	== 6);
> +static_assert(NSIGCHLD	== 6);
> +static_assert(NSIGSYS	== 2);
> +static_assert(offsetof(compat_siginfo_t, si_signo)	== 0x00);
> +static_assert(offsetof(compat_siginfo_t, si_errno)	== 0x04);
> +static_assert(offsetof(compat_siginfo_t, si_code)	== 0x08);
> +static_assert(offsetof(compat_siginfo_t, si_pid)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_uid)	== 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_tid)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_overrun)	== 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_status)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_utime)	== 0x18);
> +static_assert(offsetof(compat_siginfo_t, si_stime)	== 0x1c);
> +static_assert(offsetof(compat_siginfo_t, si_value)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_int)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_ptr)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_addr)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_trapno)	== 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x18);
> +static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x1c);
> +static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x18);
> +static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
> diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> index a0eec62c825d..c9bbf5f29078 100644
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -556,3 +556,36 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
>  	user_enter();
>  }
>  
> +/*
> + * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
> + * changes likely come with new fields that should be added below.
> + */
> +static_assert(NSIGILL	== 11);
> +static_assert(NSIGFPE	== 15);
> +static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGBUS	== 5);
> +static_assert(NSIGTRAP	== 6);
> +static_assert(NSIGCHLD	== 6);
> +static_assert(NSIGSYS	== 2);
> +static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
> +static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
> +static_assert(offsetof(siginfo_t, si_code)	== 0x08);
> +static_assert(offsetof(siginfo_t, si_pid)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_uid)	== 0x14);
> +static_assert(offsetof(siginfo_t, si_tid)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_overrun)	== 0x14);
> +static_assert(offsetof(siginfo_t, si_status)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_utime)	== 0x20);
> +static_assert(offsetof(siginfo_t, si_stime)	== 0x28);
> +static_assert(offsetof(siginfo_t, si_value)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_int)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_ptr)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_addr)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_trapno)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x20);
> +static_assert(offsetof(siginfo_t, si_lower)	== 0x28);
> +static_assert(offsetof(siginfo_t, si_upper)	== 0x30);
> +static_assert(offsetof(siginfo_t, si_pkey)	== 0x28);
> +static_assert(offsetof(siginfo_t, si_perf)	== 0x20);
> +static_assert(offsetof(siginfo_t, si_band)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
