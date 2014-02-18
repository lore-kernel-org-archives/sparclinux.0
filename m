From: Bob Picco <bpicco@meloft.net>
Date: Tue, 18 Feb 2014 19:11:19 +0000
Subject: [PATCH 2/2] sparc64 - add mem to iomem resource
Message-Id: <1392750679-6966-2-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This patch adds sparc RAM to /proc/iomem. It also identifies the
code, data and bss regions of the kernel.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/init_64.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 9c4a820..b72e51a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -22,6 +22,7 @@
 #include <linux/kprobes.h>
 #include <linux/cache.h>
 #include <linux/sort.h>
+#include <linux/ioport.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
 #include <linux/mmzone.h>
@@ -2705,3 +2706,67 @@ int devmem_is_allowed(unsigned long pagenr)
 	return rc;
 }
 #endif
+
+static struct resource code_resource = {
+	.name	= "Kernel code",
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
+static struct resource data_resource = {
+	.name	= "Kernel data",
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
+static struct resource bss_resource = {
+	.name	= "Kernel bss",
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
+static inline resource_size_t compute_kern_paddr(void *addr)
+{
+	return (resource_size_t) (addr - KERNBASE + kern_base);
+}
+
+static void __init kernel_lds_init(void)
+{
+	code_resource.start = compute_kern_paddr(_text);
+	code_resource.end   = compute_kern_paddr(_etext - 1);
+	data_resource.start = compute_kern_paddr(_etext);
+	data_resource.end   = compute_kern_paddr(_edata - 1);
+	bss_resource.start  = compute_kern_paddr(__bss_start);
+	bss_resource.end    = compute_kern_paddr(_end - 1);
+}
+
+static int __init report_memory(void)
+{
+	int i;
+	struct resource *res;
+
+	kernel_lds_init();
+
+	for (i = 0; i < pavail_ents; i++) {
+		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+
+		if (!res) {
+			pr_warn("Failed to allocate source.\n");
+			break;
+		}
+
+		res->name = "System RAM";
+		res->start = pavail[i].phys_addr;
+		res->end = pavail[i].phys_addr + pavail[i].reg_size - 1;
+		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
+
+		if (insert_resource(&iomem_resource, res) < 0) {
+			pr_warn("Resource insertion failed.\n");
+			break;
+		}
+
+		insert_resource(res, &code_resource);
+		insert_resource(res, &data_resource);
+		insert_resource(res, &bss_resource);
+	}
+
+	return 0;
+}
+device_initcall(report_memory);
-- 
1.7.1

