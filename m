From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 13 Sep 2019 18:19:52 +0000
Subject: [RFC PATCH v2 11/12] arm: smp: use SMP crash-stop common code
Message-Id: <20190913181953.45748-12-cristian.marussi@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org

Make arm use the SMP common implementation of crash_smp_send_stop() and
its generic logic, by removing the arm crash_smp_send_stop() definition
and providing the needed arch specific helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/arm/kernel/machine_kexec.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 76300f3813e8..d53973cae362 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -29,8 +29,6 @@ extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
 extern unsigned long kexec_boot_atags;
 
-static atomic_t waiting_for_crash_ipi;
-
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
@@ -89,34 +87,21 @@ void machine_crash_nonpanic_core(void *unused)
 	crash_save_cpu(&regs, smp_processor_id());
 	flush_cache_all();
 
+	/* ensure saved regs writes are visible before going offline */
+	smp_wmb();
 	set_cpu_online(smp_processor_id(), false);
-	atomic_dec(&waiting_for_crash_ipi);
 
+	/* ensure all writes visible before parking */
+	wmb();
 	while (1) {
 		cpu_relax();
 		wfe();
 	}
 }
 
-void crash_smp_send_stop(void)
+void arch_smp_crash_call(cpumask_t *cpus, unsigned int __unused)
 {
-	static int cpus_stopped;
-	unsigned long msecs;
-
-	if (cpus_stopped)
-		return;
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("Non-crashing CPUs did not react to IPI\n");
-
-	cpus_stopped = 1;
+	smp_call_function_many(cpus, machine_crash_nonpanic_core, NULL, false);
 }
 
 static void machine_kexec_mask_interrupts(void)
-- 
2.17.1
