Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D0BC4338F
	for <sparclinux@archiver.kernel.org>; Tue,  3 Aug 2021 10:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC5B60EEA
	for <sparclinux@archiver.kernel.org>; Tue,  3 Aug 2021 10:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhHCKLy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 06:11:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36086 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhHCKLx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 3 Aug 2021 06:11:53 -0400
Received: from localhost (unknown [149.11.102.75])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 64D914D9F3B59;
        Tue,  3 Aug 2021 03:11:40 -0700 (PDT)
Date:   Fri, 26 Feb 2021 16:17:00 -0800 (PST)
Message-Id: <20210226.161700.1422834673410239971.davem@davemloft.net>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [git pull] work.sparc32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <YDbaYnzBVf604ns3@zeniv-ca.linux.org.uk>
References: <YDbaYnzBVf604ns3@zeniv-ca.linux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 03 Aug 2021 03:11:42 -0700 (PDT)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 24 Feb 2021 22:59:46 +0000

> 	Switching sparc32 to generic extables.  A bunch of magic goes away,
> along with ARCH_HAS_SEARCH_EXTABLE.  Sat in -next for a couple of cycles
> by now...
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sparc32

Pulled, thanks.
