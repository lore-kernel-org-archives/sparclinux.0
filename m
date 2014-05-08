From: David Miller <davem@davemloft.net>
Date: Thu, 08 May 2014 17:36:49 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140508.133649.177876731846674449.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 08 May 2014 13:15:17 -0400 (EDT)

> Oh I see, the bug didn't even exist.  In __tsb_context_switch the
> address is adjusted properly when the huge TSB mapping is installed in
> the TLB.  So there's no bug at all. :-/

I take this back, the __tsb_context_switch() does DOES NOT adjust
the virtual address, it uses the one provided by the TSB config
structure.

So the bug is very real.

Meelis can you double check that you had this patch installed and
booted kernels built with the change present on those machines?

Thanks a lot.
