From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 09 Nov 2020 11:33:46 +0000
Subject: Re: [PATCH v5 1/5] mm: introduce debug_pagealloc_{map,unmap}_pages() helpers
Message-Id: <4bd5ae2b-4fc6-73dc-b83b-e71826990946@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20201108065758.1815-1-rppt@kernel.org>
 <20201108065758.1815-2-rppt@kernel.org>
In-Reply-To: <20201108065758.1815-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <len.brown@intel.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, linux-pm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, David Rientjes <rientjes@google.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

On 11/8/20 7:57 AM, Mike Rapoport wrote:
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1428,21 +1428,19 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
>   	return false;
>   }
>   
> -#ifdef CONFIG_DEBUG_PAGEALLOC
>   static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
>   {
>   	if (!is_debug_pagealloc_cache(cachep))
>   		return;

Hmm, I didn't notice earlier, sorry.
The is_debug_pagealloc_cache() above includes a debug_pagealloc_enabled_static() 
check, so it should be fine to use
__kernel_map_pages() directly below. Otherwise we generate two static key checks 
for the same key needlessly.

>   
> -	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
> +	if (map)
> +		debug_pagealloc_map_pages(virt_to_page(objp),
> +					  cachep->size / PAGE_SIZE);
> +	else
> +		debug_pagealloc_unmap_pages(virt_to_page(objp),
> +					    cachep->size / PAGE_SIZE);
>   }
>   
> -#else
> -static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
> -				int map) {}
> -
> -#endif
> -
>   static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
>   {
>   	int size = cachep->object_size;
> @@ -2062,7 +2060,7 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
>   
>   #if DEBUG
>   	/*
> -	 * If we're going to use the generic kernel_map_pages()
> +	 * If we're going to use the generic debug_pagealloc_map_pages()
>   	 * poisoning, then it's going to smash the contents of
>   	 * the redzone and userword anyhow, so switch them off.
>   	 */
> 
