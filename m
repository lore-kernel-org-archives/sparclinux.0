From: "John Stoffel" <john@stoffel.org>
Date: Mon, 23 Mar 2015 16:51:03 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <21776.17527.912997.355420@quad.stoffel.home>
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


David> ==========
David> [PATCH] sparc64: Fix several bugs in memmove().

David> Firstly, handle zero length calls properly.  Believe it or not there
David> are a few of these happening during early boot.

David> Next, we can't just drop to a memcpy() call in the forward copy case
David> where dst <= src.  The reason is that the cache initializing stores
David> used in the Niagara memcpy() implementations can end up clearing out
David> cache lines before we've sourced their original contents completely.

David> For example, considering NG4memcpy, the main unrolled loop begins like
David> this:

David>      load   src + 0x00
David>      load   src + 0x08
David>      load   src + 0x10
David>      load   src + 0x18
David>      load   src + 0x20
David>      store  dst + 0x00

David> Assume dst is 64 byte aligned and let's say that dst is src - 8 for
David> this memcpy() call.  That store at the end there is the one to the
David> first line in the cache line, thus clearing the whole line, which thus
David> clobbers "src + 0x28" before it even gets loaded.

David> To avoid this, just fall through to a simple copy only mildly
David> optimized for the case where src and dst are 8 byte aligned and the
David> length is a multiple of 8 as well.  We could get fancy and call
David> GENmemcpy() but this is good enough for how this thing is actually
David> used.

Would it make sense to have some memmove()/memcopy() tests on bootup
to catch problems like this?  I know this is a strange case, and
probably not too common, but how hard would it be to wire up tests
that go through 1 to 128 byte memmove() on bootup to make sure things
work properly?

This seems like one of those critical, but subtle things to be
checked.  And doing it only on bootup wouldn't slow anything down and
would (ideally) automatically get us coverage when people add new
archs or update the code.

John
