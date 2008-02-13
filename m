From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 13 Feb 2008 22:50:42 +0000
Subject: Re: [RFC/PATCH] [POWERPC] Make lmb support large physical
Message-Id: <1202943042.7296.48.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0802131639200.24317@monty.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0802131639200.24317@monty.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Becky Bruce <bgill@freescale.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, davem@davemloft.net, linux-kernel@vger.kernel.org


On Wed, 2008-02-13 at 16:43 -0600, Becky Bruce wrote:
> Convert the lmb code to use phys_addr_t instead of unsigned long for
> physical addresses and sizes.  This is needed to support large amounts
> of RAM on 32-bit systems that support 36-bit physical addressing.
> 
> Built/booted on mpc8641; build tested on pasemi and 44x.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> Folks,
> 
> This has been sitting in my tree for a few days, and now it looks like
> David M. has submitted a patch that changes the lmb code to be shared
> between sparc and powerpc.  Sparc has no notion of a phys_addr_t.
> Should we just use u64 everywhere in this code instead?  Thoughts?

An option would be to use resource_size_t, though it's a bit yucky...

Dave, what do you prefer ?

Ben.


