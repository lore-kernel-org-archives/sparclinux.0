Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF2C001DB
	for <sparclinux@archiver.kernel.org>; Fri,  4 Aug 2023 13:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjHDN5g (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHDN5e (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 4 Aug 2023 09:57:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08BDB1
        for <sparclinux@vger.kernel.org>; Fri,  4 Aug 2023 06:57:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so2747308a12.2
        for <sparclinux@vger.kernel.org>; Fri, 04 Aug 2023 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691157447; x=1691762247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQEI9Tt3LPX/UCb4Pxuia74BKZS5am/oZbLnhTBeH5c=;
        b=P+twRb0U1gRE+80Bx8flSUxpWo6z0ySWgxLZ0xc5GQLe90SBeGJmXHiD40mlY6+PD+
         pvmK69wq1ZH1nI7NsydPcAHe76Pu+AUZorv7tBo6HU/PUbxaf/dk0Gz3hhfmhGJsBwh7
         OKwTCOa3jomyXywBP6Q2TdJfpvZqir238QN9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157447; x=1691762247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQEI9Tt3LPX/UCb4Pxuia74BKZS5am/oZbLnhTBeH5c=;
        b=J+yh4l8a7fgSCyw2FKQyUa20Od1y5Kx+VfrjGe20RUsHI34oo0Z1UqXHbJ5Ij4w/TR
         /sINbTJRGbnFlENFGw7xmgjHv+VAzlPgWBy/tWuLXAFPNiunzSk16ZSF0OIri9IHjnNt
         sltF7mFcPZAeT+q3ESGvN/rgZuIpF/wPrrPOYBivG6NP+hwhbXsANbnb3e4wwd4JQKD9
         SsQXeEMQU8KBm3IMJH97FHax533/zwy5KfBdtTq9M2RzC7oRLh9qMsPIkvCL8sZ+FivJ
         rZKdY40ERPSh9T6/NIHaaH8+IoT9/eKV88dkccFwSAuz8W+LzX7D0Wd2hMFAA0PyXRHV
         EnGw==
X-Gm-Message-State: AOJu0YwZaPFl1NbMBsM/FLqbxSzn8rR4JCpaQWz5Ghcg1nHUdBRjjr9A
        nymcr41SnxWnWMvFx4dW6ZjnH4IAj/zspAZD+b9Ine1I
X-Google-Smtp-Source: AGHT+IH2vFm04IvZ77ecirReU68rWqZFSu5ldLjMdCiZ5RbCoSpiTvHwkj+hsOHw2NxWBwxHPi93Mg==
X-Received: by 2002:aa7:c383:0:b0:522:219b:ce05 with SMTP id k3-20020aa7c383000000b00522219bce05mr1852195edq.7.1691157447314;
        Fri, 04 Aug 2023 06:57:27 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id i9-20020a056402054900b0051e22660835sm1287334edx.46.2023.08.04.06.57.24
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 06:57:24 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso91105e9.0
        for <sparclinux@vger.kernel.org>; Fri, 04 Aug 2023 06:57:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1f90:b0:3f1:9a3d:4f7f with SMTP id
 je16-20020a05600c1f9000b003f19a3d4f7fmr49358wmb.1.1691157423841; Fri, 04 Aug
 2023 06:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230803160649.v3.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
 <ZMytyEoCARgP9VR8@dhcp22.suse.cz>
In-Reply-To: <ZMytyEoCARgP9VR8@dhcp22.suse.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Aug 2023 06:56:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQ18JG-sMBJHrhXByCWYSgOpCq8tL=3R8pT8CnFEa=pA@mail.gmail.com>
Message-ID: <CAD=FV=UQ18JG-sMBJHrhXByCWYSgOpCq8tL=3R8pT8CnFEa=pA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] nmi_backtrace: Allow excluding an arbitrary CPU
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Fri, Aug 4, 2023 at 12:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 03-08-23 16:07:57, Douglas Anderson wrote:
> > The APIs that allow backtracing across CPUs have always had a way to
> > exclude the current CPU. This convenience means callers didn't need to
> > find a place to allocate a CPU mask just to handle the common case.
> >
> > Let's extend the API to take a CPU ID to exclude instead of just a
> > boolean. This isn't any more complex for the API to handle and allows
> > the hardlockup detector to exclude a different CPU (the one it already
> > did a trace for) without needing to find space for a CPU mask.
> >
> > Arguably, this new API also encourages safer behavior. Specifically if
> > the caller wants to avoid tracing the current CPU (maybe because they
> > already traced the current CPU) this makes it more obvious to the
> > caller that they need to make sure that the current CPU ID can't
> > change.
>
> Yes, this looks like the best way forward.
>
> It would have been slightly safer to modify arch_trigger_cpumask_backtrac=
e
> by switching arguments so that some leftovers are captured easier.

I'm not sure I understand. Oh, you're saying make the prototype of
arch_trigger_cpumask_backtrace() incompatible so that if someone is
directly calling it then it'll be a compile-time error? I guess the
hope is that nobody is calling that directly and they're calling
through the trigger_...() functions.

For now I'm going to leave this alone.


> You also have this leftover
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 00982b133dc1..9f1743ee2b28 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -190,10 +190,6 @@ static inline bool trigger_all_cpu_backtrace(void)
>  {
>         return false;
>  }
> -static inline bool trigger_allbutself_cpu_backtrace(void)
> -{
> -       return false;
> -}

Ah yes. I missed that case. Let me send a quick v4.


>  static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
>  {
>         return false;
>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Anyway
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
