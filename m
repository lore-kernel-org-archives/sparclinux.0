From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 02 Jun 2017 18:40:51 +0000
Subject: [v1 3/6] sparc64: show time stamps from zero
Message-Id: <1496428854-936411-4-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On most platforms, time is shown from the beginning of boot.  This patch is
adding offset to sched_clock() for SPARC, to also show time from 0.

This means we will have one more load, but we saved one in an ealier patch.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/kernel/time_64.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 6724bcb..5f53b74 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -392,6 +392,7 @@ static int hbtick_add_compare(unsigned long adj)
 };
 
 static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
+static unsigned long timer_offset __read_mostly;
 
 unsigned long cmos_regs;
 EXPORT_SYMBOL(cmos_regs);
@@ -786,6 +787,10 @@ void __init time_init(void)
 	timer_ticks_per_nsec_quotient  		clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
 
+	timer_offset = (tick_operations.get_tick()
+			* timer_ticks_per_nsec_quotient)
+			>> SPARC64_NSEC_PER_CYC_SHIFT;
+
 	clocksource_tick.name = tick_operations.name;
 	clocksource_tick.read = clocksource_tick_read;
 
@@ -813,8 +818,9 @@ unsigned long long sched_clock(void)
 {
 	unsigned long ticks = tick_operations.get_tick();
 
-	return (ticks * timer_ticks_per_nsec_quotient)
-		>> SPARC64_NSEC_PER_CYC_SHIFT;
+	return ((ticks * timer_ticks_per_nsec_quotient)
+		>> SPARC64_NSEC_PER_CYC_SHIFT)
+		- timer_offset;
 }
 
 int read_current_timer(unsigned long *timer_val)
-- 
1.7.1

