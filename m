From: Rob Herring <robh@kernel.org>
Date: Mon, 03 Dec 2018 16:27:02 +0000
Subject: Re: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
Message-Id: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rppt@linux.ibm.com
Cc: mhocko@suse.com, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org, dalias@libc.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, deanbo422@gmail.com, jonas@southpole.se, linux-c6x-dev@linux-c6x.org, ysato@users.sourceforge.jp, Michael Ellerman <mpe@ellerman.id.au>, linux@armlinux.org.uk, msalter@redhat.com, Arnd Bergmann <arnd@arndb.de>, stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, shorne@gmail.com, gxt@pku.edu.cn, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Mon, Dec 3, 2018 at 9:48 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
> oneliner wrappers for memblock_alloc.
>
> Replace their usage with direct call to memblock_alloc.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/mmu.c       | 11 +++--------
>  arch/unicore32/mm/mmu.c | 12 ++++--------
>  2 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 0a04c9a5..57de0dd 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
>
>  #define vectors_base() (vectors_high() ? 0xffff0000 : 0)
>
> -static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> -{
> -       return memblock_alloc(sz, align);
> -}
> -
>  static void __init *early_alloc(unsigned long sz)

Why not get rid of this wrapper like you do on unicore?

>  {
> -       return early_alloc_aligned(sz, sz);
> +       return memblock_alloc(sz, sz);
>  }
