From: David Miller <davem@davemloft.net>
Date: Sun, 08 Feb 2009 03:09:15 +0000
Subject: Re: SBus HME startup failure
Message-Id: <20090207.190915.255375865.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Brower <ebrower@gmail.com>
Date: Sat, 7 Feb 2009 16:15:44 -0800

> I wasn't confident enough that the direct parent of a non-QFE HME
> would always be an "sbus" node, though it certainly seems like a valid
> assumption.

It's actually possible for it not to be there.

For example, via XBOX sbus expansion boards, which would add another
level of bus hierarchy.  We don't support those expander devices
currently but...

So the thing to do is to add a "of_find_parent_by_name()" interface
and use that in these kinds of situations.

I'll work on that when I get a chance.
