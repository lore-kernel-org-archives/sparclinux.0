From: David Miller <davem@davemloft.net>
Date: Thu, 05 Feb 2009 10:14:29 +0000
Subject: Re: HOLES_IN_ZONE...
Message-Id: <20090205.021429.170975463.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090204.222651.26527737.davem@davemloft.net>
	<20090205101023.GD26878@csn.ul.ie>
In-Reply-To: <20090205101023.GD26878@csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mel@csn.ul.ie
Cc: kamezawa.hiroyu@jp.fujitsu.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mel Gorman <mel@csn.ul.ie>
Date: Thu, 5 Feb 2009 10:10:23 +0000

> On Wed, Feb 04, 2009 at 10:26:51PM -0800, David Miller wrote:
> > As a suggestion, it would have been a lot more pleasant if the code
> > validated this requirement (in the !HOLES_IN_ZONE case) at boot time
> > instead of after 2 hours of stress testing :-(
> > 
> 
> Nice maybe, but we'd take a hit on pfn_valid_within() which goes from
> being compiled-away on architectures that don't need it to being
> a read of a shared cacheline and a branch.

I said at boot time Mel, not in the fast paths.  Meaning, we'd
check it after all the available ranges get registered and
tossed into the free page lists.

Anyways, it appears we have a fix already, read the rest of
the thread.
