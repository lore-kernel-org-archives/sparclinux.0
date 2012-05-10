From: David Miller <davem@davemloft.net>
Date: Thu, 10 May 2012 19:00:08 +0000
Subject: [PATCH] sparc64: Do not clobber %g2 in xcall_fetch_glob_regs().
Message-Id: <20120510.150008.1902269828420021753.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


%g2 is meant to hold the CPUID number throughout this routine, since
at the very beginning, and at the very end, we use %g2 to calculate
indexes into per-cpu arrays.

However we erroneously clobber it in order to hold the %cwp register
value mid-stream.

Fix this code to use %g3 for the %cwp read and related calulcations
instead.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/central.c |    2 +-
 arch/sparc/mm/ultra.S       |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index 38d48a5..9708851 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -269,4 +269,4 @@ static int __init sunfire_init(void)
 	return 0;
 }
 
-subsys_initcall(sunfire_init);
+fs_initcall(sunfire_init);
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index b57a594..874162a 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -495,11 +495,11 @@ xcall_fetch_glob_regs:
 	stx		%o7, [%g1 + GR_SNAP_O7]
 	stx		%i7, [%g1 + GR_SNAP_I7]
 	/* Don't try this at home kids... */
-	rdpr		%cwp, %g2
-	sub		%g2, 1, %g7
+	rdpr		%cwp, %g3
+	sub		%g3, 1, %g7
 	wrpr		%g7, %cwp
 	mov		%i7, %g7
-	wrpr		%g2, %cwp
+	wrpr		%g3, %cwp
 	stx		%g7, [%g1 + GR_SNAP_RPC]
 	sethi		%hi(trap_block), %g7
 	or		%g7, %lo(trap_block), %g7
-- 
1.7.10

