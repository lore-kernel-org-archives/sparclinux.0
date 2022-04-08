Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C61C433EF
	for <sparclinux@archiver.kernel.org>; Fri,  8 Apr 2022 10:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiDHKaz (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiDHKaz (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 8 Apr 2022 06:30:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60C31A294;
        Fri,  8 Apr 2022 03:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECEB5B82A1E;
        Fri,  8 Apr 2022 10:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00713C385A3;
        Fri,  8 Apr 2022 10:28:47 +0000 (UTC)
Date:   Fri, 8 Apr 2022 11:28:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/7] mm/mmap: Drop arch_filter_pgprot()
Message-ID: <YlAOXG9XbQW1xPaT@arm.com>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
 <20220407103251.1209606-7-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407103251.1209606-7-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Apr 07, 2022 at 04:02:50PM +0530, Anshuman Khandual wrote:
> There are no platforms left which subscribe ARCH_HAS_FILTER_PGPROT. Hence
> drop generic arch_filter_pgprot() and also config ARCH_HAS_FILTER_PGPROT.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
