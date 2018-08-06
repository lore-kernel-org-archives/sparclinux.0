From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2018 10:52:33 +0000
Subject: [PATCH v2 1/3] sparc: mm/init_32: kill trailing whitespace
Message-Id: <1533552755-16679-2-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/sparc/mm/init_32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 95fe4f0..3ec10b2 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -133,7 +133,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	}
 
 	/* Start with page aligned address of last symbol in kernel
-	 * image.  
+	 * image.
 	 */
 	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
 
@@ -214,7 +214,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
 
 		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;		
+		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
 	}
 #endif
 	/* Reserve the kernel text/data/bss. */
@@ -322,7 +322,7 @@ void __init mem_init(void)
 
 		map_high_region(start_pfn, end_pfn);
 	}
-	
+
 	mem_init_print_info(NULL);
 }
 
-- 
2.7.4

