From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 11 Nov 2016 18:11:57 +0000
Subject: [PATCH v2 2/4] sparc64: Migrate hvcons irq to panicked cpu
Message-Id: <1478887919-10361-3-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1478887919-10361-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1478887919-10361-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org

On panic, all other CPUs are stopped except the one which had
hit panic. To keep console alive, we need to migrate hvcons irq
to panicked CPU.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/include/asm/setup.h |    1 +
 arch/sparc/kernel/smp_64.c     |    6 +++++-
 drivers/tty/serial/sunhv.c     |    6 ++++++
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 29d64b1..41691a5 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -61,6 +61,7 @@ extern atomic_t dcpage_flushes_xcall;
 extern int sysctl_tsb_ratio;
 #endif
 
+void sunhv_migrate_hvcons_irq(int cpu);
 void sun_do_break(void);
 extern int stop_a_enabled;
 extern int scons_pwroff;
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 14138ad..52dc4b7 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1444,8 +1444,12 @@ void smp_send_stop(void)
 	int cpu;
 
 	if (tlb_type = hypervisor) {
+		int this_cpu = smp_processor_id();
+
+		sunhv_migrate_hvcons_irq(this_cpu);
+
 		for_each_online_cpu(cpu) {
-			if (cpu = smp_processor_id())
+			if (cpu = this_cpu)
 				continue;
 
 			set_cpu_online(cpu, false);
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 4e603d0..59828d8 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -398,6 +398,12 @@ static struct uart_driver sunhv_reg = {
 
 static struct uart_port *sunhv_port;
 
+void sunhv_migrate_hvcons_irq(int cpu)
+{
+	/* Migrate hvcons irq to param cpu */
+	irq_force_affinity(sunhv_port->irq, cpumask_of(cpu));
+}
+
 /* Copy 's' into the con_write_page, decoding "\n" into
  * "\r\n" along the way.  We have to return two lengths
  * because the caller needs to know how much to advance
-- 
1.7.1

