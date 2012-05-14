From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 14 May 2012 07:48:44 +0000
Subject: Re: [PATCH] sparc: Kill mmu_{un,}lockarea().
Message-Id: <20120514074844.GA8908@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.162832.471802901712883558.davem@davemloft.net>
In-Reply-To: <20120513.162832.471802901712883558.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 13, 2012 at 04:28:32PM -0400, David Miller wrote:
> --- a/arch/sparc/include/asm/floppy_64.h
> +++ b/arch/sparc/include/asm/floppy_64.h
> @@ -194,7 +191,7 @@ static void sun_fd_set_dma_count(int length)
>  
>  static void sun_fd_enable_dma(void)
>  {
> -	pdma_vaddr = mmu_lockarea(pdma_vaddr, pdma_size);
> +	pdma_vaddr = pdma_vaddr;

> -#define mmu_lockarea(vaddr, len)		(vaddr)

Drop the first changed line entirely? I see it was effectively there before,
but still :)

-- 
     2. That which causes joy or happiness.
