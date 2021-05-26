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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1F9C47082
	for <sparclinux@archiver.kernel.org>; Wed, 26 May 2021 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBAC6139A
	for <sparclinux@archiver.kernel.org>; Wed, 26 May 2021 17:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhEZRw1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 26 May 2021 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEZRw0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 26 May 2021 13:52:26 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63288C061574
        for <sparclinux@vger.kernel.org>; Wed, 26 May 2021 10:50:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id z3so2331731oib.5
        for <sparclinux@vger.kernel.org>; Wed, 26 May 2021 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/c57EaMZe63RxWJqN2eTbUojjqf7amOpyeK+rzirKyA=;
        b=NqTeQ4OktpJUauRiGh3Gmw3ee3au0KwtbKalcc2n/ZPWIK9JWYadoVUGNABW0sZRbK
         KEniJtapBu+rUGURe6kstQzd6GNJYP3TELrRV+JptSxiQ+v3DDjZAl1leSY+PMPZZ8TX
         47Cd1RQ4xO9Q8Y/gnu/WfjaDj0nVw/LEB29C+T4YYwtPPpnjpjae40LS8mzYhtaJ3Go8
         kaTvLGqsOr6mMg7SEbSt6RcVmJ+Cr3DBDBYUhDLgRv9XqUYzidGzJ/UZ6SGoyYqRe4+/
         VPzVjAPyPadVtc6TVwU8tsPnP2ALWdnNKkf3XiShKx0KJpN3c5ueir67CyTkj3sPZCGy
         uwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/c57EaMZe63RxWJqN2eTbUojjqf7amOpyeK+rzirKyA=;
        b=MKqlBvlBFJYeAsZyJqBPutijiJDSqLy+Hu7/zr4hTjU2kfyDte00A6um/xgYuX97XR
         nPqae2gf2iLEAnktvPKCP2tV+fmd+Ecy0F83tmuVo1DQKvSbKl0ytptVKHdcB6kNOziR
         71ZdADfsJqC3bd2ChtmhZqwUYSXGQE0x0BB5YPcak6Kwx76D45jqZQS7+HNabBn+uI7N
         bGremv1iCGSrprJ4XkJSCHaWkQW/KXj1WD+dAHMqL2bYY1cD8HLkpb7OFjKAadSwSGaj
         WuG3Lro69OR7jCKwRc3KnxH8gqPIK2IHAymdYdnDYO5ytR4cBPXyYbKhKB7ci7Xuqnha
         j27A==
X-Gm-Message-State: AOAM530tWoFd+twfife+fduIA0mrsIsj1DblzhD/SRYXTMLRF3hZ/XUn
        UlP9URCWIvnh2CQDMCs5vkv/acbDQ9t29P1PFFhCeO0hvJD9PA==
X-Google-Smtp-Source: ABdhPJzGo+pDWJGs5vYRHDuQIaA+tpNsfp+SmxEWvGcJc+7FFirv7FUDc1yvV+EgBjBVpEB9HFNw3StzZlJcs5UdaUI=
X-Received: by 2002:a05:6808:f94:: with SMTP id o20mr2735598oiw.121.1622051453632;
 Wed, 26 May 2021 10:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190734.624918-1-elver@google.com> <20210429190734.624918-3-elver@google.com>
 <20210526174217.GB19898@willie-the-truck>
In-Reply-To: <20210526174217.GB19898@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 May 2021 19:50:41 +0200
Message-ID: <CANpmjNOOW6-8su=VNipvb7ztQ0TdF9THn+yeWepz7D7BAL418Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: Add compile-time asserts for siginfo_t offsets
To:     Will Deacon <will@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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

On Wed, 26 May 2021 at 19:42, Will Deacon <will@kernel.org> wrote:
> Hi Marco,
>
> On Thu, Apr 29, 2021 at 09:07:34PM +0200, Marco Elver wrote:
> > To help catch ABI breaks at compile-time, add compile-time assertions to
> > verify the siginfo_t layout.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+)
>
> Do you want me to queue this patch in the arm64 tree, or is the series all
> going together via another route?

I think Eric will queue them together with a bunch of other cleanups,
because as-is these patches are out-of-date as of:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e31f3a38e77612ed8967aaad28db6d3ee674b5

Thanks,
-- Marco
