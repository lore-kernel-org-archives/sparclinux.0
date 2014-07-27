From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 14:26:40 +0000
Subject: [PATCH] Installing invalid entries in TSB causes hard lockup on UltraSPARC III
Message-Id: <201407271626.41251.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With recent kernels, hard lockups are observed by many users of (at least)
UltraSPARC III based systems. In most cases, users report that these lockups
occur when heavy disk I/O load is placed on the system. Uniprocessor systems
become totally unresponsive and will not output any diagnostic information,
on SMP systems a second CPU might detect that its sibling encountered a lockup
and complain about this in the syslog. The diagnostics provided on SMP systems
seem to indicate that the affected CPU has vector interrupts disabled, i.e.
%PSTATE.IE seems to be set to 0, so that this CPU also does not respond to CPU
cross calls anymore (in other words, this lockup is not caused by %PIL set
to a sufficiently high value).

My analysis showed that this is caused by a tight cycle in TLB miss trap handling.
What happens is that a ITLB or DTLB miss is triggered, and the handler tries
to locate a corresponding entry in the TSB. It succeeds, the entry is installed
in the I/DTLB, and the CPU resumes processing. However, the inserted TLB
entry has the VALID bit set to 0, causing the trap to be taken again [1]. At least
on UltraSPARC III Cu CPUs, vector interrupts seem not to be re-enabled in the
short interval between the trap handler's exit and the user instruction faulting
again, therefore the CPU behaves as if %PSTATE.IE was continuously set to 0.
(Looking at the diagnostic trap information one can see that %PSTATE.IE is
actually set to 1 for the very short time interval when the user instruction
resumes execution.)

([1] The fact that a TLB entry with VALID set to 0 was installed could be
confirmed by instrumenting the TLB miss trap handlers. I can provide the
patch for this instrumentation code on request.)

Installing a probe into the TSB insertion code shows that there seems to be
only a single path on which TSB entries with VALID set to 0 are inserted,
and it seems to be related to page migration during a fork operation:

Jul 21 10:41:55 troi kernel: [  891.542560] tsb_insert: Trying to insert invalid pte: tag=0x000000000003de pte=0x0000002dfa72b0
Jul 21 10:41:55 troi kernel: [  891.660838] CPU: 0 PID: 3517 Comm: watch Not tainted 3.13.10 #3
Jul 21 10:41:55 troi kernel: [  891.738349] Call Trace:
Jul 21 10:41:55 troi kernel: [  891.774246]  [0000000000450164] update_mmu_cache+0x84/0x1e0
Jul 21 10:41:55 troi kernel: [  891.847825]  [000000000053a0d0] remove_migration_pte+0x1d0/0x2c0
Jul 21 10:41:55 troi kernel: [  891.926552]  [0000000000526344] rmap_walk+0xa4/0x200
Jul 21 10:41:55 troi kernel: [  891.992773]  [000000000053b270] move_to_new_page+0x190/0x220
Jul 21 10:41:55 troi kernel: [  892.067365]  [000000000053bb74] migrate_pages+0x6f4/0x8c0
Jul 21 10:41:55 troi kernel: [  892.138823]  [00000000005157c4] compact_zone+0x2a4/0x400
Jul 21 10:41:55 troi kernel: [  892.209246]  [0000000000515b20] compact_zone_order+0xa0/0xe0
Jul 21 10:41:55 troi kernel: [  892.283769]  [0000000000515c20] try_to_compact_pages+0xc0/0x120
Jul 21 10:41:55 troi kernel: [  892.361232]  [000000000082dcd4] __alloc_pages_direct_compact+0x98/0x1a8
Jul 21 10:41:55 troi kernel: [  892.446964]  [00000000004fdfe8] __alloc_pages_nodemask+0x5c8/0x9a0
Jul 21 10:41:55 troi kernel: [  892.527316]  [000000000045c714] copy_process+0x154/0xe20
Jul 21 10:41:55 troi kernel: [  892.597102]  [000000000045d52c] do_fork+0x4c/0x280
Jul 21 10:41:55 troi kernel: [  892.660529]  [000000000042c5c8] sparc_do_fork+0x28/0x60
Jul 21 10:41:55 troi kernel: [  892.729166]  [0000000000406074] linux_sparc_syscall32+0x34/0x40

Also note that the TAG and PTE values seem to look fine, except that the VALID
bit in PTE is not set. As the valid bit seems also to be used for tracking "old"
pages (_PAGE_VALID = _PAGE_R), leaving it set to 0 when calling update_mmu_cache
might be unintentional (but I could not yet investigate this idea further.)

The patch as shown below prevents invalid PTEs to be installed in the TSB. It
does this by checking the VALID bit, and also rendering the TAG invalid when
the PTE is marked as invalid (in effect, invalidating a corresponding TSB
entry for a mapping of this virtual address, if it should already exist).

With this patch, no more lockups were observed on the affected SunBlade 2000
during intensive stress testing (which caused the unpatched kernel to fail
reliably after a short time).

Please note that this patch only cures the symptoms of the problem, and does
so in a very conservative way. It might also be possible to just set VALID
to 1 in the PTE value provided to tsb_insert(). As I unfortunately do not have
access to the affected machine any more since July 1st, I was unable to test more
advanced strategies.

The patch was originally developed against a 3.13 backport kernel from Debian.
Both the patch against 3.13 and a recent 3.16-rc6 are included below. Please note
that I could only test the 3.13 version as I do not have access to the affected
machine anymore.

PATCH 1 - KERNEL VERSION 3.13 #####################################################

diff -Naupr linux-source-3.13-orig/arch/sparc/mm/init_64.c linux-source-3.13-patched/arch/sparc/mm/init_64.c
--- linux-source-3.13-orig/arch/sparc/mm/init_64.c      2014-04-14 15:48:24.000000000 +0200
+++ linux-source-3.13-patched/arch/sparc/mm/init_64.c   2014-07-27 14:29:58.000000000 +0200
@@ -40,6 +40,7 @@
 #include <asm/dma.h>
 #include <asm/starfire.h>
 #include <asm/tlb.h>
+#include <asm/pgtable_64.h>
 #include <asm/spitfire.h>
 #include <asm/sections.h>
 #include <asm/tsb.h>
@@ -272,6 +273,13 @@ static inline void tsb_insert(struct tsb
        if (tlb_type = cheetah_plus || tlb_type = hypervisor)
                tsb_addr = __pa(tsb_addr);
 
+       /* If pte is not valid, also invalidate tag to prevent invalid ptes to
+        * be loaded by the TLB miss handler (causing lockup)...
+        */
+       if(!(pte & _PAGE_VALID)) {
+               tag |= (1UL << TSB_TAG_INVALID_BIT);
+       }
+
        __tsb_insert(tsb_addr, tag, pte);
 }
 
PATCH 2 - KERNEL VERSION 3.16 #####################################################

diff -Naupr linux-3.16-rc6-orig/arch/sparc/mm/init_64.c linux-3.16-rc6-patched/arch/sparc/mm/init_64.c
--- linux-3.16-rc6-orig/arch/sparc/mm/init_64.c 2014-07-27 11:47:27.000000000 +0200
+++ linux-3.16-rc6-patched/arch/sparc/mm/init_64.c      2014-07-27 14:28:12.000000000 +0200
@@ -40,6 +40,7 @@
 #include <asm/dma.h>
 #include <asm/starfire.h>
 #include <asm/tlb.h>
+#include <asm/pgtable_64.h>
 #include <asm/spitfire.h>
 #include <asm/sections.h>
 #include <asm/tsb.h>
@@ -273,6 +274,13 @@ static inline void tsb_insert(struct tsb
        if (tlb_type = cheetah_plus || tlb_type = hypervisor)
                tsb_addr = __pa(tsb_addr);
 
+       /* If pte is not valid, also invalidate tag to prevent invalid ptes to
+        * be loaded by the TLB miss handler (causing lockup)...
+        */
+       if(!(pte & _PAGE_VALID)) {
+               tag |= (1UL << TSB_TAG_INVALID_BIT);
+       }
+
        __tsb_insert(tsb_addr, tag, pte);
 }
 
Regards,
Alexander Schulze
