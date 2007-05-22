From: David Miller <davem@davemloft.net>
Date: Tue, 22 May 2007 21:53:40 +0000
Subject: Re: [PATCH/RFC] Rework ptep_set_access_flags and fix sun4c
Message-Id: <20070522.145340.59657045.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1179757647.6254.235.camel@localhost.localdomain>
	<1179815339.32247.799.camel@localhost.localdomain>
	<Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: benh@kernel.crashing.org, tcallawa@redhat.com, hugh@veritas.com, akpm@linux-foundation.org, linuxppc-dev@ozlabs.org, wli@holomorphy.com, linux-mm@kvack.org, andrea@suse.de, sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 22 May 2007 22:52:13 +0100 (BST)

> Hi Benjamin,
> 
> I have just tested this patch on my Sun4c Sparcstation 1 using my 2.6.20.9 
> test kernel without any problems.
> 
> Thank you for the work.

Thanks for your testing.

Someone please merge this in once any remaining issues have
been resolved :-)
