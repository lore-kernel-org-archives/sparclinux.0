From: David Miller <davem@davemloft.net>
Date: Sun, 22 Mar 2015 23:57:43 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150322.195743.1225936659717870427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFwEq09vwnxPEYr67O7nuOEN9_n-uJKX11qSbuBNGJVghg@mail.gmail.com>
	<20150322.182311.109269221031797359.davem@davemloft.net>
	<CA+55aFwWJU+D_rFhZVf0JZ599XH-2APELyrpBYYuvDsynyoMUw@mail.gmail.com>
In-Reply-To: <CA+55aFwWJU+D_rFhZVf0JZ599XH-2APELyrpBYYuvDsynyoMUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: david.ahern@oracle.com, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Mar 2015 16:49:51 -0700

> On Sun, Mar 22, 2015 at 3:23 PM, David Miller <davem@davemloft.net> wrote:
>>
>> Yes, using VIS how we do is alright, and in fact I did an audit of
>> this about 1 year ago.  This is another one of those "if this is
>> wrong, so much stuff would break"
> 
> Maybe. But it does seem like Bob Picco has narrowed it down to memmove().
> 
> It also bothers me enormously - and perhaps unreasonably - how that
> memcpy code has memory barriers in it. I can see _zero_ reason for a
> memory barrier inside a memcpy, unless the memcpy does something that
> isn't valid to begin with. Are the VIS operatiosn perhaps using some
> kind of non-temporal form that doesn't follow the TSO rules? Kind of
> like the "movnt" that Intel has?

The special cache line clearing stores (the ASI_BLK_INIT_QUAD_LDD_P
stuff) do not adhere to the memory model.

I had elided the memory barriers originally, but it caused memory
corruption.

So yes, this is similar to the 'movnt' situation.
