From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Sat, 29 Jul 2017 18:42:16 +0000
Subject: [PATCH v5 0/3] sparc64: Add 16GB hugepage support
Message-Id: <cover.1501353478.git.nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SPARC architecture supports 16G hugepages but the kernel did not
support these. This patch series adds support for it and also cleanes
up some page walk/alloc functions.

Patch 1/3: Core changes needed to add 16G hugepage support: To map a
  single 16G hugepage, two PUD entries are used. Each PUD entry maps
  8G portion of a 16G page. This page table encoding scheme is same as
  that used for hugepages at PMD level (8M, 256M and 2G pages) where
  each PMD entry points successively to 8M regions within a page.  No
  page table entries below the PUD level are allocated for 16G
  hugepage since those are not required.

  TSB entries for a 16G page are created at every 4M boundary since
  the HUGE_TSB is used for these pages which is configured with page
  size of 4M.  When walking page tables (on a TSB miss), bits [32:22]
  are transferred from vaddr to PUD to resolve addresses at 4M
  boundary. The resolved address mapping is then stored in HUGE_TSB.

Patch 2/3: get_user_pages() etc. are used for direct IO. These
  functions were not aware of hugepages at the PUD level and would try
  to continue walking page tables beyond the PUD level. Since 16G
  hugepages have page tables allocated till PUD level only, these
  accesses would result in invalid access. This patch adds the case
  for PUD huge pages to these functions.

Patch 3/3: Patch 1 added the case of PUD entry being huge in page
  table walk and alloc functions. This new case further increased
  nesting in these functions and made them harder to follow. This
  patch flattens these functions for better readability.

Cc: sparclinux@vger.kernel.org

Changelog v5 vs v4:
 - Checking at PUD level for hugepage entry during page table walk is
   patched out if 16GB hugepages are not being used.
Changelog v4 vs v3:
 - Added cover letter (patch 0/4) for patch series.
Changelog v3 vs v2:
 - Fixed email headers so the subject shows up correctly.

Changelog v2 vs v1:
 - Remove redundant brgez,pn (Bob Picco)
 - Remove unncessary label rename from 700 to 701 (Rob Gardner)
 - Add patch description (Paul)
 - Add 16G case to get_user_pages()

Nitin Gupta (3):
  sparc64: Support huge PUD case in get_user_pages
  sparc64: Add 16GB hugepage support
  sparc64: Cleanup hugepage table walk functions

 arch/sparc/include/asm/hugetlb.h    |   7 +++
 arch/sparc/include/asm/page_64.h    |   3 +-
 arch/sparc/include/asm/pgtable_64.h |  20 ++++++-
 arch/sparc/include/asm/tsb.h        |  36 +++++++++++++
 arch/sparc/kernel/tsb.S             |   2 +-
 arch/sparc/kernel/vmlinux.lds.S     |   5 ++
 arch/sparc/mm/gup.c                 |  45 +++++++++++++++-
 arch/sparc/mm/hugetlbpage.c         | 102 +++++++++++++++++++++---------------
 arch/sparc/mm/init_64.c             |  54 ++++++++++++++++---
 9 files changed, 220 insertions(+), 54 deletions(-)

-- 
2.9.2

