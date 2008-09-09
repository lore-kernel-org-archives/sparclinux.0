From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2008 05:12:03 +0000
Subject: Re: HyperSPARC RT625 Cache Controler, Ross CY7C605 Cache
Message-Id: <20080908.221203.158686193.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48B67008.3010007@tensilica.com>
	<20080828.024118.166054084.davem@davemloft.net>
	<48C6048E.2080609@tensilica.com>
In-Reply-To: <48C6048E.2080609@tensilica.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: piet.delaney@tensilica.com
Cc: sparclinux@vger.kernel.org, linux-omap@vger.kernel.org, piet.delaney@gmail.com

From: Piet Delaney <piet.delaney@tensilica.com>
Date: Mon, 08 Sep 2008 22:07:26 -0700

> Wonder why the update_mmu_cache() for sun4c has to do so much more
> work that sun4m.

Caches are virtually indexed and virtually tagged on sun4c, that's why.

Keep on wonderin'

> Wonder why SPARC has to do more work that ARM.

ARMs that have the cache issues aren't SMP, that's why.

Keep on wonderin'
