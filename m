From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 16 Jul 2015 11:38:29 +0000
Subject: [PATCH 17/23] sparc/time: Migrate to new 'set-state' interface
Message-Id: <6ec789f9988fac66caedf10f065072ed0047dd38.1437044518.git.viresh.kumar@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, John Stultz <john.stultz@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Xunlei Pang <pang.xunlei@linaro.org>

Migrate sparc drivers to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything which switching to few clockevent modes and so
their callbacks aren't implemented.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/sparc/kernel/sun4m_smp.c |  2 +-
 arch/sparc/kernel/time_32.c   | 57 ++++++++++++++++++++-----------------------
 arch/sparc/kernel/time_64.c   | 33 ++++++++-----------------
 3 files changed, 38 insertions(+), 54 deletions(-)

diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index d3408e72d20c..278c40abce82 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -247,7 +247,7 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 
 	ce = &per_cpu(sparc32_clockevent, cpu);
 
-	if (ce->mode & CLOCK_EVT_MODE_PERIODIC)
+	if (clockevent_state_periodic(ce))
 		sun4m_clear_profile_irq(cpu);
 	else
 		sparc_config.load_profile_irq(cpu, 0); /* Is this needless? */
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index c9692f387cee..1affabc96b08 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -101,21 +101,18 @@ irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void timer_ce_set_mode(enum clock_event_mode mode,
-			      struct clock_event_device *evt)
+static int timer_ce_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-		case CLOCK_EVT_MODE_PERIODIC:
-		case CLOCK_EVT_MODE_RESUME:
-			timer_ce_enabled = 1;
-			break;
-		case CLOCK_EVT_MODE_SHUTDOWN:
-			timer_ce_enabled = 0;
-			break;
-		default:
-			break;
-	}
+	timer_ce_enabled = 0;
+	smp_mb();
+	return 0;
+}
+
+static int timer_ce_set_periodic(struct clock_event_device *evt)
+{
+	timer_ce_enabled = 1;
 	smp_mb();
+	return 0;
 }
 
 static __init void setup_timer_ce(void)
@@ -127,7 +124,9 @@ static __init void setup_timer_ce(void)
 	ce->name     = "timer_ce";
 	ce->rating   = 100;
 	ce->features = CLOCK_EVT_FEAT_PERIODIC;
-	ce->set_mode = timer_ce_set_mode;
+	ce->set_state_shutdown = timer_ce_shutdown;
+	ce->set_state_periodic = timer_ce_set_periodic;
+	ce->tick_resume = timer_ce_set_periodic;
 	ce->cpumask  = cpu_possible_mask;
 	ce->shift    = 32;
 	ce->mult     = div_sc(sparc_config.clock_rate, NSEC_PER_SEC,
@@ -183,24 +182,20 @@ static __init int setup_timer_cs(void)
 }
 
 #ifdef CONFIG_SMP
-static void percpu_ce_setup(enum clock_event_mode mode,
-			struct clock_event_device *evt)
+static int percpu_ce_shutdown(struct clock_event_device *evt)
 {
 	int cpu = cpumask_first(evt->cpumask);
 
-	switch (mode) {
-		case CLOCK_EVT_MODE_PERIODIC:
-			sparc_config.load_profile_irq(cpu,
-						      SBUS_CLOCK_RATE / HZ);
-			break;
-		case CLOCK_EVT_MODE_ONESHOT:
-		case CLOCK_EVT_MODE_SHUTDOWN:
-		case CLOCK_EVT_MODE_UNUSED:
-			sparc_config.load_profile_irq(cpu, 0);
-			break;
-		default:
-			break;
-	}
+	sparc_config.load_profile_irq(cpu, 0);
+	return 0;
+}
+
+static int percpu_ce_set_periodic(struct clock_event_device *evt)
+{
+	int cpu = cpumask_first(evt->cpumask);
+
+	sparc_config.load_profile_irq(cpu, SBUS_CLOCK_RATE / HZ);
+	return 0;
 }
 
 static int percpu_ce_set_next_event(unsigned long delta,
@@ -224,7 +219,9 @@ void register_percpu_ce(int cpu)
 	ce->name           = "percpu_ce";
 	ce->rating         = 200;
 	ce->features       = features;
-	ce->set_mode       = percpu_ce_setup;
+	ce->set_state_shutdown = percpu_ce_shutdown;
+	ce->set_state_periodic = percpu_ce_set_periodic;
+	ce->set_state_oneshot = percpu_ce_shutdown;
 	ce->set_next_event = percpu_ce_set_next_event;
 	ce->cpumask        = cpumask_of(cpu);
 	ce->shift          = 32;
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 2e6035c0a8ca..c69b21e51efc 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -674,32 +674,19 @@ static int sparc64_next_event(unsigned long delta,
 	return tick_ops->add_compare(delta) ? -ETIME : 0;
 }
 
-static void sparc64_timer_setup(enum clock_event_mode mode,
-				struct clock_event_device *evt)
-{
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		tick_ops->disable_irq();
-		break;
-
-	case CLOCK_EVT_MODE_PERIODIC:
-	case CLOCK_EVT_MODE_UNUSED:
-		WARN_ON(1);
-		break;
-	}
+static int sparc64_timer_shutdown(struct clock_event_device *evt)
+{
+	tick_ops->disable_irq();
+	return 0;
 }
 
 static struct clock_event_device sparc64_clockevent = {
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= sparc64_timer_setup,
-	.set_next_event	= sparc64_next_event,
-	.rating		= 100,
-	.shift		= 30,
-	.irq		= -1,
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= sparc64_timer_shutdown,
+	.set_next_event		= sparc64_next_event,
+	.rating			= 100,
+	.shift			= 30,
+	.irq			= -1,
 };
 static DEFINE_PER_CPU(struct clock_event_device, sparc64_events);
 
-- 
2.4.0

