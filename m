From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Nov 2019 09:53:37 +0000
Subject: Re: [PATCH v3 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
Message-Id: <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-6-git-send-email-rppt@kernel.org> <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
 <20191104094748.GB23288@rapoport-lnx>
In-Reply-To: <20191104094748.GB23288@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sam>

Hi Mike,

On Mon, Nov 4, 2019 at 10:48 AM Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Nov 04, 2019 at 09:53:34AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Nov 4, 2019 at 7:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > m68k has two or three levels of page tables and can use appropriate
> > > pgtable-nopXd and folding of the upper layers.
> > >
> > > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > > definitions of __PAGETABLE_PxD_FOLDED in m68k with
> > > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > > include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> > > adjust page table manipulation macros and functions accordingly.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> >
> > Thanks for your patch!
> >
> > The build error reported for v1 by kbuild test robot when building for
> > sun3x is still there (m68k defconfig or sun3x_defconfig):
> >
> >     arch/m68k/sun3x/dvma.c: In function ‘dvma_map_cpu’:
> >     arch/m68k/sun3x/dvma.c:98:33: error: passing argument 2 of
> > ‘pmd_alloc’ from incompatible pointer type
> > [-Werror=incompatible-pointer-types]
> >        if((pmd = pmd_alloc(&init_mm, pgd, vaddr)) = NULL) {
> >                                      ^~~
> >     In file included from arch/m68k/sun3x/dvma.c:17:
> >     include/linux/mm.h:1875:61: note: expected ‘pud_t *’ {aka ‘struct
> > <anonymous> *’} but argument is of type ‘pgd_t *’ {aka ‘struct
> > <anonymous> *’}
> >      static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud,
> > unsigned long address)
> >                                                           ~~~~~~~^~~
>
> The initial report was against older mmotm (base:
> git://git.cmpxchg.org/linux-mmotm.git master) and I presumed this was the
> cause of the error. Will fix in v4.

OK, thanks!

My tree is based on m68k/master, which does not include the mmotm tree,
and should be fairly similar to plain v5.4-rc6.

> > This indeed boots fine on ARAnyM, which emulates on 68040.
> > It would be good to have some boot testing on '020/030, too.
>
> To be honest, I have no idea how to to that :)

Sure. This was more a request for the fellow m68k users.
But don't worry too much about it.  If it breaks '020/'030, we can fix
that later.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
