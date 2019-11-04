From: Mike Rapoport <rppt@kernel.org>
Date: Mon, 04 Nov 2019 10:02:22 +0000
Subject: Re: [PATCH v3 13/13] mm: remove __ARCH_HAS_4LEVEL_HACK and include/asm-generic/4level-fixup.h
Message-Id: <20191104100221.GC23288@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-14-git-send-email-rppt@kernel.org>
 <CAK8P3a3e7oG5NMPbhgQOoKvB0Z5ui0iAHHFqyAxy87Nd903Vmw@mail.gmail.com>
In-Reply-To: <CAK8P3a3e7oG5NMPbhgQOoKvB0Z5ui0iAHHFqyAxy87Nd903Vmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam

On Mon, Nov 04, 2019 at 10:11:51AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 4, 2019 at 7:58 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > There are no architectures that use include/asm-generic/4level-fixup.h
> > therefore it can be removed along with __ARCH_HAS_4LEVEL_HACK define.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> For asm-generic:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Have you discussed how the series should get merged? I assume an initial
> set of patches can just go through architecture maintainer trees, but
> whatever patches don't get picked up that way would go through either
> Andrew's -mm tree (for memory management) or my asm-generic tree
> (for cross-architecture cleanups).

I thought that the entire set could go via -mm or asm-generic, but if
architecture maintainers would prefer to pick relevant patches to the arch
trees, I'll resend the rest afterwards.
 
> Since there is still at least one regression, I expect not to do anything
> for now. Please let me know when/if you expect me to merge the
> remaining patches.

Sure, thanks!

>       Arnd

-- 
Sincerely yours,
Mike.
