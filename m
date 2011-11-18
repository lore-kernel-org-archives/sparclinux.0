From: David Miller <davem@davemloft.net>
Date: Fri, 18 Nov 2011 19:22:04 +0000
Subject: [GIT] Sparc
Message-Id: <20111118.142204.540812327639462900.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Several bug fixes:

1) Make syscall restart properly save and restore the first argument
   register across possible ptrace modifications.

2) Implement sparc's io_remap_pfn_range() in terms of remap_pfn_range().
   A ton of divergance has occured over time and it makes no sense to
   have a completely seperate loop for what amounts to being a very
   minor optimization on sparc64.

3) Because modules can use things like pgprot_noncached() and friends,
   we have to process the sun4v code patching sections upon module
   load on sparc64.  This fixes crashes with infiniband on Niagara
   machines.

4) Missing header include, from Ben Hutchings.

Please pull, thanks a lot!

The following changes since commit b6844523839779030430ff28f036f83e2a3f43e6:

  Merge branch 'stable/for-linus-fixes-3.2' of git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen (2011-11-18 13:18:07 -0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

Ben Hutchings (1):
      sparc: sigutil: Include <linux/errno.h>

David S. Miller (4):
      sparc: Fix handling of orig_i0 wrt. debugging when restarting syscalls.
      sparc: Stash orig_i0 into %g6 instead of %g2
      sparc: Kill custom io_remap_pfn_range().
      sparc64: Patch sun4v code sequences properly on module load.

 arch/sparc/include/asm/pgtable_32.h |   20 ++++-
 arch/sparc/include/asm/pgtable_64.h |   20 ++++-
 arch/sparc/kernel/entry.h           |    7 ++
 arch/sparc/kernel/module.c          |   27 ++++++
 arch/sparc/kernel/setup_64.c        |   48 ++++++----
 arch/sparc/kernel/signal32.c        |   18 ++--
 arch/sparc/kernel/signal_32.c       |   30 +++++-
 arch/sparc/kernel/signal_64.c       |   42 ++++++---
 arch/sparc/kernel/sigutil_64.c      |    1 +
 arch/sparc/mm/Makefile              |    1 -
 arch/sparc/mm/generic_32.c          |   99 ---------------------
 arch/sparc/mm/generic_64.c          |  165 -----------------------------------
 12 files changed, 159 insertions(+), 319 deletions(-)
 delete mode 100644 arch/sparc/mm/generic_32.c
 delete mode 100644 arch/sparc/mm/generic_64.c

   
