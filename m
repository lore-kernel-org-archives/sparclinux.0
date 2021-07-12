Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D6BC07E99
	for <sparclinux@archiver.kernel.org>; Mon, 12 Jul 2021 10:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDA46100C
	for <sparclinux@archiver.kernel.org>; Mon, 12 Jul 2021 10:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhGLKll (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 06:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhGLKlk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 12 Jul 2021 06:41:40 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A9C0613E5
        for <sparclinux@vger.kernel.org>; Mon, 12 Jul 2021 03:38:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id p12-20020a05683019ccb02904b7e9d93563so6322900otp.13
        for <sparclinux@vger.kernel.org>; Mon, 12 Jul 2021 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Abpkrmbi7hM6v18oMOHQaKzwxHKtd7V69lS8CcVKxk=;
        b=hkLnZ+MPLYfwtzuVihIRqHJWlhF88H7TrpHAe9DNC1bRPlV9FsOrn5x15A3sx5F/UT
         9P6CtDdi1xDlX0T9xo87ri+bvrW/gv/OiUzZCz+E+rdMKJlnTCnYIookcoyzHrzLYOSN
         AVW/wnIxALKLy0YnIXl1swwbrFMysQ/7mlNZzJrBq0uwqLHn2Z8JRQAFcLITBYco3dMd
         rHMIyxJC3VkjUEfrO3YYlgONpFOl42RMvRzNrdC9JQwmMu+18UiEmRmnw7iqn6gsn8Ff
         1tu2h/gJ7TyRlDH4ITsA3O/B7YzJg4UpeHcZxcl7uCZLxtCoaEEYQs1b4uo+mjOViPSz
         /MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Abpkrmbi7hM6v18oMOHQaKzwxHKtd7V69lS8CcVKxk=;
        b=DSxXwDRKGn8vnlttuMV8o2jpl3gC7888HA4yEGs9ID1gQiVfn60CPxAe984/AYQvQL
         K2p6IwWpR1pCDWh1McENBrDX7ikzJj90qBW3//yvLxuKaFGfR4EW6gE0TnE711haaRfQ
         datf8wuSLa6/Hi6BqV5BS9t8cZG/nVO1779Dz9BuCcm+Xe/gm1+Zq6QtFKfmmzbtPGHg
         SgmBnwuTQC8Zgd4FWF5f8yqSe6BV6xaueaz63pD8FPpaNsfh8bxIuNKCxKsgvtUFBZuM
         /rIO5YoEb9afaDEr04gB3hGXpjzuS6HfES5N1zkZWdI6oebksPCOikLTD9kHnSc8VDYr
         QuQQ==
X-Gm-Message-State: AOAM530tmGM6phnep+fQEdDsBG0jD4TlfqdYBugk6hOxhg7Q3b1HX9WM
        qfJwZrPqhMlmXNRYFpYVxs8vlfJXibNfnkevm4yVhA==
X-Google-Smtp-Source: ABdhPJzwqcdegrxmwogsl63GhPad+XspOkXNK1DJOlDJqP68fy3nXb8QhuLEr/J6GvNpa7CuHniwTnMsgznbLI4sr2o=
X-Received: by 2002:a05:6830:905:: with SMTP id v5mr8700538ott.17.1626086331832;
 Mon, 12 Jul 2021 03:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190734.624918-1-elver@google.com> <20210429190734.624918-3-elver@google.com>
 <20210526174217.GB19898@willie-the-truck> <CANpmjNOOW6-8su=VNipvb7ztQ0TdF9THn+yeWepz7D7BAL418Q@mail.gmail.com>
 <20210526182937.GA20055@willie-the-truck> <CANpmjNN6D7MQJN5oDuLzmG3wxuFvc-ORBoHPLPhWo+f6cOH2cA@mail.gmail.com>
In-Reply-To: <CANpmjNN6D7MQJN5oDuLzmG3wxuFvc-ORBoHPLPhWo+f6cOH2cA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Jul 2021 12:38:40 +0200
Message-ID: <CANpmjNNR8iAzrUT56tNP=Vp9F=97J2-5idtPrindciVTojt5Aw@mail.gmail.com>
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

On Fri, 2 Jul 2021 at 10:51, Marco Elver <elver@google.com> wrote:
> On Wed, 26 May 2021 at 20:29, Will Deacon <will@kernel.org> wrote:
> > On Wed, May 26, 2021 at 07:50:41PM +0200, Marco Elver wrote:
> > > On Wed, 26 May 2021 at 19:42, Will Deacon <will@kernel.org> wrote:
> > > > Hi Marco,
> > > >
> > > > On Thu, Apr 29, 2021 at 09:07:34PM +0200, Marco Elver wrote:
> > > > > To help catch ABI breaks at compile-time, add compile-time assertions to
> > > > > verify the siginfo_t layout.
> > > > >
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > ---
> > > > >  arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
> > > > >  arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 72 insertions(+)
> > > >
> > > > Do you want me to queue this patch in the arm64 tree, or is the series all
> > > > going together via another route?
> > >
> > > I think Eric will queue them together with a bunch of other cleanups,
> > > because as-is these patches are out-of-date as of:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e31f3a38e77612ed8967aaad28db6d3ee674b5
> >
> > Ok, thanks. I will ignore this then :)
>
> Eric, are these static_assert patches being sent this merge-window
> along with the other cleanups?

I'm happy to send out a rebased version of this series only. I'll go
ahead and do that later in the week if I don't hear objections.

Thanks,
-- Marco
