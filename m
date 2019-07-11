From: Hoan Tran OS <hoan@os.amperecomputing.com>
Date: Thu, 11 Jul 2019 23:25:49 +0000
Subject: [PATCH v2 2/5] powerpc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Message-Id: <1562887528-5896-3-git-send-email-Hoan@os.amperecomputing.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Hoan Tran OS <hoan@os.amperecomputing.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled by
default with NUMA.

Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
---
 arch/powerpc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c1c636..bdde8bc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -629,15 +629,6 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on NEED_MULTIPLE_NODES
-
 config STDBINUTILS
 	bool "Using standard binutils settings"
 	depends on 44x
-- 
2.7.4
