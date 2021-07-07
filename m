Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E368C07E95
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jul 2021 08:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5314461C82
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jul 2021 08:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhGGI3i (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:29:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhGGI3i (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 7 Jul 2021 04:29:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B82ED1;
        Wed,  7 Jul 2021 01:26:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.2.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB7C43F694;
        Wed,  7 Jul 2021 01:26:56 -0700 (PDT)
Date:   Wed, 7 Jul 2021 09:26:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Peter Zijlstra <peterz@lists.infradead.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Subject: Re: [sparc64] locking/atomic, kernel OOPS on running stress-ng
Message-ID: <20210707082636.GA94463@C02TD0UTHF1T.local>
References: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
 <20210705195638.GA53988@C02TD0UTHF1T.local>
 <20210706091104.GA69200@C02TD0UTHF1T.local>
 <CADxRZqxNdYBAs1daPJTAPKGeJx30D+v7xz87K2sB_dXYKdTrVg@mail.gmail.com>
 <20210706120030.GB69200@C02TD0UTHF1T.local>
 <CADxRZqyQq4X-p=BpkpwcKUnLJAeZBLBLZ1u9fOkp74URR4Nb0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqyQq4X-p=BpkpwcKUnLJAeZBLBLZ1u9fOkp74URR4Nb0Q@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Jul 07, 2021 at 10:47:06AM +0300, Anatoly Pugachev wrote:
> On Tue, Jul 6, 2021 at 3:00 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Jul 06, 2021 at 02:51:06PM +0300, Anatoly Pugachev wrote:
> > > On Tue, Jul 6, 2021 at 12:11 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > Fixes: ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Peter Zijlstra <peterz@lists.infradead.org>
> > > > ---
> > > >  arch/sparc/include/asm/cmpxchg_64.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
> > > > index 8c39a9981187..12d00a42c0a3 100644
> > > > --- a/arch/sparc/include/asm/cmpxchg_64.h
> > > > +++ b/arch/sparc/include/asm/cmpxchg_64.h
> > > > @@ -201,7 +201,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
> > > >  #define arch_cmpxchg64_local(ptr, o, n)                                        \
> > > >    ({                                                                   \
> > > >         BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > > > -       cmpxchg_local((ptr), (o), (n));                                 \
> > > > +       arch_cmpxchg_local((ptr), (o), (n));                                    \
> > > >    })
> > > >  #define arch_cmpxchg64(ptr, o, n)      arch_cmpxchg64_local((ptr), (o), (n))
> > >
> > >
> > > Mark, thanks, fixed...
> > > tested on git kernel 5.13.0-11788-g79160a603bdb-dirty (dirty - cause
> > > patch has been applied).
> >
> > Great! Thanks for confirming.
> >
> > Peter, are you happy to pick that (full commit in last mail), or should
> > I send a new copy?
> 
> It would be nice if patch could hit the kernel before v5.14-rc1

Absolutely; I'll resend this on it's own so that it's easier for folk to
pick, and I'll poke people about picking it.

Mark.
