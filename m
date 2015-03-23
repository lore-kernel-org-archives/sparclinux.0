From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Mar 2015 19:47:49 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <CA+55aFwfAxOME7v=EUZd7j0AoHinXgs6TDwU-TZKiGy3Rs5Lbg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322.221906.1670737065885267482.davem@davemloft.net>
	<20150323.122530.812870422534676208.davem@davemloft.net>
	<CA+55aFzepCj56MPVgYmMem+yfYpSOX7tBRtPHeOQxXp31Tghhg@mail.gmail.com>
	<20150323.150833.1435862810481480096.davem@davemloft.net>
In-Reply-To: <20150323.150833.1435862810481480096.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, sparclinux@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpicco@meloft.net

On Mon, Mar 23, 2015 at 12:08 PM, David Miller <davem@davemloft.net> wrote:
>
> Sure you could do that in C, but I really want to avoid using memcpy()
> if dst and src overlap in any way at all.
>
> Said another way, I don't want to codify that "64" thing.  The next
> chip could do 128 byte initializing stores.

But David, THAT IS NOT WHAT YOUR BROKEN ASM DOES ANYWAY!

Read it again. Your asm code does not check for overlap. Look at this:

        cmp             %o0, %o1
        bleu,pt         %xcc, 2f

and ponder. It's wrong.

So even if you don't want to take that "allow overlap more than 64
bytes apart" thing, my C version actually is *better* than the broken
asm version you have.

The new asm version is better than the old one, because the new
breakage is about really bad performance rather than actively
breaking, but still..

                         Linus
