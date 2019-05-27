From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Mon, 27 May 2019 21:10:56 +0000
Subject: [PATCH v5 0/2] Fix issues with vmalloc flush flag
Message-Id: <20190527211058.2729-1-rick.p.edgecombe@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, peterz@infradead.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, luto@kernel.org
Cc: dave.hansen@intel.com, namit@vmware.com, Rick Edgecombe <rick.p.edgecombe@intel.com>

These two patches address issues with the recently added
VM_FLUSH_RESET_PERMS vmalloc flag.

Patch 1 addresses an issue that could cause a crash after other
architectures besides x86 rely on this path.

Patch 2 addresses an issue where in a rare case strange arguments
could be provided to flush_tlb_kernel_range(). 

v4->v5:
 - Update commit messages with info that the first issue will actually
   not cause problems today
 - Avoid re-use of variable (PeterZ)

v3->v4:
 - Drop patch that switched vm_unmap_alias() calls to regular flush (Andy)
 - Add patch to address correctness previously fixed in dropped patch

v2->v3:
 - Split into two patches (Andy)

v1->v2:
 - Update commit message with more detail
 - Fix flush end range on !CONFIG_ARCH_HAS_SET_DIRECT_MAP case


Rick Edgecombe (2):
  vmalloc: Fix calculation of direct map addr range
  vmalloc: Avoid rare case of flushing tlb with weird arguments

 mm/vmalloc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.20.1
