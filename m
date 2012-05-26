From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:11 +0000
Subject: [PATCH 07/15] sparc32: handle leon in cpu.c
Message-Id: <1338016819-22245-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A few hardcoded constant were replaced by symbolic
versions to improve readability

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/psr.h |    2 ++
 arch/sparc/kernel/cpu.c      |   18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/psr.h b/arch/sparc/include/asm/psr.h
index c02c735..cee7ed9 100644
--- a/arch/sparc/include/asm/psr.h
+++ b/arch/sparc/include/asm/psr.h
@@ -35,7 +35,9 @@
 #define PSR_VERS    0x0f000000         /* cpu-version field          */
 #define PSR_IMPL    0xf0000000         /* cpu-implementation field   */
 
+#define PSR_VERS_SHIFT		24
 #define PSR_IMPL_SHIFT		28
+#define PSR_VERS_SHIFTED_MASK	0xf
 #define PSR_IMPL_SHIFTED_MASK	0xf
 
 #define PSR_IMPL_TI		0x4
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 2d18196..a6c94a2 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -121,7 +121,7 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		FPU(-1, NULL)
 	}
 },{
-	4,
+	PSR_IMPL_TI,
 	.cpu_info = {
 		CPU(0, "Texas Instruments, Inc. - SuperSparc-(II)"),
 		/* SparcClassic  --  borned STP1010TAB-50*/
@@ -191,7 +191,7 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		FPU(-1, NULL)
 	}
 },{
-	0xF,		/* Aeroflex Gaisler */
+	PSR_IMPL_LEON,		/* Aeroflex Gaisler */
 	.cpu_info = {
 		CPU(3, "LEON"),
 		CPU(-1, NULL)
@@ -440,16 +440,16 @@ static int __init cpu_type_probe(void)
 	int psr_impl, psr_vers, fpu_vers;
 	int psr;
 
-	psr_impl = ((get_psr() >> 28) & 0xf);
-	psr_vers = ((get_psr() >> 24) & 0xf);
+	psr_impl = ((get_psr() >> PSR_IMPL_SHIFT) & PSR_IMPL_SHIFTED_MASK);
+	psr_vers = ((get_psr() >> PSR_VERS_SHIFT) & PSR_VERS_SHIFTED_MASK);
 
 	psr = get_psr();
 	put_psr(psr | PSR_EF);
-#ifdef CONFIG_SPARC_LEON
-	fpu_vers = get_psr() & PSR_EF ? ((get_fsr() >> 17) & 0x7) : 7;
-#else
-	fpu_vers = ((get_fsr() >> 17) & 0x7);
-#endif
+
+	if (psr_impl = PSR_IMPL_LEON)
+		fpu_vers = get_psr() & PSR_EF ? ((get_fsr() >> 17) & 0x7) : 7;
+	else
+		fpu_vers = ((get_fsr() >> 17) & 0x7);
 
 	put_psr(psr);
 
-- 
1.6.0.6

