From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 07 Oct 2005 05:18:19 +0000
Subject: Re: [PATCH 2.6] Fix prom_getproperty calls
Message-Id: <20051006.221819.06813198.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1128605959.2140.131.camel@localhost.localdomain>
In-Reply-To: <1128605959.2140.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 06 Oct 2005 08:39:19 -0500

> --- linux-2.6.11/drivers/video/cg14.c.BAD	2005-03-04 02:01:59.732195963 -0500
> +++ linux-2.6.11/drivers/video/cg14.c	2005-03-04 02:02:50.616460379 -0500
> @@ -532,7 +532,8 @@ static void cg14_init_one(struct sbus_de
>  		all->info.screen_base = (char __iomem *)(unsigned long)bases[1];
>  	}
>  
> -	prom_getproperty(node, "reg", (char *) &bases[0], sizeof(bases));
> +	if(prom_getproperty(node, "reg", (char *) &bases[0], sizeof(bases)) <= 0)
> +		return;
>  	is_8mb = (bases[5] = 0x800000);
>  
>  	if (sizeof(all->par.mmap_map) != sizeof(__cg14_mmap_map)) {

Leaks memory... and bad coding style "if ()" not "if()" please.

sunffb.c, sunhme.c, arch/sparc64/prom/console.c,
and arch/m68k/sun3/prom/console.c all need the same
coding style fix.

Please fixup and resubmit, thanks.
