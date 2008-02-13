From: David Miller <davem@davemloft.net>
Date: Wed, 13 Feb 2008 23:18:28 +0000
Subject: Re: [RFC/PATCH] [POWERPC] Make lmb support large physical
Message-Id: <20080213.151828.177835338.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0802131639200.24317@monty.am.freescale.net>
	<1202943042.7296.48.camel@pasglop>
In-Reply-To: <1202943042.7296.48.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Feb 2008 09:50:42 +1100

> 
> On Wed, 2008-02-13 at 16:43 -0600, Becky Bruce wrote:
> > Convert the lmb code to use phys_addr_t instead of unsigned long for
> > physical addresses and sizes.  This is needed to support large amounts
> > of RAM on 32-bit systems that support 36-bit physical addressing.
> > 
> > Built/booted on mpc8641; build tested on pasemi and 44x.
> > 
> > Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> > ---
> > Folks,
> > 
> > This has been sitting in my tree for a few days, and now it looks like
> > David M. has submitted a patch that changes the lmb code to be shared
> > between sparc and powerpc.  Sparc has no notion of a phys_addr_t.
> > Should we just use u64 everywhere in this code instead?  Thoughts?
> 
> An option would be to use resource_size_t, though it's a bit yucky...
> 
> Dave, what do you prefer ?

u64 is fine with me, either way we'll be casting the printk()
arguments all over the place so the choice really isn't
so important one way or the other as far as I can tell.
