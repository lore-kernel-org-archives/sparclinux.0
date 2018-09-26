From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Wed, 26 Sep 2018 23:28:20 +0000
Subject: [RFC mm PATCH 0/5] mm: Deferred page init improvements
Message-Id: <20180926232117.17365.72207.stgit@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: pavel.tatashin@microsoft.com, mhocko@suse.com, dave.jiang@intel.com, alexander.h.duyck@linux.intel.com, dan.j.williams@intel.com, willy@infradead.org, mingo@kernel.org, khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz, akpm@linux-foundation.org, ldufour@linux.vnet.ibm.com, davem@davemloft.net, kirill.shutemov@linux.intel.com

This patchset is essentially a refactor of the page initialization logic
to provide for better code reuse while providing a significant improvement
in deferred page initialization performance.

In my testing I have seen a 3:1 reduction in the time needed for deferred
memory initialization on two different x86_64 based test systems I have.

In addition this provides a very slight improvement for the hotplug memory 
initialization, although the improvement doesn't exceed 5% from what I can
tell and that is to be expected since most of the changes related to
hotplug initialization are just code clean-up to allow for reuse. I had
been considering using a large memset for the entire pageblock I was
initializing which showed a significant speedup for persistent memory init
however that showed no improvements to a slight regression for regular
deferred initialization of standard memory.

---

Alexander Duyck (5):
      mm: Use mm_zero_struct_page from SPARC on all 64b architectures
      mm: Drop meminit_pfn_in_nid as it is redundant
      mm: Use memblock/zone specific iterator for handling deferred page init
      mm: Move hot-plug specific memory init into separate functions and optimize
      mm: Use common iterator for deferred_init_pages and deferred_free_pages


 arch/sparc/include/asm/pgtable_64.h |   30 --
 include/linux/memblock.h            |   58 ++++
 include/linux/mm.h                  |   33 ++
 mm/memblock.c                       |   63 ++++
 mm/page_alloc.c                     |  555 +++++++++++++++++++++--------------
 5 files changed, 485 insertions(+), 254 deletions(-)

--
