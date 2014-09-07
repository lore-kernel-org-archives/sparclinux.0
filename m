From: Bob Picco <bpicco@meloft.net>
Date: Sun, 07 Sep 2014 15:48:45 +0000
Subject: [PATCH] sparc64: mem mmap
Message-Id: <1410104925-22342-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This patch attempts to restrict mmap of /dev/mem. It tightens up the bus
error (DTLB errors) issues related to mmap of /dev/mem.

A root privileged application like python using dmidecode mmap-s /dev/mem to
examine an x86 magic area which is non-existent on sparc64. This results
in a power off event within sun4v_dtlb_error_report because the HV reports
an invalid RA.

The mmap restriction of /dev/mem does introduce ARCH_HAS_VALID_PHYS_ADDR_RANGE.
This does cause us to clone the functionality of valid_phys_addr_range. A
mapper is not allowed to mmap a range which isn't kern_addr_valid true on
every 4Mb boundary.

Cc: sparclinux@vger.kernel.org
Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/io_64.h |    3 +++
 arch/sparc/mm/init_64.c        |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 80b54b3..3588a63 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -440,6 +440,9 @@ void sbus_set_sbus64(struct device *, int);
  * access
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
+#define ARCH_HAS_VALID_PHYS_ADDR_RANGE
+extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
+extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
 /*
  * Convert a virtual cached pointer to an uncached pointer
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 98ac8e8..da1f051 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -169,6 +169,33 @@ unsigned long sparc64_valid_addr_bitmap[VALID_ADDR_BITMAP_BYTES /
 					sizeof(unsigned long)];
 EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
 
+/* This is a perfect clone of mem.c's version.*/
+int valid_phys_addr_range(phys_addr_t addr, size_t count)
+{
+	return addr + count <= __pa(high_memory);
+}
+
+/* For mmap of /dev/mem we don't permit ranges with a hole which
+ * can result in a bus error. Should a mapping be required then
+ * multiple mappings with the bus error holes avoided is necessary.
+ */
+int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
+{
+	unsigned long pa_start = pfn << PAGE_SHIFT;
+	unsigned long pa_end = pa_start + size;
+	int rc = 0;
+
+	for (pa_start = (pa_start >> ILOG2_4MB) << ILOG2_4MB;
+		pa_start < pa_end; pa_start = pa_start + (1UL << ILOG2_4MB)) {
+		unsigned long vaddr = (unsigned long) __va(pa_start);
+
+		rc = kern_addr_valid(vaddr);
+		if (!rc)
+			break;
+	}
+	return rc;
+}
+
 /* Kernel physical address base and size in bytes.  */
 unsigned long kern_base __read_mostly;
 unsigned long kern_size __read_mostly;
-- 
1.7.1

