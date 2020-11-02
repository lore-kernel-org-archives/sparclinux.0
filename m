From: Mike Rapoport <rppt@kernel.org>
Date: Mon, 02 Nov 2020 15:15:24 +0000
Subject: Re: [PATCH v3 3/4] arch, mm: restore dependency of __kernel_map_pages() of DEBUG_PAGEALLOC
Message-Id: <20201102151524.GB4879@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-4-rppt@kernel.org>
 <8eac2aa4-114e-f981-c8f8-ad8523175cf8@redhat.com>
In-Reply-To: <8eac2aa4-114e-f981-c8f8-ad8523175cf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <len.brown@intel.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, linux-pm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, David Rientjes <rientjes@google.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Mon, Nov 02, 2020 at 10:23:20AM +0100, David Hildenbrand wrote:
> 
> >   int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
> >   				   unsigned numpages, unsigned long page_flags)
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 14e397f3752c..ab0ef6bd351d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2924,7 +2924,11 @@ static inline bool debug_pagealloc_enabled_static(void)
> >   	return static_branch_unlikely(&_debug_pagealloc_enabled);
> >   }
> > -#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
> > +#ifdef CONFIG_DEBUG_PAGEALLOC
> > +/*
> > + * To support DEBUG_PAGEALLOC architecture must ensure that
> > + * __kernel_map_pages() never fails
> 
> Maybe add here, that this implies mapping everything via PTEs during boot.

This is more of an implementation detail, while assumption that
__kernel_map_pages() does not fail is somewhat a requirement :)

> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
