From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 30 Nov 2005 00:26:32 +0000
Subject: Re: CG3 frame buffer is broaken (2.6.12 onwards) again [PATCH]
Message-Id: <20051129.162632.02559568.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10511221501160.30262-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10511221501160.30262-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: adaplas@pol.net, wli@holomorphy.com, zippel@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org, kbuild-devel@lists.sourceforge.net

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 22 Nov 2005 15:17:04 +0000 (GMT)

>  config FB_FFB
>  	bool "Creator/Creator3D/Elite3D support"
>  	depends on FB_SBUS && SPARC64
> +	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	select FB_SOFT_CURSOR

Unnecessary, the ffb.c driver does accelerated fillrect, and
therefore does not references the cfb_fillrect software
rendering code.
