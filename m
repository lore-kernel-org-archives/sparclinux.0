From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 01 Dec 2009 18:21:16 +0000
Subject: Re: [PATCH 3/4] Don't call idprom_init() on LEON
Message-Id: <20091201182116.GC25617@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1259679176-29835-3-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1259679176-29835-3-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 01, 2009 at 03:52:55PM +0100, Kristoffer Glembo wrote:
> LEON does not have an idprom and idprom_init prints 
> some bogus info (e.g. incorrect Ethernet address).
> 
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
> ---
>  arch/sparc/kernel/setup_32.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 9be2af5..1d3cf56 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -271,7 +271,10 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  	boot_flags_init(*cmdline_p);
>  
> +#ifndef CONFIG_SPARC_LEON
>  	idprom_init();
> +#endif
> +
>  	if (ARCH_SUN4C)
>  		sun4c_probe_vac();
>  	load_mmu();

I suggest to drop all idprom support in case of
leon and then use stub functions so you do not
need ifdef like above.

	Sam
