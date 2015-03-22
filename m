From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Mar 2015 23:49:51 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <CA+55aFwWJU+D_rFhZVf0JZ599XH-2APELyrpBYYuvDsynyoMUw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFwXmDom=GKE=K2QVqp_RUtOPQ0v5kCArATqQEKUOZ6OrA@mail.gmail.com>
	<20150322.133603.471287558426791155.davem@davemloft.net>
	<CA+55aFwEq09vwnxPEYr67O7nuOEN9_n-uJKX11qSbuBNGJVghg@mail.gmail.com>
	<20150322.182311.109269221031797359.davem@davemloft.net>
In-Reply-To: <20150322.182311.109269221031797359.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, sparclinux@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Mar 22, 2015 at 3:23 PM, David Miller <davem@davemloft.net> wrote:
>
> Yes, using VIS how we do is alright, and in fact I did an audit of
> this about 1 year ago.  This is another one of those "if this is
> wrong, so much stuff would break"

Maybe. But it does seem like Bob Picco has narrowed it down to memmove().

It also bothers me enormously - and perhaps unreasonably - how that
memcpy code has memory barriers in it. I can see _zero_ reason for a
memory barrier inside a memcpy, unless the memcpy does something that
isn't valid to begin with. Are the VIS operatiosn perhaps using some
kind of non-temporal form that doesn't follow the TSO rules? Kind of
like the "movnt" that Intel has?

That kind of stuff makes me worry. For example, the only reason I see for

        membar          #StoreLoad | #StoreStore

after that VIS loop is that the stxa doesn't honor normal memory store
ordering rules, but if that's true, then shouldn't we have a membar
*before* the loop too? How about "ldx"? Does that also do some
unordered loads?

So the memory barriers in there just make me nervous, because they are
either entirely bogus or superfluous, or they are not - and if they
aren't, then that implies that some of the code does something really
odd with memory ordering.

I dunno. I really can't read that code at all, so I'm going entirely
by gut instinct here.

                          Linus
