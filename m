From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 27 May 2012 22:36:58 +0000
Subject: Re: [PATCH 2/4] sparc32,leon: always include leon_pmc in build
Message-Id: <20120527223658.GB509@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1338043409-6827-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1338043409-6827-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 26, 2012 at 04:43:27PM +0200, Sam Ravnborg wrote:
> @@ -65,13 +66,15 @@ void pmc_leon_idle(void)
>  /* Install LEON Power Down function */
>  static int __init leon_pmc_install(void)
>  {
> -	/* Assign power management IDLE handler */
> -	if (pmc_leon_need_fixup())
> -		pm_idle = pmc_leon_idle_fixup;
> -	else
> -		pm_idle = pmc_leon_idle;
> +	if (sparc_cpu_model = sparc_leon) {
> +		/* Assign power management IDLE handler */
> +		if (pmc_leon_need_fixup())
> +			pm_idle = pmc_leon_idle_fixup;
> +		else
> +			pm_idle = pmc_leon_idle;
>  
> -	printk(KERN_INFO "leon: power management initialized\n");
> +		printk(KERN_INFO "leon: power management initialized\n");
> +	}
>  
>  	return 0;
>  }

Why not simply invert the logic and save a level of indentation?

if (sparc_cpu_model != sparc_leon)
	return 0;

Possibly also return something like -EINVAL - but I don't know the caller's
MO offhand so the fake 0 might actually be better.

-- 
     2. That which causes joy or happiness.
