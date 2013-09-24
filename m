From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 24 Sep 2013 21:28:53 +0000
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-Id: <20130924212853.GK12758@n2100.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
In-Reply-To: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Sep 24, 2013 at 02:23:31PM -0700, Timothy Pepper wrote:
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 0c63562..0e7355d 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/personality.h>
>  #include <linux/random.h>
> +#include <linux/security.h>
>  #include <asm/cachetype.h>
>  
>  #define COLOUR_ALIGN(addr,pgoff)		\
> @@ -146,7 +147,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

This looks sane for ARM.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
