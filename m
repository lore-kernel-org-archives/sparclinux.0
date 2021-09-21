Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC312C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 21 Sep 2021 07:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B41561156
	for <sparclinux@archiver.kernel.org>; Tue, 21 Sep 2021 07:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhIUHnX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:43:23 -0400
Received: from verein.lst.de ([213.95.11.211]:55373 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhIUHnX (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 21 Sep 2021 03:43:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50DBA67373; Tue, 21 Sep 2021 09:41:52 +0200 (CEST)
Date:   Tue, 21 Sep 2021 09:41:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/2] sparc32: remove dma_make_coherent
Message-ID: <20210921074151.GA26525@lst.de>
References: <20210920113108.1299996-1-hch@lst.de> <20210920113108.1299996-2-hch@lst.de> <YUixtMGPMLWvv8S9@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUixtMGPMLWvv8S9@ravnborg.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Sep 20, 2021 at 06:07:16PM +0200, Sam Ravnborg wrote:
> On Mon, Sep 20, 2021 at 01:31:07PM +0200, Christoph Hellwig wrote:
> > LEON only needs snooping when DMA accesses are not seen on the processor
> > bus.  Given that coherent allocations are mapped uncached this can't
> > happen for those, so open code the d-cache flushing logic in the only
> > remaing place that needs it, arch_sync_dma_for_cpu.

> I do not see this change explicitly explained in the changelog.
> Is this not one of the "only remaining place that needs it"?

Yes.  Two callers, one needs it, one doesn't.

> Would be nice to see it explicitly mentioned.

Ok.  I'll respin with a more detailed commit log.
