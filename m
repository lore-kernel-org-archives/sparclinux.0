From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 22:53:08 +0000
Subject: [PATCH 1/4] sparc: drop prom/devmap.c
Message-Id: <1293922391-17661-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

None of the functions was used.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/oplib_32.h |   12 --------
 arch/sparc/prom/Makefile          |    1 -
 arch/sparc/prom/devmap.c          |   53 -------------------------------------
 3 files changed, 0 insertions(+), 66 deletions(-)
 delete mode 100644 arch/sparc/prom/devmap.c

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 9e5c640..31d2249 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -48,18 +48,6 @@ extern void prom_init(struct linux_romvec *rom_ptr);
 /* Boot argument acquisition, returns the boot command line string. */
 extern char *prom_getbootargs(void);
 
-/* Device utilities. */
-
-/* Map and unmap devices in IO space at virtual addresses. Note that the
- * virtual address you pass is a request and the prom may put your mappings
- * somewhere else, so check your return value as that is where your new
- * mappings really are!
- *
- * Another note, these are only available on V2 or higher proms!
- */
-extern char *prom_mapio(char *virt_hint, int io_space, unsigned int phys_addr, unsigned int num_bytes);
-extern void prom_unmapio(char *virt_addr, unsigned int num_bytes);
-
 /* Miscellaneous routines, don't really fit in any category per se. */
 
 /* Reboot the machine with the command line passed. */
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 816c0fa..113e630 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -5,7 +5,6 @@ asflags := -ansi
 ccflags := -Werror
 
 lib-y                 := bootstr_$(BITS).o
-lib-$(CONFIG_SPARC32) += devmap.o
 lib-y                 += init_$(BITS).o
 lib-$(CONFIG_SPARC32) += memory.o
 lib-y                 += misc_$(BITS).o
diff --git a/arch/sparc/prom/devmap.c b/arch/sparc/prom/devmap.c
deleted file mode 100644
index 46157d2..0000000
--- a/arch/sparc/prom/devmap.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * promdevmap.c:  Map device/IO areas to virtual addresses.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-
-#include <asm/openprom.h>
-#include <asm/oplib.h>
-
-extern void restore_current(void);
-
-/* Just like the routines in palloc.c, these should not be used
- * by the kernel at all.  Bootloader facility mainly.  And again,
- * this is only available on V2 proms and above.
- */
-
-/* Map physical device address 'paddr' in IO space 'ios' of size
- * 'num_bytes' to a virtual address, with 'vhint' being a hint to
- * the prom as to where you would prefer the mapping.  We return
- * where the prom actually mapped it.
- */
-char *
-prom_mapio(char *vhint, int ios, unsigned int paddr, unsigned int num_bytes)
-{
-	unsigned long flags;
-	char *ret;
-
-	spin_lock_irqsave(&prom_lock, flags);
-	if((num_bytes = 0) || (paddr = 0)) ret = (char *) 0x0;
-	else
-	ret = (*(romvec->pv_v2devops.v2_dumb_mmap))(vhint, ios, paddr,
-						    num_bytes);
-	restore_current();
-	spin_unlock_irqrestore(&prom_lock, flags);
-	return ret;
-}
-
-/* Unmap an IO/device area that was mapped using the above routine. */
-void
-prom_unmapio(char *vaddr, unsigned int num_bytes)
-{
-	unsigned long flags;
-
-	if(num_bytes = 0x0) return;
-	spin_lock_irqsave(&prom_lock, flags);
-	(*(romvec->pv_v2devops.v2_dumb_munmap))(vaddr, num_bytes);
-	restore_current();
-	spin_unlock_irqrestore(&prom_lock, flags);
-}
-- 
1.6.0.6

