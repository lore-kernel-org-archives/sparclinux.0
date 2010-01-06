From: Anton Blanchard <anton@samba.org>
Date: Wed, 06 Jan 2010 04:55:14 +0000
Subject: [patch 5/6] sparc: cpumask_of_node() should handle -1 as a node
Message-Id: <20100106045525.329010098@samba.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20100106045509.245662398@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>

pcibus_to_node can return -1 if we cannot determine which node a pci bus
is on. If passed -1, cpumask_of_node will negatively index the lookup array
and pull in random data:

# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
00000000,00000003,00000000,00000000
# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
64-65

Change cpumask_of_node to check for -1 and return cpu_all_mask in this
case:

# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
ffffffff,ffffffff,ffffffff,ffffffff
# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
0-127

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/sparc/include/asm/topology_64.h
=================================--- linux-cpumask.orig/arch/sparc/include/asm/topology_64.h	2010-01-06 15:20:22.912584116 +1100
+++ linux-cpumask/arch/sparc/include/asm/topology_64.h	2010-01-06 15:27:17.209419879 +1100
@@ -12,7 +12,9 @@ static inline int cpu_to_node(int cpu)
 
 #define parent_node(node)	(node)
 
-#define cpumask_of_node(node) (&numa_cpumask_lookup_table[node])
+#define cpumask_of_node(node) ((node) = -1 ?				\
+			       cpu_all_mask :				\
+			       &numa_cpumask_lookup_table[node])
 
 struct pci_bus;
 #ifdef CONFIG_PCI

-- 

