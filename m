From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 05:31:13 +0000
Subject: [PATCH] sparc64: Adjust __raw_local_irq_save() to cooperate in
Message-Id: <20100412.223113.191111095.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If we are in an NMI then doing a plain raw_local_irq_disable() will
write PIL_NORMAL_MAX into %pil, which is lower than PIL_NMI, and thus
we'll re-enable NMIs and recurse.

Doing a simple:

	%pil = %pil | PIL_NORMAL_MAX

does what we want, if we're already at PIL_NMI (15) we leave it at
that setting, else we set it to PIL_NORMAL_MAX (14).

This should get the function tracer working on sparc64.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Frederic, this is the actual fix I'm going to use for all of
the function tracer problems on sparc64.  So please discard
all those other things I've showed you and use this instead.

I'll push this to Linus soon, as well as patches to get
the function graph tracer and kmemleak working on sparc64
which I'll post later tonight.

 arch/sparc/include/asm/irqflags_64.h |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/irqflags_64.h b/arch/sparc/include/asm/irqflags_64.h
index 8b49bf9..a16e94c 100644
--- a/arch/sparc/include/asm/irqflags_64.h
+++ b/arch/sparc/include/asm/irqflags_64.h
@@ -76,9 +76,19 @@ static inline int raw_irqs_disabled(void)
  */
 static inline unsigned long __raw_local_irq_save(void)
 {
-	unsigned long flags = __raw_local_save_flags();
+	unsigned long flags, tmp;
 
-	raw_local_irq_disable();
+	/* Disable interrupts to PIL_NORMAL_MAX unless we already
+	 * are using PIL_NMI, in which case PIL_NMI is retained.
+	 */
+	__asm__ __volatile__(
+		"rdpr	%%pil, %0\n\t"
+		"or	%0, %2, %1\n\t"
+		"wrpr	%1, 0x0, %%pil"
+		: "=r" (flags), "=r" (tmp)
+		: "i" (PIL_NORMAL_MAX)
+		: "memory"
+	);
 
 	return flags;
 }
-- 
1.7.0.4

