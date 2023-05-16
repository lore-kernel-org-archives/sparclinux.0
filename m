Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE6EC77B75
	for <sparclinux@archiver.kernel.org>; Tue, 16 May 2023 10:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjEPKJq (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 16 May 2023 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjEPKJo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 16 May 2023 06:09:44 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0B19B4
        for <sparclinux@vger.kernel.org>; Tue, 16 May 2023 03:09:33 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4536ec953c1so3979145e0c.3
        for <sparclinux@vger.kernel.org>; Tue, 16 May 2023 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684231773; x=1686823773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lEOYeeU5eTLm7de7UnRvbY+9wcsAqP7XOcqCDjWADA=;
        b=gK8/96Mwc9pJtoGDw27JnaeCATyvSkorVev6aES+s3evOWGv2eZ4S4ZQmr3dLrS1ji
         P75ZaYIR630JDnG938lXkgTpAzoCDm25UQTJicgxSxrC3C5xMLuqUAPnjpjFrMhTltvf
         5nOShkedMWMDsdiQC31T8R7CGcauuP/Smnv++IlvHsPbYsldV+8gK/muWzPtBUnpiWnm
         Edf/xMXcnyiN3A+Aoitl4bcEl0LNRK/bxRLNRAcSY4buq6wTKN2GYV7kQg0AX0DercuO
         4x6z9zmJyS5hNtZA48bVcCbR5vHvKIoMRTebZWJTjQO8cX5BYJGXGALHEndzBJd2BeEM
         QaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231773; x=1686823773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lEOYeeU5eTLm7de7UnRvbY+9wcsAqP7XOcqCDjWADA=;
        b=gMgYIUunmvGivvd9NJ45mPbsK0FlM2QY4OhELpOhAyfYGvuRhF7tVi5IIv0g3hhzkp
         MxMemGSMdcW1FawbMI/sm/MGyhPPaG7O1cIP875p0ddxy6es+gY3KvNvpefa0/Ghl1PQ
         9is7v5zgFjkzSP9ZxYoC4XezZ2S2UrsIf+BmYbewCjOkSEbVQGugHsPIBIJ4lZF9jtu/
         T2sLNWjIbKPVMrorYBw+5mkEVAt4okvWaTdpTrZni9P5NmNzKyHLE4S3mnmWTKmga+b/
         xbLdSoWUylmT691nyYwhLxwzPbFzQdENx7F8jf24MoYmzSRx0rVgDw7XqPveqXUworGD
         50gg==
X-Gm-Message-State: AC+VfDxHAvYc4UDc10mO7zH2guMgrP2OZcQ2c3fRGNQCXwRI7DhVxFSI
        h7drwlxorjWYEnsMzYxvIIkDDlTDd8hDrJmggTAhnw==
X-Google-Smtp-Source: ACHHUZ6TLbLYd474B27i7fOyl3BsnPpQ4fbmukWnlRJS2Ui51PNk1Fw9UBPkdN9uxCCarlSOI3HX0KcO/kJKITuV9Sk=
X-Received: by 2002:a1f:6dc6:0:b0:44f:eb0a:77db with SMTP id
 i189-20020a1f6dc6000000b0044feb0a77dbmr13395898vkc.11.1684231772863; Tue, 16
 May 2023 03:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <CAD=FV=Wny=iFQf2GGuC2qP9hy4FHzpiRpV=ZvxEW77DX02XGzQ@mail.gmail.com>
 <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com> <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
In-Reply-To: <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 16 May 2023 15:39:21 +0530
Message-ID: <CAFA6WYOU8HW2JVBfCeFEkn-5cd81TM-x=ArUKeaSi3NzxgKaGQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] arm64: Add framework to turn an IPI as NMI
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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

On Wed, 10 May 2023 at 22:20, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, May 10, 2023 at 9:30=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > On Wed, May 10, 2023 at 08:28:17AM -0700, Doug Anderson wrote:
> > > Hi,
> >
> > Hi Doug,
> >
> > > On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > > This is an attempt to resurrect Sumit's old patch series [1] that
> > > > allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs an=
d
> > > > also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> > > > could find was v7, so I called this series v8. I haven't copied all=
 of
> > > > his old changelongs here, but you can find them from the link.
> > > >

Thanks Doug for picking up this work and for all your additions/improvement=
s.

> > > > Since v7, I have:
> > > > * Addressed the small amount of feedback that was there for v7.
> > > > * Rebased.
> > > > * Added a new patch that prevents us from spamming the logs with id=
le
> > > >   tasks.
> > > > * Added an extra patch to gracefully fall back to regular IPIs if
> > > >   pseudo-NMIs aren't there.
> > > >
> > > > Since there appear to be a few different patches series related to
> > > > being able to use NMIs to get stack traces of crashed systems, let =
me
> > > > try to organize them to the best of my understanding:
> > > >
> > > > a) This series. On its own, a) will (among other things) enable sta=
ck
> > > >    traces of all running processes with the soft lockup detector if
> > > >    you've enabled the sysctl "kernel.softlockup_all_cpu_backtrace".=
 On
> > > >    its own, a) doesn't give a hard lockup detector.
> > > >
> > > > b) A different recently-posted series [2] that adds a hard lockup
> > > >    detector based on perf. On its own, b) gives a stack crawl of th=
e
> > > >    locked up CPU but no stack crawls of other CPUs (even if they're
> > > >    locked too). Together with a) + b) we get everything (full locku=
p
> > > >    detect, full ability to get stack crawls).
> > > >
> > > > c) The old Android "buddy" hard lockup detector [3] that I'm
> > > >    considering trying to upstream. If b) lands then I believe c) wo=
uld
> > > >    be redundant (at least for arm64). c) on its own is really only
> > > >    useful on arm64 for platforms that can print CPU_DBGPCSR somehow
> > > >    (see [4]). a) + c) is roughly as good as a) + b).
> >
> > > It's been 3 weeks and I haven't heard a peep on this series. That
> > > means nobody has any objections and it's all good to land, right?
> > > Right? :-P

For me it was months waiting without any feedback. So I think you are
lucky :) or atleast better than me at poking arm64 maintainers.

> >
> > FWIW, there are still longstanding soundness issues in the arm64 pseudo=
-NMI
> > support (and fixing that requires an overhaul of our DAIF / IRQ flag
> > management, which I've been chipping away at for a number of releases),=
 so I
> > hadn't looked at this in detail yet because the foundations are still s=
omewhat
> > dodgy.
> >
> > I appreciate that this has been around for a while, and it's on my queu=
e to
> > look at.
>
> Ah, thanks for the heads up! We've been thinking about turning this on
> in production in ChromeOS because it will help us track down a whole
> class of field-generated crash reports that are otherwise opaque to
> us. It sounds as if maybe that's not a good idea quite yet? Do you
> have any idea of how much farther along this needs to go? ...of
> course, we've also run into issues with Mediatek devices because they
> don't save/restore GICR registers properly [1]. In theory, we might be
> able to work around that in the kernel.
>
> In any case, even if there are bugs that would prevent turning this on
> for production, it still seems like we could still land this series.
> It simply wouldn't do anything until someone turned on pseudo NMIs,
> which wouldn't happen till the kinks are worked out.

I agree here. We should be able to make the foundations robust later
on. IMHO, until we turn on features surrounding pseudo NMIs, I am not
sure how we can have true confidence in the underlying robustness.

-Sumit

>
> ...actually, I guess I should say that if all the patches of the
> current series do land then it actually _would_ still do something,
> even without pseudo-NMI. Assuming the last patch looks OK, it would at
> least start falling back to using regular IPIs to do backtraces. That
> wouldn't get backtraces on hard locked up CPUs but it would be better
> than what we have today where we don't get any backtraces. This would
> get arm64 on par with arm32...
>
> [1] https://issuetracker.google.com/281831288
