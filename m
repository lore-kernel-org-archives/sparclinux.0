From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 03 Dec 2015 20:38:10 +0000
Subject: Re: [V2 PATCH] sparc64/gup: check address scope legitimacy
Message-Id: <20151203203809.GA15235@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1448490684-17171-1-git-send-email-yang.shi@linaro.org>
 <1448491543-17946-1-git-send-email-yang.shi@linaro.org>
In-Reply-To: <1448491543-17946-1-git-send-email-yang.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yang Shi <yang.shi@linaro.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linaro-kernel@lists.linaro.org

Hi Yang.

On Wed, Nov 25, 2015 at 02:45:43PM -0800, Yang Shi wrote:
> Check if user address is accessible in atomic version __get_user_pages_fast()
> before walking the page table.
> And, check if end > start in get_user_pages_fast(), otherwise fallback to slow
> path.

Two different but related things in one patch is often a bad thing.
It would have been better to split it up.


> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
> Just found slow_irqon label is not defined, added it to avoid compile error.
> 
>  arch/sparc/mm/gup.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
> index 2e5c4fc..cf4fb47 100644
> --- a/arch/sparc/mm/gup.c
> +++ b/arch/sparc/mm/gup.c
> @@ -173,6 +173,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
> +	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
> +					(void __user *)start, len)))
> +		return 0;
This change is not justified.
Why would we take the time to first do the access_ok() stuff.
If this had been an expensive operation then we had made this function
slower in the normal case ( assuming there were no access violations in the
normal case).
When I look at the implementation of access_ok() I get the impression that
this is not really a check we need.

access_ok() always returns 1.


>  
>  	local_irq_save(flags);
>  	pgdp = pgd_offset(mm, addr);
> @@ -203,6 +206,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
> +	if (end < start)
> +		goto slow_irqon;

end can only be smaller than start if there is some overflow.
See how end is calculated just the line above.

This looks like a highly suspicious change.

	Sam
