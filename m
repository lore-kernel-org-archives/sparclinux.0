Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D35C432BE
	for <sparclinux@archiver.kernel.org>; Tue,  3 Aug 2021 10:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C4560ED6
	for <sparclinux@archiver.kernel.org>; Tue,  3 Aug 2021 10:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhHCKLy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 06:11:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36080 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhHCKLw (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 3 Aug 2021 06:11:52 -0400
Received: from localhost (unknown [149.11.102.75])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 2E1124D9F6213;
        Tue,  3 Aug 2021 03:11:35 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:19:47 -0700 (PDT)
Message-Id: <20200820.171947.876981661045565142.davem@davemloft.net>
To:     viro@zeniv.linux.org.uk
Cc:     sparclinux@vger.kernel.org
Subject: Re: [sparc32] userland unaligned access
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200821000002.GI1236603@ZenIV.linux.org.uk>
References: <20200820233730.GH1236603@ZenIV.linux.org.uk>
        <20200820.164708.2016059081784711542.davem@davemloft.net>
        <20200821000002.GI1236603@ZenIV.linux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 03 Aug 2021 03:11:36 -0700 (PDT)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 21 Aug 2020 01:00:02 +0100

> On Thu, Aug 20, 2020 at 04:47:08PM -0700, David Miller wrote:
> 
>> > I don't have sunos toolchain to try and build such a binary and test it on
>> > a 2.2 kernel, but I would be rather surprised if that had been it.
>> > 
>> > Anyway, it really looks like that's dead code these days...
>> 
>> %100 it is dead code.
> 
> 	Could you check if you are OK with
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.sparc?

Looks good to me.
