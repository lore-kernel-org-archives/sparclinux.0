From: David Miller <davem@davemloft.net>
Date: Mon, 13 Aug 2007 02:03:40 +0000
Subject: Re: Sun4c interrupt controller - Sun4d relevance
Message-Id: <20070812.190340.25157187.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46BF2A25.9090900@netunix.com>
In-Reply-To: <46BF2A25.9090900@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sun, 12 Aug 2007 15:27:24 -0400

> I hate to be a bother here, but aren't there some legal concerns with
> looking at Solaris source code, then implementing code in Linux?
> 
> Even on OpenSolaris, there is a grey area as to whether one can legally
> view CDDL licensed code, then reimplement it as GPL (CDDL is
> GPL-Incompatible) for Linux... but on old Solaris, that code should be
> proprietary, unless Sun opened it when I wasn't looking.
> 
> Mark, can you legally be doing this? 

Tom is absolutely right, the situation is questionable at best,
so we have to take the safe course of action and now not accept
contributions from those who have gone so far as to publicly
state that they've read the Solaris code and thus are tainted.

It's unfortunate, but really there is no other reasonable course
of action at this point, sorry :-/
