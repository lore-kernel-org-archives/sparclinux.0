From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:31:44 +0000
Subject: PATCH [0/14] sparc32: removal of sun4c platform support
Message-Id: <20120511213143.GA1518@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is the bulk of the removal of sun4c support.
I have tried to be careful not to break the build
during the removal process.

I like the diffstat summary:

 36 files changed, 75 insertions(+), 3726 deletions(-)

The final result is boot tested on my ss5 box.
I also boot tested a few of the steps.

So all-in-all I feel rather confident about this
patch-set.

Something noteworthy:

o In patch 1 I redo the nmi handler a bit.
  I think what I did is OK - but here I would like
  some extra carefull revieing please.

o In patch 12 I have removed all the sun + sun4c
  support in head_32.S.
  Here I did some minor restructuring.
  I have not tested if the warnings works on a sun4c box,
  as mine is hidden away right now.


This is not a complete removal - but I will address
the remaining items later.
The remaining bits are random cleanups + removal
of btfixup when no longer needed.

Patches are sent to the mailing list only (+ davem).

	Sam

 arch/sparc/include/asm/cpu_type.h       |    4 -
 arch/sparc/include/asm/elf_32.h         |    5 +-
 arch/sparc/include/asm/head_32.h        |   14 +-
 arch/sparc/include/asm/memreg.h         |   51 -
 arch/sparc/include/asm/oplib_32.h       |    8 -
 arch/sparc/include/asm/pgtable_32.h     |   31 +-
 arch/sparc/include/asm/pgtsun4c.h       |  172 ---
 arch/sparc/include/asm/thread_info_32.h |    7 +-
 arch/sparc/include/asm/traps.h          |    7 -
 arch/sparc/kernel/Makefile              |    2 +-
 arch/sparc/kernel/devices.c             |    4 -
 arch/sparc/kernel/entry.S               |  269 +----
 arch/sparc/kernel/etrap_32.S            |   50 +-
 arch/sparc/kernel/head_32.S             |  162 +--
 arch/sparc/kernel/irq_32.c              |    5 -
 arch/sparc/kernel/kernel.h              |    3 -
 arch/sparc/kernel/process_32.c          |   32 -
 arch/sparc/kernel/rtrap_32.S            |   76 +-
 arch/sparc/kernel/setup_32.c            |    9 -
 arch/sparc/kernel/signal_32.c           |    7 +-
 arch/sparc/kernel/sparc_ksyms_32.c      |    1 -
 arch/sparc/kernel/sun4c_irq.c           |  269 ----
 arch/sparc/kernel/sys_sparc_32.c        |   11 -
 arch/sparc/kernel/wof.S                 |   72 +-
 arch/sparc/kernel/wuf.S                 |   60 +-
 arch/sparc/lib/atomic_32.S              |   20 -
 arch/sparc/mm/Makefile                  |    6 -
 arch/sparc/mm/btfixup.c                 |   15 +-
 arch/sparc/mm/fault_32.c                |   94 +--
 arch/sparc/mm/init_32.c                 |    8 -
 arch/sparc/mm/loadmmu.c                 |    5 -
 arch/sparc/mm/nosun4c.c                 |   77 --
 arch/sparc/mm/srmmu.c                   |   50 +-
 arch/sparc/mm/sun4c.c                   | 2166 -------------------------------
 arch/sparc/prom/Makefile                |    1 -
 arch/sparc/prom/segment.c               |   28 -
 36 files changed, 75 insertions(+), 3726 deletions(-)

Sam Ravnborg (14):
      sparc32: drop sun4c support
      sparc32: remove calls to sun4c dummy mm inits functions
      sparc32: remove sun4c traps
      sparc32: drop sun4c specific ___xchg32 implementation
      sparc32: remove all uses of ARCH_SUN4C
      saprc32: delete pgtsun4c.h
      sparc32: drop sun4c specific stack validation
      sparc32: drop sun4c window overflow stack checking routine
      sparc32: drop sun4c stack checking routine
      sparc32: drop sun4c user stack checking routine
      sparc32: drop test for sun4c in signal_32
      sparc32: drop sun4c bits from head_32.S
      sparc32: drop btfixup for alloc_thread_info_node/free_thread_info
      sparc32: use inline versions of pgprot_noncached, pte_to_pgoff and pgoff_to_pte

