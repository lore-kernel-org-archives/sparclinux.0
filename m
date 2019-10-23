From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Date: Wed, 23 Oct 2019 09:40:25 +0000
Subject: Re: [PATCH 02/12] arm: nommu: use pgtable-nopud instead of 4level-fixup
Message-Id: <20191023094025.GY25745@shell.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-3-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-3-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gupta1@syno>

On Wed, Oct 23, 2019 at 12:28:51PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The generic nommu implementation of page table manipulation takes care of
> folding of the upper levels and does not require fixups.
> 
> Simply replace of include/asm-generic/4level-fixup.h with
> include/asm-generic/pgtable-nopud.h.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
>  arch/arm/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 3ae120c..eabcb48 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -12,7 +12,7 @@
>  
>  #ifndef CONFIG_MMU
>  
> -#include <asm-generic/4level-fixup.h>
> +#include <asm-generic/pgtable-nopud.h>
>  #include <asm/pgtable-nommu.h>
>  
>  #else
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
