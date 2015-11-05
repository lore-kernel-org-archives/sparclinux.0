From: David Miller <davem@davemloft.net>
Date: Thu, 05 Nov 2015 21:39:59 +0000
Subject: [GIT] Sparc
Message-Id: <20151105.163959.1438115257720770769.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just a couple of fixes/cleanups:

1) Correct NUMA latency calculations on sparc64, from Nitin Gupta.

2) ASI_ST_BLKINIT_MRU_S value was wrong, from Rob Gardner.

3) Fix non-faulting load handling of non-quad values, also from Rob
   Gardner.

4) Cleanup VISsave assembler, from Sam Ravnborg.

5) Fix iommu-common code so it doesn't emit rediculous warnings
   on some architectures, particularly ARM.

Please pull, thanks a lot!

The following changes since commit 49d7c6559bf2ab4f1d56be131ab9571a51fc71bd:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2015-08-07 05:28:24 +0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 52708d690b8be132ba9d294464625dbbdb9fa5df:

  sparc64: Fix numa distance values (2015-11-04 12:14:49 -0800)

----------------------------------------------------------------
David S. Miller (1):
      iommu-common: Fix error code used in iommu_tbl_range_{alloc,free}().

Nitin Gupta (1):
      sparc64: Fix numa distance values

Rob Gardner (2):
      sparc64: Fix incorrect ASI_ST_BLKINIT_MRU_S value
      sparc64: Don't restrict fp regs for no-fault loads

Sam Ravnborg (1):
      sparc64: use ENTRY/ENDPROC in VISsave

 arch/sparc/include/asm/topology_64.h |  3 +++
 arch/sparc/include/uapi/asm/asi.h    |  2 +-
 arch/sparc/kernel/iommu.c            | 12 ++++++------
 arch/sparc/kernel/ldc.c              |  2 +-
 arch/sparc/kernel/pci_sun4v.c        | 18 +++++++++---------
 arch/sparc/kernel/unaligned_64.c     | 22 +++++++++++++++-------
 arch/sparc/lib/VISsave.S             | 10 +++++-----
 arch/sparc/mm/init_64.c              | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu-common.h         |  1 +
 lib/iommu-common.c                   | 10 +++-------
 10 files changed, 113 insertions(+), 37 deletions(-)
