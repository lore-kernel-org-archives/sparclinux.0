From: David Miller <davem@davemloft.net>
Date: Fri, 29 Jun 2007 04:25:42 +0000
Subject: Re: [PATCH] sparc64: add linux/pagemap.h to asm/tlb.h
Message-Id: <20070628.212542.36924510.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070628131448.GA8888@localhost.sw.ru>
In-Reply-To: <20070628131448.GA8888@localhost.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexey Dobriyan <adobriyan@sw.ru>
Date: Thu, 28 Jun 2007 17:14:48 +0400

> As seen on sparc64-allnoconfig:
> 
>   CC      arch/sparc64/mm/tlb.o
> In file included from arch/sparc64/mm/tlb.c:19:
> include/asm/tlb.h: In function 'tlb_flush_mmu':
> include/asm/tlb.h:60: warning: implicit declaration of function 'release_pages'
> include/asm/tlb.h: In function 'tlb_remove_page':
> include/asm/tlb.h:92: warning: implicit declaration of function 'page_cache_release'
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@sw.ru>

Patch applied, thanks a lot Alexey.
