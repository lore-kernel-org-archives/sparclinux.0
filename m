From: David Miller <davem@davemloft.net>
Date: Thu, 20 Feb 2014 00:50:17 +0000
Subject: Re: [PATCH] sparc32: make copy_to/from_user_page() usable from modular code
Message-Id: <20140219.195017.88959684259741556.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1392326101-20388-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1392326101-20388-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paul.gortmaker@windriver.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 13 Feb 2014 16:15:01 -0500

> While copy_to/from_user_page() users are uncommon, there is one in
> drivers/staging/lustre/lustre/libcfs/linux/linux-curproc.c which leads
> to the following:
> 
> ERROR: "sparc32_cachetlb_ops" [drivers/staging/lustre/lustre/libcfs/libcfs.ko] undefined!
> 
> during routine allmodconfig build coverage.  The reason this happens
> is as follows:
> 
> In arch/sparc/include/asm/cacheflush_32.h we have:
> 
>  #define flush_cache_page(vma,addr,pfn) \
>         sparc32_cachetlb_ops->cache_page(vma, addr)
> 
>  #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
>         do {                                                    \
>                 flush_cache_page(vma, vaddr, page_to_pfn(page));\
>                 memcpy(dst, src, len);                          \
>         } while (0)
>  #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
>         do {                                                    \
>                 flush_cache_page(vma, vaddr, page_to_pfn(page));\
>                 memcpy(dst, src, len);                          \
>         } while (0)
> 
> However, sparc32_cachetlb_ops isn't exported and hence the error.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Also applied.
