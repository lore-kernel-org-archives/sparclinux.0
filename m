From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 18:02:25 +0000
Subject: [PATCH [0/5] sparc32 patches
Message-Id: <20120512180225.GA30372@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Random collection of clean-up patches.

o fix build failue due to warning in floppy.
o cleanup in floppy glue to please my eyes
o more btfix drops - and things became much simpler by this
o drop some unused stuff from the header files

I considered dropping some sun4c definitions in asi.h -
but thouth it was better to keep the list complete.

	Sam

Sam Ravnborg (5):
      sparc32: fix warning in floopy glue
      sparc32: code cleanup in floppy glue
      sparc32: drop btfixup for switch_mm
      sparc32: drop btfixup for check_pgt_cache
      sparc32: drop unused type/extern

 arch/sparc/include/asm/floppy_32.h      |   18 +++++++++---------
 arch/sparc/include/asm/mmu_context_32.h |    5 ++---
 arch/sparc/include/asm/page_32.h        |    6 ------
 arch/sparc/include/asm/pgalloc_32.h     |    4 +---
 arch/sparc/include/asm/pgtable_32.h     |    8 --------
 arch/sparc/kernel/process_32.c          |    2 --
 arch/sparc/mm/init_32.c                 |   16 ----------------
 arch/sparc/mm/srmmu.c                   |   11 ++---------
 8 files changed, 14 insertions(+), 56 deletions(-)
