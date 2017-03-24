From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 24 Mar 2017 19:19:47 +0000
Subject: [v2 0/5] parallelized "struct page" zeroing
Message-Id: <1490383192-981017-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org

Changelog:
	v1 - v2
	- Per request, added s390 to deferred "struct page" zeroing
	- Collected performance data on x86 which proofs the importance to
	  keep memset() as prefetch (see below).

When deferred struct page initialization feature is enabled, we get a
performance gain of initializing vmemmap in parallel after other CPUs are
started. However, we still zero the memory for vmemmap using one boot CPU.
This patch-set fixes the memset-zeroing limitation by deferring it as well.

Performance gain on SPARC with 32T:
base:	https://hastebin.com/ozanelatat.go
fix:	https://hastebin.com/utonawukof.go

As you can see without the fix it takes: 97.89s to boot
With the fix it takes: 46.91 to boot.

Performance gain on x86 with 1T:
base:	https://hastebin.com/uvifasohon.pas
fix:	https://hastebin.com/anodiqaguj.pas

On Intel we save 10.66s/T while on SPARC we save 1.59s/T. Intel has
twice as many pages, and also fewer nodes than SPARC (sparc 32 nodes, vs.
intel 8 nodes).

It takes one thread 11.25s to zero vmemmap on Intel for 1T, so it should
take additional 11.25 / 8 = 1.4s  (this machine has 8 nodes) per node to
initialize the memory, but it takes only additional 0.456s per node, which
means on Intel we also benefit from having memset() and initializing all
other fields in one place.

Pavel Tatashin (5):
  sparc64: simplify vmemmap_populate
  mm: defining memblock_virt_alloc_try_nid_raw
  mm: add "zero" argument to vmemmap allocators
  mm: zero struct pages during initialization
  mm: teach platforms not to zero struct pages memory

 arch/powerpc/mm/init_64.c |    4 +-
 arch/s390/mm/vmem.c       |    5 ++-
 arch/sparc/mm/init_64.c   |   26 +++++++----------------
 arch/x86/mm/init_64.c     |    3 +-
 include/linux/bootmem.h   |    3 ++
 include/linux/mm.h        |   15 +++++++++++--
 mm/memblock.c             |   46 ++++++++++++++++++++++++++++++++++++------
 mm/page_alloc.c           |    3 ++
 mm/sparse-vmemmap.c       |   48 +++++++++++++++++++++++++++++---------------
 9 files changed, 103 insertions(+), 50 deletions(-)

