From: David Miller <davem@davemloft.net>
Date: Thu, 19 Mar 2015 02:16:44 +0000
Subject: [PATCH] sparc: Fix /proc/kcore
Message-Id: <20150318.221644.1812020402880708625.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


/proc/kcore investigates the "System RAM" elements in /proc/iomem to
initialize it's memory tables.  Therefore we have to register them
before it tries to do so.  kcore uses device_initcall() so let's
use arch_initcall() for the registry.

Also we need ARCH_PROC_KCORE_TEXT to get the virtual addresses of
the kernel image correct.

Reported-by: David Ahern <david.ahern@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig      | 3 +++
 arch/sparc/mm/init_64.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 96ac69c..efb00ec 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -86,6 +86,9 @@ config ARCH_DEFCONFIG
 	default "arch/sparc/configs/sparc32_defconfig" if SPARC32
 	default "arch/sparc/configs/sparc64_defconfig" if SPARC64
 
+config ARCH_PROC_KCORE_TEXT
+	def_bool y
+
 config IOMMU_HELPER
 	bool
 	default y if SPARC64
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3ea267c..4ca0d6b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2820,7 +2820,7 @@ static int __init report_memory(void)
 
 	return 0;
 }
-device_initcall(report_memory);
+arch_initcall(report_memory);
 
 #ifdef CONFIG_SMP
 #define do_flush_tlb_kernel_range	smp_flush_tlb_kernel_range
-- 
2.1.2.532.g19b5d50

