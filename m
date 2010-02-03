From: David Miller <davem@davemloft.net>
Date: Wed, 03 Feb 2010 16:44:49 +0000
Subject: Re: SILO problems
Message-Id: <20100203.084449.123293189.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 1 Feb 2010 21:30:40 +0000

> While preparing an update for Debian's SILO package, I ran into a 
> problem: the version built from the current git tree [0] fails to boot 
> on my SunBlade 1000 box with the following messages:

Thanks for reporting these issues Jurij, I'll look into
either fixing or reverting that buggy change and also
integrating your build fix patch.

Thanks again!
