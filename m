From: Bob Breuer <breuerr@mc.net>
Date: Tue, 06 Jun 2006 07:09:00 +0000
Subject: Re: 2.6.17-rc5 does not build for sparc
Message-Id: <44852A0C.4030603@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4478bffd45960@wp.pl>
In-Reply-To: <4478bffd45960@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bob Breuer <breuerr@mc.net>
> Date: Mon, 05 Jun 2006 23:59:29 -0500
> 
>> rw->lock in this case is the full 32-bit raw_rwlock_t, so a value of
>> 0x000000ff is locked by a writer, 0x00000100 would be locked by a
>> reader, and 0x000001ff would be locked by a reader and updating the counter.
> 
> For a moment I thought you were right, but the spinlock acts
> to atomicize the reader counter updates too.

Is it ok if the can_lock macros are conservative and maybe return a
false failure?

> That lock could be set transiently, while decrementing the
> reader counter down to zero.
> 
> So it really does matter, and in fact you have to be even more
> careful that I originally indicated.  In fact I can't even see
> how you can implement this %100 correctly.

Even if can_lock() is 100% correct, there is no guarantee that the lock
will still be available right after, only a trylock could give that kind
of guarantee.

> We simply can't tell if the spinlock is held because the writer
> is trying to get in, or because a reader is holding is just to
> increment or decrement the counter.

If we can't tell, then be conservative and return 0.

> If the reader count is zero, for example, the spinlock could be held
> by a writer and we don't want to spin waiting for it to clear in that
> case.  If, however, the reader count is zero but the spinlock is
> held so that a reader can increment the count, we would want to
> spin waiting for the spinlock to release in that case.

The can_lock macros never need to spin.

Ok, how about a truth table to cover all combinations:

reader count | wlock | lock value | write_can_lock | read_can_lock
-------------+-------+------------+----------------+--------------
1)     0     |   0   | 000000 00  |       1        |      1
2)     0     | not 0 | 000000 xx  |       0        |      0
3)   not 0   |   0   | xxxxxx 00  |       0        |      1
4)   not 0   | not 0 | xxxxxx xx  |       0        |      0

reader count and wlock are part the _same_ 32-bit value, therefore when
we read the value we get a simultaneous snapshot of both and it must be
in one of these 4 states.

State 2 is a questionable state and could be caused by either a reader
or a writer, therefore neither one can be guaranteed to succeed.

State 4 would be a bigger concern because read_can_lock() could be
expected to return true, but then again the caller must be expecting
potential failure, or they wouldn't be checking with can_lock.


