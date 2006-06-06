From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jun 2006 05:08:38 +0000
Subject: Re: 2.6.17-rc5 does not build for sparc
Message-Id: <20060605.220838.88476823.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4478bffd45960@wp.pl>
In-Reply-To: <4478bffd45960@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Mon, 05 Jun 2006 23:59:29 -0500

> rw->lock in this case is the full 32-bit raw_rwlock_t, so a value of
> 0x000000ff is locked by a writer, 0x00000100 would be locked by a
> reader, and 0x000001ff would be locked by a reader and updating the counter.

For a moment I thought you were right, but the spinlock acts
to atomicize the reader counter updates too.

That lock could be set transiently, while decrementing the
reader counter down to zero.

So it really does matter, and in fact you have to be even more
careful that I originally indicated.  In fact I can't even see
how you can implement this %100 correctly.

We simply can't tell if the spinlock is held because the writer
is trying to get in, or because a reader is holding is just to
increment or decrement the counter.

If the reader count is zero, for example, the spinlock could be held
by a writer and we don't want to spin waiting for it to clear in that
case.  If, however, the reader count is zero but the spinlock is
held so that a reader can increment the count, we would want to
spin waiting for the spinlock to release in that case.

There is a way to fix this.  Rewrite the rwlock stuff to use the
atomic_t hashed spinlocks to update rwlock_t and just modify it
as a 32-bit atomically updatable value just like platforms which
have compare-and-swap primitives do.

Then we could implement the "can lock" primitives just like the
other platforms do.
