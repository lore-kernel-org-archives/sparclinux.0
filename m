From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sat, 31 Aug 2019 05:58:23 +0000
Subject: [PATCH v2 9/9] mips: numa: check the node id consistently for mips loongson64
Message-Id: <1567231103-13237-10-git-send-email-linyunsheng@huawei.com>
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

Since mips loongson64 uses __node_data instead of
node_to_cpumask_map, this patch checks node id with the below
case before returning &__node_data[node]->cpumask:
1. if node_id >= MAX_NUMNODES, return cpu_none_mask
2. if node_id < 0, return cpu_online_mask
3. if hub_data(node) is NULL, return cpu_online_mask

[1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 arch/mips/include/asm/mach-loongson64/topology.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index 7ff819a..b19b983 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -5,7 +5,17 @@
 #ifdef CONFIG_NUMA
 
 #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
-#define cpumask_of_node(node)	(&__node_data[(node)]->cpumask)
+
+static inline const struct cpumask *cpumask_of_node(int node)
+{
+	if (node >= MAX_NUMNODES)
+		return cpu_none_mask;
+
+	if (node < 0 || !__node_data[node])
+		return cpu_online_mask;
+
+	return &__node_data[node]->cpumask;
+}
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.8.1
