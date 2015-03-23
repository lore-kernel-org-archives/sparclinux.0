From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Mar 2015 17:00:02 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <CA+55aFzepCj56MPVgYmMem+yfYpSOX7tBRtPHeOQxXp31Tghhg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <550F5852.5020405@oracle.com>
	<20150322.220024.1171832215344978787.davem@davemloft.net>
	<20150322.221906.1670737065885267482.davem@davemloft.net>
	<20150323.122530.812870422534676208.davem@davemloft.net>
In-Reply-To: <20150323.122530.812870422534676208.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, sparclinux@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpicco@meloft.net

On Mon, Mar 23, 2015 at 9:25 AM, David Miller <davem@davemloft.net> wrote:
>
> Ok, here is what I committed.

So I wonder - looking at that assembly, I get the feeling that it
isn't any better code than gcc could generate from simple C code.

Would it perhaps be better to turn memmove() into C?

That's particularly true because if I read this code right, it now
seems to seriously pessimise non-overlapping memmove's, in that it now
*always* uses that slow downward copy if the destination is below the
source.

Now, admittedly, the kernel doesn't use a lot of memmov's, but this
still falls back on the "byte at a time" model for a lot of cases (all
non-64-bit-aligned ones). I could imagine those existing. And some
people (reasonably) hate memcpy because they've been burnt by the
overlapping case and end up using memmove as a "safe alternative", so
it's not necessarily just the overlapping case that might trigger
this.

Maybe the code could be something like

    void *memmove(void *dst, const void *src, size_t n);
    {
        // non-overlapping cases
        if (src + n <= dst)
            return memcpy(dst, src, n);
        if (dst + n <= src)
            return memcpy(dst, src, n);

        // overlapping, but we know we
        //  (a) copy upwards
        //  (b) initialize the result in at most chunks of 64
        if (dst+64 <= src)
            return memcpy(dst, src, n);

        .. do the backwards thing ..
    }

(ok, maybe I got it wrong, but you get the idea).

I *think* gcc should do ok on the above kind of code, and not generate
wildly different code from your handcoded version.

                            Linus
