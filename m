From: Will Deacon <will@kernel.org>
Date: Tue, 26 May 2020 17:33:01 +0000
Subject: [PATCH 2/3] sparc32: mm: Disable SPLIT_PTLOCK_CPUS
Message-Id: <20200526173302.377-3-will@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200526173302.377-1-will@kernel.org>
In-Reply-To: <20200526173302.377-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "David S . Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, Mike Rapoport <rppt@kernel.org>, kernel-team@android.com

The SRMMU page-table allocator is not compatible with SPLIT_PTLOCK_CPUS
for two major reasons:

  1. Pages are allocated via memblock, and therefore the ptl is not
     cleared by prep_new_page(), which is expected by ptlock_init()

  2. Multiple PTE tables can exist in a single page, causing them to
     share the same ptl and deadlock when attempting to take the same
     lock twice (e.g. as part of copy_page_range()).

Ensure that SPLIT_PTLOCK_CPUS is not selected for SPARC32.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..97458119cce8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -192,6 +192,9 @@ config MEMORY_HOTREMOVE
 # Default to 4 for wider testing, though 8 might be more appropriate.
 # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
 # PA-RISC 7xxx's spinlock_t would enlarge struct page from 32 to 44 bytes.
+# SPARC32 allocates multiple pte tables within a single page, and therefore
+# a per-page lock leads to problems when multiple tables need to be locked
+# at the same time (e.g. copy_page_range()).
 # DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC spinlock_t also enlarge struct page.
 #
 config SPLIT_PTLOCK_CPUS
@@ -199,6 +202,7 @@ config SPLIT_PTLOCK_CPUS
 	default "999999" if !MMU
 	default "999999" if ARM && !CPU_CACHE_VIPT
 	default "999999" if PARISC && !PA20
+	default "999999" if SPARC32
 	default "4"
 
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
-- 
2.27.0.rc0.183.gde8f92d652-goog
