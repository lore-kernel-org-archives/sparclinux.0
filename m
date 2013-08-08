From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 08 Aug 2013 14:00:06 +0000
Subject: [PATCH 04/35] cpufreq: sparc: call cpufreq_frequency_table_get_attr()
Message-Id: <2a23a50adec189d064cb934e7f3568ab0367d3c4.1375964117.git.viresh.kumar@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This exposes frequency table of driver to cpufreq core and is required for core
to guess what the index for a target frequency is, when it calls
cpufreq_frequency_table_target(). And so this driver needs to expose it.

Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 6 +++++-
 drivers/cpufreq/sparc-us3-cpufreq.c  | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index cf5bc2c..80e6d92 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -307,6 +307,7 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	struct cpufreq_frequency_table *table  		&us2e_freq_table[cpu].table[0];
+	int ret;
 
 	table[0].driver_data = 0;
 	table[0].frequency = clock_tick / 1;
@@ -324,7 +325,10 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 0;
 	policy->cur = clock_tick;
 
-	return cpufreq_frequency_table_cpuinfo(policy, table);
+	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (!ret)
+		cpufreq_frequency_table_get_attr(table, policy->cpu);
+	return ret;
 }
 
 static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index ac76b48..73a90de 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -168,6 +168,7 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	struct cpufreq_frequency_table *table  		&us3_freq_table[cpu].table[0];
+	int ret;
 
 	table[0].driver_data = 0;
 	table[0].frequency = clock_tick / 1;
@@ -181,7 +182,11 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 0;
 	policy->cur = clock_tick;
 
-	return cpufreq_frequency_table_cpuinfo(policy, table);
+	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (!ret)
+		cpufreq_frequency_table_get_attr(table, policy->cpu);
+
+	return ret;
 }
 
 static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.12.rc2.18.g61b472e

