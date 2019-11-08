From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 08 Nov 2019 19:39:17 +0000
Subject: Re: [PATCH v4 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
Message-Id: <20191108113917.a9c6ebb8373cc95fd684b734@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
        <1572938135-31886-6-git-send-email-rppt@kernel.org>
In-Reply-To: <1572938135-31886-6-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vi

On Tue,  5 Nov 2019 09:15:27 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> m68k has two or three levels of page tables and can use appropriate
> pgtable-nopXd and folding of the upper layers.
> 
> Replace usage of include/asm-generic/4level-fixup.h and explicit
> definitions of __PAGETABLE_PxD_FOLDED in m68k with
> include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> adjust page table manipulation macros and functions accordingly.

This one was messed up by linux-next changes in arch/m68k/mm/kmap.c. 
Can you please take a look?
