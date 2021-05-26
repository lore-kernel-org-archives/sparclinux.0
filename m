Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0774C47088
	for <sparclinux@archiver.kernel.org>; Wed, 26 May 2021 17:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA01613D2
	for <sparclinux@archiver.kernel.org>; Wed, 26 May 2021 17:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhEZRn6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 26 May 2021 13:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232702AbhEZRn5 (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 26 May 2021 13:43:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B13613CD;
        Wed, 26 May 2021 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622050942;
        bh=KZeocktmgw9QVG8vyb716qfSwqi5jI0UlqP4AlCaRro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUoaNCQLK626L7kmjIUbSuxe8FOu+X533J+WsCIGIx9iyEbdAjD3ty7TmkWI9WNBN
         8BL0wkvwKQKzlsM6UOv4v302fu8p1IcHamtwxwqT4v1ZH6UX0DSvTLVqto5nBoOLZN
         W6aLHYewmF4XlEQYQwY2FS3MmABTW1dDmgcmkh5CMB7dg9J/izPRm5T17v53OSU01R
         q81KvONycD+suTo9dY3mufa/o3p9wtQyvKjIeBG+cJ03tYuowU2vIm/+zrWYuzXiio
         YRMdyQMoV1VKFrtvsDQa7mKZxScxfHAJTK9pt2EGalUthcY/qn686Nxfqvvg/zhW16
         neTLaKisUGwhg==
Date:   Wed, 26 May 2021 18:42:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     ebiederm@xmission.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, davem@davemloft.net, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: Add compile-time asserts for siginfo_t offsets
Message-ID: <20210526174217.GB19898@willie-the-truck>
References: <20210429190734.624918-1-elver@google.com>
 <20210429190734.624918-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429190734.624918-3-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Marco,

On Thu, Apr 29, 2021 at 09:07:34PM +0200, Marco Elver wrote:
> To help catch ABI breaks at compile-time, add compile-time assertions to
> verify the siginfo_t layout.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)

Do you want me to queue this patch in the arm64 tree, or is the series all
going together via another route?

Thanks,

Will
