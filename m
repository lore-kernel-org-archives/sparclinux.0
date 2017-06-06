From: Jane Chu <jane.chu@oracle.com>
Date: Tue, 06 Jun 2017 20:32:29 +0000
Subject: [PATCH v3] arch/sparc: support NR_CPUS = 4096
Message-Id: <1496781149-648310-1-git-send-email-jane.chu@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, tglx@linutronix.de, bob.picco@oracle.com, steven.sistare@oracle.com, atish.patra@oracle.com
Cc: Liam.Howlett@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jane.chu@oracle.com

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
 arch/sparc/kernel/irq_64.c |   17 +++++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

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
index 4d0248a..99dd133 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -1034,17 +1034,26 @@ static void __init init_cpu_send_mondo_info(struct trap_per_cpu *tb)
 {
 #ifdef CONFIG_SMP
 	unsigned long page;
+	void *mondo, *p;
 
-	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > (PAGE_SIZE - 64));
+	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > PAGE_SIZE);
+
+	/* Make sure mondo block is 64byte aligned */
+	p = kzalloc(127, GFP_KERNEL);
+	if (!p) {
+		prom_printf("SUN4V: Error, cannot allocate mondo block.\n");
+		prom_halt();
+	}
+	mondo = (void *)(((unsigned long)p + 63) & ~0x3f);
+	tb->cpu_mondo_block_pa = __pa(mondo);
 
 	page = get_zeroed_page(GFP_KERNEL);
 	if (!page) {
-		prom_printf("SUN4V: Error, cannot allocate cpu mondo page.\n");
+		prom_printf("SUN4V: Error, cannot allocate cpu list page.\n");
 		prom_halt();
 	}
 
-	tb->cpu_mondo_block_pa = __pa(page);
-	tb->cpu_list_pa = __pa(page + 64);
+	tb->cpu_list_pa = __pa(page);
 #endif
 }
 
-- 
1.7.1

