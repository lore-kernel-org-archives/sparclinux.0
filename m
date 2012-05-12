From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 08:07:18 +0000
Subject: [PATCH] sparc32: Add back early sun4/sun4c detection so we can warn properly.
Message-Id: <20120512.040718.1043756785933730177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We need to do the check before we try to remap the kernel using
SRMMU operations.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

The sun4/sun4c warning should actually work now :-)

This means we can almost certainly kill the checks we do later
on, feel free to take care of that Sam as I'm heading to bed.

 arch/sparc/kernel/head_32.S |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index ea45894..0d01798 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -532,6 +532,29 @@ copy_prom_done:
 		be	go_to_highmem		! this will be a nop then
 		 nop
 
+		/* Validate that we are in fact running on an
+		 * SRMMU based cpu.
+		 */
+		set	0x4000, %g6
+		cmp	%g7, %g6
+		bne	not_a_sun4
+		 nop
+
+halt_sun4_or_sun4c:
+		ld	[%g7 + 0x68], %o1
+		set	sun4c_notsup, %o0
+		sub	%o0, %l6, %o0
+		call	%o1
+		 nop
+		ba	halt_me
+		 nop
+
+not_a_sun4:
+		lda	[%g0] ASI_M_MMUREGS, %g1
+		andcc	%g1, 1, %g0
+		be	halt_sun4_or_sun4c
+		 nop
+
 srmmu_remap:
 		/* First, check for a viking (TI) module. */
 		set	0x40000000, %g2
-- 
1.7.10

