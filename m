From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 06 Nov 2019 01:13:09 +0000
Subject: Re: [PATCH v4 13/13] mm: remove __ARCH_HAS_4LEVEL_HACK and include/asm-generic/4level-fixup.h
Message-Id: <20191105171309.9a5ccf9cf14d7288f7adf198@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
        <1572938135-31886-14-git-send-email-rppt@kernel.org>
In-Reply-To: <1572938135-31886-14-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vi

On Tue,  5 Nov 2019 09:15:35 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> There are no architectures that use include/asm-generic/4level-fixup.h
> therefore it can be removed along with __ARCH_HAS_4LEVEL_HACK define.

Conflicts a bit with Vineet's "asm-generic/tlb: stub out pud_free_tlb()
if nopud ...", from
http://lkml.kernel.org/r/20191016162400.14796-2-vgupta@synopsys.com

I fixed it up by removing include/asm-generic/4level-fixup.h anyway and
removing the removal of "#ifndef __ARCH_HAS_4LEVEL_HAC" from
include/asm-generic/tlb.h.
