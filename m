From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Nov 2019 08:35:31 +0000
Subject: Re: [PATCH v4 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
Message-Id: <CAMuHMdXqaw_k=XiY0RYvvR+smE-5tbTBzWiAZOFev731vR3q3A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org> <1572938135-31886-6-git-send-email-rppt@kernel.org>
In-Reply-To: <1572938135-31886-6-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sam>

Hi Mike,

On Tue, Nov 5, 2019 at 8:16 AM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> m68k has two or three levels of page tables and can use appropriate
> pgtable-nopXd and folding of the upper layers.
>
> Replace usage of include/asm-generic/4level-fixup.h and explicit
> definitions of __PAGETABLE_PxD_FOLDED in m68k with
> include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> adjust page table manipulation macros and functions accordingly.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

One forgotten error message update below.

> --- a/arch/m68k/mm/kmap.c
> +++ b/arch/m68k/mm/kmap.c
> @@ -258,18 +265,23 @@ void __iounmap(void *addr, unsigned long size)
>  {
>         unsigned long virtaddr = (unsigned long)addr;
>         pgd_t *pgd_dir;
> +       p4d_t *p4d_dir;
> +       pud_t *pud_dir;
>         pmd_t *pmd_dir;
>         pte_t *pte_dir;
>
>         while ((long)size > 0) {
>                 pgd_dir = pgd_offset_k(virtaddr);
> -               if (pgd_bad(*pgd_dir)) {
> -                       printk("iounmap: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
> -                       pgd_clear(pgd_dir);
> +               p4d_dir = p4d_offset(pgd_dir, virtaddr);
> +               pud_dir = pud_offset(p4d_dir, virtaddr);
> +               if (pud_bad(*pud_dir)) {
> +                       printk("iounmap: bad pgd(%08lx)\n", pud_val(*pud_dir));

bad pud

> +                       pud_clear(pud_dir);
>                         return;
>                 }
> -               pmd_dir = pmd_offset(pgd_dir, virtaddr);
> +               pmd_dir = pmd_offset(pud_dir, virtaddr);
>
> +#if CONFIG_PGTABLE_LEVELS = 3
>                 if (CPU_IS_020_OR_030) {
>                         int pmd_off = (virtaddr/PTRTREESIZE) & 15;
>                         int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
