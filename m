From: Bob Picco <bpicco@meloft.net>
Date: Sun, 07 Sep 2014 15:47:38 +0000
Subject: [PATCH] sparc64: sun4v TLB error power off events
Message-Id: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

We've witnessed a few TLB events causing the machine to power off because
of prom_halt. In one case it was some nfs related area during rmmod. Another
was an mmapper of /dev/mem. A more recent one is an ITLB issue with
a bad pagesize which could be a hardware bug. Bugs happen but we should
attempt to not power off the machine and/or hang it when possible.

This is a DTLB error from an mmapper of /dev/mem:
[root@sparcie ~]# SUN4V-DTLB: Error at TPC[fffff80100903e6c], tl 1
SUN4V-DTLB: TPC<0xfffff80100903e6c>
SUN4V-DTLB: O7[fffff801081979d0]
SUN4V-DTLB: O7<0xfffff801081979d0>
SUN4V-DTLB: vaddr[fffff80100000000] ctx[1250] pte[98000000000f0610] error[2]
.

This is recent mainline for ITLB:
[ 3708.179864] SUN4V-ITLB: TPC<0xfffffc010071cefc>
[ 3708.188866] SUN4V-ITLB: O7[fffffc010071cee8]
[ 3708.197377] SUN4V-ITLB: O7<0xfffffc010071cee8>
[ 3708.206539] SUN4V-ITLB: vaddr[e0003] ctx[1a3c] pte[2900000dcc800eeb] error[4]
.

We've treated DTLB/ITLB error events identically within the patch.
Should TL be <= 1 then proceed to die_if_kernel. Fully expect
though that for a privileged access the machine must be reset
when panic_on_oops is armed. Should panic_on_oops not be armed, then you
remain up but the quality and duration will be subject to what the error
condition caused.  An unprivileged task is killed off with a SIGSEGV.

Power off of large sparc64 machines is painful. Plus die_if_kernel provides
more context. A reset sequence isn't a brief period on large sparc64 but
better than power-off/power-on sequence.

For TL > 1 the machine does abruptly enter power off like it has.

Cc: sparclinux@vger.kernel.org
Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/kernel/traps_64.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index fb6640e..6a34e96 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2104,6 +2104,18 @@ void sun4v_nonresum_overflow(struct pt_regs *regs)
 	atomic_inc(&sun4v_nonresum_oflow_cnt);
 }
 
+static void sun4v_tlb_error(struct pt_regs *regs, int tl, char *message)
+{
+	/* Should we be above TL=1 then we just prom_halt. Should
+	 * pstate.priv have been true at trap time and panic_on_oops
+	 * disabled then we proceed but YMMV.
+	 */
+	if (tl > 1)
+		prom_halt();
+	else
+		die_if_kernel(message, regs);
+}
+
 unsigned long sun4v_err_itlb_vaddr;
 unsigned long sun4v_err_itlb_ctx;
 unsigned long sun4v_err_itlb_pte;
@@ -2125,7 +2137,7 @@ void sun4v_itlb_error_report(struct pt_regs *regs, int tl)
 	       sun4v_err_itlb_vaddr, sun4v_err_itlb_ctx,
 	       sun4v_err_itlb_pte, sun4v_err_itlb_error);
 
-	prom_halt();
+	sun4v_tlb_error(regs, tl, "ITLB HV ERROR");
 }
 
 unsigned long sun4v_err_dtlb_vaddr;
@@ -2149,7 +2161,7 @@ void sun4v_dtlb_error_report(struct pt_regs *regs, int tl)
 	       sun4v_err_dtlb_vaddr, sun4v_err_dtlb_ctx,
 	       sun4v_err_dtlb_pte, sun4v_err_dtlb_error);
 
-	prom_halt();
+	sun4v_tlb_error(regs, tl, "DTLB HV ERROR");
 }
 
 void hypervisor_tlbop_error(unsigned long err, unsigned long op)
-- 
1.7.1

