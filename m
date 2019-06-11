From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 11 Jun 2019 19:22:33 +0000
Subject: Re: [PATCH 01/16] mm: use untagged_addr() for get_user_pages_fast addresses
Message-Id: <9145f3f9-4e14-df6a-87f5-663ad197e96e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-2-hch@lst.de>
In-Reply-To: <20190611144102.8848-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 6/11/19 8:40 AM, Christoph Hellwig wrote:
> This will allow sparc64 to override its ADI tags for
> get_user_pages and get_user_pages_fast.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Commit message is sparc64 specific but the goal here is to allow any
architecture with memory tagging to use this. So I would suggest
rewording the commit log. Other than that:

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..6bb521db67ec 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2146,7 +2146,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long flags;
>  	int nr = 0;
>  
> -	start &= PAGE_MASK;
> +	start = untagged_addr(start) & PAGE_MASK;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
>  
> @@ -2219,7 +2219,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  	unsigned long addr, len, end;
>  	int nr = 0, ret = 0;
>  
> -	start &= PAGE_MASK;
> +	start = untagged_addr(start) & PAGE_MASK;
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
> 
