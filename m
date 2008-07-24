From: Johannes Weiner <hannes@saeurebad.de>
Date: Thu, 24 Jul 2008 21:32:06 +0000
Subject: Re: [Bug 11046] New: Kernel bug in mm/bootmem.c on Sparc machines
Message-Id: <873alz55pl.fsf@saeurebad.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080706132049.4019e09f.akpm@linux-foundation.org>
	<20080723.202533.114601491.davem@davemloft.net>
	<20080723203836.e0c14568.akpm@linux-foundation.org>
	<20080723.204247.114065226.davem@davemloft.net>
In-Reply-To: <20080723.204247.114065226.davem@davemloft.net> (David Miller's
	message of "Wed, 23 Jul 2008 20:42:47 -0700 (PDT)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, lomp0101@gmx.net, linux-kernel@vger.kernel.org

Hi,

David Miller <davem@davemloft.net> writes:

> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Wed, 23 Jul 2008 20:38:36 -0700
>
>> So if we're going to change it in 2.6.26, we'll need a separate patch.
>
> Here is the 2.6.26 version:
>
> bootmem: Allow zero length reserve and free.
>
> It's either this or all the call sites explicitly check
> when such a case is possible and sometimes expected.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/mm/bootmem.c b/mm/bootmem.c
> index 8d9f60e..e540f7a 100644
> --- a/mm/bootmem.c
> +++ b/mm/bootmem.c
> @@ -153,7 +153,8 @@ static void __init reserve_bootmem_core(bootmem_data_t *bdata,
>  	unsigned long sidx, eidx;
>  	unsigned long i;
>  
> -	BUG_ON(!size);
> +	if (!size)
> +		return;
>  
>  	/* out of range */
>  	if (addr + size < bdata->node_boot_start ||
> @@ -187,7 +188,8 @@ static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
>  	unsigned long sidx, eidx;
>  	unsigned long i;
>  
> -	BUG_ON(!size);
> +	if (!size)
> +		return;
>  
>  	/* out range */
>  	if (addr + size < bdata->node_boot_start ||

Sorry, Dave, I missed that before: there is still the BUG_ON() in
can_reserve_bootmem_core(), which should just return 0 instead.

Other than that, yes, Andrew, this introduces the same behaviour the
bootmem rewrite.

	Hannes
