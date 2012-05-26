From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:07 +0000
Subject: [PATCH 03/15] sparc32: implement proper LEON support in head_32 (after highmem)
Message-Id: <1338016819-22245-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We use the compatibility property to determine the
sun models. For leon we use psr.impl and ignore the
result of the getprops call.

Include a hack to allow build as the support code
is not yet converted.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/head_32.S |   58 ++++++++++++++++++++++++------------------
 1 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 5a418d3..f22a729 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -372,37 +372,27 @@ execute_in_high_mem:
 		sethi	%hi(linux_dbvec), %g1
 		st	%o1, [%g1 + %lo(linux_dbvec)]
 
-/* Get the machine type via the mysterious romvec node operations. */
-
-		add	%g7, 0x1c, %l1
-		ld	[%l1], %l0
-		ld	[%l0], %l0
-		call	%l0
-		 or	%g0, %g0, %o0		! next_node(0) = first_node
-		or	%o0, %g0, %g6
-
-		sethi	%hi(cputypvar), %o1	! First node has cpu-arch
-		or	%o1, %lo(cputypvar), %o1
-		sethi	%hi(cputypval), %o2	! information, the string
-		or	%o2, %lo(cputypval), %o2
-		ld	[%l1], %l0		! 'compatible' tells
-		ld	[%l0 + 0xc], %l0	! that we want 'sun4x' where
-		call	%l0			! x is one of 'm', 'd' or 'e'.
-		 nop				! %o2 holds pointer
-						! to a buf where above string
-						! will get stored by the prom.
+		/* Check if this is a LEON CPU.
+		 * Skip getprops call if it is
+		 */
+		srl	%g3, PSR_IMPL_SHIFT, %g3
+		and	%g3, PSR_IMPL_SHIFTED_MASK, %g3
+		cmp	%g3, PSR_IMPL_LEON
+		 bne	get_cputype
 
-#ifdef CONFIG_SPARC_LEON
-	        /* no cpu-type check is needed, it is a SPARC-LEON */
 
+		/* LEON CPU - set boot_cpu_id */
 		sethi	%hi(boot_cpu_id), %g2	! boot-cpu index
 
 #ifdef CONFIG_SMP
 		ldub	[%g2 + %lo(boot_cpu_id)], %g1
 		cmp	%g1, 0xff		! unset means first CPU
+#ifdef CONFIG_SPARC_LEON
+		/* XXX Hack to allow build - remove ifdef later */
 		bne	leon_smp_cpu_startup	! continue only with master
 		 nop
 #endif
+#endif
 		/* Get CPU-ID from most significant 4-bit of ASR17 */
 		rd     %asr17, %g1
 		srl    %g1, 28, %g1
@@ -412,12 +402,30 @@ execute_in_high_mem:
 
 		ba continue_boot
 		 nop
-#endif
+
+/* Get the machine type via the mysterious romvec node operations. */
+get_cputype:
+		add	%g7, 0x1c, %l1
+		ld	[%l1], %l0
+		ld	[%l0], %l0
+		call	%l0
+		 or	%g0, %g0, %o0		! next_node(0) = first_node
+		or	%o0, %g0, %g6
+
+		sethi	%hi(cputypvar), %o1	! First node has cpu-arch
+		or	%o1, %lo(cputypvar), %o1
+		sethi	%hi(cputypval), %o2	! information, the string
+		or	%o2, %lo(cputypval), %o2
+		ld	[%l1], %l0		! 'compatible' tells
+		ld	[%l0 + 0xc], %l0	! that we want 'sun4x' where
+		call	%l0			! x is one of 'm', 'd' or 'e'.
+		 nop				! %o2 holds pointer
+						! to a buf where above string
+						! will get stored by the prom.
 
 /* Check to cputype. We may be booted on a sun4u (64 bit box),
  * and sun4d needs special treatment.
  */
-
 		set	cputypval, %o2
 		ldub	[%o2 + 0x4], %l1
 
@@ -467,9 +475,9 @@ sun4m_init:
 /* This sucks, apparently this makes Vikings call prom panic, will fix later */
 2:
 		rd	%psr, %o1
-		srl	%o1, 28, %o1		! Get a type of the CPU
+		srl	%o1, PSR_IMPL_SHIFT, %o1	! Get a type of the CPU
 
-		subcc	%o1, 4, %g0		! TI: Viking or MicroSPARC
+		subcc	%o1, PSR_IMPL_TI, %g0		! TI: Viking or MicroSPARC
 		be	continue_boot
 		 nop
 
-- 
1.6.0.6

