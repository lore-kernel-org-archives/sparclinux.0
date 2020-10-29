From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 29 Oct 2020 07:54:16 +0000
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Message-Id: <20201029075416.GJ1428094@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
In-Reply-To: <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

On Wed, Oct 28, 2020 at 09:15:38PM +0000, Edgecombe, Rick P wrote:
> On Sun, 2020-10-25 at 12:15 +0200, Mike Rapoport wrote:
> > +       if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> > +               unsigned long addr = (unsigned
> > long)page_address(page);
> > +               int ret;
> > +
> > +               if (enable)
> > +                       ret = set_direct_map_default_noflush(page);
> > +               else
> > +                       ret = set_direct_map_invalid_noflush(page);
> > +
> > +               if (WARN_ON(ret))
> > +                       return;
> > +
> > +               flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +       } else {
> > +               debug_pagealloc_map_pages(page, 1, enable);
> > +       }
> 
> Looking at the arm side again, I think this might actually introduce a
> regression for the arm/hibernate/DEBUG_PAGEALLOC combo.
> 
> Unlike __kernel_map_pages(), it looks like arm's cpa will always bail
> in the set_direct_map_() functions if rodata_full is false.
>
> So if rodata_full was disabled but debug page alloc is on, then this
> would now skip remapping the pages. I guess the significance depends
> on whether hibernate could actually try to save any DEBUG_PAGEALLOC
> unmapped pages. Looks like it to me though.
 
__kernel_map_pages() on arm64 will also bail out if rodata_full is
false:

void __kernel_map_pages(struct page *page, int numpages, int enable)
{
	if (!debug_pagealloc_enabled() && !rodata_full)
		return;

	set_memory_valid((unsigned long)page_address(page), numpages, enable);
}

So using set_direct_map() to map back pages removed from the direct map
with __kernel_map_pages() seems safe to me.

-- 
Sincerely yours,
Mike.
