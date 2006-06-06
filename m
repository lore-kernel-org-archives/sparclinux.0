From: Bob Breuer <breuerr@mc.net>
Date: Tue, 06 Jun 2006 04:59:29 +0000
Subject: Re: 2.6.17-rc5 does not build for sparc
Message-Id: <44850BB1.9020007@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4478bffd45960@wp.pl>
In-Reply-To: <4478bffd45960@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
> Date: Sat, 27 May 2006 23:09:17 +0200
> 
>> I tried to build the 2.6.17-rc5 for sparc with SMP enabled. The
>> kernel was not build due to a missing macro. Here is a patch
>> which fixes this (I copied the macro from a sparc64 header).
> 
> I was going to apply this just to fix the build, but it's
> not correct.
> 
> Because we embed a spinlock in the rwlock_t, we have to spin
> waiting for the lock bits to be clear before we can trust the
> sample of the rest of the lock.  We used to have to do this
> when we embedded a spinlock into the atomic_t's on sparc32.

Correct me if I am wrong, but...

From asm-sparc/spinlock.h:

 *      ------------------------------------
 *      | 24-bit counter           | wlock |  raw_rwlock_t
 *      ------------------------------------
 *       31                       8 7     0
 *
 * wlock signifies the one writer is in or somebody is updating
 * counter. For a writer, if he successfully acquires the wlock,
 * but counter is non-zero, he has to release the lock and wait,
 * till both counter and wlock are zero.


rw->lock in this case is the full 32-bit raw_rwlock_t, so a value of
0x000000ff is locked by a writer, 0x00000100 would be locked by a
reader, and 0x000001ff would be locked by a reader and updating the counter.

For __raw_write_can_lock(), we should be able to return true when the
whole 32-bits is zero (i.e. no readers, no counter being updated, and no
writers).  rw->lock is the whole 32-bits, so a check of !(rw)->lock
should be the right thing.

While we are at it, another one we are missing is __raw_read_can_lock(),
and I think that a check of !((rw)->lock & 0xff) will work (i.e. no
writers and no updating of the counter), or might it be better if the
counter was negated and we checked  rw->lock <= 0 ?

Bob
