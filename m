From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Sep 2013 13:12:32 +0000
Subject: [PATCH 086/228] cpufreq: sparc: Use generic cpufreq routines
Message-Id: <5cf8e2c2fb92577ef065fa85abeef68fa52a9b59.1379063063.git.viresh.kumar@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 8 +-------
 drivers/cpufreq/sparc-us3-cpufreq.c  | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index 8db0c18..291688c 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -295,12 +295,6 @@ static int us2e_freq_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
-static int us2e_freq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy,
-					      &us2e_freq_table[policy->cpu].table[0]);
-}
-
 static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -363,7 +357,7 @@ static int __init us2e_freq_init(void)
 			goto err_out;
 
 		driver->init = us2e_freq_cpu_init;
-		driver->verify = us2e_freq_verify;
+		driver->verify = cpufreq_generic_frequency_table_verify;
 		driver->target = us2e_freq_target;
 		driver->get = us2e_freq_get;
 		driver->exit = us2e_freq_cpu_exit;
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 120a2df..9b3dbd3 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -156,12 +156,6 @@ static int us3_freq_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
-static int us3_freq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy,
-					      &us3_freq_table[policy->cpu].table[0]);
-}
-
 static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -224,7 +218,7 @@ static int __init us3_freq_init(void)
 			goto err_out;
 
 		driver->init = us3_freq_cpu_init;
-		driver->verify = us3_freq_verify;
+		driver->verify = cpufreq_generic_frequency_table_verify;
 		driver->target = us3_freq_target;
 		driver->get = us3_freq_get;
 		driver->exit = us3_freq_cpu_exit;
-- 
1.7.12.rc2.18.g61b472e

