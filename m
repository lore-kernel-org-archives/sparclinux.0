From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 19:08:33 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150323.150833.1435862810481480096.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322.221906.1670737065885267482.davem@davemloft.net>
	<20150323.122530.812870422534676208.davem@davemloft.net>
	<CA+55aFzepCj56MPVgYmMem+yfYpSOX7tBRtPHeOQxXp31Tghhg@mail.gmail.com>
In-Reply-To: <CA+55aFzepCj56MPVgYmMem+yfYpSOX7tBRtPHeOQxXp31Tghhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: david.ahern@oracle.com, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Mar 2015 10:00:02 -0700

> Maybe the code could be something like
> 
>     void *memmove(void *dst, const void *src, size_t n);
>     {
>         // non-overlapping cases
>         if (src + n <= dst)
>             return memcpy(dst, src, n);
>         if (dst + n <= src)
>             return memcpy(dst, src, n);
> 
>         // overlapping, but we know we
>         //  (a) copy upwards
>         //  (b) initialize the result in at most chunks of 64
>         if (dst+64 <= src)
>             return memcpy(dst, src, n);
> 
>         .. do the backwards thing ..
>     }
> 
> (ok, maybe I got it wrong, but you get the idea).
> 
> I *think* gcc should do ok on the above kind of code, and not generate
> wildly different code from your handcoded version.

Sure you could do that in C, but I really want to avoid using memcpy()
if dst and src overlap in any way at all.

Said another way, I don't want to codify that "64" thing.  The next
chip could do 128 byte initializing stores.
