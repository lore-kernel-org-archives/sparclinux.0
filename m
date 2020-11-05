From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 05 Nov 2020 11:42:00 +0000
Subject: Re: [PATCH v4 3/4] arch, mm: restore dependency of __kernel_map_pages() of DEBUG_PAGEALLOC
Message-Id: <20201105114200.GZ4879@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103162057.22916-1-rppt@kernel.org>
 <20201103162057.22916-4-rppt@kernel.org>
 <f9c1dc66-fc60-db4d-9670-0271adb2ed07@suse.cz>
In-Reply-To: <f9c1dc66-fc60-db4d-9670-0271adb2ed07@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <len.brown@intel.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, linux-pm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, David Rientjes <rientjes@google.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

On Wed, Nov 04, 2020 at 07:02:20PM +0100, Vlastimil Babka wrote:
> On 11/3/20 5:20 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Subject should have "on DEBUG_PAGEALLOC" ?
> 
> > The design of DEBUG_PAGEALLOC presumes that __kernel_map_pages() must never
> > fail. With this assumption is wouldn't be safe to allow general usage of
> > this function.
> > 
> > Moreover, some architectures that implement __kernel_map_pages() have this
> > function guarded by #ifdef DEBUG_PAGEALLOC and some refuse to map/unmap
> > pages when page allocation debugging is disabled at runtime.
> > 
> > As all the users of __kernel_map_pages() were converted to use
> > debug_pagealloc_map_pages() it is safe to make it available only when
> > DEBUG_PAGEALLOC is set.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/Kconfig                     |  3 +++
> >   arch/arm64/Kconfig               |  4 +---
> >   arch/arm64/mm/pageattr.c         |  8 ++++++--
> >   arch/powerpc/Kconfig             |  5 +----
> >   arch/riscv/Kconfig               |  4 +---
> >   arch/riscv/include/asm/pgtable.h |  2 --
> >   arch/riscv/mm/pageattr.c         |  2 ++
> >   arch/s390/Kconfig                |  4 +---
> >   arch/sparc/Kconfig               |  4 +---
> >   arch/x86/Kconfig                 |  4 +---
> >   arch/x86/mm/pat/set_memory.c     |  2 ++
> >   include/linux/mm.h               | 10 +++++++---
> >   12 files changed, 26 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 56b6ccc0e32d..56d4752b6db6 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1028,6 +1028,9 @@ config HAVE_STATIC_CALL_INLINE
> >   	bool
> >   	depends on HAVE_STATIC_CALL
> > +config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> > +	bool
> > +
> >   source "kernel/gcov/Kconfig"
> >   source "scripts/gcc-plugins/Kconfig"
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 1d466addb078..a932810cfd90 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -71,6 +71,7 @@ config ARM64
> >   	select ARCH_USE_QUEUED_RWLOCKS
> >   	select ARCH_USE_QUEUED_SPINLOCKS
> >   	select ARCH_USE_SYM_ANNOTATIONS
> > +	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> >   	select ARCH_SUPPORTS_MEMORY_FAILURE
> >   	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> >   	select ARCH_SUPPORTS_ATOMIC_RMW
> > @@ -1025,9 +1026,6 @@ config HOLES_IN_ZONE
> >   source "kernel/Kconfig.hz"
> > -config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> > -	def_bool y
> > -
> >   config ARCH_SPARSEMEM_ENABLE
> >   	def_bool y
> >   	select SPARSEMEM_VMEMMAP_ENABLE
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index 1b94f5b82654..439325532be1 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -155,7 +155,7 @@ int set_direct_map_invalid_noflush(struct page *page)
> >   		.clear_mask = __pgprot(PTE_VALID),
> >   	};
> > -	if (!rodata_full)
> > +	if (!debug_pagealloc_enabled() && !rodata_full)
> >   		return 0;
> >   	return apply_to_page_range(&init_mm,
> > @@ -170,7 +170,7 @@ int set_direct_map_default_noflush(struct page *page)
> >   		.clear_mask = __pgprot(PTE_RDONLY),
> >   	};
> > -	if (!rodata_full)
> > +	if (!debug_pagealloc_enabled() && !rodata_full)
> >   		return 0;
> >   	return apply_to_page_range(&init_mm,
> 
> I don't understand these two hunks. Previous patch calls this for
> hibernation when CONFIG_ARCH_HAS_SET_DIRECT_MAP, which is true for arm64.
> Why suddenly this starts to depend on debug_pagealloc_enabled()?

I was confused about this for quite a long :)

On arm64 the changes to direct^w linear map are allowed when 

	debug_page_alloc() || rodata_full

In hibernation we essentially have now

	if (1)
		set_direct_map(something)
	else
		debug_page_alloc_map()

With debug_pagealloc enabled but with rodata_full disabled arm64
versions of set_direct_map_*() will become a nop, so a page that was
unmapped by debug_pagealloc() will not be mapped back.

I'm still puzzled how hibernation might ever need to save a free page,
but that's another story.

-- 
Sincerely yours,
Mike.
