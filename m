Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D69C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92F160FDA
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 11:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhINLlg (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:41:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52020 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhINLle (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Sep 2021 07:41:34 -0400
Received: from localhost (unknown [149.11.102.75])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 8CB914F6D9FC8;
        Tue, 14 Sep 2021 04:40:04 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:39:59 +0100 (BST)
Message-Id: <20210914.123959.2004307654918303528.davem@davemloft.net>
To:     hch@lst.de
Cc:     sam@ravnborg.org, andreas@gaisler.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210914061222.GA26679@lst.de>
References: <20210908074822.16793-1-andreas@gaisler.com>
        <YTjfJl6YmBCdZ8XB@ravnborg.org>
        <20210914061222.GA26679@lst.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 14 Sep 2021 04:40:05 -0700 (PDT)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 14 Sep 2021 08:12:22 +0200

> On Wed, Sep 08, 2021 at 06:04:54PM +0200, Sam Ravnborg wrote:
>> Hi Andreas,
>> 
>> On Wed, Sep 08, 2021 at 09:48:22AM +0200, Andreas Larsson wrote:
>> > Commit 53b7670e5735 ("sparc: factor the dma coherent mapping into
>> > helper") lost the page align for the calls to dma_make_coherent and
>> > srmmu_unmapiorange. The latter cannot handle a non page aligned len
>> > argument.
>> 
>> I wonder how you managed to track this down - well done.
>> > 
>> > Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>> 
>> I assume David or Christoph picks it up.
> 
> I'll happily pick it up if that is ok.  Dave?

Yep, it's ok.
