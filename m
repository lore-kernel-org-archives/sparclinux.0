From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2018 10:52:35 +0000
Subject: [PATCH v2 3/3] sparc32: split ramdisk detection and reservation to a helper function
Message-Id: <1533552755-16679-4-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>

The detection and reservation of ramdisk memory were separated to allow
bootmem bitmap initialization after the ramdisk boundaries are detected.
Since the bootmem initialization is removed, the reservation of ramdisk
memory is done immediately after its boundaries are found.

Split the entire block into a separate helper function.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Suggested-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_32.c | 56 +++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e786fe0..92634d4 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -102,6 +102,36 @@ static unsigned long calc_max_low_pfn(void)
 	return tmp;
 }
 
+static void __init find_ramdisk(unsigned long end_of_phys_memory)
+{
+#ifdef CONFIG_BLK_DEV_INITRD
+	unsigned long size;
+
+	/* Now have to check initial ramdisk, so that it won't pass
+	 * the end of memory
+	 */
+	if (sparc_ramdisk_image) {
+		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
+			sparc_ramdisk_image -= KERNBASE;
+		initrd_start = sparc_ramdisk_image + phys_base;
+		initrd_end = initrd_start + sparc_ramdisk_size;
+		if (initrd_end > end_of_phys_memory) {
+			printk(KERN_CRIT "initrd extends beyond end of memory "
+			       "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
+			       initrd_end, end_of_phys_memory);
+			initrd_start = 0;
+		} else {
+			/* Reserve the initrd image area. */
+			size = initrd_end - initrd_start;
+			memblock_reserve(initrd_start, size);
+
+			initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
+			initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
+		}
+	}
+#endif
+}
+
 unsigned long __init bootmem_init(unsigned long *pages_avail)
 {
 	unsigned long start_pfn, bytes_avail, size;
@@ -160,32 +190,8 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		    high_pages >> (20 - PAGE_SHIFT));
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* Now have to check initial ramdisk, so that it won't pass
-	 * the end of memory
-	 */
-	if (sparc_ramdisk_image) {
-		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
-			sparc_ramdisk_image -= KERNBASE;
-		initrd_start = sparc_ramdisk_image + phys_base;
-		initrd_end = initrd_start + sparc_ramdisk_size;
-		if (initrd_end > end_of_phys_memory) {
-			printk(KERN_CRIT "initrd extends beyond end of memory "
-		                 	 "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
-			       initrd_end, end_of_phys_memory);
-			initrd_start = 0;
-		}
-	}
-
-	if (initrd_start) {
-		/* Reserve the initrd image area. */
-		size = initrd_end - initrd_start;
-		memblock_reserve(initrd_start, size);
+	find_ramdisk(end_of_phys_memory);
 
-		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
-	}
-#endif
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
-- 
2.7.4

