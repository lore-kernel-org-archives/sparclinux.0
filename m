From: David Miller <davem@davemloft.net>
Date: Fri, 17 Apr 2015 20:14:03 +0000
Subject: [GIT] Sparc
Message-Id: <20150417.161403.768546036867659750.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


The PowerPC folks have a really nice scalable IOMMU pool allocator
that we wanted to make use of for sparc.   So here we have a series
that abstracts out their code into a common layer that anyone can
make use of.

Sparc is converted, and the PowerPC folks have reviewed and ACK'd
this series and plan to convert PowerPC over as well.

Please pull, thanks a lot!

The following changes since commit 497a5df7bf6ffd136ae21c49d1a01292930d7ca2:

  Merge tag 'stable/for-linus-4.1-rc0-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip (2015-04-16 14:01:03 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to cb97201cb060d13da0b87fd1bf68208c7389c5b1:

  iommu-common: Fix PARISC compile-time warnings (2015-04-17 15:24:36 -0400)

----------------------------------------------------------------
David S. Miller (1):
      Merge branch 'generic-iommu-allocator'

Sowmini Varadhan (4):
      sparc: Break up monolithic iommu table/lock into finer graularity pools and lock
      sparc: Make sparc64 use scalable lib/iommu-common.c functions
      sparc: Make LDC use common iommu poll management functions
      iommu-common: Fix PARISC compile-time warnings

 arch/sparc/include/asm/iommu_64.h |   7 ++--
 arch/sparc/kernel/iommu.c         | 188 ++++++++++++++++++++++++++++++++---------------------------------------------------------------
 arch/sparc/kernel/iommu_common.h  |   8 -----
 arch/sparc/kernel/ldc.c           | 185 +++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------
 arch/sparc/kernel/pci_sun4v.c     | 193 ++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------
 include/linux/iommu-common.h      |  55 ++++++++++++++++++++++++++++
 lib/Makefile                      |   2 +-
 lib/iommu-common.c                | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 537 insertions(+), 325 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c
