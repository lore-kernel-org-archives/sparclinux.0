From: David Miller <davem@davemloft.net>
Date: Tue, 20 Apr 2010 07:50:51 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100420.005051.40113282.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 19 Apr 2010 22:51:05 -0700 (PDT)

> I have to think about why I might have done things this way to
> make sure I fix this right.

Ok, I don't get crashes any more.  There are all kinds of issues
with the sw watchdog triggering because cpus get slogged in
the scheduler rebalance code, but that's a seperate set of
issues.

Here is the final fix I'll commit.

sparc64: Fix hardirq tracing in trap return path.

We can overflow the hardirq stack if we set the %pil here
so early, just let the normal control flow do it.

This is fine as we are allowed to do the actual IRQ enable
at any point after we call trace_hardirqs_on.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/rtrap_64.S |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 83f1873..090b9e9 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -130,7 +130,17 @@ rtrap_xcall:
 		 nop
 		call			trace_hardirqs_on
 		 nop
-		wrpr			%l4, %pil
+		/* Do not actually set the %pil here.  We will do that
+		 * below after we clear PSTATE_IE in the %pstate register.
+		 * If we re-enable interrupts here, we can recurse down
+		 * the hardirq stack potentially endlessly, causing a
+		 * stack overflow.
+		 *
+		 * It is tempting to put this test and trace_hardirqs_on
+		 * call at the 'rt_continue' label, but that will not work
+		 * as that path hits unconditionally and we do not want to
+		 * execute this in NMI return paths, for example.
+		 */
 #endif
 rtrap_no_irq_enable:
 		andcc			%l1, TSTATE_PRIV, %l3
-- 
1.7.0.4


