From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2012 07:54:24 +0000
Subject: [PATCH 0/9] sparc32 mm/ cleanups
Message-Id: <20120720075424.GA17460@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a simple set of cleanups of srmmu.c
and a few other mm bits.
I was browsing mm/ to better understand
all the mmu stuff in sparc.

I resisted doing a lot of trivial cleanups - 
but I could not resist on everything.
So here is a set of 9 trivial patches.

No functional changes - and I like the one where
I kill swapper_pg_dir - it is 4K saved.

I am heading for cz soon so this is just a dump
of what I had ready as the merge window may
open up soon.

Next on my todo is to look at the porposal to
map the kernel using pgd size chunks in head_32.S.

	Sam

Sam Ravnborg (9):
      sparc32: define a few srmmu functons __init
      sparc32: sort includes in srmmu.c
      sparc32: fix coding-style in srmmu.c
      sparc32: use void * in nocache get/free
      sparc32: beautify srmmu_inherit_prom_mappings()
      sparc32: drop swapper_pg_dir
      sparc32: drop unused kmap_atomic_to_page
      sparc32: fixmap.h cleanup
      sparc32: drop fixmap.h

 arch/sparc/include/asm/fixmap.h     |  110 ---------------
 arch/sparc/include/asm/highmem.h    |    2 -
 arch/sparc/include/asm/pgalloc_32.h |   16 +-
 arch/sparc/include/asm/pgtable_32.h |    5 +-
 arch/sparc/include/asm/vaddrs.h     |   22 +++
 arch/sparc/kernel/head_32.S         |    2 -
 arch/sparc/mm/highmem.c             |   25 +---
 arch/sparc/mm/srmmu.c               |  251 ++++++++++++++++++-----------------
 8 files changed, 167 insertions(+), 266 deletions(-)

