From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Apr 2014 19:30:36 +0000
Subject: [PATCH 0/5] sparc32 sparse fixes in mm/
Message-Id: <20140420193036.GA13910@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following 5 patches fixes most of the sparse generated
warnings in mm/.

Sam Ravnborg (5):
      sparc32: rename mm/srmmu.h to mm/mm_32.h
      sparc32: fix sparse warning in fault_32.c
      sparc32: fix sparse warning in init_32.c
      sparc32: fix sparse warnings in srmmu.c
      sparc32: fix sparse "Should it be static?" in mm/

 arch/sparc/include/asm/pgtable_32.h |  1 +
 arch/sparc/mm/fault_32.c            |  5 ++---
 arch/sparc/mm/init_32.c             |  3 ++-
 arch/sparc/mm/iommu.c               |  5 ++---
 arch/sparc/mm/leon_mm.c             |  4 ++--
 arch/sparc/mm/mm_32.h               | 24 ++++++++++++++++++++++++
 arch/sparc/mm/srmmu.c               | 13 ++++---------
 arch/sparc/mm/srmmu.h               |  4 ----
 8 files changed, 37 insertions(+), 22 deletions(-)

There are now only two sparse warning left in mm/ (for sparc32)
Both warnings relates to the return value of of_ioremap() which is __iomem.

iommu.c:69:21: warning: incorrect type in assignment (different address spaces)
    iommu->regs is set to a value obtained by of_ioremap().
    And this value is later dereferenced like this:
    iommu->regs->control = xxx;

io-unit.c:56:13: warning: incorrect type in assignment (different address spaces)
    iounit->page_table is set to a value obtained by of_ioremap(),
    the address of the External Page Table.
    And this value is dereference later like this
    dev->archdata.iommu->page_table[scan]

When looking closer at ioport.c which implments of_ioremap()
I tentatively conclude that the direct reference above is OK.
But as I was not sure I left these as is.

The warnings could have been silenced with a few casts but that would just
hide the potential error that they flag.

	Sam
