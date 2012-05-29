From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 May 2012 18:14:12 +0000
Subject: [PATCH 1/3] sparc32,leon: fix leon bootup
Message-Id: <1338315254-3829-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

head_32.S failed to set cputypval for leon, causing boot to fail.
The boot failed because we failed to recognize this was a LEON
cpu so we did not preoperly run-time patch the the kernel.
This resulted in an early crash.

Reported-by: Daniel Hellstrom <daniel@gaisler.com>
Tested-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/head_32.S |   73 ++++++++++++++++++++++++-------------------
 1 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index cdc7f29..5364a05 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -372,36 +372,9 @@ execute_in_high_mem:
 		sethi	%hi(linux_dbvec), %g1
 		st	%o1, [%g1 + %lo(linux_dbvec)]
 
-		/* Check if this is a LEON CPU.
-		 * Skip getprops call if it is
+		/* Get the machine type via the romvec
+		 * getprops node operation
 		 */
-		srl	%g3, PSR_IMPL_SHIFT, %g3
-		and	%g3, PSR_IMPL_SHIFTED_MASK, %g3
-		cmp	%g3, PSR_IMPL_LEON
-		 bne	get_cputype
-
-
-		/* LEON CPU - set boot_cpu_id */
-		sethi	%hi(boot_cpu_id), %g2	! boot-cpu index
-
-#ifdef CONFIG_SMP
-		ldub	[%g2 + %lo(boot_cpu_id)], %g1
-		cmp	%g1, 0xff		! unset means first CPU
-		bne	leon_smp_cpu_startup	! continue only with master
-		 nop
-#endif
-		/* Get CPU-ID from most significant 4-bit of ASR17 */
-		rd     %asr17, %g1
-		srl    %g1, 28, %g1
-
-		/* Update boot_cpu_id only on boot cpu */
-		stub	%g1, [%g2 + %lo(boot_cpu_id)]
-
-		ba continue_boot
-		 nop
-
-/* Get the machine type via the mysterious romvec node operations. */
-get_cputype:
 		add	%g7, 0x1c, %l1
 		ld	[%l1], %l0
 		ld	[%l0], %l0
@@ -420,10 +393,26 @@ get_cputype:
 						! to a buf where above string
 						! will get stored by the prom.
 
-/* Check to cputype. We may be booted on a sun4u (64 bit box),
- * and sun4d needs special treatment.
- */
+
+		/* Check value of "compatible" property.
+		 * "value" => "model"
+		 * leon => sparc_leon
+		 * sun4m => sun4m
+		 * sun4s => sun4m
+		 * sun4d => sun4d
+		 * sun4e => "no_sun4e_here"
+		 * '*'   => "no_sun4u_here"
+		 * Check single letters only
+		 */
+
 		set	cputypval, %o2
+		/* If cputypval[0] = 'l' (lower case letter L) this is leon */
+		ldub	[%o2], %l1
+		cmp	%l1, 'l'
+		be	leon_init
+		 nop
+
+		/* Check cputypval[4] to find the sun model */
 		ldub	[%o2 + 0x4], %l1
 
 		cmp	%l1, 'm'
@@ -438,6 +427,26 @@ get_cputype:
 		b	no_sun4u_here		! AIEEE, a V9 sun4u... Get our BIG BROTHER kernel :))
 		 nop
 
+leon_init:
+		/* LEON CPU - set boot_cpu_id */
+		sethi	%hi(boot_cpu_id), %g2	! boot-cpu index
+
+#ifdef CONFIG_SMP
+		ldub	[%g2 + %lo(boot_cpu_id)], %g1
+		cmp	%g1, 0xff		! unset means first CPU
+		bne	leon_smp_cpu_startup	! continue only with master
+		 nop
+#endif
+		/* Get CPU-ID from most significant 4-bit of ASR17 */
+		rd     %asr17, %g1
+		srl    %g1, 28, %g1
+
+		/* Update boot_cpu_id only on boot cpu */
+		stub	%g1, [%g2 + %lo(boot_cpu_id)]
+
+		ba continue_boot
+		 nop
+
 /* CPUID in bootbus can be found at PA 0xff0140000 */
 #define SUN4D_BOOTBUS_CPUID     0xf0140000
 
-- 
1.6.0.6

