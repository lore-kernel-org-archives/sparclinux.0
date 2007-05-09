From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 09 May 2007 22:48:02 +0000
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
Message-Id: <1178750882.14928.199.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20070430145414.88fda272.akpm@linux-foundation.org>
	 <20070430.150407.07642146.davem@davemloft.net>
	 <1177977619.24962.6.camel@localhost.localdomain>
	 <20070430.173806.112621225.davem@davemloft.net>
	 <Pine.LNX.4.61.0705010223040.3556@mtfhpc.demon.co.uk>
	 <1177985136.24962.8.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0705011453380.4771@mtfhpc.demon.co.uk>
	 <1178055110.13263.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0705012354290.12808@mtfhpc.demon.co.uk>
	 <Pine.LNX.4.61.0705092005060.29444@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0705092005060.29444@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org, wli@holomorphy.com, linux-mm@kvack.org, andrea@suse.de, sparclinux@vger.kernel.org

On Wed, 2007-05-09 at 20:44 +0100, Mark Fortescue wrote:
> Hi Ben,
> 
> Is it worth formally sending in either of my patches or does more work 
> need to be done first?

Sorry, I've been busy with other things...

What do other thing about it ? Having update_mmu_cache() call buried
inside the ptep_set_access_flags() sounds good ? Somebody has a better
idea ?

One thing I was thinking was that we could replace the whole logic with
having ptep_set_access_flags() compare the new PTE bits with what was
already there and return wether an update_mmu_cache() is required....

Ben.

