From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 15 Aug 2011 20:10:31 +0000
Subject: [PATCH] sparc64: remove unnecessary macros from spinlock_64.h
Message-Id: <20041.32055.652850.148995@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

The sparc64 spinlock_64.h contains a number of operations defined
first as static inline functions, and then as macros with the same
names and parameters as the functions.  Maybe this was needed at
some point in the past, but now nothing seems to depend on these
macros (checked with a recursive grep looking for ifdefs on these
names).  Other archs don't define these identity-macros.

So this patch deletes these unnecessary macros.

Compile-tested with sparc64_defconfig.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
--- linux-3.1-rc2/arch/sparc/include/asm/spinlock_64.h.~1~	2011-05-19 06:06:34.000000000 +0200
+++ linux-3.1-rc2/arch/sparc/include/asm/spinlock_64.h	2011-08-15 20:51:27.000000000 +0200
@@ -210,14 +210,8 @@ static int inline arch_write_trylock(arc
 	return result;
 }
 
-#define arch_read_lock(p)	arch_read_lock(p)
 #define arch_read_lock_flags(p, f) arch_read_lock(p)
-#define arch_read_trylock(p)	arch_read_trylock(p)
-#define arch_read_unlock(p)	arch_read_unlock(p)
-#define arch_write_lock(p)	arch_write_lock(p)
 #define arch_write_lock_flags(p, f) arch_write_lock(p)
-#define arch_write_unlock(p)	arch_write_unlock(p)
-#define arch_write_trylock(p)	arch_write_trylock(p)
 
 #define arch_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
 #define arch_write_can_lock(rw)	(!(rw)->lock)
