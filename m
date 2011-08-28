From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sun, 28 Aug 2011 22:16:28 +0000
Subject: [PATCH] sparc32,sun4d: Change IPI IRQ level to prevent collision
Message-Id: <Pine.LNX.4.64.1108282349020.24571@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun4d systems running in SMP mode, IRQ 14 is used for timer interrupts 
and has a specialized interrupt handler. IPI is currently set to use IRQ 14 
as well, which causes it to trigger the timer interrupt handler, and not the 
IPI interrupt handler. 

The IPI interrupt is therefore changed to IRQ 13, which is the highest 
normally handled interrupt. This IRQ is also used for SBUS interrupts, 
however there is nothing in the IPI/SBUS interrupt handlers that indicate 
that they will not handle sharing the interrupt.
(IRQ 13 is indicated as audio interrupt, which is unlikely to be found in a 
sun4d system)

Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>
---

 arch/sparc/kernel/irq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 100b9c2..4285112 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -88,7 +88,7 @@ BTFIXUPDEF_CALL(void, set_irq_udt, int)
 #define set_irq_udt(cpu) BTFIXUP_CALL(set_irq_udt)(cpu)
 
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
-#define SUN4D_IPI_IRQ 14
+#define SUN4D_IPI_IRQ 13
 
 extern void sun4d_ipi_interrupt(void);
 
