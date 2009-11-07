From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 07 Nov 2009 12:16:24 +0000
Subject: Re: [patch 14/16] sparc: Replace old style lock initializer
Message-Id: <alpine.LFD.2.00.0911071310570.12138@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-934661253-1257596187=:12138"
List-Id: <sparclinux.vger.kernel.org>
References: <20091106223547.784916750@linutronix.de> <20091106223806.973326715@linutronix.de> <20091106.221834.246946954.davem@davemloft.net> <20091106.222032.02604670.davem@davemloft.net>
In-Reply-To: <20091106.222032.02604670.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-934661253-1257596187=:12138
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 6 Nov 2009, David Miller wrote:

> From: David Miller <davem@davemloft.net>
> Date: Fri, 06 Nov 2009 22:18:34 -0800 (PST)
> 
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Date: Fri, 06 Nov 2009 22:42:14 -0000
> > 
> >> SPIN_LOCK_UNLOCKED is deprecated. Use __SPIN_LOCK_UNLOCKED instead.
> >> 
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Applied to sparc-next-2.6, thanks.
> 
> This breaks the build:
> 
> /home/davem/src/GIT/sparc-next-2.6/arch/sparc/include/asm/rwsem.h:39: error: expected identifier or ‘(’ before ‘{’ token
> /home/davem/src/GIT/sparc-next-2.6/arch/sparc/include/asm/rwsem.h:39: error: expected identifier or ‘(’ before ‘}’ token
> make[1]: *** [arch/sparc/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2

Darn, I compiled it but the 32bit build does not use that file :)
Working version below.

Thanks,

	tglx
---
Subject: sparc: Replace old style lock initializer
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 06 Nov 2009 22:06:35 +0100

SPIN_LOCK_UNLOCKED is deprecated. Use __SPIN_LOCK_UNLOCKED instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/rwsem.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/sparc/include/asm/rwsem.h
===================================================================
--- linux-2.6.orig/arch/sparc/include/asm/rwsem.h
+++ linux-2.6/arch/sparc/include/asm/rwsem.h
@@ -35,8 +35,8 @@ struct rw_semaphore {
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-  __RWSEM_DEP_MAP_INIT(name) }
+{ RWSEM_UNLOCKED_VALUE, __SPIN_LOCK_UNLOCKED((name).wait_lock), \
+  LIST_HEAD_INIT((name).wait_list) __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
--8323328-934661253-1257596187=:12138--
