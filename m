From: Pete Zaitcev <zaitcev@redhat.com>
Date: Tue, 16 Mar 2004 17:10:56 +0000
Subject: Re: nonzero phys_base
Message-Id: <20040316091056.3d35109f.zaitcev@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040316114121.GA5170@spike>
In-Reply-To: <20040316114121.GA5170@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 16 Mar 2004 12:41:21 +0100
Stefan Holst <mail@s-holst.de> wrote:

Looks good on the whole, especially in that you accepted a correct
relationship between PFN and indexing into mem_map.

The only little problem is:

> +#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
> +#define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))

This, obviously, overflows on highmem systems.
Do we have any users for __pa, __va, virt_to_phys and phys_to_virt?
It would be helpful if you enumerated all of them and perhaps
removed some.

> -#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
> +#define virt_to_page(kaddr)	pfn_to_page(PFN(__pa(kaddr)))

This was correct before, because of the way mem_map was placed,
its physical address never overflowed. But with nonzero phys_base,
it is not correct anymore.

In fact you do not need this, just use

 mem_map + ((unsigned long)(x) - PAGE_OFFSET)

> +#define virt_addr_valid(kaddr)	pfn_valid(PFN(__pa(kaddr)))

Ditto

-- Pete
