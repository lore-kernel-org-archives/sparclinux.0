From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2019 17:05:45 +0000
Subject: Re: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
Message-Id: <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de> <20190525133203.25853-5-hch@lst.de>
In-Reply-To: <20190525133203.25853-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Khalid Aziz <khalid.aziz@oracle.com>
Cc: Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

[ Adding Khalid, who added the sparc64 code ]

On Sat, May 25, 2019 at 6:32 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This will allow sparc64 to override its ADI tags for
> get_user_pages and get_user_pages_fast.  I have no idea why this
> is not required for plain old get_user_pages, but it keeps the
> existing sparc64 behavior.

This is actually generic. ARM64 has tagged pointers too. Right now the
system call interfaces are all supposed to mask off the tags, but
there's been noise about having the kernel understand them.

That said:

> +#ifndef gup_fixup_start_addr
> +#define gup_fixup_start_addr(start)    (start)
> +#endif

I'd rather name this much more specifically (ie make it very much
about "clean up pointer tags") and I'm also not clear on why sparc64
actually wants this. I thought the sparc64 rules were the same as the
(current) arm64 rules: any addresses passed to the kernel have to be
the non-tagged ones.

As you say, nothing *else* in the kernel does that address cleanup,
why should get_user_pages_fast() do it?

David? Khalid? Why does sparc64 actually need this? It looks like the
generic get_user_pages() doesn't do it.

                Linus
