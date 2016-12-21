From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 22:24:16 +0000
Subject: [PATCH] sparc64: Support reserving memory with memmap=xxx$yyy
Message-Id: <1482359056-59721-1-git-send-email-larry.bassel@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The kernel commandline parameter memmap= was supported
on several other architectures but not on SPARC (it was
being ignored on SPARC).

Add support for the memmap=xxx$yyy commandline parameter
(sparc64 only). The patch is based on the existing
code for the "tile" architecture.

There are other types of memmap= commandlines which
are only supported on x86 that are e820-specific.
These were not implemented.

Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 arch/sparc/mm/init_64.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 65457c9..cbd905d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -744,6 +744,58 @@ do {	if (numa_debug) \
 		printk(KERN_INFO f, ## a); \
 } while (0)
 
+struct memmap_entry {
+	u64 addr;	/* start of memory segment */
+	u64 size;	/* size of memory segment */
+};
+static struct memmap_entry memmap_map[64];
+static int memmap_nr;
+
+static void add_memmap_region(u64 addr, u64 size)
+{
+	if (memmap_nr >= ARRAY_SIZE(memmap_map)) {
+		pr_err("Too many entries in the memory map!\n");
+		return;
+	}
+	memmap_map[memmap_nr].addr = addr;
+	memmap_map[memmap_nr].size = size;
+	memmap_nr++;
+}
+
+static int __init setup_memmap(char *p)
+{
+	char *oldp;
+	u64 start_at, mem_size;
+
+	if (!p)
+		return -EINVAL;
+
+	if (!strncmp(p, "exactmap", 8)) {
+		pr_err("\"memmap=exactmap\" not valid on SPARC\n");
+		return 0;
+	}
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p = oldp)
+		return -EINVAL;
+
+	if (*p = '@') {
+		pr_err("\"memmap=nn@ss\" (force RAM) invalid on SPARC\n");
+	} else if (*p = '#') {
+		pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on SPARC\n");
+	} else if (*p = '!') {
+		pr_err("\"memmap=nn!ss\" (mark as protected) invalid on SPARC\n");
+	} else if (*p = '$') {
+		start_at = memparse(p+1, &p);
+		add_memmap_region(start_at, mem_size);
+	} else {
+		pr_err("unsupported memmap option\n");
+	}
+	return *p = '\0' ? 0 : -EINVAL;
+}
+early_param("memmap", setup_memmap);
+
 static void __init find_ramdisk(unsigned long phys_base)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -2179,6 +2231,12 @@ void __init paging_init(void)
 	if (cmdline_memory_size)
 		reduce_memory(cmdline_memory_size);
 
+	/* Reserve any memory excluded by "memmap" arguments. */
+	for (i = 0; i < memmap_nr; ++i) {
+		struct memmap_entry *m = &memmap_map[i];
+		memblock_remove(m->addr, m->size);
+	}
+
 	memblock_allow_resize();
 	memblock_dump_all();
 
@@ -2887,6 +2945,24 @@ static void __init kernel_lds_init(void)
 	bss_resource.end    = compute_kern_paddr(_end - 1);
 }
 
+static struct resource* __init
+insert_ram_resource(u64 start_pfn, u64 end_pfn, bool reserved)
+{
+	struct resource *res +		kzalloc(sizeof(struct resource), GFP_ATOMIC);
+	if (!res)
+		return NULL;
+	res->name = reserved ? "Reserved" : "System RAM";
+	res->start = start_pfn << PAGE_SHIFT;
+	res->end = (end_pfn << PAGE_SHIFT) - 1;
+	res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
+	if (insert_resource(&iomem_resource, res)) {
+		kfree(res);
+		return NULL;
+	}
+	return res;
+}
+
 static int __init report_memory(void)
 {
 	int i;
@@ -2917,6 +2993,13 @@ static int __init report_memory(void)
 		insert_resource(res, &bss_resource);
 	}
 
+	/* Mark any "memmap" regions busy for the resource manager. */
+	for (i = 0; i < memmap_nr; ++i) {
+		struct memmap_entry *m = &memmap_map[i];
+		insert_ram_resource(PFN_DOWN(m->addr),
+				    PFN_UP(m->addr + m->size - 1), 1);
+	}
+
 	return 0;
 }
 arch_initcall(report_memory);
-- 
1.7.1

