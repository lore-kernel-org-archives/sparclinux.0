From: David Miller <davem@davemloft.net>
Date: Mon, 23 Aug 2010 04:39:45 +0000
Subject: Re: [PATCH 2/2] rwsem: Move powerpc atomic-long based
Message-Id: <20100822.213945.241455303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
	<1282281295.22370.401.camel@pasglop>
In-Reply-To: <1282281295.22370.401.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: torvalds@linux-foundation.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 20 Aug 2010 15:14:55 +1000

> Other architectures who support cmpxchg and atomic_long can
> use that directly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: David S. Miller <davem@davemloft.net>

I'll move sparc64 over to this once it hits Linus's tree.
