From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Sep 2013 13:12:00 +0000
Subject: [PATCH 054/228] cpufreq: sparc: call cpufreq_frequency_table_put_attr()
Message-Id: <7baecf8302d921d18afa8fc7447e68e41eb434e8.1379063063.git.viresh.kumar@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
they have called cpufreq_frequency_table_get_attr() in their init path.

This driver was missing this part and is fixed with this patch.

Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 4 +++-
 drivers/cpufreq/sparc-us3-cpufreq.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index e35840d..8db0c18 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -329,8 +329,10 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 
 static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (cpufreq_us2e_driver)
+	if (cpufreq_us2e_driver) {
+		cpufreq_frequency_table_put_attr(policy->cpu);
 		us2e_set_cpu_divider_index(policy, 0);
+	}
 
 	return 0;
 }
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 23f2d3b..120a2df 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -186,8 +186,10 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 
 static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (cpufreq_us3_driver)
+	if (cpufreq_us3_driver) {
+		cpufreq_frequency_table_put_attr(policy->cpu);
 		us3_set_cpu_divider_index(policy, 0);
+	}
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

