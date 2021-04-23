Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AADC433B4
	for <sparclinux@archiver.kernel.org>; Fri, 23 Apr 2021 20:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E75D61001
	for <sparclinux@archiver.kernel.org>; Fri, 23 Apr 2021 20:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDWUdj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:33:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59056 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWUdh (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 23 Apr 2021 16:33:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 8E61D4D25A19E;
        Fri, 23 Apr 2021 13:33:00 -0700 (PDT)
Date:   Fri, 23 Apr 2021 13:33:00 -0700 (PDT)
Message-Id: <20210423.133300.1671385649231876076.davem@davemloft.net>
To:     shreya.ajithchb@gmail.com
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH]sbus:char:bbc_i2c:Replaced header file asm/io.h with
 linux/io.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210423065558.d5gy3zpxus6gsyc2@shreya-VirtualBox>
References: <20210423065558.d5gy3zpxus6gsyc2@shreya-VirtualBox>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 23 Apr 2021 13:33:00 -0700 (PDT)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Shreya Ajith <shreya.ajithchb@gmail.com>
Date: Fri, 23 Apr 2021 12:25:58 +0530

> Replaced header file asm/io.h with linux/io.h
> 
> Signed-off-by:Shreya Ajith <shreya.ajithchb@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
