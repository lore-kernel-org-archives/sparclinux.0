From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sat, 31 Aug 2019 05:58:18 +0000
Subject: [PATCH v2 4/9] powerpc: numa: check the node id consistently for powerpc
Message-Id: <1567231103-13237-5-git-send-email-linyunsheng@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com
Cc: linux-sh@vger.kernel.org, peterz@infradead.org, dave.hansen@linux.intel.com, linuxarm@huawei.com, linux-mips@vger.kernel.org, mwb@linux.vnet.ibm.com, hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, rppt@linux.ibm.com, dledford@redhat.com, jeffrey.t.kirsher@intel.com, nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, len.brown@intel.com, anshuman.khandual@arm.com, cai@lca.pw, luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, axboe@kernel.dk, robin.murphy@arm.com, linux-kernel@vger.kernel.org, tbogendoerfer@suse.de, linux-alpha@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org

According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
of proximity domain is optional, as below:

This optional object is used to describe proximity domain
associations within a machine. _PXM evaluates to an integer
that identifies a device as belonging to a Proximity Domain
defined in the System Resource Affinity Table (SRAT).

This patch checks node id with the below case before returning
node_to_cpumask_map[node]:
1. if node_id >= nr_node_ids, return cpu_none_mask
2. if node_id < 0, return cpu_online_mask
3. if node_to_cpumask_map[node_id] is NULL, return cpu_online_mask

[1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 arch/powerpc/include/asm/topology.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 2f7e1ea..217dc9b 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -17,9 +17,16 @@ struct device_node;
 
 #include <asm/mmzone.h>
 
-#define cpumask_of_node(node) ((node) = -1 ?				\
-			       cpu_all_mask :				\
-			       node_to_cpumask_map[node])
+static inline const struct cpumask *cpumask_of_node(int node)
+{
+	if (node >= nr_node_ids)
+		return cpu_none_mask;
+
+	if (node < 0 || !node_to_cpumask_map[node])
+		return cpu_online_mask;
+
+	return node_to_cpumask_map[node];
+}
 
 struct pci_bus;
 #ifdef CONFIG_PCI
-- 
2.8.1
