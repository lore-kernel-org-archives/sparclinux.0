From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 02 Jun 2017 18:40:53 +0000
Subject: [v1 5/6] sparc64: improve modularity tick options
Message-Id: <1496428854-936411-6-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch prepares the code for early boot time stamps by making it more
modular.

- init_tick_ops() to initialize struct sparc64_tick_ops
- new sparc64_tick_ops operation get_frequency() which returns a
  frequency

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/include/asm/timer_64.h |    2 +
 arch/sparc/kernel/time_64.c       |   83 ++++++++++++++++++++++++------------
 2 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index bde2cc4..61d0725 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -22,6 +22,8 @@ struct sparc64_tick_ops {
 
 	void (*init_tick)(void);
 	unsigned long (*add_tick)(unsigned long);
+	unsigned long (*get_frequency)(void);
+	unsigned long frequency;
 
 	char *name;
 };
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index d654f5c..faec3f0 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -164,6 +164,11 @@ static unsigned long tick_add_tick(unsigned long adj)
 	return new_tick;
 }
 
+static unsigned long tick_get_frequency(void)
+{
+	return local_cpu_data().clock_tick;
+}
+
 static struct sparc64_tick_ops tick_operations __aligned(64) __read_mostly = {
 	.name		=	"tick",
 	.init_tick	=	tick_init_tick,
@@ -171,6 +176,7 @@ static struct sparc64_tick_ops tick_operations __aligned(64) __read_mostly = {
 	.get_tick	=	tick_get_tick,
 	.add_tick	=	tick_add_tick,
 	.add_compare	=	tick_add_compare,
+	.get_frequency	=	tick_get_frequency,
 	.softint_mask	=	1UL << 0,
 };
 
@@ -250,6 +256,13 @@ static int stick_add_compare(unsigned long adj)
 	return ((long)(new_tick - (orig_tick+adj))) > 0L;
 }
 
+static unsigned long stick_get_frequency(void)
+{
+	struct device_node *dp = of_find_node_by_path("/");
+
+	return of_getintprop_default(dp, "stick-frequency", 0);
+}
+
 static struct sparc64_tick_ops stick_operations __read_mostly = {
 	.name		=	"stick",
 	.init_tick	=	stick_init_tick,
@@ -257,6 +270,7 @@ static int stick_add_compare(unsigned long adj)
 	.get_tick	=	stick_get_tick,
 	.add_tick	=	stick_add_tick,
 	.add_compare	=	stick_add_compare,
+	.get_frequency	=	stick_get_frequency,
 	.softint_mask	=	1UL << 16,
 };
 
@@ -381,6 +395,13 @@ static int hbtick_add_compare(unsigned long adj)
 	return ((long)(val2 - val)) > 0L;
 }
 
+static unsigned long hbtick_get_frequency(void)
+{
+	struct device_node *dp = of_find_node_by_path("/");
+
+	return of_getintprop_default(dp, "stick-frequency", 0);
+}
+
 static struct sparc64_tick_ops hbtick_operations __read_mostly = {
 	.name		=	"hbtick",
 	.init_tick	=	hbtick_init_tick,
@@ -388,6 +409,7 @@ static int hbtick_add_compare(unsigned long adj)
 	.get_tick	=	hbtick_get_tick,
 	.add_tick	=	hbtick_add_tick,
 	.add_compare	=	hbtick_add_compare,
+	.get_frequency	=	hbtick_get_frequency,
 	.softint_mask	=	1UL << 0,
 };
 
@@ -580,36 +602,17 @@ static int __init clock_init(void)
  */
 fs_initcall(clock_init);
 
-/* This is gets the master TICK_INT timer going. */
-static unsigned long sparc64_init_timers(void)
+/* Return true if this is Hummingbird, aka Ultra-IIe */
+static bool is_hummingbird(void)
 {
-	struct sparc64_tick_ops *ops = NULL;
-	struct device_node *dp;
-	unsigned long freq;
+	unsigned long ver, manuf, impl;
 
-	dp = of_find_node_by_path("/");
-	if (tlb_type = spitfire) {
-		unsigned long ver, manuf, impl;
-
-		__asm__ __volatile__ ("rdpr %%ver, %0"
-				      : "=&r" (ver));
-		manuf = ((ver >> 48) & 0xffff);
-		impl = ((ver >> 32) & 0xffff);
-		if (manuf = 0x17 && impl = 0x13) {
-			/* Hummingbird, aka Ultra-IIe */
-			ops = &hbtick_operations;
-			freq = of_getintprop_default(dp, "stick-frequency", 0);
-		} else {
-			freq = local_cpu_data().clock_tick;
-		}
-	} else {
-		ops = &stick_operations;
-		freq = of_getintprop_default(dp, "stick-frequency", 0);
-	}
-	if (ops)
-		memcpy(&tick_operations, ops, sizeof(struct sparc64_tick_ops));
+	__asm__ __volatile__ ("rdpr %%ver, %0"
+			      : "=&r" (ver));
+	manuf = ((ver >> 48) & 0xffff);
+	impl = ((ver >> 32) & 0xffff);
 
-	return freq;
+	return (manuf = 0x17 && impl = 0x13);
 }
 
 struct freq_table {
@@ -775,10 +778,34 @@ static u64 clocksource_tick_read(struct clocksource *cs)
 	return tick_operations.get_tick();
 }
 
+static void init_tick_ops(struct sparc64_tick_ops *ops)
+{
+	unsigned long freq, quotient, tick;
+
+	freq = ops->get_frequency();
+	quotient = clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
+	tick = ops->get_tick();
+
+	ops->offset = (tick * quotient) >> SPARC64_NSEC_PER_CYC_SHIFT;
+	ops->ticks_per_nsec_quotient = quotient;
+	ops->frequency = freq;
+	tick_operations = *ops;
+}
+
 void __init time_init(void)
 {
-	unsigned long freq = sparc64_init_timers();
+	unsigned long freq;
+
+	if (tlb_type = spitfire) {
+		if (is_hummingbird())
+			init_tick_ops(&hbtick_operations);
+		else
+			init_tick_ops(&tick_operations);
+	} else {
+		init_tick_ops(&stick_operations);
+	}
 
+	freq = tick_operations.frequency;
 	tb_ticks_per_usec = freq / USEC_PER_SEC;
 
 	tick_operations.ticks_per_nsec_quotient -- 
1.7.1

