From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 26 Jun 2019 06:11:34 +0000
Subject: Re: [PATCH 1/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Message-Id: <20190626061134.GD17798@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
 <1561501810-25163-2-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-2-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hoan Tran OS <hoan@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>

On Tue 25-06-19 22:30:24, Hoan Tran OS wrote:
> This patch enables CONFIG_NODES_SPAN_OTHER_NODES by default
> for NUMA. As some NUMA nodes have memory ranges that span other
> nodes. Even though a pfn is valid and between a node's start and
> end pfns, it may not reside on that node.

Please describe the problem more thoroughly. What is the layout, what
doesn't work with the default configuration and why do we need this
particular fix rather than enabling of the config option for the
specific HW.

> 
> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d66bc8a..6335505 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1413,7 +1413,7 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
>  }
>  #endif
>  
> -#ifdef CONFIG_NODES_SPAN_OTHER_NODES
> +#ifdef CONFIG_NUMA
>  /* Only safe to use early in boot when initialisation is single-threaded */
>  static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
>  {
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
