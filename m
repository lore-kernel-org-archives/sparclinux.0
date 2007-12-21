From: David Miller <davem@davemloft.net>
Date: Fri, 21 Dec 2007 00:17:26 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071220.161726.68534356.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071220.045359.107684960.davem@davemloft.net>
	<20071220174540.GW19691@waste.org>
	<200712202047.56745.m.kozlowski@tuxland.pl>
In-Reply-To: <200712202047.56745.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: m.kozlowski@tuxland.pl
Cc: mpm@selenic.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Thu, 20 Dec 2007 20:47:55 +0100

> [  145.128915] TSTATE: 0000004411009603 TPC: 00000000005119ac TNPC: 00000000005119b0 Y: 00000000    Not tainted
> [  145.128940] TPC: <kpagecount_read+0x94/0xe0>

My suspicion at this point is that with certain RAM layouts, simply
iterating over PFN's is simply not working out.

pfn_to_page() seems to be doing no range checking, and with sparsemem
vmemmap, which sparc64 always uses, this can be problematic.

It just blindly goes "vmemmap + pfn" which is asking for trouble, in
particular when the physical RAM layout really is sparse.

Maybe it's enough to add a pfn_valid() check here?  If pfn_valid()
means there is a vmemmap translation setup for that page struct too,
it would work.
