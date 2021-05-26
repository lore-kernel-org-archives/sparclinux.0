Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46257C47082
	for <sparclinux@archiver.kernel.org>; Wed, 26 May 2021 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B29613AB
	for <sparclinux@archiver.kernel.org>; Wed, 26 May 2021 18:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhEZSbP (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 26 May 2021 14:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbhEZSbO (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 26 May 2021 14:31:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96587613B0;
        Wed, 26 May 2021 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622053783;
        bh=wNW/3lbAzflM5LIUM/8IdAP6xp80z8iphq0uxRQwSx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgohjmzjSckj5W7Js4HNE69pssksZSmiDuhkIP4QiufTQsfepo7I7C7dl93QlT5hT
         kqOre2QXBBzp8owNkuu8p4zzekAjwDB2SE0qTKniFbFBBRLTCKO8rH2NM+7cIzto2p
         zdORHyHbnOLK5/UNT6FApK7dT+9QO1tLL/wq3VQ0Hpd16g1eUOV3H6epco21Hgndw0
         tPL/ywt8qRpXPFMjfYDODfZEz070EkdIEuXEvv724H580UOXSa8gf2/5DrYfaJNtgH
         GJwWc027uThnJQHjhJK/f+d5VODEh4Hbn/NlhRo1qV7Nw8dDlqpnn+5fOeebl6IIcx
         JaIXLHcmJHjcw==
Date:   Wed, 26 May 2021 19:29:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: Add compile-time asserts for siginfo_t offsets
Message-ID: <20210526182937.GA20055@willie-the-truck>
References: <20210429190734.624918-1-elver@google.com>
 <20210429190734.624918-3-elver@google.com>
 <20210526174217.GB19898@willie-the-truck>
 <CANpmjNOOW6-8su=VNipvb7ztQ0TdF9THn+yeWepz7D7BAL418Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOOW6-8su=VNipvb7ztQ0TdF9THn+yeWepz7D7BAL418Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, May 26, 2021 at 07:50:41PM +0200, Marco Elver wrote:
> On Wed, 26 May 2021 at 19:42, Will Deacon <will@kernel.org> wrote:
> > Hi Marco,
> >
> > On Thu, Apr 29, 2021 at 09:07:34PM +0200, Marco Elver wrote:
> > > To help catch ABI breaks at compile-time, add compile-time assertions to
> > > verify the siginfo_t layout.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
> > >  arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 72 insertions(+)
> >
> > Do you want me to queue this patch in the arm64 tree, or is the series all
> > going together via another route?
> 
> I think Eric will queue them together with a bunch of other cleanups,
> because as-is these patches are out-of-date as of:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e31f3a38e77612ed8967aaad28db6d3ee674b5

Ok, thanks. I will ignore this then :)

Will
