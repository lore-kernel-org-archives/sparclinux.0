From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Jun 2017 14:40:59 +0000
Subject: [v1 2/2] sparc64: broken %tick frequency on spitfire cpus
Message-Id: <1497537659-419752-3-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After early boot time stamps project the %tick frequency is detected
incorrectly on spittfire cpus.

We must use cpuid of boot cpu to find corresponding cpu node in OpenBoot,
and extract clock-frequency property from there.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/sparc/kernel/time_64.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index a62758c..f584c53 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -162,9 +162,34 @@ static unsigned long tick_add_tick(unsigned long adj)
 	return new_tick;
 }
 
+/* Searches for cpu clock frequency with given cpuid in OpenBoot tree */
+static unsigned long cpuid_to_freq(phandle node, int cpuid)
+{
+	bool is_cpu_node = false;
+	unsigned long freq = 0;
+	char type[128];
+
+	if (!node)
+		return freq;
+
+	if (prom_getproperty(node, "device_type", type, sizeof(type)) != -1)
+		is_cpu_node = (strcmp(type, "cpu") = 0);
+
+	/* try upa-portis then cpuid to get cpuid, see prom_64.c */
+	if (is_cpu_node && (prom_getint(node, "upa-portis") = cpuid ||
+			    prom_getint(node, "cpuid") = cpuid))
+		freq = prom_getintdefault(node, "clock-frequency", 0);
+	if (!freq)
+		freq = cpuid_to_freq(prom_getchild(node), cpuid);
+	if (!freq)
+		freq = cpuid_to_freq(prom_getsibling(node), cpuid);
+
+	return freq;
+}
+
 static unsigned long tick_get_frequency(void)
 {
-	return local_cpu_data().clock_tick;
+	return cpuid_to_freq(prom_root_node, hard_smp_processor_id());
 }
 
 static struct sparc64_tick_ops tick_operations __cacheline_aligned = {
-- 
1.7.1

