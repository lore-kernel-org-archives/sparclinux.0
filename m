From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 20:58:46 +0000
Subject: [PATCH 0/18] sparc32 mm/ cleanups v2
Message-Id: <20120726205846.GA3838@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is version two of a patch-set to clean-up
various bits in arch/sparc/mm/ (mainly).
v1 was dropped on my request as I had an idea
to improve one of the patches. In the end the idea
was bogus.

But looking a bit more on the relevant files
the patch-set grew a bit larger and now counts 18
patches.

They are all fairly trivial as most just moved code
around or delete unused code.
The removal of fixmap counts as the largest patch.

I could do much more trivial cleanup but resisted for now.

The patches are based and a one day old pull from
upstream.
(On top of bdc0077af574800d24318b6945cf2344e8dbb050
"Merge tag 'scsi-misc' ...")

We are in the middle of the merge window and this
is late in that game. On the other hand this is
trivial stuff so it should be OK to merge now I hope.

This was delayed a bit as I have spent some time
in nl and cz during my holidays.
But soon work is calling again :-(

	Sam

Sam Ravnborg (18):
      sparc32: define a few srmmu functions __init
      sparc32: sort includes in srmmu.c
      sparc32: fix coding-style in srmmu.c
      sparc32: use void * in nocache get/free
      sparc32: beautify srmmu_inherit_prom_mappings()
      sparc32: drop swapper_pg_dir
      sparc32: drop unused kmap_atomic_to_page
      sparc32: fixmap.h cleanup
      sparc32: drop fixmap.h
      sparc32,leon: drop leon_init()
      sparc32: drop sparc_unmapped_base
      sparc32: drop sparc model check in paging_init
      sparc32: drop quicklist
      sparc32: centralize all mmu context handling in srmmu.c
      sparc32: drop unused BAD_PAGE stuff
      sparc32: move probe_memory() to srmmu.c
      sparc32: move kmap_init() to highmem.c
      sparc32: delete dead code in show_mem()

 arch/sparc/include/asm/fixmap.h         |  110 ----------
 arch/sparc/include/asm/highmem.h        |    3 -
 arch/sparc/include/asm/leon.h           |    1 -
 arch/sparc/include/asm/mmu_context_32.h |    8 +-
 arch/sparc/include/asm/page_32.h        |    3 +-
 arch/sparc/include/asm/pgalloc_32.h     |   29 +--
 arch/sparc/include/asm/pgtable_32.h     |   44 +----
 arch/sparc/include/asm/vaddrs.h         |   22 ++
 arch/sparc/kernel/head_32.S             |    2 -
 arch/sparc/kernel/leon_kernel.c         |   16 --
 arch/sparc/kernel/setup_32.c            |    1 -
 arch/sparc/mm/fault_32.c                |   18 --
 arch/sparc/mm/highmem.c                 |   42 ++--
 arch/sparc/mm/init_32.c                 |   58 +------
 arch/sparc/mm/srmmu.c                   |  332 +++++++++++++++++++------------
 15 files changed, 260 insertions(+), 429 deletions(-)
