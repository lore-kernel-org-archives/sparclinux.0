From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2019 00:17:16 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org> <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
 <20190717233031.GB30369@altlinux.org>
In-Reply-To: <20190717233031.GB30369@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Christoph Hellwig <hch@lst.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Wed, Jul 17, 2019 at 4:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> Sure, here it is:

Hmm. I'm not seeing anything obviously wrong in the generic gup conversion.

From the oops, I assume that the problem is that get_user_pages_fast()
returned an invalid page, causing the bad access later in
get_futex_key(). But that's odd too, considering that
get_user_pages_fast() had already accessed the page (both for looking
up the head, and for then doing things like SetPageReferenced(page)).

The only half-way subtle thing is the pte_access_permitted() movement,
but it looks like it matches what gup_pte_range() did in the original
sparc64 code. And the address masking is done the same way too, as far
as I can tell.

So clearly there's something wrong there, but I'm not seeing it. Maybe
I'm incorrectly looking at that pte case, and the problem happened
earlier.

Anyway, I suspect some sparc64 person needs to delve into it.

I know this got reviewed by sparc64 people (the final commit message
only has a single Reviewed-by, but I see an Ack by Davem in my maill
that seems to have gotten lost by the time the patch made it in), but
maybe actually nobody ever _tested_ it until it hit my tree?

                   Linus
