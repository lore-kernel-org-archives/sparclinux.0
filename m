From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Sep 2013 13:14:34 +0000
Subject: [PATCH 208/228] cpufreq: sparc: remove calls to cpufreq_notify_transition()
Message-Id: <e9a2b8127585439a3428ebc222b3df1dbe88924e.1379063063.git.viresh.kumar@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Most of the drivers do following in their ->target_index() routines:

	struct cpufreq_freqs freqs;
	freqs.old = old freq...
	freqs.new = new freq...

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);

	/* Change rate here */

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);

This is replicated over all cpufreq drivers today and there doesn't exists a
good enough reason why this shouldn't be moved to cpufreq core instead.

Earlier patches have added support in cpufreq core to do cpufreq notification on
frequency change, this one removes it from this driver.

Some related minor cleanups are also done along with it.

Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 7 -------
 drivers/cpufreq/sparc-us3-cpufreq.c  | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index 3bf5b8f..62aa23e 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -251,7 +251,6 @@ static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned long new_bits, new_freq;
 	unsigned long clock_tick, divisor, old_divisor, estar;
 	cpumask_t cpus_allowed;
-	struct cpufreq_freqs freqs;
 
 	cpumask_copy(&cpus_allowed, tsk_cpus_allowed(current));
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
@@ -265,16 +264,10 @@ static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
 
 	old_divisor = estar_to_divisor(estar);
 
-	freqs.old = clock_tick / old_divisor;
-	freqs.new = new_freq;
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-
 	if (old_divisor != divisor)
 		us2e_transition(estar, new_bits, clock_tick * 1000,
 				old_divisor, divisor);
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 
 	return 0;
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 2e54d55..724ffbd 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -98,7 +98,6 @@ static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned int cpu = policy->cpu;
 	unsigned long new_bits, new_freq, reg;
 	cpumask_t cpus_allowed;
-	struct cpufreq_freqs freqs;
 
 	cpumask_copy(&cpus_allowed, tsk_cpus_allowed(current));
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
@@ -124,16 +123,10 @@ static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
 
 	reg = read_safari_cfg();
 
-	freqs.old = get_current_freq(cpu, reg);
-	freqs.new = new_freq;
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-
 	reg &= ~SAFARI_CFG_DIV_MASK;
 	reg |= new_bits;
 	write_safari_cfg(reg);
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 
 	return 0;
-- 
1.7.12.rc2.18.g61b472e

