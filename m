From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 12 Aug 2013 12:02:24 +0000
Subject: [PATCH] sparc64: Remove RWSEM export leftovers
Message-Id: <444041376308944@web25h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The functions

			__down_read
			__down_read_trylock
			__down_write
			__down_write_trylock
			__up_read
			__up_write
			__downgrade_write

are implemented inline, so remove corresponding EXPORT_SYMBOLs
(They lead to compile errors on RT kernel).

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/lib/ksyms.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index 0c4e35e..323335b 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -98,15 +98,6 @@ EXPORT_SYMBOL(___copy_from_user);
 EXPORT_SYMBOL(___copy_in_user);
 EXPORT_SYMBOL(__clear_user);
 
-/* RW semaphores */
-EXPORT_SYMBOL(__down_read);
-EXPORT_SYMBOL(__down_read_trylock);
-EXPORT_SYMBOL(__down_write);
-EXPORT_SYMBOL(__down_write_trylock);
-EXPORT_SYMBOL(__up_read);
-EXPORT_SYMBOL(__up_write);
-EXPORT_SYMBOL(__downgrade_write);
-
 /* Atomic counter implementation. */
 EXPORT_SYMBOL(atomic_add);
 EXPORT_SYMBOL(atomic_add_ret);
