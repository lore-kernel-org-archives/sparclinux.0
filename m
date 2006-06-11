From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 06:17:22 +0000
Subject: [PATCH 1/4] sparc32: add topology_init
Message-Id: <448BB572.6030706@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030604000503060301010900"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------030604000503060301010900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fix a crash in SMP mode by adding the missing topology_init.
Also makes /proc/cpuinfo backwards compatible with 2.4.

Signed-off-by: Bob Breuer <breuerr@mc.net>
---


--------------030604000503060301010900
Content-Type: text/plain;
 name="sparc32-topology_init.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32-topology_init.patch.txt"

--- linux-2.6.17-rc1/arch/sparc/kernel/setup.c.orig	2005-10-28 20:13:29.000000000 -0500
+++ linux-2.6.17-rc1/arch/sparc/kernel/setup.c	2006-04-03 23:59:43.000000000 -0500
@@ -31,6 +31,7 @@
 #include <linux/console.h>
 #include <linux/spinlock.h>
 #include <linux/root_dev.h>
+#include <linux/cpu.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -389,6 +390,8 @@ console_initcall(set_preferred_console);
 extern char *sparc_cpu_type;
 extern char *sparc_fpu_type;
 
+static int ncpus_probed;
+
 static int show_cpuinfo(struct seq_file *m, void *__unused)
 {
 	seq_printf(m,
@@ -411,7 +414,7 @@ static int show_cpuinfo(struct seq_file 
 		   romvec->pv_printrev >> 16,
 		   romvec->pv_printrev & 0xffff,
 		   &cputypval,
-		   num_possible_cpus(),
+		   ncpus_probed,
 		   num_online_cpus()
 #ifndef CONFIG_SMP
 		   , cpu_data(0).udelay_val/(500000/HZ),
@@ -471,3 +474,30 @@ void sun_do_break(void)
 
 int serial_console = -1;
 int stop_a_enabled = 1;
+
+static int __init topology_init(void)
+{
+	int i, ncpus, err;
+
+	/* Count the number of physically present processors in
+	 * the machine, even on uniprocessor, so that /proc/cpuinfo
+	 * output is consistent with 2.4.x
+	 */
+	ncpus = 0;
+	while (!cpu_find_by_instance(ncpus, NULL, NULL))
+		ncpus++;
+	ncpus_probed = ncpus;
+
+	err = 0;
+	for_each_online_cpu(i) {
+		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			err = -ENOMEM;
+		else
+			register_cpu(p, i, NULL);
+	}
+
+	return err;
+}
+
+subsys_initcall(topology_init);

--------------030604000503060301010900--
