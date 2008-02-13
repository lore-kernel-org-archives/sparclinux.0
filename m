From: Jon Loeliger <jdl@jdl.com>
Date: Wed, 13 Feb 2008 14:20:07 +0000
Subject: Re: [PATCH] [POWERPC] Fix initial lmb add region with a non-zero base
Message-Id: <E1JPIT1-0001ke-GR@jdl.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net> 
In-Reply-To: Your message of "Wed, 13 Feb 2008 07:37:27 CST."
	<Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kumar Gala <galak@kernel.crashing.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, davem@davemloft.net, linux-kernel@vger.kernel.org

So, like, the other day Kumar Gala mumbled:
> If we add to an empty lmb region with a non-zero base we will not coalesce
> the number of regions done to one.  This causes problems on ppc32 for the

s/done/down

> memory region as its assumed to only have one region.
> 
> We can fix this be easily specially casing the initial add to just replace
> the dummy region.
> 
> ---
>
> Posting this since Dave's looking a pulling the lmb code out into lib/ and
> sharing it between powerpc and sparc.

Did you want to S-o-b: this patch?  Or was this just informational?

Thanks,
jdl
