From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 13 Apr 2017 08:17:07 +0000
Subject: [patch V2 06/13] sparc/sysfs: Replace racy task affinity logic
Message-Id: <alpine.DEB.2.20.1704131001270.2408@nanos>
List-Id: <sparclinux.vger.kernel.org>
References: <20170412200726.941336635@linutronix.de> <20170412201042.612462984@linutronix.de> <20170412.215206.1568460664651298892.davem@davemloft.net>
In-Reply-To: <20170412.215206.1568460664651298892.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org, bigeasy@linutronix.de, benh@kernel.crashing.org, fenghua.yu@intel.com, herbert@gondor.apana.org.au, jiangshanlai@gmail.com, lenb@kernel.org, mpe@ellerman.id.au, rjw@rjwysocki.net, tj@kernel.org, tony.luck@intel.com, viresh.kumar@linaro.org, sparclinux@vger.kernel.org

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
Acked-by: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---

V2: Use NULL instead of 0 (David), fix compile breakage (build-bot)

 arch/sparc/kernel/sysfs.c |   39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

Index: b/arch/sparc/kernel/sysfs.c
=================================--- a/arch/sparc/kernel/sysfs.c
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
+	long val = work_on_cpu(s->id, read_mmustat_enable, NULL);
+
 	return sprintf(buf, "%lx\n", val);
 }
 
@@ -150,13 +131,15 @@ static ssize_t store_mmustat_enable(stru
 			struct device_attribute *attr, const char *buf,
 			size_t count)
 {
-	unsigned long val, err;
-	int ret = sscanf(buf, "%lu", &val);
+	unsigned long val;
+	long err;
+	int ret;
 
+	ret = sscanf(buf, "%lu", &val);
 	if (ret != 1)
 		return -EINVAL;
 
-	err = run_on_cpu(s->id, write_mmustat_enable, val);
+	err = work_on_cpu(s->id, write_mmustat_enable, &val);
 	if (err)
 		return -EIO;
 

