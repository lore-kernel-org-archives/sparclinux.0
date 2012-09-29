From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 29 Sep 2012 13:14:49 +0000
Subject: [PATCH] sparc: fix format string argument for prom_printf()
Message-Id: <1348924489-28256-1-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

prom_printf() takes printf style arguments.  Specifing GCC's format
attribute reveals that there are several wrong usages of prom_printf().

This fixes those wrong format strings and arguments, and also leaves
format attributes in order to detect similar mistakes at compile time.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/oplib_32.h | 2 +-
 arch/sparc/include/asm/oplib_64.h | 2 +-
 arch/sparc/kernel/hvapi.c         | 2 +-
 arch/sparc/kernel/prom_64.c       | 2 +-
 arch/sparc/kernel/traps_64.c      | 2 +-
 arch/sparc/mm/init_64.c           | 7 ++++---
 arch/sparc/mm/iommu.c             | 4 ++--
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 2751787..c72f304 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -94,7 +94,7 @@ extern int prom_getprev(void);
 extern void prom_console_write_buf(const char *buf, int len);
 
 /* Prom's internal routines, don't use in kernel/boot code. */
-extern void prom_printf(const char *fmt, ...);
+extern __printf(1, 2) void prom_printf(const char *fmt, ...);
 extern void prom_write(const char *buf, unsigned int len);
 
 /* Multiprocessor operations... */
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index 97a9047..a12dbe3 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -98,7 +98,7 @@ extern unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
 extern void prom_console_write_buf(const char *buf, int len);
 
 /* Prom's internal routines, don't use in kernel/boot code. */
-extern void prom_printf(const char *fmt, ...);
+extern __printf(1, 2) void prom_printf(const char *fmt, ...);
 extern void prom_write(const char *buf, unsigned int len);
 
 /* Multiprocessor operations... */
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 8593672..ccf18e0 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -193,7 +193,7 @@ void __init sun4v_hvapi_init(void)
 
 bad:
 	prom_printf("HVAPI: Cannot register API group "
-		    "%lx with major(%u) minor(%u)\n",
+		    "%lx with major(%lu) minor(%lu)\n",
 		    group, major, minor);
 	prom_halt();
 }
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 340c5b9..d397d7f 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -37,7 +37,7 @@ void * __init prom_early_alloc(unsigned long size)
 	void *ret;
 
 	if (!paddr) {
-		prom_printf("prom_early_alloc(%lu) failed\n");
+		prom_printf("prom_early_alloc(%lu) failed\n", size);
 		prom_halt();
 	}
 
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 3b05e66..fa1f1d3 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -850,7 +850,7 @@ void __init cheetah_ecache_flush_init(void)
 	ecache_flush_physbase = find_ecache_flush_span(ecache_flush_size);
 
 	if (ecache_flush_physbase = ~0UL) {
-		prom_printf("cheetah_ecache_flush_init: Cannot find %d byte "
+		prom_printf("cheetah_ecache_flush_init: Cannot find %ld byte "
 			    "contiguous physical memory.\n",
 			    ecache_flush_size);
 		prom_halt();
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index d58edf5..29c8ebe 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -101,7 +101,8 @@ static void __init read_obp_memory(const char *property,
 
 	ret = prom_getproperty(node, property, (char *) regs, prop_size);
 	if (ret = -1) {
-		prom_printf("Couldn't get %s property from /memory.\n");
+		prom_printf("Couldn't get %s property from /memory.\n",
+				property);
 		prom_halt();
 	}
 
@@ -462,7 +463,7 @@ static void __init read_obp_translations(void)
 		prom_halt();
 	}
 	if (unlikely(n > sizeof(prom_trans))) {
-		prom_printf("prom_mappings: Size %Zd is too big.\n", n);
+		prom_printf("prom_mappings: Size %d is too big.\n", n);
 		prom_halt();
 	}
 
@@ -524,7 +525,7 @@ static void __init hypervisor_tlb_lock(unsigned long vaddr,
 	unsigned long ret = sun4v_mmu_map_perm_addr(vaddr, 0, pte, mmu);
 
 	if (ret != 0) {
-		prom_printf("hypervisor_tlb_lock[%lx:%lx:%lx:%lx]: "
+		prom_printf("hypervisor_tlb_lock[%lx:%x:%lx:%lx]: "
 			    "errors with %lx\n", vaddr, 0, pte, mmu, ret);
 		prom_halt();
 	}
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 5e29939..f9027fd 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -90,8 +90,8 @@ static void __init sbus_iommu_init(struct platform_device *op)
            it to us. */
         tmp = __get_free_pages(GFP_KERNEL, IOMMU_ORDER);
 	if (!tmp) {
-		prom_printf("Unable to allocate iommu table [0x%08x]\n",
-			    IOMMU_NPTES*sizeof(iopte_t));
+		prom_printf("Unable to allocate iommu table [0x%lx]\n",
+			    IOMMU_NPTES * sizeof(iopte_t));
 		prom_halt();
 	}
 	iommu->page_table = (iopte_t *)tmp;
-- 
1.7.11.4

