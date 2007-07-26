From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2007 05:09:50 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <20070725.220950.99487380.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 05:31:16 +0100 (BST)

> This version alows the condition you indicated (VTOC sanity=0,version=0 
> and no_partitions=0) to work as before as long as what were the spare1/spare2
> fields in the VTOC partition entries are zero.
> 
> Can you try it out and see if it behaves correctly for fully set up VTOC 
> and also the previous Linux-Sun partition situation.
> 
> This should at least prevent some posible problems with posible future 
> versions of VTOC. It may be desirable to to reject partitions if the 
> VTOC is not compatible (different sanity or version > 1). What is your view?
> 
> The code will now also scan up to VTOC partitions when a validated VTOC 
> has been detected.

It looks like it would work and I will give it some testing,
thanks Mark.

Why don't we want to try and use 16-partition x86 Solaris labels?
Are those only found as sub-labels of MSDOS partitions?
