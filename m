From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 20 Sep 2017 20:17:02 +0000
Subject: [PATCH v9 00/12] complete deferred page initialization
Message-Id: <20170920201714.19817-1-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Changelog:
v9 - v8
- Addressed comments raised by Mark Rutland and Ard Biesheuvel: changed
  kasan implementation. Added a new function: kasan_map_populate() that
  zeroes the allocated and mapped memory

v8 - v7
- Added Acked-by's from Dave Miller for SPARC changes
- Fixed a minor compiling issue on tile architecture reported by kbuild

v7 - v6
- Addressed comments from Michal Hocko
- memblock_discard() patch was removed from this series and integrated
  separately
- Fixed bug reported by kbuild test robot new patch:
  mm: zero reserved and unavailable struct pages
- Removed patch
  x86/mm: reserve only exiting low pages
  As, it is not needed anymore, because of the previous fix
- Re-wrote deferred_init_memmap(), found and fixed an existing bug, where
  page variable is not reset when zone holes present.
- Merged several patches together per Michal request
- Added performance data including raw logs

v6 - v5
- Fixed ARM64 + kasan code, as reported by Ard Biesheuvel
- Tested ARM64 code in qemu and found few more issues, that I fixed in this
  iteration
- Added page roundup/rounddown to x86 and arm zeroing routines to zero the
  whole allocated range, instead of only provided address range.
- Addressed SPARC related comment from Sam Ravnborg
- Fixed section mismatch warnings related to memblock_discard().

v5 - v4
- Fixed build issues reported by kbuild on various configurations

v4 - v3
- Rewrote code to zero sturct pages in __init_single_page() as
  suggested by Michal Hocko
- Added code to handle issues related to accessing struct page
  memory before they are initialized.

v3 - v2
- Addressed David Miller comments about one change per patch:
    * Splited changes to platforms into 4 patches
    * Made "do not zero vmemmap_buf" as a separate patch

v2 - v1
- Per request, added s390 to deferred "struct page" zeroing
- Collected performance data on x86 which proofs the importance to
  keep memset() as prefetch (see below).

SMP machines can benefit from the DEFERRED_STRUCT_PAGE_INIT config option,
which defers initializing struct pages until all cpus have been started so
it can be done in parallel.

However, this feature is sub-optimal, because the deferred page
initialization code expects that the struct pages have already been zeroed,
and the zeroing is done early in boot with a single thread only.  Also, we
access that memory and set flags before struct pages are initialized. All
of this is fixed in this patchset.

In this work we do the following:
- Never read access struct page until it was initialized
- Never set any fields in struct pages before they are initialized
- Zero struct page at the beginning of struct page initialization


=====================================
Performance improvements on x86 machine with 8 nodes:
Intel(R) Xeon(R) CPU E7-8895 v3 @ 2.60GHz and 1T of memory:
                        TIME          SPEED UP
base no deferred:       95.796233s
fix no deferred:        79.978956s    19.77%

base deferred:          77.254713s
fix deferred:           55.050509s    40.34%
=====================================
SPARC M6 3600 MHz with 15T of memory
                        TIME          SPEED UP
base no deferred:       358.335727s
fix no deferred:        302.320936s   18.52%

base deferred:          237.534603s
fix deferred:           182.103003s   30.44%
=====================================
Raw dmesg output with timestamps:
x86 base no deferred:    https://hastebin.com/ofunepurit.scala
x86 base deferred:       https://hastebin.com/ifazegeyas.scala
x86 fix no deferred:     https://hastebin.com/pegocohevo.scala
x86 fix deferred:        https://hastebin.com/ofupevikuk.scala
sparc base no deferred:  https://hastebin.com/ibobeteken.go
sparc base deferred:     https://hastebin.com/fariqimiyu.go
sparc fix no deferred:   https://hastebin.com/muhegoheyi.go
sparc fix deferred:      https://hastebin.com/xadinobutu.go

Pavel Tatashin (12):
  x86/mm: setting fields in deferred pages
  sparc64/mm: setting fields in deferred pages
  mm: deferred_init_memmap improvements
  sparc64: simplify vmemmap_populate
  mm: defining memblock_virt_alloc_try_nid_raw
  mm: zero struct pages during initialization
  sparc64: optimized struct page zeroing
  mm: zero reserved and unavailable struct pages
  mm/kasan: kasan specific map populate function
  x86/kasan: use kasan_map_populate()
  arm64/kasan: use kasan_map_populate()
  mm: stop zeroing memory during allocation in vmemmap

 arch/arm64/include/asm/pgtable.h    |   3 +
 arch/arm64/mm/kasan_init.c          |  12 +--
 arch/sparc/include/asm/pgtable_64.h |  30 ++++++
 arch/sparc/mm/init_64.c             |  31 +++---
 arch/x86/mm/init_64.c               |   9 +-
 arch/x86/mm/kasan_init_64.c         |   8 +-
 include/linux/bootmem.h             |  27 +++++
 include/linux/kasan.h               |   2 +
 include/linux/memblock.h            |  16 +++
 include/linux/mm.h                  |  26 +++++
 mm/kasan/kasan_init.c               |  67 ++++++++++++
 mm/memblock.c                       |  60 +++++++++--
 mm/page_alloc.c                     | 207 ++++++++++++++++++++----------------
 mm/sparse-vmemmap.c                 |  15 ++-
 mm/sparse.c                         |   6 +-
 15 files changed, 380 insertions(+), 139 deletions(-)

-- 
2.14.1

