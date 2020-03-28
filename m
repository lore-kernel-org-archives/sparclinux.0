From: Hoan Tran <Hoan@os.amperecomputing.com>
Date: Sat, 28 Mar 2020 18:31:22 +0000
Subject: [PATCH v3 5/5] s390: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Message-Id: <1585420282-25630-6-git-send-email-Hoan@os.amperecomputing.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, lho@amperecomputing.com, mmorana@amperecomputing.com, x86@kernel.org, linux-kernel@vger.kernel.org, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Hoan Tran <Hoan@os.amperecomputing.com>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled
by default with NUMA.

Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
---
 arch/s390/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bc88841..d86066e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -449,14 +449,6 @@ config NR_CPUS
 config HOTPLUG_CPU
 	def_bool y
 
-# Some NUMA nodes have memory ranges that span
-# other nodes.	Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.	See memmap_init_zone()
-# for details. <- They meant memory holes!
-config NODES_SPAN_OTHER_NODES
-	def_bool NUMA
-
 config NUMA
 	bool "NUMA support"
 	depends on SCHED_TOPOLOGY
-- 
1.8.3.1
