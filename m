From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 06:19:22 +0000
Subject: [PATCH 3/4] sparc32: add missing rw can_lock macros
Message-Id: <448BB5EA.2060200@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030600070606030706090601"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------030600070606030706090601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fix a link failure by adding the missing can_lock macros for the rw locks.

Signed-off-by: Bob Breuer <breuerr@mc.net>
---


--------------030600070606030706090601
Content-Type: text/plain;
 name="sparc32-rw_can_lock.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32-rw_can_lock.patch.txt"

--- linux-2.6.17-rc5-clean/include/asm-sparc/spinlock.h	2006-04-30 14:18:19.000000000 -0500
+++ linux-2.6.17-rc5/include/asm-sparc/spinlock.h	2006-06-01 00:47:28.000000000 -0500
@@ -154,6 +154,9 @@ static inline int __raw_write_trylock(ra
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 #define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
+#define __raw_read_can_lock(rw) (!((rw)->lock & 0xff))
+#define __raw_write_can_lock(rw) (!(rw)->lock)
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* __SPARC_SPINLOCK_H */

--------------030600070606030706090601--
