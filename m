From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 May 2012 20:10:41 +0000
Subject: [PATCH 3/5] sparc32: implement proper LEON support in head_32 (after highmem)
Message-Id: <1337717443-11904-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We use the compatibility property to determine the
sun models. for leon we use psr.impl and ignore the
result of the getprops call.

Include a hack to allow build and the support code
is not yet converted.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/head_32.S |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 1be5b62..488a23a 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -392,7 +392,18 @@ execute_in_high_mem:
 						! to a buf where above string
 						! will get stored by the prom.
 
-#ifdef CONFIG_SPARC_LEON
+		/* If this is a LEON cpu we ignore the result
+		 * of the getprops call.
+		 * XXX Can we drop the getprops call?
+		 */
+		rd	%psr, %g1
+		set     PSR_IMPL, %g2
+		and     %g1, %g2, %g1
+		srl     %g1, PSR_IMPL_SHIFT, %g1
+		cmp     %g1, PSR_IMPL_LEON
+		bne	check_cputype
+		 nop
+
 	        /* no cpu-type check is needed, it is a SPARC-LEON */
 
 		sethi	%hi(boot_cpu_id), %g2	! boot-cpu index
@@ -400,9 +411,12 @@ execute_in_high_mem:
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
@@ -412,8 +426,8 @@ execute_in_high_mem:
 
 		ba continue_boot
 		 nop
-#endif
 
+check_cputype:
 /* Check to cputype. We may be booted on a sun4u (64 bit box),
  * and sun4d needs special treatment.
  */
-- 
1.6.0.6

