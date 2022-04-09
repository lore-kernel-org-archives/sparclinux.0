Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7FDC433F5
	for <sparclinux@archiver.kernel.org>; Sat,  9 Apr 2022 07:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiDIHt7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 9 Apr 2022 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiDIHt7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 9 Apr 2022 03:49:59 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Apr 2022 00:47:51 PDT
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D43F30462F
        for <sparclinux@vger.kernel.org>; Sat,  9 Apr 2022 00:47:49 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 360b3d46-b7d9-11ec-8da1-0050568c148b;
        Sat, 09 Apr 2022 07:46:48 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 0087E194B3E;
        Sat,  9 Apr 2022 09:46:46 +0200 (CEST)
Date:   Sat, 9 Apr 2022 09:46:40 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: cacheflush_32.h needs <linux/mm.h>
Message-ID: <YlE54Cs0mi0WDPo7@ravnborg.org>
References: <20220409060215.19890-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409060215.19890-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Randy,

On Fri, Apr 08, 2022 at 11:02:15PM -0700, Randy Dunlap wrote:
> Add <linux/mm.h> to cacheflush_32.h just as in cacheflush_64.h.

Just add a forward declaration like this to fix it:

struct page;

No need to pull in a header file when a forward is enough.

Maybe we could simplify sparc64 in a similar way, but that is another
patch and it may require extra work in other files anyway.

	Sam
