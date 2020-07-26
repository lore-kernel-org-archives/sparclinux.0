From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 26 Jul 2020 06:48:59 +0000
Subject: Re: [PATCH 0/3] Drop unused MAX_PHYSADDR_BITS
Message-Id: <20200726064859.GA2835983@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 07:15:41PM -0400, Arvind Sankar wrote:
> This #define is not used anywhere, and has the wrong value on x86_64.
> 
> I tried digging into the history a bit, but it seems to have been unused
> even in the initial merge of sparsemem in v2.6.13, when it was first
> defined.
> 
> Arvind Sankar (3):
>   x86/mm: Drop unused MAX_PHYSADDR_BITS
>   sh/mm: Drop unused MAX_PHYSADDR_BITS
>   sparc: Drop unused MAX_PHYSADDR_BITS

For the series

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

 
>  arch/sh/include/asm/sparsemem.h    | 4 +---
>  arch/sparc/include/asm/sparsemem.h | 1 -
>  arch/x86/include/asm/sparsemem.h   | 6 +-----
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> -- 
> 2.26.2
> 
> 

-- 
Sincerely yours,
Mike.
