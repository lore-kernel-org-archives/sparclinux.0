Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A3C7EE22
	for <sparclinux@archiver.kernel.org>; Wed, 10 May 2023 16:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEJQtE (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 10 May 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbjEJQs5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 10 May 2023 12:48:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531635A7
        for <sparclinux@vger.kernel.org>; Wed, 10 May 2023 09:48:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52079a12451so5295561a12.3
        for <sparclinux@vger.kernel.org>; Wed, 10 May 2023 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683737334; x=1686329334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4AcAs1XOdI4uJxnLDu55ay7WUOLwtVEGo1buGajIlI=;
        b=eIe/TM1O/2jR8pOKOuC32y9biefgI7keyijTbmhj/x3B+2EgYFNpttI/P8qI1CuHjU
         zIXxVbp2TUrgrb8rLF4e8F8lGpM1kc7mk6cb7vfc1BGzlpKif8W+Gd3RQCPgw1fFwiJk
         EV4ZeYRKd4v09j11MjIZf4KMnnMI0XP7hVyOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683737334; x=1686329334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4AcAs1XOdI4uJxnLDu55ay7WUOLwtVEGo1buGajIlI=;
        b=KDsr/MCllASeRT9zYX3cTljhJ0o2XHQL2FpeOn9WaWjpjGkAum75IrHyrlIzRoU19B
         b3ZqBtkqe997ODqMo6z6a0N7YdDSNxG+bJM4ljnCzjIKVzX6ciNJxFuUlizHJUeU3Y4B
         zlyMn3hGTwNgW3o221kAKxCTDiqUTMYIfV0ZMAh11URFR9Qfhfh53btokDosZ0HT/O+R
         zrjL95WWcL2hIi/YUTtB1a1cJe8kcwm7w606Rqx4RYQSGPKbxnnsopHjS8wVlKGKS/us
         T3bk76QMpE9nHEzAIU13rKiV0sRlv4P2QVCrrqIXOp11kv7Ljxzq/sIIaP1S/n07uu9A
         sffQ==
X-Gm-Message-State: AC+VfDyX2HMJtVlqquCuIfBBrlBZKumirchCjC9A8pmXJAf+pfaPczar
        zNJBqjRrtiSLGVRX47mOsbfh1SzN8ou8v2avFLsoCQ==
X-Google-Smtp-Source: ACHHUZ6qqwphWTCBUYCD+TI1wD/PQtiDImpFzJE0YGwQXjk2WlxbPBJyZzaJL86hxCkjF8gp9a6cqg==
X-Received: by 2002:a17:90a:8004:b0:24e:5245:6383 with SMTP id b4-20020a17090a800400b0024e52456383mr18250872pjn.23.1683737334475;
        Wed, 10 May 2023 09:48:54 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id 63-20020a630242000000b0052c737ea9bbsm3474966pgc.39.2023.05.10.09.48.54
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 09:48:54 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1aae90f5ebcso234495ad.1
        for <sparclinux@vger.kernel.org>; Wed, 10 May 2023 09:48:54 -0700 (PDT)
X-Received: by 2002:ac8:5792:0:b0:3ee:d8fe:6f5c with SMTP id
 v18-20020ac85792000000b003eed8fe6f5cmr329937qta.1.1683736943923; Wed, 10 May
 2023 09:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <CAD=FV=Wny=iFQf2GGuC2qP9hy4FHzpiRpV=ZvxEW77DX02XGzQ@mail.gmail.com>
 <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 May 2023 09:42:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
Message-ID: <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] arm64: Add framework to turn an IPI as NMI
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>,
        Joey Gouly <joey.gouly@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 9:30=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, May 10, 2023 at 08:28:17AM -0700, Doug Anderson wrote:
> > Hi,
>
> Hi Doug,
>
> > On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > > This is an attempt to resurrect Sumit's old patch series [1] that
> > > allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> > > also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> > > could find was v7, so I called this series v8. I haven't copied all o=
f
> > > his old changelongs here, but you can find them from the link.
> > >
> > > Since v7, I have:
> > > * Addressed the small amount of feedback that was there for v7.
> > > * Rebased.
> > > * Added a new patch that prevents us from spamming the logs with idle
> > >   tasks.
> > > * Added an extra patch to gracefully fall back to regular IPIs if
> > >   pseudo-NMIs aren't there.
> > >
> > > Since there appear to be a few different patches series related to
> > > being able to use NMIs to get stack traces of crashed systems, let me
> > > try to organize them to the best of my understanding:
> > >
> > > a) This series. On its own, a) will (among other things) enable stack
> > >    traces of all running processes with the soft lockup detector if
> > >    you've enabled the sysctl "kernel.softlockup_all_cpu_backtrace". O=
n
> > >    its own, a) doesn't give a hard lockup detector.
> > >
> > > b) A different recently-posted series [2] that adds a hard lockup
> > >    detector based on perf. On its own, b) gives a stack crawl of the
> > >    locked up CPU but no stack crawls of other CPUs (even if they're
> > >    locked too). Together with a) + b) we get everything (full lockup
> > >    detect, full ability to get stack crawls).
> > >
> > > c) The old Android "buddy" hard lockup detector [3] that I'm
> > >    considering trying to upstream. If b) lands then I believe c) woul=
d
> > >    be redundant (at least for arm64). c) on its own is really only
> > >    useful on arm64 for platforms that can print CPU_DBGPCSR somehow
> > >    (see [4]). a) + c) is roughly as good as a) + b).
>
> > It's been 3 weeks and I haven't heard a peep on this series. That
> > means nobody has any objections and it's all good to land, right?
> > Right? :-P
>
> FWIW, there are still longstanding soundness issues in the arm64 pseudo-N=
MI
> support (and fixing that requires an overhaul of our DAIF / IRQ flag
> management, which I've been chipping away at for a number of releases), s=
o I
> hadn't looked at this in detail yet because the foundations are still som=
ewhat
> dodgy.
>
> I appreciate that this has been around for a while, and it's on my queue =
to
> look at.

Ah, thanks for the heads up! We've been thinking about turning this on
in production in ChromeOS because it will help us track down a whole
class of field-generated crash reports that are otherwise opaque to
us. It sounds as if maybe that's not a good idea quite yet? Do you
have any idea of how much farther along this needs to go? ...of
course, we've also run into issues with Mediatek devices because they
don't save/restore GICR registers properly [1]. In theory, we might be
able to work around that in the kernel.

In any case, even if there are bugs that would prevent turning this on
for production, it still seems like we could still land this series.
It simply wouldn't do anything until someone turned on pseudo NMIs,
which wouldn't happen till the kinks are worked out.

...actually, I guess I should say that if all the patches of the
current series do land then it actually _would_ still do something,
even without pseudo-NMI. Assuming the last patch looks OK, it would at
least start falling back to using regular IPIs to do backtraces. That
wouldn't get backtraces on hard locked up CPUs but it would be better
than what we have today where we don't get any backtraces. This would
get arm64 on par with arm32...

[1] https://issuetracker.google.com/281831288
