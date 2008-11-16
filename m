From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 16 Nov 2008 22:25:57 +0000
Subject: Re: [PATCH] sparc,sparc64: unify Kconfig
Message-Id: <20081116222557.GA20252@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 16, 2008 at 09:56:57AM +0100, Sam Ravnborg wrote:
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
>  
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-32)"
> -	range 2 32
> +	int "Maximum number of CPUs"
> +	range 2 32 if SPARC32
> +	range 2 1024 if SPARC64
>  	depends on SMP
> -	default "32"
> +	default "2" if SPARC32
> +	default "64" if SPARC64

Did you really intend to decrease the sparc32 default to 2 during the merge?
Just wondering...

-- 
     2. That which causes joy or happiness.
