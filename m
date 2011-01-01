From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 22:53:09 +0000
Subject: [PATCH 2/4] sparc: drop prom/palloc.c
Message-Id: <1293922391-17661-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

None of the functions was used.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/oplib_32.h |   10 --------
 arch/sparc/prom/Makefile          |    1 -
 arch/sparc/prom/palloc.c          |   43 -------------------------------------
 3 files changed, 0 insertions(+), 54 deletions(-)
 delete mode 100644 arch/sparc/prom/palloc.c

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 31d2249..91411bc 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -114,16 +114,6 @@ extern int prom_idlecpu(int cpunode);
 /* Re-Start the CPU with the passed device tree node. */
 extern int prom_restartcpu(int cpunode);
 
-/* PROM memory allocation facilities... */
-
-/* Allocated at possibly the given virtual address a chunk of the
- * indicated size.
- */
-extern char *prom_alloc(char *virt_hint, unsigned int size);
-
-/* Free a previously allocated chunk. */
-extern void prom_free(char *virt_addr, unsigned int size);
-
 /* Sun4/sun4c specific memory-management startup hook. */
 
 /* Map the passed segment in the given context at the passed
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 113e630..8287bbe 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -9,7 +9,6 @@ lib-y                 += init_$(BITS).o
 lib-$(CONFIG_SPARC32) += memory.o
 lib-y                 += misc_$(BITS).o
 lib-$(CONFIG_SPARC32) += mp.o
-lib-$(CONFIG_SPARC32) += palloc.o
 lib-$(CONFIG_SPARC32) += ranges.o
 lib-$(CONFIG_SPARC32) += segment.o
 lib-y                 += console_$(BITS).o
diff --git a/arch/sparc/prom/palloc.c b/arch/sparc/prom/palloc.c
deleted file mode 100644
index 2e2a88b..0000000
--- a/arch/sparc/prom/palloc.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * palloc.c:  Memory allocation from the Sun PROM.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#include <asm/openprom.h>
-#include <asm/oplib.h>
-
-/* You should not call these routines after memory management
- * has been initialized in the kernel, if fact you should not
- * use these if at all possible in the kernel.  They are mainly
- * to be used for a bootloader for temporary allocations which
- * it will free before jumping into the kernel it has loaded.
- *
- * Also, these routines don't work on V0 proms, only V2 and later.
- */
-
-/* Allocate a chunk of memory of size 'num_bytes' giving a suggestion
- * of virtual_hint as the preferred virtual base address of this chunk.
- * There are no guarantees that you will get the allocation, or that
- * the prom will abide by your "hint".  So check your return value.
- */
-char *
-prom_alloc(char *virtual_hint, unsigned int num_bytes)
-{
-	if(prom_vers = PROM_V0) return (char *) 0x0;
-	if(num_bytes = 0x0) return (char *) 0x0;
-	return (*(romvec->pv_v2devops.v2_dumb_mem_alloc))(virtual_hint, num_bytes);
-}
-
-/* Free a previously allocated chunk back to the prom at virtual address
- * 'vaddr' of size 'num_bytes'.  NOTE: This vaddr is not the hint you
- * used for the allocation, but the virtual address the prom actually
- * returned to you.  They may be have been the same, they may have not,
- * doesn't matter.
- */
-void
-prom_free(char *vaddr, unsigned int num_bytes)
-{
-	if((prom_vers = PROM_V0) || (num_bytes = 0x0)) return;
-	(*(romvec->pv_v2devops.v2_dumb_mem_free))(vaddr, num_bytes);
-}
-- 
1.6.0.6

