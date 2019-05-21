From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 20:51:35 +0000
Subject: [PATCH v4 0/2] Fix issues with vmalloc flush flag
Message-Id: <20190521205137.22029-1-rick.p.edgecombe@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, peterz@infradead.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, luto@kernel.org
Cc: dave.hansen@intel.com, namit@vmware.com, Rick Edgecombe <rick.p.edgecombe@intel.com>

These two patches address issues with the recently added
VM_FLUSH_RESET_PERMS vmalloc flag.

Patch 1 is the most critical and addresses an issue that could cause a
crash on x86.

Patch 2 addresses an issue where in a rare case strange arguments
could be provided to flush_tlb_kernel_range(). Most arch's should be
fine with it, but some may not like them, so we should avoid doing
this.

v3->v4:
 - Drop patch that switched vm_unmap_alias() calls to regular flush
 - Add patch to address correctness previously fixed in dropped patch

v2->v3:
 - Split into two patches

v1->v2:
 - Update commit message with more detail
 - Fix flush end range on !CONFIG_ARCH_HAS_SET_DIRECT_MAP case

Rick Edgecombe (2):
  vmalloc: Fix calculation of direct map addr range
  vmalloc: Avoid rare case of flushing tlb with weird arguements

 mm/vmalloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.20.1
