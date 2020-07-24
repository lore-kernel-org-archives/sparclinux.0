From: David Hildenbrand <david@redhat.com>
Date: Fri, 24 Jul 2020 08:22:47 +0000
Subject: Re: [PATCH 3/3] sparc: Drop unused MAX_PHYSADDR_BITS
Message-Id: <405d44f1-9042-d22e-8478-7bc2d5f89c61@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
 <20200723231544.17274-4-nivedita@alum.mit.edu>
In-Reply-To: <20200723231544.17274-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On 24.07.20 01:15, Arvind Sankar wrote:
> The macro is not used anywhere, so remove the definition.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/sparc/include/asm/sparsemem.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sparc/include/asm/sparsemem.h b/arch/sparc/include/asm/sparsemem.h
> index 1dd1b61432db..aa9a676bc341 100644
> --- a/arch/sparc/include/asm/sparsemem.h
> +++ b/arch/sparc/include/asm/sparsemem.h
> @@ -7,7 +7,6 @@
>  #include <asm/page.h>
>  
>  #define SECTION_SIZE_BITS       30
> -#define MAX_PHYSADDR_BITS       MAX_PHYS_ADDRESS_BITS
>  #define MAX_PHYSMEM_BITS        MAX_PHYS_ADDRESS_BITS
>  
>  #endif /* !(__KERNEL__) */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
