Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE07C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 06:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1845160F36
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 06:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhINGNl (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 02:13:41 -0400
Received: from verein.lst.de ([213.95.11.211]:58595 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237875AbhINGNl (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 14 Sep 2021 02:13:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 751A167357; Tue, 14 Sep 2021 08:12:22 +0200 (CEST)
Date:   Tue, 14 Sep 2021 08:12:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Andreas Larsson <andreas@gaisler.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        software@gaisler.com
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
Message-ID: <20210914061222.GA26679@lst.de>
References: <20210908074822.16793-1-andreas@gaisler.com> <YTjfJl6YmBCdZ8XB@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTjfJl6YmBCdZ8XB@ravnborg.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Sep 08, 2021 at 06:04:54PM +0200, Sam Ravnborg wrote:
> Hi Andreas,
> 
> On Wed, Sep 08, 2021 at 09:48:22AM +0200, Andreas Larsson wrote:
> > Commit 53b7670e5735 ("sparc: factor the dma coherent mapping into
> > helper") lost the page align for the calls to dma_make_coherent and
> > srmmu_unmapiorange. The latter cannot handle a non page aligned len
> > argument.
> 
> I wonder how you managed to track this down - well done.
> > 
> > Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I assume David or Christoph picks it up.

I'll happily pick it up if that is ok.  Dave?
