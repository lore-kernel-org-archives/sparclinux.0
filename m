From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Mon, 20 May 2019 23:38:39 +0000
Subject: [PATCH v2 0/2] Fix issues with vmalloc flush flag
Message-Id: <20190520233841.17194-1-rick.p.edgecombe@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, peterz@infradead.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, luto@amacapital.net
Cc: dave.hansen@intel.com, namit@vmware.com, davem@davemloft.net, Rick Edgecombe <rick.p.edgecombe@intel.com>

These two patches address issues with the recently added
VM_FLUSH_RESET_PERMS vmalloc flag. It is now split into two patches, which
made sense to me, but can split it further if desired.

Patch 1 is the most critical and addresses an issue that could cause a
crash on x86.

Patch 2 is to try to reduce the work done in the free operation to push
it to allocation time where it would be more expected. This shouldn't be
a big issue most of the time, but I thought it was slightly better.

v2->v3:
 - Split into two patches

v1->v2:
 - Update commit message with more detail
 - Fix flush end range on !CONFIG_ARCH_HAS_SET_DIRECT_MAP case

Rick Edgecombe (2):
  vmalloc: Fix calculation of direct map addr range
  vmalloc: Remove work as from vfree path

 mm/vmalloc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.20.1
