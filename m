From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Thu, 18 Mar 2004 02:45:17 +0000
Subject: Re: nonzero phys_base
Message-Id: <20040318024517.GA16659@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040316114121.GA5170@spike>
In-Reply-To: <20040316114121.GA5170@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 16, 2004 at 09:10:56AM -0800, Pete Zaitcev wrote:

> > +#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
> > +#define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))
> 
> This, obviously, overflows on highmem systems.
> Do we have any users for __pa, __va, virt_to_phys and phys_to_virt?
> It would be helpful if you enumerated all of them and perhaps
> removed some.

Pete, this has always been true for highmem.  How does his patch make
this worse?

-- 
Keith M Wesolowski
