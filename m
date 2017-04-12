From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 12 Apr 2017 20:07:32 +0000
Subject: [patch 06/13] sparc/sysfs: Replace racy task affinity logic
Message-Id: <20170412201042.612462984@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170412200726.941336635@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, sparclinux@vger.kernel.org

The mmustat_enable sysfs file accessor functions must run code on the
target CPU. This is achieved by temporarily setting the affinity of the
calling user space thread to the requested CPU and reset it to the original
affinity afterwards.

That's racy vs. concurrent affinity settings for that thread resulting in
code executing on the wrong CPU and overwriting the new affinity setting.

Replace it by using work_on_cpu() which guarantees to run the code on the
requested CPU.

Protection against CPU hotplug is not required as the open sysfs file
already prevents the removal from the CPU offline callback. Using the
hotplug protected version would actually be wrong because it would deadlock
against a CPU hotplug operation of the CPU associated to the sysfs file in
progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/sysfs.c |   36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -98,27 +98,7 @@ static struct attribute_group mmu_stat_g
 	.name = "mmu_stats",
 };
 
-/* XXX convert to rusty's on_one_cpu */
-static unsigned long run_on_cpu(unsigned long cpu,
-			        unsigned long (*func)(unsigned long),
-				unsigned long arg)
-{
-	cpumask_t old_affinity;
-	unsigned long ret;
-
-	cpumask_copy(&old_affinity, &current->cpus_allowed);
-	/* should return -EINVAL to userspace */
-	if (set_cpus_allowed_ptr(current, cpumask_of(cpu)))
-		return 0;
-
-	ret = func(arg);
-
-	set_cpus_allowed_ptr(current, &old_affinity);
-
-	return ret;
-}
-
-static unsigned long read_mmustat_enable(unsigned long junk)
+static long read_mmustat_enable(void *data __maybe_unused)
 {
 	unsigned long ra = 0;
 
@@ -127,11 +107,11 @@ static unsigned long read_mmustat_enable
 	return ra != 0;
 }
 
-static unsigned long write_mmustat_enable(unsigned long val)
+static long write_mmustat_enable(void *data)
 {
-	unsigned long ra, orig_ra;
+	unsigned long ra, orig_ra, *val = data;
 
-	if (val)
+	if (*val)
 		ra = __pa(&per_cpu(mmu_stats, smp_processor_id()));
 	else
 		ra = 0UL;
@@ -142,7 +122,8 @@ static unsigned long write_mmustat_enabl
 static ssize_t show_mmustat_enable(struct device *s,
 				struct device_attribute *attr, char *buf)
 {
-	unsigned long val = run_on_cpu(s->id, read_mmustat_enable, 0);
+	long val = work_on_cpu(s->id, read_mmustat_enable, 0);
+
 	return sprintf(buf, "%lx\n", val);
 }
 
@@ -150,13 +131,14 @@ static ssize_t store_mmustat_enable(stru
 			struct device_attribute *attr, const char *buf,
 			size_t count)
 {
-	unsigned long val, err;
 	int ret = sscanf(buf, "%lu", &val);
+	unsigned long val;
+	long err;
 
 	if (ret != 1)
 		return -EINVAL;
 
-	err = run_on_cpu(s->id, write_mmustat_enable, val);
+	err = work_on_cpu(s->id, write_mmustat_enable, &val);
 	if (err)
 		return -EIO;
 


