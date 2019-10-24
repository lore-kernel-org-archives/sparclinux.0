From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 24 Oct 2019 05:35:34 +0000
Subject: Re: [PATCH 04/12] m68k: nommu: use pgtable-nopud instead of 4level-fixup
Message-Id: <20191024053533.GA12281@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-5-git-send-email-rppt@kernel.org>
 <de03a882-fb1a-455c-7c60-84ab0c4f9674@linux-m68k.org>
In-Reply-To: <de03a882-fb1a-455c-7c60-84ab0c4f9674@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org

Hi Greg,

On Thu, Oct 24, 2019 at 02:09:01PM +1000, Greg Ungerer wrote:
> Hi Mike,
> 
> On 23/10/19 7:28 pm, Mike Rapoport wrote:
> >From: Mike Rapoport <rppt@linux.ibm.com>
> >
> >The generic nommu implementation of page table manipulation takes care of
> >folding of the upper levels and does not require fixups.
> >
> >Simply replace of include/asm-generic/4level-fixup.h with
> >include/asm-generic/pgtable-nopud.h.
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/m68k/include/asm/pgtable_no.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
> >index c18165b..ccc4568 100644
> >--- a/arch/m68k/include/asm/pgtable_no.h
> >+++ b/arch/m68k/include/asm/pgtable_no.h
> >@@ -2,7 +2,7 @@
> >  #ifndef _M68KNOMMU_PGTABLE_H
> >  #define _M68KNOMMU_PGTABLE_H
> >-#include <asm-generic/4level-fixup.h>
> >+#include <asm-generic/pgtable-nopud.h>
> >  /*
> >   * (C) Copyright 2000-2002, Greg Ungerer <gerg@snapgear.com>
> 
> This fails to compile for me (targeting m5208evb_defconfig):
> 
>   CC      init/main.o
> In file included from ./arch/m68k/include/asm/pgtable_no.h:56:0,
>                  from ./arch/m68k/include/asm/pgtable.h:3,
>                  from ./include/linux/mm.h:99,
>                  from ./include/linux/ring_buffer.h:5,
>                  from ./include/linux/trace_events.h:6,
>                  from ./include/trace/syscall.h:7,
>                  from ./include/linux/syscalls.h:85,
>                  from init/main.c:21:
> ./include/asm-generic/pgtable.h:738:34: error: unknown type name ‘pmd_t’
>  static inline int pmd_soft_dirty(pmd_t pmd)
>                                   ^

...

> scripts/Makefile.build:265: recipe for target 'init/main.o' failed
> make[1]: *** [init/main.o] Error 1
> Makefile:1649: recipe for target 'init' failed
> make: *** [init] Error 2

The hunk below fixes the build.

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index c00b67a..05e1e1e 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -21,7 +21,7 @@
 /*
  * These are used to make use of C type-checking..
  */
-#if CONFIG_PGTABLE_LEVELS = 3
+#if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS = 3
 typedef struct { unsigned long pmd[16]; } pmd_t;
 #define pmd_val(x)	((&x)->pmd[0])
 #define __pmd(x)	((pmd_t) { { (x) }, })
 
> Regards
> Greg
> 

-- 
Sincerely yours,
Mike.
