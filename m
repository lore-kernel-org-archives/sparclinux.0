From: Benoit Boissinot <bboissin@gmail.com>
Date: Fri, 05 Aug 2005 19:18:38 +0000
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Message-Id: <40f323d00508051218c30d7af@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050708150313.GA30373@suse.de>
	 <40f323d005080511516a81a7d6@mail.gmail.com>
	 <20050805190006.GA6747@suse.de>
In-Reply-To: <20050805190006.GA6747@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 8/5/05, Olaf Hering <olh@suse.de> wrote:
>  On Fri, Aug 05, Benoit Boissinot wrote:
> 
> > On 7/8/05, Olaf Hering <olh@suse.de> wrote:
> > >
> > > In file included from include2/asm/tlb.h:31,
> > >                  from linux-2.6.13-rc2-olh/arch/ppc64/kernel/pSeries_lpar.c:37:
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:77: warning: implicit declaration of function `release_pages'
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_remove_page':
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:117: warning: implicit declaration of function `page_cache_release'
> > >
> > This went in 2.6.13-rc3 (commit
> > 542d1c88bd7f73e2e59d41b12e4a9041deea89e4), and broke sparc compilation
> > because of the following circular dependency:
> > asm-sparc/pgtable include linux/swap.h
> 
> Why does it need swap.h? Do the users of pgtable.h rely on swap.h?
> 
sparc is the only architecture to do that, it looks like it uses it
for boot time linking (BTFIXUP_*). I don't know anything about sparc,
so i can't fix it.

(adding sparclinux@vger.kernel.org to the cc list)
