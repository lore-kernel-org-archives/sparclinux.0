From: David Miller <davem@davemloft.net>
Date: Sat, 18 Apr 2015 21:58:51 +0000
Subject: [GIT] Sparc
Message-Id: <20150418.175851.1417021646798799609.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Unfortunately, I brown paper bagged the generic iommu pool
allocator by applying the wrong revision of the patch series.

This reverts the bad one, and puts the right one in.

Please pull, thanks a lot!

The following changes since commit 04b7fe6a4a231871ef681bc95e08fe66992f7b1f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide (2015-04-17 16:36:59 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to ccb301862aa51ea7c10c10b440f3e8bbeac5b720:

  Merge branch 'iommu-generic-allocator' (2015-04-18 12:35:09 -0700)

----------------------------------------------------------------
David S. Miller (2):
      sparc: Revert generic IOMMU allocator.
      Merge branch 'iommu-generic-allocator'

Sowmini Varadhan (4):
      Break up monolithic iommu table/lock into finer graularity pools and lock
      sparc: Make sparc64 use scalable lib/iommu-common.c functions
      sparc: Make LDC use common iommu poll management functions
      iommu-common: Fix PARISC compile-time warnings

 arch/sparc/include/asm/iommu_64.h |   2 +-
 arch/sparc/kernel/iommu.c         |  78 +++++++++++-------------------
 arch/sparc/kernel/ldc.c           |  60 ++++++------------------
 arch/sparc/kernel/pci_sun4v.c     |  64 ++++++++++---------------
 include/linux/iommu-common.h      |  38 +++++++--------
 lib/iommu-common.c                | 190 ++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 6 files changed, 202 insertions(+), 230 deletions(-)
