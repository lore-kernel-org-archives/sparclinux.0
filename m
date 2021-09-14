Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362FCC433F5
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 08:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F65361108
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 08:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhINIxO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 04:53:14 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:12714 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231235AbhINIxL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Tue, 14 Sep 2021 04:53:11 -0400
X-Halon-ID: 00cded83-1539-11ec-ac84-005056917a89
Authorized-sender: andreas@gaisler.com
Received: from [192.168.10.42] (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 00cded83-1539-11ec-ac84-005056917a89;
        Tue, 14 Sep 2021 10:51:52 +0200 (CEST)
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
References: <20210908074822.16793-1-andreas@gaisler.com>
 <20210909060712.GA25485@lst.de>
 <3a653ab5-14d2-f61f-cb0a-cbeba93b4ac8@gaisler.com>
 <20210914061705.GB26679@lst.de>
From:   Andreas Larsson <andreas@gaisler.com>
Message-ID: <87971ad4-9519-cf0d-76a8-6baa253d0122@gaisler.com>
Date:   Tue, 14 Sep 2021 10:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914061705.GB26679@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 2021-09-14 08:17, Christoph Hellwig wrote:
> Thanks.  Can you take a look and test the two patches below on top of
> your fix?  A git tree is also available here:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sparc32-generic-dma
> 

In a quick test, this seems to work on LEON for code paths previously 
going to arch_dma_alloc and arch_dma_free. However, this makes setting 
up these DMA mappings to not go through sparc_dma_alloc_resource, and it 
seems important that they do that on Sun systems. Hopefully, someone 
with more knowledge about that could chime in here.

The added pgprot_dmacoherent is problematic as it sets SRMMU_PRIV, which 
sets up kernel access only. This was fine for arch_dma_alloc that sets 
up kernel accesses only, but for user space DMA mmap this would make 
them kernel accessable only. Having no sparc-specific 
pgprot_dmacoherent, keeping it to default to pgprot_noncached, is 
probably better.

-- 
Andreas Larsson
