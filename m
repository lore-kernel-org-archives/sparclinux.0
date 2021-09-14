Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E729C433F5
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E33F61139
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 10:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhINKoR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:44:17 -0400
Received: from verein.lst.de ([213.95.11.211]:59690 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhINKoQ (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 14 Sep 2021 06:44:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A8D3E67373; Tue, 14 Sep 2021 12:42:56 +0200 (CEST)
Date:   Tue, 14 Sep 2021 12:42:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
Message-ID: <20210914104256.GA14645@lst.de>
References: <20210908074822.16793-1-andreas@gaisler.com> <20210909060712.GA25485@lst.de> <3a653ab5-14d2-f61f-cb0a-cbeba93b4ac8@gaisler.com> <20210914061705.GB26679@lst.de> <87971ad4-9519-cf0d-76a8-6baa253d0122@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87971ad4-9519-cf0d-76a8-6baa253d0122@gaisler.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 14, 2021 at 10:51:51AM +0200, Andreas Larsson wrote:
> On 2021-09-14 08:17, Christoph Hellwig wrote:
>> Thanks.  Can you take a look and test the two patches below on top of
>> your fix?  A git tree is also available here:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sparc32-generic-dma
>>
>
> In a quick test, this seems to work on LEON for code paths previously going 
> to arch_dma_alloc and arch_dma_free. However, this makes setting up these 
> DMA mappings to not go through sparc_dma_alloc_resource, and it seems 
> important that they do that on Sun systems. Hopefully, someone with more 
> knowledge about that could chime in here.

Does the hardware actually care about it?  The only thing it does is
to force allocating from a specific virtual address range, but how
would that have a special meaning?

> The added pgprot_dmacoherent is problematic as it sets SRMMU_PRIV, which 
> sets up kernel access only. This was fine for arch_dma_alloc that sets up 
> kernel accesses only, but for user space DMA mmap this would make them 
> kernel accessable only. Having no sparc-specific pgprot_dmacoherent, 
> keeping it to default to pgprot_noncached, is probably better.

I've just tried to keep the existing attributes.  If SRMMU_PRIV does
indeed mean that the page can't also be mapped into userspace page tables
it would be good to remove it in an incremental patch.  If OTOH it only
means that this PTE is a kernel mapping it should not affect a userspace
mapping as that will always use separate PTEs.

>
> -- 
> Andreas Larsson
---end quoted text---
