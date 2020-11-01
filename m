From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 01 Nov 2020 17:02:17 +0000
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Message-Id: <20201101170217.GD14628@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
 <20201029075416.GJ1428094@kernel.org>
 <604554805defb03d158c09aba4b5cced3416a7fb.camel@intel.com>
In-Reply-To: <604554805defb03d158c09aba4b5cced3416a7fb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

On Thu, Oct 29, 2020 at 11:19:18PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2020-10-29 at 09:54 +0200, Mike Rapoport wrote:
> > __kernel_map_pages() on arm64 will also bail out if rodata_full is
> > false:
> > void __kernel_map_pages(struct page *page, int numpages, int enable)
> > {
> >         if (!debug_pagealloc_enabled() && !rodata_full)
> >                 return;
> > 
> >         set_memory_valid((unsigned long)page_address(page), numpages,
> > enable);
> > }
> > 
> > So using set_direct_map() to map back pages removed from the direct
> > map
> > with __kernel_map_pages() seems safe to me.
> 
> Heh, one of us must have some simple boolean error in our head. I hope
> its not me! :) I'll try on more time.

Well, then it's me :)
You are right, I misread this and I could not understand why
!rodata_full bothers you.

> __kernel_map_pages() will bail out if rodata_full is false **AND**
> debug page alloc is off. So it will only bail under conditions where
> there could be nothing unmapped on the direct map.
> 
> Equivalent logic would be:
> 	if (!(debug_pagealloc_enabled() || rodata_full))
> 		return;
> 
> Or:
> 	if (debug_pagealloc_enabled() || rodata_full)
> 		set_memory_valid(blah)
> 
> So if either is on, the existing code will try to re-map. But the
> set_direct_map_()'s will only work if rodata_full is on. So switching
> hibernate to set_direct_map() will cause the remap to be missed for the
> debug page alloc case, with !rodata_full.
> 
> It also breaks normal debug page alloc usage with !rodata_full for
> similar reasons after patch 3. The pages would never get unmapped.

I've updated the patches, there should be no regression now.

-- 
Sincerely yours,
Mike.
