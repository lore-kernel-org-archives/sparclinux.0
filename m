From: David Miller <davem@davemloft.net>
Date: Thu, 24 May 2012 20:57:28 +0000
Subject: [PATCH] sparc: Fix user_addr_max() definition.
Message-Id: <20120524.165728.2124546768664666818.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We need to use TASK_SIZE because for 64-bit tasks the value
of STACK_TOP actually sits in the middle of the address space
so we'll get false-negatives.

Adjust the TASK_SIZE definition on sparc64 to accomodate this,
in the context in which user_addr_max() is used we have the
test_thread_flag() definition available but not the one for
test_tsk_thread_flag().

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Some glibc testsuite failures for 64-bit showed me that
STACK_TOP isn't the right thing to use here because of
how we place the 64-bit process stack in the middle
of the address space.

Committed to master.

 arch/sparc/include/asm/processor_64.h |    4 +++-
 arch/sparc/include/asm/uaccess.h      |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index e713db2..6ca7709 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -42,7 +42,9 @@
 #define TASK_SIZE_OF(tsk) \
 	(test_tsk_thread_flag(tsk,TIF_32BIT) ? \
 	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
-#define TASK_SIZE	TASK_SIZE_OF(current)
+#define TASK_SIZE \
+	(test_thread_flag(TIF_32BIT) ? \
+	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
 #ifdef __KERNEL__
 
 #define STACK_TOP32	((1UL << 32UL) - PAGE_SIZE)
diff --git a/arch/sparc/include/asm/uaccess.h b/arch/sparc/include/asm/uaccess.h
index 20c2acb..0167d26 100644
--- a/arch/sparc/include/asm/uaccess.h
+++ b/arch/sparc/include/asm/uaccess.h
@@ -7,7 +7,7 @@
 #endif
 
 #define user_addr_max() \
-	(segment_eq(get_fs(), USER_DS) ? STACK_TOP : ~0UL)
+	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
-- 
1.7.10

