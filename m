Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278AEC433F5
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B52C60F93
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhITLgG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:36:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52190 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhITLgG (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Sep 2021 07:36:06 -0400
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id A8FF54D2D5526;
        Mon, 20 Sep 2021 04:34:37 -0700 (PDT)
Date:   Mon, 20 Sep 2021 12:34:32 +0100 (BST)
Message-Id: <20210920.123432.51038656274894609.davem@davemloft.net>
To:     hch@lst.de
Cc:     andreas@gaisler.com, sparclinux@vger.kernel.org
Subject: Re: use the generic DMA remap allocator for sparc32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210920113108.1299996-1-hch@lst.de>
References: <20210920113108.1299996-1-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Mon, 20 Sep 2021 04:34:38 -0700 (PDT)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 Sep 2021 13:31:06 +0200

> Hi Dave,
> 
> this series switches sparc32 to use the generic dma remap allocator
> instead of its own version.

For series:

Acked-by: David S. Miller <davem@davemloft.net>
