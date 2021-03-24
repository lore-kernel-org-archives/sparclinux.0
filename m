Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90815C433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 23:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6A561A17
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 23:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhCXXcw (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbhCXXcv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 Mar 2021 19:32:51 -0400
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1ABC06174A
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 16:32:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 5D1074D248D95;
        Wed, 24 Mar 2021 16:32:48 -0700 (PDT)
Date:   Wed, 24 Mar 2021 16:32:44 -0700 (PDT)
Message-Id: <20210324.163244.1041346292889410246.davem@davemloft.net>
To:     npiggin@gmail.com
Cc:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, sfr@canb.auug.org.au
Subject: Re: [PATCH] sparc32: add stub pud_page define for walking huge
 vmalloc page tables
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210324232825.1157363-1-npiggin@gmail.com>
References: <20210324232825.1157363-1-npiggin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 24 Mar 2021 16:32:48 -0700 (PDT)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 25 Mar 2021 09:28:25 +1000

> Similarly to the stub p4d_page in sparc64, add a stub pud_page, this
> is needed for hugepages in the vmap page tables to be walked without
> ifdefs, which should be no functional change for sparc32.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
