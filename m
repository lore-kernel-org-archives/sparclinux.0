From: Jane Chu <jane.chu@oracle.com>
Date: Thu, 01 Jun 2017 21:39:13 +0000
Subject: [PATCH] arch/sparc: support NR_CPUS = 4096
Message-Id: <1496353153-587795-1-git-send-email-jane.chu@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, tglx@linutronix.de
Cc: atish.patra@oracle.com, Liam.Howlett@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jane.chu@oracle.com

Linux SPARC64 limits NR_CPUS to 4064 because init_cpu_send_mondo_info()
only allocates a single page for NR_CPUS mondo entries. Thus we cannot
use all 4096 CPUs on some SPARC platforms.

To fix, allocate (2^order) pages where order is set according to the size
of cpu_list for possible cpus. Since cpu_list_pa and cpu_mondo_block_pa
are not used in asm code, there are no imm13 offsets from the base PA
that will break because they can only reach one page.

Orabug: 25505750

Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Atish Patra <atish.patra@oracle.com>
---
 arch/sparc/Kconfig         |    4 ++--
 arch/sparc/kernel/irq_64.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 58243b0..4399be7 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -192,9 +192,9 @@ config NR_CPUS
 	int "Maximum number of CPUs"
 	depends on SMP
 	range 2 32 if SPARC32
-	range 2 1024 if SPARC64
+	range 2 4096 if SPARC64
 	default 32 if SPARC32
-	default 64 if SPARC64
+	default 4096 if SPARC64
 
 source kernel/Kconfig.hz
 
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 4d0248a..5b19108 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -1034,12 +1034,12 @@ static void __init init_cpu_send_mondo_info(struct trap_per_cpu *tb)
 {
 #ifdef CONFIG_SMP
 	unsigned long page;
+	unsigned int order;
 
-	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > (PAGE_SIZE - 64));
-
-	page = get_zeroed_page(GFP_KERNEL);
+	order = get_order(num_possible_cpus() * sizeof(u16) + 64);
+	page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!page) {
-		prom_printf("SUN4V: Error, cannot allocate cpu mondo page.\n");
+		prom_printf("SUN4V: Error, cannot allocate cpu mondo pages.\n");
 		prom_halt();
 	}
 
-- 
1.7.1

