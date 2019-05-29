From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 29 May 2019 08:19:56 +0000
Subject: Re: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
Message-Id: <CAHkRjk5ChgbYGXCRG3ob3iCuggC3MVYqeJNNm+nnt6rCqo+b0Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de> <20190525133203.25853-5-hch@lst.de>
In-Reply-To: <20190525133203.25853-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Christoph,

On Sat, 25 May 2019 at 14:33, Christoph Hellwig <hch@lst.de> wrote:
> diff --git a/mm/gup.c b/mm/gup.c
> index f173fcbaf1b2..1c21ecfbf38b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2117,6 +2117,10 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
>         } while (pgdp++, addr = next, addr != end);
>  }
>
> +#ifndef gup_fixup_start_addr
> +#define gup_fixup_start_addr(start)    (start)
> +#endif

As you pointed out in a subsequent reply, we could use the
untagged_addr() macro from Andrey (or a shorter "untag_addr" if you
want it to look like a verb).

>  #ifndef gup_fast_permitted
>  /*
>   * Check if it's allowed to use __get_user_pages_fast() for the range, or
> @@ -2145,7 +2149,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>         unsigned long flags;
>         int nr = 0;
>
> -       start &= PAGE_MASK;
> +       start = gup_fixup_start_addr(start) & PAGE_MASK;
>         len = (unsigned long) nr_pages << PAGE_SHIFT;
>         end = start + len;
>
> @@ -2218,7 +2222,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>         unsigned long addr, len, end;
>         int nr = 0, ret = 0;
>
> -       start &= PAGE_MASK;
> +       start = gup_fixup_start_addr(start) & PAGE_MASK;
>         addr = start;
>         len = (unsigned long) nr_pages << PAGE_SHIFT;
>         end = start + len;

In Andrey's patch [1] we don't fix __get_user_pages_fast(), only
__get_user_pages() as it needs to do a find_vma() search. I wonder
whether this is actually necessary for the *_fast() versions. If the
top byte is non-zero (i.e. tagged address), 'end' would also have the
same tag. The page table macros like pgd_index() and pgd_addr_end()
already take care of masking out the top bits (at least for arm64)
since they need to work on kernel address with the top bits all 1. So
gup_pgd_range() should cope with tagged addresses already.

[1] https://lore.kernel.org/lkml/d234cd71774f35229bdfc0a793c34d6712b73093.1557160186.git.andreyknvl@google.com/

-- 
Catalin
