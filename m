From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Mar 2015 19:47:08 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <CA+55aFwEq09vwnxPEYr67O7nuOEN9_n-uJKX11qSbuBNGJVghg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFwyuVWHMq_oc_hfwWcu6RaPGSifXD9-adX2_TOa-L+PHA@mail.gmail.com>
	<550DAE23.7030000@oracle.com>
	<CA+55aFwXmDom=GKE=K2QVqp_RUtOPQ0v5kCArATqQEKUOZ6OrA@mail.gmail.com>
	<20150322.133603.471287558426791155.davem@davemloft.net>
In-Reply-To: <20150322.133603.471287558426791155.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, sparclinux@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Mar 22, 2015 at 10:36 AM, David Miller <davem@davemloft.net> wrote:
>
> And they end up using that byte-at-a-time code, since SLAB and SLUB
> do mmemove() calls of the form:
>
>         memmove(X + N, X, LEN);

Actually, the common case in slab is overlapping but of the form

     memmove(p, p+x, len);

which goes to memcpy. It's basically re-compacting the array at the beginning.

Which was why I was asking how sure you are that memcpy *always*
copies from low to high.

I don't even know which version of memcpy ends up being used on M7.
Some of them do things like use VIS. I can follow some regular sparc
asm, there's no way I'm even *looking* at that. Is it really ok to use
VIS registers in random contexts?

                           Linus
