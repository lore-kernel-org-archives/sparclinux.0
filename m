From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 28 Oct 2020 09:41:56 +0000
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Message-Id: <20201028094156.GD1428094@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
 <20201026091554.GB1154158@kernel.org>
 <a28d8248057e7dc01716764da9edfd666722ff62.camel@intel.com>
 <20201027084902.GH1154158@kernel.org>
 <ce66dcf2bbc17d40bcbe752868edb13976b3f1bb.camel@intel.com>
In-Reply-To: <ce66dcf2bbc17d40bcbe752868edb13976b3f1bb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Oct 27, 2020 at 10:44:21PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2020-10-27 at 10:49 +0200, Mike Rapoport wrote:
> > On Mon, Oct 26, 2020 at 06:57:32PM +0000, Edgecombe, Rick P wrote:
> > > On Mon, 2020-10-26 at 11:15 +0200, Mike Rapoport wrote:
> > > > On Mon, Oct 26, 2020 at 12:38:32AM +0000, Edgecombe, Rick P
> > > > wrote:
> > > > > On Sun, 2020-10-25 at 12:15 +0200, Mike Rapoport wrote:
> > > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > > 
> > > > > > When DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP is enabled a
> > > > > > page
> > > > > > may
> > > > > > be
> > > > > > not present in the direct map and has to be explicitly mapped
> > > > > > before
> > > > > > it
> > > > > > could be copied.
> > > > > > 
> > > > > > On arm64 it is possible that a page would be removed from the
> > > > > > direct
> > > > > > map
> > > > > > using set_direct_map_invalid_noflush() but
> > > > > > __kernel_map_pages()
> > > > > > will
> > > > > > refuse
> > > > > > to map this page back if DEBUG_PAGEALLOC is disabled.
> > > > > 
> > > > > It looks to me that arm64 __kernel_map_pages() will still
> > > > > attempt
> > > > > to
> > > > > map it if rodata_full is true, how does this happen?
> > > > 
> > > > Unless I misread the code, arm64 requires both rodata_full and
> > > > debug_pagealloc_enabled() to be true for __kernel_map_pages() to
> > > > do
> > > > anything.
> > > > But rodata_full condition applies to set_direct_map_*_noflush()
> > > > as
> > > > well,
> > > > so with !rodata_full the linear map won't be ever changed.
> > > 
> > > Hmm, looks to me that __kernel_map_pages() will only skip it if
> > > both
> > > debug pagealloc and rodata_full are false.
> > > 
> > > But now I'm wondering if maybe we could simplify things by just
> > > moving
> > > the hibernate unmapped page logic off of the direct map. On x86,
> > > text_poke() used to use this reserved fixmap pte thing that it
> > > could
> > > rely on to remap memory with. If hibernate had some separate pte
> > > for
> > > remapping like that, then we could not have any direct map
> > > restrictions
> > > caused by it/kernel_map_pages(), and it wouldn't have to worry
> > > about
> > > relying on anything else.
> > 
> > Well, there is map_kernel_range() that can be used by hibernation as
> > there is no requirement for particular virtual address, but that
> > would
> > be quite costly if done for every page.
> > 
> > Maybe we can do somthing like
> > 
> > 	if (kernel_page_present(s_page)) {
> > 		do_copy_page(dst, page_address(s_page));
> > 	} else {
> > 		map_kernel_range_noflush(page_address(page), PAGE_SIZE,
> > 					 PROT_READ, &page);
> > 		do_copy_page(dst, page_address(s_page));
> > 		unmap_kernel_range_noflush(page_address(page),
> > PAGE_SIZE);
> > 	}
> > 
> > But it seems that a prerequisite for changing the way a page is
> > mapped
> > in safe_copy_page() would be to teach hibernation that a mapping here
> > may fail.
> > 
> Yea that is what I meant, the direct map could still be used for mapped
> pages.
> 
> But for the unmapped case it could have a pre-setup 4k pte for some non
> direct map address. Then just change the pte to point to any unmapped
> direct map page that was encountered. The point would be to give
> hibernate some 4k pte of its own to manipulate so that it can't fail.
> 
> Yet another option would be have hibernate_map_page() just map large
> pages if it finds them.
> 
> So we could teach hibernate to handle mapping failures, OR we could
> change it so it doesn't rely on direct map page sizes in order to
> succeed. The latter seems better to me since there isn't a reason why
> it should have to fail and the resulting logic might be simpler. Both
> seem like improvements in robustness though.

That's correct, but as the purpose of this series is to prevent usage of
__kernel_map_pages() outside DEBUG_PAGALLOC, for now I'm going to update this
patch changelog and add a comment to hibernate_map_page().

-- 
Sincerely yours,
Mike.
