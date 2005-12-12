From: Keith Owens <kaos@sgi.com>
Date: Mon, 12 Dec 2005 04:55:38 +0000
Subject: generic read_trylock() never tries, it always waits
Message-Id: <9942.1134363338@kao2.melbourne.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, rmk@arm.linux.org.uk, takata@linux-m32r.org, linux-mips@linux-mips.org, parisc-linux@lists.parisc-linux.org, linux-sh@m17n.org, lethal@linux-sh.org, davem@davemloft.net, sparclinux@vger.kernel.org

Copied to assorted architecture maintainers and mailing lists, please
trim cc: list back to lkml plus arch if you reply.

The generic version of read_trylock() never tests if the lock is in
use, it always spins waiting for the lock to be free.  IOW, it behaves
like read_lock().  Given the different implementations of rwlock_t, it
is hard for generic__raw_read_trylock() to do anything else.

I strongly recommend that the architectures below define their own
version of __raw_read_trylock() that really test the lock first, then
we can ditch generic__raw_read_trylock().  I have already sent an ia64
patch to that mailing list.

include/asm-arm/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-ia64/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-m32r/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-mips/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-parisc/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-sh/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-sparc64/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)

