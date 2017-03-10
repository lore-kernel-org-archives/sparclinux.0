From: Bob Picco <bob.picco@oracle.com>
Date: Fri, 10 Mar 2017 19:31:19 +0000
Subject: [PATCH] sparc64: kern_addr_valid regression
Message-Id: <20170310193119.18768-1-bob.picco@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bob.picco@oracle.com>

I encountered this bug when using /proc/kcore to examine the kernel. Plus a
coworker inquired about debugging tools. We computed pa but did
not use it during the maximum physical address bits test. Instead we used
the identity mapped virtual address which will always fail this test.

I believe the defect came in here:
[bpicco@zareason linus.git]$ git describe --contains bb4e6e85daa52
v3.18-rc1~87^2~4
.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5d2f91511c60..47ecac5106d3 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1495,7 +1495,7 @@ bool kern_addr_valid(unsigned long addr)
 	if ((long)addr < 0L) {
 		unsigned long pa = __pa(addr);
 
-		if ((addr >> max_phys_bits) != 0UL)
+		if ((pa >> max_phys_bits) != 0UL)
 			return false;
 
 		return pfn_valid(pa >> PAGE_SHIFT);
-- 
2.11.0

