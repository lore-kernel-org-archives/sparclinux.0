From: Pete Zaitcev <zaitcev@redhat.com>
Date: Thu, 18 Mar 2004 03:36:53 +0000
Subject: Re: nonzero phys_base
Message-Id: <20040317193653.2aae2bd0.zaitcev@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040316114121.GA5170@spike>
In-Reply-To: <20040316114121.GA5170@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 17 Mar 2004 18:45:17 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> On Tue, Mar 16, 2004 at 09:10:56AM -0800, Pete Zaitcev wrote:
> 
> > > +#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
> > > +#define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))
> > 
> > This, obviously, overflows on highmem systems.
> > Do we have any users for __pa, __va, virt_to_phys and phys_to_virt?
> > It would be helpful if you enumerated all of them and perhaps
> > removed some.
> 
> Pete, this has always been true for highmem.  How does his patch make
> this worse?

The patch is not making anything worse, but having nonzero phys_base
allows for the first SIMM bank or DIMM to be missing. They always
overflowed, but the box would not boot far enough for this to be
noticeable regarding the calculation of index into mem_map.

The changed assumption is that everything that is low mem (mapped)
has a small physical address.

Actually, I meant to note it before, but perhaps phys_base should be
eliminated completely in favor of pfn_base.

-- Pete
