From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 24 Oct 2019 08:51:24 +0000
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Message-Id: <20191024085123.GB12281@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-9-git-send-email-rppt@kernel.org>
 <70339cfc547e2fa0f6b98fefb1b1a9fa@sf-tec.de>
In-Reply-To: <70339cfc547e2fa0f6b98fefb1b1a9fa@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-parisc-owner@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, linux-arm-kernel@lists.infr

On Wed, Oct 23, 2019 at 12:20:29PM +0200, Rolf Eike Beer wrote:
> >diff --git a/arch/parisc/include/asm/page.h
> >b/arch/parisc/include/asm/page.h
> >index 93caf17..1d339ee 100644
> >--- a/arch/parisc/include/asm/page.h
> >+++ b/arch/parisc/include/asm/page.h
> >@@ -42,48 +42,54 @@ typedef struct { unsigned long pte; } pte_t; /*
> >either 32 or 64bit */
> >
> > /* NOTE: even on 64 bits, these entries are __u32 because we allocate
> >  * the pmd and pgd in ZONE_DMA (i.e. under 4GB) */
> >-typedef struct { __u32 pmd; } pmd_t;
> > typedef struct { __u32 pgd; } pgd_t;
> > typedef struct { unsigned long pgprot; } pgprot_t;
> >
> >-#define pte_val(x)	((x).pte)
> >-/* These do not work lvalues, so make sure we don't use them as such. */
> >+#if CONFIG_PGTABLE_LEVELS = 3
> >+typedef struct { __u32 pmd; } pmd_t;
> >+#define __pmd(x)	((pmd_t) { (x) } )
> >+/* pXd_val() do not work lvalues, so make sure we don't use them as such.
> >*/
> 
> For me it sounds like there is something missing, maybe an "as" before
> lvalues?

Right, "as lvalues" makes sense.

> And it was "These", so plural, and now it is singular, so do -> does?

There's also pgd_val() a few lines below, it's just not visible in the
patch.
 
> Eike

-- 
Sincerely yours,
Mike.
