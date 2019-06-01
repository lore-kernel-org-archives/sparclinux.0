From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 01 Jun 2019 16:14:17 +0000
Subject: Re: [PATCH 03/16] mm: simplify gup_fast_permitted
Message-Id: <CAHk-=whusWKhS=SYoC9f9HjVmPvR5uP51Mq=ZCtktqTBT2qiBw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-4-hch@lst.de>
In-Reply-To: <20190601074959.14036-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Sat, Jun 1, 2019 at 12:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Pass in the already calculated end value instead of recomputing it, and
> leave the end > start check in the callers instead of duplicating them
> in the arch code.

Good cleanup, except it's wrong.

> -       if (nr_pages <= 0)
> +       if (end < start)
>                 return 0;

You moved the overflow test to generic code - good.

You removed the sign and zero test on nr_pages - bad.

The zero test in particular is _important_ - the GUP range operators
know and depend on the fact that they are passed a non-empty range.

The sign test it less so, but is definitely appropriate. It might be
even better to check that the "<< PAGE_SHIFT" doesn't overflow in
"long", of course, but with callers being supposed to be trusted, the
sign test at least checks for stupid underflow issues.

So at the very least that "(end < start)" needs to be "(end <start)", but honestly, I think the sign of the nr_pages should be
continued to be checked.

                      Linus
