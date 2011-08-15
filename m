From: David Miller <davem@davemloft.net>
Date: Mon, 15 Aug 2011 21:37:10 +0000
Subject: Re: [PATCH,v2] sparc32: unbreak arch_write_unlock()
Message-Id: <20110815.143710.1173702549295979935.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041.32134.131376.866324@pilspetsen.it.uu.se>
In-Reply-To: <20041.32134.131376.866324@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 15 Aug 2011 22:11:50 +0200

> The sparc32 version of arch_write_unlock() is just a plain assignment.
> Unfortunately this allows the compiler to schedule side-effects in a
> protected region to occur after the HW-level unlock, which is broken.
> E.g., the following trivial test case gets miscompiled:
> 
> 	#include <linux/spinlock.h>
> 	rwlock_t lock;
> 	int counter;
> 	void foo(void) { write_lock(&lock); ++counter; write_unlock(&lock); }
> 
> Fixed by adding a compiler memory barrier to arch_write_unlock().  The
> sparc64 version combines the barrier and assignment into a single asm(),
> and implements the operation as a static inline, so that's what I did too.
> 
> Compile-tested with sparc32_defconfig + CONFIG_SMP=y.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied.
