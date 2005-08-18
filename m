From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 18 Aug 2005 05:16:02 +0000
Subject: Re: Questions on CPU frequency drivers for UltraSPARC IIe and III
Message-Id: <20050817.221602.44053567.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817221559.71501529@enterprise.weeve.org>
In-Reply-To: <20050817221559.71501529@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Jason, give this patch a spin, it should clear up the two
bugs you spotted.

1) The clock tick values given to the cpufreq layer need to be
   in KHZ not MHZ.

2) The us2e/us3 drivers were not providing a "->get()" method which
   is why the cpuinfo_cur_freq sysfs field was not provided.

Thanks.

diff --git a/arch/sparc64/kernel/us2e_cpufreq.c b/arch/sparc64/kernel/us2e_cpufreq.c
--- a/arch/sparc64/kernel/us2e_cpufreq.c
+++ b/arch/sparc64/kernel/us2e_cpufreq.c
@@ -88,7 +88,6 @@ static void frob_mem_refresh(int cpu_slo
 {
 	unsigned long old_refr_count, refr_count, mctrl;
 
-
 	refr_count  = (clock_tick * MCTRL0_REFR_INTERVAL);
 	refr_count /= (MCTRL0_REFR_CLKS_P_CNT * divisor * 1000000000UL);
 
@@ -230,6 +229,25 @@ static unsigned long estar_to_divisor(un
 	return ret;
 }
 
+static unsigned int us2e_freq_get(unsigned int cpu)
+{
+	cpumask_t cpus_allowed;
+	unsigned long clock_tick, estar;
+
+	if (!cpu_online(cpu))
+		return 0;
+
+	cpus_allowed = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+	clock_tick = sparc64_get_clock_tick(cpu) / 1000;
+	estar = read_hbreg(HBIRD_ESTAR_MODE_ADDR);
+
+	set_cpus_allowed(current, cpus_allowed);
+
+	return clock_tick / estar_to_divisor(estar);
+}
+
 static void us2e_set_cpu_divider_index(unsigned int cpu, unsigned int index)
 {
 	unsigned long new_bits, new_freq;
@@ -243,7 +261,7 @@ static void us2e_set_cpu_divider_index(u
 	cpus_allowed = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 
-	new_freq = clock_tick = sparc64_get_clock_tick(cpu);
+	new_freq = clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	new_bits = index_to_estar_mode(index);
 	divisor = index_to_divisor(index);
 	new_freq /= divisor;
@@ -258,7 +276,8 @@ static void us2e_set_cpu_divider_index(u
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	if (old_divisor != divisor)
-		us2e_transition(estar, new_bits, clock_tick, old_divisor, divisor);
+		us2e_transition(estar, new_bits, clock_tick * 1000,
+				old_divisor, divisor);
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
@@ -272,10 +291,8 @@ static int us2e_freq_target(struct cpufr
 	unsigned int new_index = 0;
 
 	if (cpufreq_frequency_table_target(policy,
-					      &us2e_freq_table[policy->cpu].table[0],
-					      target_freq,
-					      relation,
-					      &new_index))
+					   &us2e_freq_table[policy->cpu].table[0],
+					   target_freq, relation, &new_index))
 		return -EINVAL;
 
 	us2e_set_cpu_divider_index(policy->cpu, new_index);
@@ -292,7 +309,7 @@ static int us2e_freq_verify(struct cpufr
 static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
-	unsigned long clock_tick = sparc64_get_clock_tick(cpu);
+	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	struct cpufreq_frequency_table *table  		&us2e_freq_table[cpu].table[0];
 
@@ -351,9 +368,10 @@ static int __init us2e_freq_init(void)
 		memset(us2e_freq_table, 0,
 		       (NR_CPUS * sizeof(struct us2e_freq_percpu_info)));
 
+		driver->init = us2e_freq_cpu_init;
 		driver->verify = us2e_freq_verify;
 		driver->target = us2e_freq_target;
-		driver->init = us2e_freq_cpu_init;
+		driver->get = us2e_freq_get;
 		driver->exit = us2e_freq_cpu_exit;
 		driver->owner = THIS_MODULE,
 		strcpy(driver->name, "UltraSPARC-IIe");
diff --git a/arch/sparc64/kernel/us3_cpufreq.c b/arch/sparc64/kernel/us3_cpufreq.c
--- a/arch/sparc64/kernel/us3_cpufreq.c
+++ b/arch/sparc64/kernel/us3_cpufreq.c
@@ -56,7 +56,7 @@ static void write_safari_cfg(unsigned lo
 
 static unsigned long get_current_freq(unsigned int cpu, unsigned long safari_cfg)
 {
-	unsigned long clock_tick = sparc64_get_clock_tick(cpu);
+	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	unsigned long ret;
 
 	switch (safari_cfg & SAFARI_CFG_DIV_MASK) {
@@ -76,6 +76,26 @@ static unsigned long get_current_freq(un
 	return ret;
 }
 
+static unsigned int us3_freq_get(unsigned int cpu)
+{
+	cpumask_t cpus_allowed;
+	unsigned long reg;
+	unsigned int ret;
+
+	if (!cpu_online(cpu))
+		return 0;
+
+	cpus_allowed = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+	reg = read_safari_cfg();
+	ret = get_current_freq(cpu, reg);
+
+	set_cpus_allowed(current, cpus_allowed);
+
+	return ret;
+}
+
 static void us3_set_cpu_divider_index(unsigned int cpu, unsigned int index)
 {
 	unsigned long new_bits, new_freq, reg;
@@ -88,7 +108,7 @@ static void us3_set_cpu_divider_index(un
 	cpus_allowed = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 
-	new_freq = sparc64_get_clock_tick(cpu);
+	new_freq = sparc64_get_clock_tick(cpu) / 1000;
 	switch (index) {
 	case 0:
 		new_bits = SAFARI_CFG_DIV_1;
@@ -150,7 +170,7 @@ static int us3_freq_verify(struct cpufre
 static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
-	unsigned long clock_tick = sparc64_get_clock_tick(cpu);
+	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	struct cpufreq_frequency_table *table  		&us3_freq_table[cpu].table[0];
 
@@ -206,9 +226,10 @@ static int __init us3_freq_init(void)
 		memset(us3_freq_table, 0,
 		       (NR_CPUS * sizeof(struct us3_freq_percpu_info)));
 
+		driver->init = us3_freq_cpu_init;
 		driver->verify = us3_freq_verify;
 		driver->target = us3_freq_target;
-		driver->init = us3_freq_cpu_init;
+		driver->get = us3_freq_get;
 		driver->exit = us3_freq_cpu_exit;
 		driver->owner = THIS_MODULE,
 		strcpy(driver->name, "UltraSPARC-III");
