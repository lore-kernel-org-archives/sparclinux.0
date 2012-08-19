From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:53 +0000
Subject: [PATCH 17/17] sparc64: Update generic comments in perf event code to match reality.
Message-Id: <20120818.232853.567792567510779106.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Describe how we support two types of PMU setups, one with a single control
register and two counters stored in a single register, and another with
one control register per counter and each counter living in it's own
register.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 1885370..e48651d 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -30,27 +30,39 @@
 #include "kernel.h"
 #include "kstack.h"
 
-/* Sparc64 chips have two performance counters, 32-bits each, with
- * overflow interrupts generated on transition from 0xffffffff to 0.
- * The counters are accessed in one go using a 64-bit register.
+/* Two classes of sparc64 chips currently exist.  All of which have
+ * 32-bit counters which can generate overflow interrupts on the
+ * transition from 0xffffffff to 0.
  *
- * Both counters are controlled using a single control register.  The
- * only way to stop all sampling is to clear all of the context (user,
- * supervisor, hypervisor) sampling enable bits.  But these bits apply
- * to both counters, thus the two counters can't be enabled/disabled
- * individually.
+ * All chips upto and including SPARC-T3 have two performance
+ * counters.  The two 32-bit counters are accessed in one go using a
+ * single 64-bit register.
  *
- * The control register has two event fields, one for each of the two
- * counters.  It's thus nearly impossible to have one counter going
- * while keeping the other one stopped.  Therefore it is possible to
- * get overflow interrupts for counters not currently "in use" and
- * that condition must be checked in the overflow interrupt handler.
+ * On these older chips both counters are controlled using a single
+ * control register.  The only way to stop all sampling is to clear
+ * all of the context (user, supervisor, hypervisor) sampling enable
+ * bits.  But these bits apply to both counters, thus the two counters
+ * can't be enabled/disabled individually.
+ *
+ * Furthermore, the control register on these older chips have two
+ * event fields, one for each of the two counters.  It's thus nearly
+ * impossible to have one counter going while keeping the other one
+ * stopped.  Therefore it is possible to get overflow interrupts for
+ * counters not currently "in use" and that condition must be checked
+ * in the overflow interrupt handler.
  *
  * So we use a hack, in that we program inactive counters with the
  * "sw_count0" and "sw_count1" events.  These count how many times
  * the instruction "sethi %hi(0xfc000), %g0" is executed.  It's an
  * unusual way to encode a NOP and therefore will not trigger in
  * normal code.
+ *
+ * Starting with SPARC-T4 we have one control register per counter.
+ * And the counters are stored in individual registers.  The registers
+ * for the counters are 64-bit but only a 32-bit counter is
+ * implemented.  The event selections on SPARC-T4 lack any
+ * restrictions, therefore we can elide all of the complicated
+ * conflict resolution code we have for SPARC-T3 and earlier chips.
  */
 
 #define MAX_HWEVENTS			4
@@ -103,6 +115,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = { .enabled = 1, };
 /* An event map describes the characteristics of a performance
  * counter event.  In particular it gives the encoding as well as
  * a mask telling which counters the event can be measured on.
+ *
+ * The mask is unused on SPARC-T4 and later.
  */
 struct perf_event_map {
 	u16	encoding;
-- 
1.7.10.4

