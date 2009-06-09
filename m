From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 09 Jun 2009 20:15:08 +0000
Subject: Re: [PATCH 6/7] Handle sparc-leon SRMMU specific bug
Message-Id: <20090609201508.GJ7181@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45EA.5040705@gaisler.com>
In-Reply-To: <4A2E45EA.5040705@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 09, 2009 at 01:22:18PM +0200, Konrad Eisele wrote:
> From f95779d3a4d478d9df1070cc54a42163993f3b97 Mon Sep 17 00:00:00 2001
> From: Konrad Eisele <konrad@gaisler.com>
> Date: Tue, 9 Jun 2009 13:05:17 +0200
> Subject: [PATCH 6/7] Handle sparc-leon SRMMU specific bug. Shielded by 
> CONFIG_LEON.
> 
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
> ---
>  arch/sparc/mm/fault_32.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 12e447f..602eb82 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -227,7 +227,11 @@ asmlinkage void do_sparc_fault(struct pt
>  	 */
>  good_area:
>  	info.si_code = SEGV_ACCERR;
> -	if(write) {
> +	if (write
> +#ifdef CONFIG_LEON
> +	   && !text_fault
> +#endif
> +	   ) {
>  		if(!(vma->vm_flags & VM_WRITE))
>  			goto bad_area;
>  	} else {

We do not break up an if like this.
And you need to comment on this.
Consider using an inline helper function or similar to avoid
obscufating the code.

	Sam
