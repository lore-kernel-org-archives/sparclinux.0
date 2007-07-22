From: David Miller <davem@davemloft.net>
Date: Sun, 22 Jul 2007 02:10:19 +0000
Subject: Re: [PATCH] constify of_platform_driver name
Message-Id: <20070721.191019.28395100.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070722002303.df29f666.sfr@canb.auug.org.au>
In-Reply-To: <20070722002303.df29f666.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, linuxppc-dev@ozlabs.org, paulus@samba.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 22 Jul 2007 00:23:03 +1000

> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/pcmcia/m8xx_pcmcia.c |    2 +-
>  include/linux/of_platform.h  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Built for PowerPC allmodconfig and ppc64_defconfig, and for Sparc and
> Sparc64 defconfig.

Acked-by: David S. Miller <davem@davemloft.net>
