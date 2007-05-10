From: David Miller <davem@davemloft.net>
Date: Thu, 10 May 2007 07:12:34 +0000
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
Message-Id: <20070510.001234.126579706.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0705012354290.12808@mtfhpc.demon.co.uk>
	<20070509231937.ea254c26.akpm@linux-foundation.org>
	<1178778583.14928.210.camel@localhost.localdomain>
In-Reply-To: <1178778583.14928.210.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: akpm@linux-foundation.org, mark@mtfhpc.demon.co.uk, linuxppc-dev@ozlabs.org, wli@holomorphy.com, linux-mm@kvack.org, andrea@suse.de, sparclinux@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 May 2007 16:29:43 +1000

> 
> > We never seemed to reach completion here?
> 
> Well, I'm waiting for other people comments too... as I said earlier,
> I'm not too fan of burrying the update_mmu_cache() inside
> ptep_set_access_flags(), but perhaps we could remove the whole logic of
> reading the old PTE & comparing it, and instead have
> ptep_set_access_flags() do that locally and return to the caller wether
> a change occured that requires update_mmu_cache() to be called.
> 
> That way, archs who don't actually need update_mmu_cache() under some
> circumstances will be able to return 0 there.
> 
> What do you guys thing ?

I think that's a good idea.
