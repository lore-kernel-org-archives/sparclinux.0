From: David Miller <davem@davemloft.net>
Date: Thu, 19 Aug 2010 05:29:25 +0000
Subject: Re: 64-bit ppc rwsem
Message-Id: <20100818.222925.233689776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<1282195403.22370.296.camel@pasglop>
In-Reply-To: <1282195403.22370.296.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: torvalds@linux-foundation.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 19 Aug 2010 15:23:23 +1000

> Similar here, but using atomic_long_t instead so it works for 32-bit too
> for me. I suppose we could make that part common indeed.
> 
> What about asm-generic/rwsem-atomic.h  or rwsem-cmpxchg.h ?

Using rwsem-cmpxchg.h sounds best I guess.
