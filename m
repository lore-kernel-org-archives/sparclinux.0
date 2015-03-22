From: David Ahern <david.ahern@oracle.com>
Date: Sun, 22 Mar 2015 23:35:49 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <550F51D5.2010804@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFwXmDom=GKE=K2QVqp_RUtOPQ0v5kCArATqQEKUOZ6OrA@mail.gmail.com>	<20150322.133603.471287558426791155.davem@davemloft.net>	<CA+55aFwEq09vwnxPEYr67O7nuOEN9_n-uJKX11qSbuBNGJVghg@mail.gmail.com> <20150322.182311.109269221031797359.davem@davemloft.net>
In-Reply-To: <20150322.182311.109269221031797359.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Bob Picco <bpicco@meloft.net>

On 3/22/15 4:23 PM, David Miller wrote:
>> I don't even know which version of memcpy ends up being used on M7.
>> Some of them do things like use VIS. I can follow some regular sparc
>> asm, there's no way I'm even *looking* at that. Is it really ok to use
>> VIS registers in random contexts?
>
> Yes, using VIS how we do is alright, and in fact I did an audit of
> this about 1 year ago.  This is another one of those "if this is
> wrong, so much stuff would break"
>
> The only thing funny some of these routines do is fetch 2 64-byte
> blocks of data ahead in the inner loops, but that should be fine
> right?
>
> On the M7 we'll use the Niagara-4 memcpy.
>
> Hmmm... I'll run this silly sparc kernel memmove through the glibc
> testsuite and see if it barfs.
>

I don't know if you caught Bob's message; he has a hack to bypass memcpy 
and memmove in mm/slab.c use a for loop to move entries. With the hack 
he is not seeing the problem.

This is the hack:

+static void move_entries(void *dest, void *src, int nr)
+{
+       unsigned long *dp = dest;
+       unsigned long *sp = src;
+
+       for (; nr; nr--, dp++, sp++)
+               *dp = *sp;
+}
+

and then replace the mempy and memmove calls in transfer_objects, 
cache_flusharray and drain_array to use move_entries.

I just put it on 4.0.0-rc4 and ditto -- problem goes away, so it clearly 
suggests the memcpy or memmove are the root cause.

David

