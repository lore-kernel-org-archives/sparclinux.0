Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04736C433F5
	for <sparclinux@archiver.kernel.org>; Thu,  9 Sep 2021 06:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FB660F93
	for <sparclinux@archiver.kernel.org>; Thu,  9 Sep 2021 06:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350945AbhIIGIY (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 9 Sep 2021 02:08:24 -0400
Received: from verein.lst.de ([213.95.11.211]:41357 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhIIGIY (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Thu, 9 Sep 2021 02:08:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 127A367373; Thu,  9 Sep 2021 08:07:13 +0200 (CEST)
Date:   Thu, 9 Sep 2021 08:07:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
Message-ID: <20210909060712.GA25485@lst.de>
References: <20210908074822.16793-1-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908074822.16793-1-andreas@gaisler.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Sep 08, 2021 at 09:48:22AM +0200, Andreas Larsson wrote:
> Commit 53b7670e5735 ("sparc: factor the dma coherent mapping into
> helper") lost the page align for the calls to dma_make_coherent and
> srmmu_unmapiorange. The latter cannot handle a non page aligned len
> argument.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Andreas - while I've got your attention:  I've been looking into fully
converting sparc32 to the generic DMA code.  Do you have any
documentation for the Leon cache handling in dma_make_coherent,
and more importantly how that applies to the dma coherent handling?
I could see how a flush might be required for the streaming DMA mappings,
that is mapping normal cached memory for I/O.  But for the coherent
allocations which can be accessed from the device and the cpu without
another DMA mapping call this seems really strange.
