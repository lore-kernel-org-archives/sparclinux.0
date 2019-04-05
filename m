From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 05 Apr 2019 22:12:06 +0000
Subject: [mm PATCH v7 0/4] Deferred page init improvements
Message-Id: <20190405221043.12227.19679.stgit@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: pavel.tatashin@microsoft.com, mhocko@suse.com, dave.jiang@intel.com, linux-nvdimm@lists.01.org, alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mingo@kernel.org, yi.z.zhang@linux.intel.com, khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz, sparclinux@vger.kernel.org, dan.j.williams@intel.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, davem@davemloft.net, kirill.shutemov@linux.intel.com

This patchset is essentially a refactor of the page initialization logic
that is meant to provide for better code reuse while providing a
significant improvement in deferred page initialization performance.

In my testing on an x86_64 system with 384GB of RAM I have seen the
following. In the case of regular memory initialization the deferred init
time was decreased from 3.75s to 1.38s on average. This amounts to a 172%
improvement for the deferred memory initialization performance.

I have called out the improvement observed with each patch.

v1->v2:
    Fixed build issue on PowerPC due to page struct size being 56
    Added new patch that removed __SetPageReserved call for hotplug
v2->v3:
    Rebased on latest linux-next
    Removed patch that had removed __SetPageReserved call from init
    Added patch that folded __SetPageReserved into set_page_links
    Tweaked __init_pageblock to use start_pfn to get section_nr instead of pfn
v3->v4:
    Updated patch description and comments for mm_zero_struct_page patch
        Replaced "default" with "case 64"
        Removed #ifndef mm_zero_struct_page
    Fixed typo in comment that ommited "_from" in kerneldoc for iterator
    Added Reviewed-by for patches reviewed by Pavel
    Added Acked-by from Michal Hocko
    Added deferred init times for patches that affect init performance
    Swapped patches 5 & 6, pulled some code/comments from 4 into 5
v4->v5:
    Updated Acks/Reviewed-by
    Rebased on latest linux-next
    Split core bits of zone iterator patch from MAX_ORDER_NR_PAGES init
v5->v6:
    Rebased on linux-next with previous v5 reverted
    Drop the "This patch" or "This change" from patch descriptions.
    Cleaned up patch descriptions for patches 3 & 4
    Fixed kerneldoc for __next_mem_pfn_range_in_zone
    Updated several Reviewed-by, and incorporated suggestions from Pavel
    Added __init_single_page_nolru to patch 5 to consolidate code
    Refactored iterator in patch 7 and fixed several issues
v6->v7:
    Updated MAX_ORDER_NR_PAGES patch to stop on section aligned boundaries
    Dropped patches 5-7
        Will follow-up later with reserved bit rework before resubmitting

---

Alexander Duyck (4):
      mm: Use mm_zero_struct_page from SPARC on all 64b architectures
      mm: Drop meminit_pfn_in_nid as it is redundant
      mm: Implement new zone specific memblock iterator
      mm: Initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections


 arch/sparc/include/asm/pgtable_64.h |   30 -----
 include/linux/memblock.h            |   41 +++++++
 include/linux/mm.h                  |   41 ++++++-
 mm/memblock.c                       |   64 ++++++++++
 mm/page_alloc.c                     |  218 ++++++++++++++++++++++-------------
 5 files changed, 277 insertions(+), 117 deletions(-)

--
