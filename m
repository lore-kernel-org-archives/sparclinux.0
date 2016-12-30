From: Dmitry Safonov <dsafonov@virtuozzo.com>
Date: Fri, 30 Dec 2016 15:56:31 +0000
Subject: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
Message-Id: <20161230155634.8692-2-dsafonov@virtuozzo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
In-Reply-To: <20161230155634.8692-1-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
TASK_SIZE_MAX since:
commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
FSBASE/GSBASE upper limits"),
commit a06db751c321 ("pagemap: check permissions and capabilities at
open time"),

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 arch/arm64/include/asm/memory.h       | 2 --
 arch/mips/include/asm/processor.h     | 3 ---
 arch/parisc/include/asm/processor.h   | 3 +--
 arch/powerpc/include/asm/processor.h  | 3 +--
 arch/s390/include/asm/processor.h     | 3 +--
 arch/sparc/include/asm/processor_64.h | 3 ---
 arch/x86/include/asm/processor.h      | 2 --
 include/linux/sched.h                 | 4 ----
 8 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index bfe632808d77..329bb4fd543c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -80,8 +80,6 @@
 #define TASK_SIZE_32		UL(0x100000000)
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-				TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64
 #endif /* CONFIG_COMPAT */
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 95b8c471f572..c2827a5507d4 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -73,9 +73,6 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 #define STACK_TOP_MAX	TASK_SIZE64
 
-#define TASK_SIZE_OF(tsk)						\
-	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-
 #define TASK_IS_32BIT_ADDR test_thread_flag(TIF_32BIT_ADDR)
 
 #endif
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index a3661ee6b060..8b51ddae8e4a 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -32,8 +32,7 @@
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
-#define TASK_SIZE_OF(tsk)       ((tsk)->thread.task_size)
-#define TASK_SIZE	        TASK_SIZE_OF(current)
+#define TASK_SIZE	        (current->thread.task_size)
 #define TASK_UNMAPPED_BASE      (current->thread.map_base)
 
 #define DEFAULT_TASK_SIZE32	(0xFFF00000UL)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1ba814436c73..04e575ead590 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -111,9 +111,8 @@ void release_thread(struct task_struct *);
  */
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
 
-#define TASK_SIZE_OF(tsk) (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+#define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
-#define TASK_SIZE	  TASK_SIZE_OF(current)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 6bca916a5ba0..c53e8e2a51ac 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -89,10 +89,9 @@ extern void execve_tail(void);
  * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
  */
 
-#define TASK_SIZE_OF(tsk)	((tsk)->mm->context.asce_limit)
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
 					(1UL << 30) : (1UL << 41))
-#define TASK_SIZE		TASK_SIZE_OF(current)
+#define TASK_SIZE		(current->mm->context.asce_limit)
 #define TASK_MAX_SIZE		(1UL << 53)
 
 #define STACK_TOP		(1UL << (test_thread_flag(TIF_31BIT) ? 31:42))
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 6448cfc8292f..6ce1a75d7a24 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -36,9 +36,6 @@
 #define VPTE_SIZE	(1 << (VA_BITS - PAGE_SHIFT + 3))
 #endif
 
-#define TASK_SIZE_OF(tsk) \
-	(test_tsk_thread_flag(tsk,TIF_32BIT) ? \
-	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
 #define TASK_SIZE \
 	(test_thread_flag(TIF_32BIT) ? \
 	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index eaf100508c36..090a860b792a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -819,8 +819,6 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
-#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
-					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
 
 #define STACK_TOP		TASK_SIZE
 #define STACK_TOP_MAX		TASK_SIZE_MAX
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4d1905245c7a..7a2e2f3f38a3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3610,10 +3610,6 @@ static inline void inc_syscw(struct task_struct *tsk)
 }
 #endif
 
-#ifndef TASK_SIZE_OF
-#define TASK_SIZE_OF(tsk)	TASK_SIZE
-#endif
-
 #ifdef CONFIG_MEMCG
 extern void mm_update_next_owner(struct mm_struct *mm);
 #else
-- 
2.11.0

