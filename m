From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 04 Jan 2005 19:11:05 +0000
Subject: Re: [5/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <20050104191105.GN2708@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41DAE8BB.7050501@gaisler.com>
In-Reply-To: <41DAE8BB.7050501@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:04:27PM +0100, Jiri Gaisler wrote:
> Leon3 serial+ethermac driver:
> [5/7] diff2.6.10_arch_sparc_Kocnfig.diff  diff for arch/sparc/Kconfig
> --- ../linux-2.6.10-driver/arch/sparc/Kconfig	2005-01-03 18:03:49.000000000 +0100
> +++ linux-2.6.10/arch/sparc/Kconfig	2005-01-03 18:01:44.000000000 +0100
> @@ -239,12 +239,6 @@
>  	  Say Y here if you are running on a Leon3 from grlib
>  	  (download from www.gaisler.com). 
>  
> -if LEON_3
> -
> -source "drivers/amba/Kconfig"
> -
> -endif
> -
>  endif

This one is a bit unusual. It doesn't seem to have been added by a
previous patch. The intended effect may have been something else. Were
there supposed to be drivers in this patch?


-- wli
