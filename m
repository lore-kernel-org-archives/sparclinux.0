From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Thu, 02 Aug 2018 11:53:53 +0000
Subject: [PATCH 2/2] sparc32: tidy up ramdisk memory reservation
Message-Id: <1533210833-14748-3-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1533210833-14748-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1533210833-14748-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>

The detection and reservation of ramdisk memory were separated to allow
bootmem bitmap initialization after the ramdisk boundaries are detected.
Since the bootmem initialization is removed, the reservation of ramdisk
memory can be done immediately after its boundaries are found.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/sparc/mm/init_32.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 5117a5e..b5d8f90 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -161,6 +161,8 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		    high_pages >> (20 - PAGE_SHIFT));
 	}
 
+	*pages_avail = (memblock_phys_mem_size() >> PAGE_SHIFT) - high_pages;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	/*
 	 * Now have to check initial ramdisk, so that it won't pass
@@ -176,23 +178,17 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		                 	 "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
 			       initrd_end, end_of_phys_memory);
 			initrd_start = 0;
+		} else {
+			/* Reserve the initrd image area. */
+			size = initrd_end - initrd_start;
+			memblock_reserve(initrd_start, size);
+			*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+			initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
+			initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
 		}
 	}
 #endif
-
-	*pages_avail = (memblock_phys_mem_size() >> PAGE_SHIFT) - high_pages;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		/* Reserve the initrd image area. */
-		size = initrd_end - initrd_start;
-		memblock_reserve(initrd_start, size);
-		*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
-	}
-#endif
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
-- 
2.7.4

