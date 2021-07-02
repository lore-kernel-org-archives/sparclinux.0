Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86966C11F68
	for <sparclinux@archiver.kernel.org>; Fri,  2 Jul 2021 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C58F6141E
	for <sparclinux@archiver.kernel.org>; Fri,  2 Jul 2021 08:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhGBIxx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 2 Jul 2021 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhGBIxx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 2 Jul 2021 04:53:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CADC061764
        for <sparclinux@vger.kernel.org>; Fri,  2 Jul 2021 01:51:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so10490517oig.12
        for <sparclinux@vger.kernel.org>; Fri, 02 Jul 2021 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbPxvu3NmB2z0+Y/UKqhW4DpRcr/7LUWF7NaploBKiY=;
        b=g25azOrQxK05y8GRoMOZ+brcEx47mkcPMDJpvFXSyPuG3DFIItFa0fY3sE+mixpaVM
         ws+joTgnwsvcrFjC6noqzghYqyjApLTZf3/GR8fpmhPRBepsgZlXCGzzTzpiQL8gPjXe
         fnMwrTok4oukOf/UFv6IpM2uO5IJ3hn1t5IK+TQTyMLXEJzjnxjh6Sl9jPj5Bjj7glXm
         YGGskCsDUjCqolu/ZsbHGqSQPW43Wv+9O2Ui00PyBlyUwGkGEW1hSlIliznPfxEcWbT2
         WxNonKgDlH2gwU7OekOq+F8AXT2NvkSnK0AggHowz4Y/P1Z/E1HvUOauPgrjYC6kBDno
         DW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbPxvu3NmB2z0+Y/UKqhW4DpRcr/7LUWF7NaploBKiY=;
        b=ivjz3H7ZaQN29rPY71XeVZ0g2E0cpNrajpbaWRkgN4FKOP79rNjoaOQnjLVgPZyS9d
         VYQautoOqaUBt2QGY6caN0oBn8O94igF0cN0aCImzo7zmNAuXVrUvg1KapvSMoSgK2gM
         z+lUr9lPGbCLwU0Xh0NV3bGHvJw2y5ET6qScwqlTGepcY90WSHQlJeKrffNMm9oIW85e
         I8OUc1NmN5bPQ06DuGJ1lUUCXJPcKxXyQ7ZUn0abvhk4rrbZ3dTYhAmmkyCNqn8ZscR1
         MGwFyitnbQEffg9JXg8Oo+a5cPGHZ1rSsL+wuJU2NaDyoyhxPU9LM2gpKSEowcu+ARSc
         tn3g==
X-Gm-Message-State: AOAM532KBqSVWqFPHRr4R+NEKKjxr6guiStsPw6xQw7sJKyTWodtNwlX
        ST90QuRkODZlTLsM3SEV9b9moeoJyEF4mFKJCXX9Tg==
X-Google-Smtp-Source: ABdhPJympXWi8Ppuk567NBcohD0mgz01KaWIVKIBQyPdKE6YubE7I55ijr5HkmI+QxdfkyM3G3QCDTahgXwb8SBr2eM=
X-Received: by 2002:a05:6808:7c8:: with SMTP id f8mr3011976oij.121.1625215880431;
 Fri, 02 Jul 2021 01:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190734.624918-1-elver@google.com> <20210429190734.624918-3-elver@google.com>
 <20210526174217.GB19898@willie-the-truck> <CANpmjNOOW6-8su=VNipvb7ztQ0TdF9THn+yeWepz7D7BAL418Q@mail.gmail.com>
 <20210526182937.GA20055@willie-the-truck>
In-Reply-To: <20210526182937.GA20055@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Fri, 2 Jul 2021 10:51:08 +0200
Message-ID: <CANpmjNN6D7MQJN5oDuLzmG3wxuFvc-ORBoHPLPhWo+f6cOH2cA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: Add compile-time asserts for siginfo_t offsets
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, 26 May 2021 at 20:29, Will Deacon <will@kernel.org> wrote:
> On Wed, May 26, 2021 at 07:50:41PM +0200, Marco Elver wrote:
> > On Wed, 26 May 2021 at 19:42, Will Deacon <will@kernel.org> wrote:
> > > Hi Marco,
> > >
> > > On Thu, Apr 29, 2021 at 09:07:34PM +0200, Marco Elver wrote:
> > > > To help catch ABI breaks at compile-time, add compile-time assertions to
> > > > verify the siginfo_t layout.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > >  arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
> > > >  arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 72 insertions(+)
> > >
> > > Do you want me to queue this patch in the arm64 tree, or is the series all
> > > going together via another route?
> >
> > I think Eric will queue them together with a bunch of other cleanups,
> > because as-is these patches are out-of-date as of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e31f3a38e77612ed8967aaad28db6d3ee674b5
>
> Ok, thanks. I will ignore this then :)

Eric, are these static_assert patches being sent this merge-window
along with the other cleanups?

Thanks,
-- Marco
