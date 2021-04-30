Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47914C433ED
	for <sparclinux@archiver.kernel.org>; Fri, 30 Apr 2021 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA3A6147F
	for <sparclinux@archiver.kernel.org>; Fri, 30 Apr 2021 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhD3WXx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 18:23:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54024 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhD3WXx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Apr 2021 18:23:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 5D5F24F7E7593;
        Fri, 30 Apr 2021 15:23:02 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:22:58 -0700 (PDT)
Message-Id: <20210430.152258.729887124786441756.davem@davemloft.net>
To:     elver@google.com
Cc:     ebiederm@xmission.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/3] sparc64: Add compile-time asserts for siginfo_t
 offsets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210429190734.624918-1-elver@google.com>
References: <20210429190734.624918-1-elver@google.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 30 Apr 2021 15:23:02 -0700 (PDT)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Marco Elver <elver@google.com>
Date: Thu, 29 Apr 2021 21:07:32 +0200

> To help catch ABI breaks at compile-time, add compile-time assertions to
> verify the siginfo_t layout. Unlike other architectures, sparc64 is
> special, because it is one of few architectures requiring si_trapno.
> ABI breaks around that field would only be caught here.
> 
> Link: https://lkml.kernel.org/r/m11rat9f85.fsf@fess.ebiederm.org
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
