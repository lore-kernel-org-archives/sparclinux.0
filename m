From: David Hildenbrand <david@redhat.com>
Date: Thu, 29 Oct 2020 08:15:47 +0000
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map manipulation
Message-Id: <30075bb8-caed-c4de-c09e-e0f6fb964a8d@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <len.brown@intel.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, linux-pm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, David Rientjes <rientjes@google.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On 25.10.20 11:15, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> During recent discussion about KVM protected memory, David raised a concern
> about usage of __kernel_map_pages() outside of DEBUG_PAGEALLOC scope [1].
> 
> Indeed, for architectures that define CONFIG_ARCH_HAS_SET_DIRECT_MAP it is
> possible that __kernel_map_pages() would fail, but since this function is
> void, the failure will go unnoticed.
> 
> Moreover, there's lack of consistency of __kernel_map_pages() semantics
> across architectures as some guard this function with
> #ifdef DEBUG_PAGEALLOC, some refuse to update the direct map if page
> allocation debugging is disabled at run time and some allow modifying the
> direct map regardless of DEBUG_PAGEALLOC settings.
> 
> This set straightens this out by restoring dependency of
> __kernel_map_pages() on DEBUG_PAGEALLOC and updating the call sites
> accordingly.
> 

So, I was primarily wondering if we really have to touch direct mappings 
in hibernation code, or if we can avoid doing that. I was wondering if 
we cannot simply do something like kmap() when trying to access a 
!mapped page. Similar to reading old-os memory after kexec when in 
kdump. Just a thought.

-- 
Thanks,

David / dhildenb
