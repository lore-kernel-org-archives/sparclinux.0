From: Bob Picco <bpicco@meloft.net>
Date: Tue, 24 Mar 2015 14:57:53 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150324145753.GC10685@zareason>
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
Cc: david.ahern@oracle.com, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

David Miller wrote:	[Mon Mar 23 2015, 12:25:30PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Sun, 22 Mar 2015 22:19:06 -0400 (EDT)
> 
> > I'll work on a fix.
> 
> Ok, here is what I committed.   David et al., let me know if you still
> see the crashes with this applied.
> 
> Of course, I'll queue this up for -stable as well.
> 
> Thanks!
> 
> ==========
> [PATCH] sparc64: Fix several bugs in memmove().
> 
> Firstly, handle zero length calls properly.  Believe it or not there
> are a few of these happening during early boot.
> 
> Next, we can't just drop to a memcpy() call in the forward copy case
> where dst <= src.  The reason is that the cache initializing stores
> used in the Niagara memcpy() implementations can end up clearing out
> cache lines before we've sourced their original contents completely.
> 
> For example, considering NG4memcpy, the main unrolled loop begins like
> this:
> 
>      load   src + 0x00
>      load   src + 0x08
>      load   src + 0x10
>      load   src + 0x18
>      load   src + 0x20
>      store  dst + 0x00
> 
> Assume dst is 64 byte aligned and let's say that dst is src - 8 for
> this memcpy() call.  That store at the end there is the one to the
> first line in the cache line, thus clearing the whole line, which thus
> clobbers "src + 0x28" before it even gets loaded.
> 
> To avoid this, just fall through to a simple copy only mildly
> optimized for the case where src and dst are 8 byte aligned and the
> length is a multiple of 8 as well.  We could get fancy and call
> GENmemcpy() but this is good enough for how this thing is actually
> used.
> 
> Reported-by: David Ahern <david.ahern@oracle.com>
> Reported-by: Bob Picco <bpicco@meloft.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
Seems solid with 2.6.39 on M7-4. Jalap?no is happy with current sparc.git.
