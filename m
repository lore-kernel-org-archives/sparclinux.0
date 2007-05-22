From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 22 May 2007 23:29:14 +0000
Subject: Re: [PATCH/RFC] Rework ptep_set_access_flags and fix sun4c
Message-Id: <1179876554.32247.889.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1179757647.6254.235.camel@localhost.localdomain>
	 <1179815339.32247.799.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
	 <20070522.145340.59657045.davem@davemloft.net>
In-Reply-To: <20070522.145340.59657045.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mark@mtfhpc.demon.co.uk, tcallawa@redhat.com, hugh@veritas.com, akpm@linux-foundation.org, linuxppc-dev@ozlabs.org, wli@holomorphy.com, linux-mm@kvack.org, andrea@suse.de, sparclinux@vger.kernel.org

On Tue, 2007-05-22 at 14:53 -0700, David Miller wrote:
> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Tue, 22 May 2007 22:52:13 +0100 (BST)
> 
> > Hi Benjamin,
> > 
> > I have just tested this patch on my Sun4c Sparcstation 1 using my 2.6.20.9 
> > test kernel without any problems.
> > 
> > Thank you for the work.
> 
> Thanks for your testing.
> 
> Someone please merge this in once any remaining issues have
> been resolved :-)

I'll send a patch fixing the couple of x86/ia64 nits & my bad english
spelling (no, I don't happen to raise castrated rams) as soon as I reach
the office later today.

Cheers,
Ben.


