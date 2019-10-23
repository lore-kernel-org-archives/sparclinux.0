From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Wed, 23 Oct 2019 10:20:29 +0000
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Message-Id: <70339cfc547e2fa0f6b98fefb1b1a9fa@sf-tec.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-9-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-9-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.>

> diff --git a/arch/parisc/include/asm/page.h 
> b/arch/parisc/include/asm/page.h
> index 93caf17..1d339ee 100644
> --- a/arch/parisc/include/asm/page.h
> +++ b/arch/parisc/include/asm/page.h
> @@ -42,48 +42,54 @@ typedef struct { unsigned long pte; } pte_t; /*
> either 32 or 64bit */
> 
>  /* NOTE: even on 64 bits, these entries are __u32 because we allocate
>   * the pmd and pgd in ZONE_DMA (i.e. under 4GB) */
> -typedef struct { __u32 pmd; } pmd_t;
>  typedef struct { __u32 pgd; } pgd_t;
>  typedef struct { unsigned long pgprot; } pgprot_t;
> 
> -#define pte_val(x)	((x).pte)
> -/* These do not work lvalues, so make sure we don't use them as such. 
> */
> +#if CONFIG_PGTABLE_LEVELS = 3
> +typedef struct { __u32 pmd; } pmd_t;
> +#define __pmd(x)	((pmd_t) { (x) } )
> +/* pXd_val() do not work lvalues, so make sure we don't use them as 
> such. */

For me it sounds like there is something missing, maybe an "as" before 
lvalues?
And it was "These", so plural, and now it is singular, so do -> does?

Eike
