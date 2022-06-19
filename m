Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8E7C433EF
	for <sparclinux@archiver.kernel.org>; Sun, 19 Jun 2022 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiFSKme (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 19 Jun 2022 06:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiFSKmc (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 19 Jun 2022 06:42:32 -0400
Received: from relay05.pair.com (relay05.pair.com [216.92.24.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6A10546;
        Sun, 19 Jun 2022 03:42:31 -0700 (PDT)
Received: from orac.inputplus.co.uk (unknown [84.51.159.244])
        by relay05.pair.com (Postfix) with ESMTP id D388F1A1987;
        Sun, 19 Jun 2022 06:42:29 -0400 (EDT)
Received: from orac.inputplus.co.uk (orac.inputplus.co.uk [IPv6:::1])
        by orac.inputplus.co.uk (Postfix) with ESMTP id A9789201F7;
        Sun, 19 Jun 2022 11:42:28 +0100 (BST)
To:     Matthew Wilcox <willy@infradead.org>
cc:     Nate Karstens <nate.karstens@garmin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Laight <David.Laight@aculab.com>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH v2] Implement close-on-fork
From:   Ralph Corderoy <ralph@inputplus.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
In-reply-to: <Yq4qIxh5QnhQZ0SJ@casper.infradead.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com> <20220618114111.61EC71F981@orac.inputplus.co.uk> <Yq4qIxh5QnhQZ0SJ@casper.infradead.org>
Date:   Sun, 19 Jun 2022 11:42:28 +0100
Message-Id: <20220619104228.A9789201F7@orac.inputplus.co.uk>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Matthew, thanks for replying.

> > The need for O_CLOFORK might be made more clear by looking at a
> > long-standing Go issue, i.e. unrelated to system(3), which was started
> > in 2017 by Russ Cox when he summed up the current race-condition
> > behaviour of trying to execve(2) a newly created file:
> > https://github.com/golang/go/issues/22315.
>
> The problem is that people advocating for O_CLOFORK understand its
> value, but not its cost.  Other google employees have a system which
> has literally millions of file descriptors in a single process.
> Having to maintain this extra state per-fd is a cost they don't want
> to pay (and have been quite vocal about earlier in this thread).

So do you agree the userspace issue is best solved by *_CLOFORK and the
problem is how to implement *_CLOFORK at an acceptable cost?

OTOH David Laight was making suggestions on moving the load to the
fork/exec path earlier in the thread, but OTOH Al Viro mentioned a
‘portable solution’, though that could have been to a specific issue
rather than the more general case.

How would you recommend approaching an acceptable cost is progressed?
Iterate on patch versions?  Open a bugzilla.kernel.org for central
tracking and linking from the other projects?  ..?

-- 
Cheers, Ralph.
