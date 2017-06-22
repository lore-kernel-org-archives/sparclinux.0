From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 22 Jun 2017 20:19:04 +0000
Subject: [v1] sparc64: fix typo in property
Message-Id: <1498162744-840346-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There is a typo in a comment that propogated into code:
upa-portis instead of upa-portid

This problem was detected by code inspection, and I am not sure if it
effects any current systems. It was not reproduced by QEMU.

It is likely that all existing implementations of OpenBoot have cpuid
property in cpu node.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reported-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/kernel/prom_64.c |    2 +-
 arch/sparc/kernel/time_64.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 20cc5d8..baeaeed 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -381,7 +381,7 @@ bool arch_find_n_match_cpu_physical_id(struct device_node *cpun,
 	int this_cpu_id;
 
 	/* On hypervisor based platforms we interrogate the 'reg'
-	 * property.  On everything else we look for a 'upa-portis',
+	 * property.  On everything else we look for a 'upa-portid',
 	 * 'portid', or 'cpuid' property.
 	 */
 
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index f584c53..564f0e4 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -175,8 +175,8 @@ static unsigned long cpuid_to_freq(phandle node, int cpuid)
 	if (prom_getproperty(node, "device_type", type, sizeof(type)) != -1)
 		is_cpu_node = (strcmp(type, "cpu") = 0);
 
-	/* try upa-portis then cpuid to get cpuid, see prom_64.c */
-	if (is_cpu_node && (prom_getint(node, "upa-portis") = cpuid ||
+	/* try upa-portid then cpuid to get cpuid, see prom_64.c */
+	if (is_cpu_node && (prom_getint(node, "upa-portid") = cpuid ||
 			    prom_getint(node, "cpuid") = cpuid))
 		freq = prom_getintdefault(node, "clock-frequency", 0);
 	if (!freq)
-- 
1.7.1

