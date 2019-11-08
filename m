From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Nov 2019 08:32:27 +0000
Subject: Re: [PATCH v3 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
Message-Id: <CAMuHMdVe-7=587nMWK_FcHzsm1TLckwTY9JxKHM_Gg8+ogZsgA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-6-git-send-email-rppt@kernel.org> <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
 <20191104094748.GB23288@rapoport-lnx> <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
 <3d908bbf-0469-c53b-dd86-87df98f40ee7@gmail.com>
In-Reply-To: <3d908bbf-0469-c53b-dd86-87df98f40ee7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>

Hi Michael,

On Fri, Nov 8, 2019 at 5:30 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 04.11.2019 um 22:53 schrieb Geert Uytterhoeven:
> >>> This indeed boots fine on ARAnyM, which emulates on 68040.
> >>> It would be good to have some boot testing on '020/030, too.
> >>
> >> To be honest, I have no idea how to to that :)
> >
> > Sure. This was more a request for the fellow m68k users.
> > But don't worry too much about it.  If it breaks '020/'030, we can fix
> > that later.
>
> Boots fine on 030, too.

Thanks a lot for testing!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
