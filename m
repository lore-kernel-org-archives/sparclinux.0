From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 23 Jun 2020 08:36:51 +0000
Subject: [PATCH v4 6/8] arm: Break cyclic percpu include
Message-Id: <20200623083721.454517573@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/percpu.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -10,6 +10,8 @@
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
  */
 #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
+register unsigned long current_stack_pointer asm ("sp");
+
 static inline void set_my_cpu_offset(unsigned long off)
 {
 	/* Set TPIDRPRW */
