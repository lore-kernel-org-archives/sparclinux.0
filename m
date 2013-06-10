From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 10 Jun 2013 06:56:41 +0000
Subject: [PATCH] sparc32, leon: Enable interrupts before going idle to avoid getting stuck
Message-Id: <1370847401-766-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This enables interrupts for Leon before having the CPU enter power-down mode.

Commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092, "sparc: Use generic idle loop",
gets the CPU stuck on idle for Leon systems. On Leon, disabling interrupts and
powering down the processor will get the processor stuck waiting for an
interrupt that will never be reacted to.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---

I assume that going idle with interrupts disabled is the right thing to
do for the other users of the sparc_idle function pointer. Otherwise,
the right way to go is probably to enable interrupts in the 32-bit
arch_cpu_idle before calling the idle function instead.

 arch/sparc/kernel/leon_pmc.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index bdf53d9..b0b3967 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -47,6 +47,10 @@ void pmc_leon_idle_fixup(void)
 	 * MMU does not get a TLB miss here by using the MMU BYPASS ASI.
 	 */
 	register unsigned int address = (unsigned int)leon3_irqctrl_regs;
+
+	/* Interrupts need to be enabled to not hang the CPU */
+	local_irq_enable();
+
 	__asm__ __volatile__ (
 		"wr	%%g0, %%asr19\n"
 		"lda	[%0] %1, %%g0\n"
@@ -60,6 +64,9 @@ void pmc_leon_idle_fixup(void)
  */
 void pmc_leon_idle(void)
 {
+	/* Interrupts need to be enabled to not hang the CPU */
+	local_irq_enable();
+
 	/* For systems without power-down, this will be no-op */
 	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
 }
-- 
1.7.10.4

