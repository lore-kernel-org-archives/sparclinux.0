From: David Miller <davem@davemloft.net>
Date: Thu, 18 Jul 2019 21:43:36 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <20190718.144336.350349509076783997.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
	<20190717233031.GB30369@altlinux.org>
	<CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
In-Reply-To: <CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: ldv@altlinux.org, hch@lst.de, khalid.aziz@oracle.com, akpm@linux-foundation.org, matorola@gmail.com, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2019 17:17:16 -0700

> From the oops, I assume that the problem is that get_user_pages_fast()
> returned an invalid page, causing the bad access later in
> get_futex_key().

That's correct.  It's the first deref of page that oops's.


> But that's odd too, considering that get_user_pages_fast() had
> already accessed the page (both for looking up the head, and for
> then doing things like SetPageReferenced(page)).

Even the huge page cases all do that dereference as well, so it is
indeed a mystery how the pointer works inside of get_user_pages_fast()
but becomes garbage in the caller.

This page pointer sits on the stack, so maybe something stores garbage
there meanwhile.  Maybe the issue is even compiler dependent.

I'll keep looking over the changes made here for clues.
