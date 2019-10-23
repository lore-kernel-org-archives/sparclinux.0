From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2019 10:25:48 +0000
Subject: Re: [PATCH 00/12] mm: remove __ARCH_HAS_4LEVEL_HACK
Message-Id: <CAHk-=whd6wNfx2bq7BmN4ouZgt=NQ5pw+3uqPOTbvz_Qb3itFg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gu>

On Wed, Oct 23, 2019 at 5:29 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_4LEVEL_HACK along with include/asm-generic/4level-fixup.h.

Thanks for doing this.

The patches look sane from a quick scan, and it's definitely the right
thing to do. So ack on my part, but obviously testing the different
architectures would be a really good thing...

                Linus
