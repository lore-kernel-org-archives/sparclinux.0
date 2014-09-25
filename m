From: David Miller <davem@davemloft.net>
Date: Thu, 25 Sep 2014 18:56:40 +0000
Subject: Re: [PATCH V3] sparc64: sparse irq
Message-Id: <20140925.145640.561025215100707097.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 25 Sep 2014 13:34:20 -0400 (EDT)

> In an attempt to test this, I'm using your patch but I modified it
> to negotiate HV_GRP_INTR major=2 and then use the cookie only
> routines if that succeeded.
> 
> The negotiation of major=2 works, but hv calls fail with EINVAL and
> other strange things.
> 
> Trying to investigate further, because making this work with major=2
> would be great because we could avoid the ivector table allocation
> on even more machines.

Ok the problem is that with pre-major=3 supporting hypervisors, it
looks like VIRQs are only supported for LDC interrupts.

So we really do need major>=3 for cookie-only system wide.
