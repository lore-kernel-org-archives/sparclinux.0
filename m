From: David Miller <davem@davemloft.net>
Date: Wed, 13 Feb 2008 22:33:59 +0000
Subject: Re: [PATCH] [POWERPC] Fix initial lmb add region with a non-zero
Message-Id: <20080213.143359.258873954.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: galak@kernel.crashing.org
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 13 Feb 2008 07:37:27 -0600 (CST)

> If we add to an empty lmb region with a non-zero base we will not coalesce
> the number of regions done to one.  This causes problems on ppc32 for the
> memory region as its assumed to only have one region.
> 
> We can fix this be easily specially casing the initial add to just replace
> the dummy region.
> 
> ---
> 
> Posting this since Dave's looking a pulling the lmb code out into lib/ and
> sharing it between powerpc and sparc.
> 
> (this is my git tree git.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git)

I noticed this issue when I use lmb on sparc64 and I intended to bring
it up eventually.  Thanks for fixing it!
