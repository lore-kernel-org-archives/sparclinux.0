From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 01 Nov 2019 09:11:57 +0000
Subject: Re: [PATCH v2 01/13] alpha: use pgtable-nop4d instead of 4level-fixup
Message-Id: <20191101091157.q4cesn6vsiy5qj2j@box>
List-Id: <sparclinux.vger.kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org>
 <1572597584-6390-2-git-send-email-rppt@kernel.org>
In-Reply-To: <1572597584-6390-2-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, sparclinux@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>, Vincent Chen <deanbo422@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>

On Fri, Nov 01, 2019 at 10:39:32AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> It is not likely alpha will have 5-level page tables.
> 
> Replace usage of include/asm-generic/4level-fixup.h and implied
> __ARCH_HAS_4LEVEL_HACK with include/asm-generic/pgtable-nop4d.h and adjust
> page table manipulation macros and functions accordingly.

Not pgtable-nop4d.h, but pgtable-nopud.h. Also in subject.

-- 
 Kirill A. Shutemov
