From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 01 Feb 2017 19:34:38 +0000
Subject: [PATCH v3 2/4] sparc64: Migrate hvcons irq to panicked cpu
Message-Id: <1485977680-203775-3-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org, vijay.ac.kumar@oracle.com

On panic, all other CPUs are stopped except the one which had
hit panic. To keep console alive, we need to migrate hvcons irq
to panicked CPU.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
v2->v3: Added SERIAL_SUNHV conditional group for
        sunhv_migrate_hvcons_irq().
---
 arch/sparc/include/asm/setup.h |    5 ++++-
 arch/sparc/kernel/smp_64.c     |    6 +++++-
 drivers/tty/serial/sunhv.c     |    6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 29d64b1..478bf6b 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -59,8 +59,11 @@ static inline int con_is_present(void)
 extern atomic_t dcpage_flushes_xcall;
 
 extern int sysctl_tsb_ratio;
-#endif
 
+#ifdef CONFIG_SERIAL_SUNHV
+void sunhv_migrate_hvcons_irq(int cpu);
+#endif
+#endif
 void sun_do_break(void);
 extern int stop_a_enabled;
 extern int scons_pwroff;
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 712bf1b..90a02cb 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1452,8 +1452,12 @@ void smp_send_stop(void)
 	int cpu;
 
 	if (tlb_type = hypervisor) {
+		int this_cpu = smp_processor_id();
+#ifdef CONFIG_SERIAL_SUNHV
+		sunhv_migrate_hvcons_irq(this_cpu);
+#endif
 		for_each_online_cpu(cpu) {
-			if (cpu = smp_processor_id())
+			if (cpu = this_cpu)
 				continue;
 
 			set_cpu_online(cpu, false);
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 99ef5c6..039ae05 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -398,6 +398,12 @@ static int sunhv_verify_port(struct uart_port *port, struct serial_struct *ser)
 
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

