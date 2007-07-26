From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2007 00:10:05 +0000
Subject: Re: [Bugme-new] [Bug 8811] New: us3_cpufreq not working on blade
Message-Id: <20070725.171005.21898354.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070725161440.0b49cbd4.akpm@linux-foundation.org>
In-Reply-To: <20070725161440.0b49cbd4.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 25 Jul 2007 16:14:40 -0700

> > Steps to reproduce:
> > 1. Load the us3_cpufreq kernel module
> > 2. Set the governor to powersave

What does the kernel print in the logs during these attempted
cpufreq changes with the following debugging patch applied?

diff --git a/arch/sparc64/kernel/us3_cpufreq.c b/arch/sparc64/kernel/us3_cpufreq.c
index 47e3aca..521d865 100644
--- a/arch/sparc64/kernel/us3_cpufreq.c
+++ b/arch/sparc64/kernel/us3_cpufreq.c
@@ -141,6 +141,10 @@ static void us3_set_cpu_divider_index(unsigned int cpu, unsigned int index)
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	set_cpus_allowed(current, cpus_allowed);
+#if 1
+	printk(KERN_ERR "US3: Wrote %lx (index %x) to SAFARI_CFG on cpu %u\n",
+	       reg, index, cpu);
+#endif
 }
 
 static int us3_freq_target(struct cpufreq_policy *policy,
