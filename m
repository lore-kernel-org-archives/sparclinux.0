From: David Miller <davem@davemloft.net>
Date: Wed, 30 Aug 2017 01:12:08 +0000
Subject: Re: [PATCH v7 07/11] sparc64: optimized struct page zeroing
Message-Id: <20170829.181208.171985548699678313.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1503972142-289376-1-git-send-email-pasha.tatashin@oracle.com>
 <1503972142-289376-8-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1503972142-289376-8-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 28 Aug 2017 22:02:18 -0400

> Add an optimized mm_zero_struct_page(), so struct page's are zeroed without
> calling memset(). We do eight to ten regular stores based on the size of
> struct page. Compiler optimizes out the conditions of switch() statement.
> 
> SPARC-M6 with 15T of memory, single thread performance:
> 
>                                BASE            FIX  OPTIMIZED_FIX
>         bootmem_init   28.440467985s   2.305674818s   2.305161615s
> free_area_init_nodes  202.845901673s 225.343084508s 172.556506560s
>                       --------------------------------------------
> Total                 231.286369658s 227.648759326s 174.861668175s
> 
> BASE:  current linux
> FIX:   This patch series without "optimized struct page zeroing"
> OPTIMIZED_FIX: This patch series including the current patch.
> 
> bootmem_init() is where memory for struct pages is zeroed during
> allocation. Note, about two seconds in this function is a fixed time: it
> does not increase as memory is increased.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

You should probably use initializing stores when you are doing 8
stores and we thus know the page struct is cache line aligned.

But other than that:

Acked-by: David S. Miller <davem@davemloft.net>
