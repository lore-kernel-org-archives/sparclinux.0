From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2014 08:41:23 +0000
Subject: Re: [PATCH] sparc32: make copy_to/from_user_page() usable from modular code
Message-Id: <CAMuHMdUNvSahqcHPo9eO44d6opQXTvQq_HbUbFM2qhXTOj7LJQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1392326101-20388-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1392326101-20388-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Feb 13, 2014 at 10:15 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> While copy_to/from_user_page() users are uncommon, there is one in
> drivers/staging/lustre/lustre/libcfs/linux/linux-curproc.c which leads
> to the following:
>
> ERROR: "sparc32_cachetlb_ops" [drivers/staging/lustre/lustre/libcfs/libcf=
s.ko] undefined!
>
> during routine allmodconfig build coverage.  The reason this happens
> is as follows:
>
> In arch/sparc/include/asm/cacheflush_32.h we have:
>
>  #define flush_cache_page(vma,addr,pfn) \
>         sparc32_cachetlb_ops->cache_page(vma, addr)
>
>  #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
>         do {                                                    \
>                 flush_cache_page(vma, vaddr, page_to_pfn(page));\
>                 memcpy(dst, src, len);                          \
>         } while (0)
>  #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
>         do {                                                    \
>                 flush_cache_page(vma, vaddr, page_to_pfn(page));\
>                 memcpy(dst, src, len);                          \
>         } while (0)
>
> However, sparc32_cachetlb_ops isn't exported and hence the error.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Sorry for only noticing now. A similar fix for pa-risc was reverted:

"Christoph Hellwig <hch@infradead.org> commented:
 This one shouldn't go in - Geert sent it a bit prematurely, as Lustre
 shouldn't use it just to reimplement core VM functionality (which it
 shouldn't use either, but that's a separate story)."

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=A446e72bc15c7bfd2c953e56064ace3566c79b0e

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
