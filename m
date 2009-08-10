From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 10 Aug 2009 02:53:09 +0000
Subject: [PATCH resend 0/8] sparc: use asm-generic/dma-mapping-common.h and pci-dma-compat.h
Message-Id: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, fujita.tomonori@lab.ntt.co.jp

This is the repost of the patchset (as Ingo asked me offline) :

http://lkml.org/lkml/2009/7/13/20

There is no functional change. I just added David's ack to #3-8
patches and Robert's Tested-by to #8 patch.

I confirmed that it can be applied cleanly to mainline, -next, and
-tip trees.

The git tree is also available:

git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git sparc

 arch/ia64/include/asm/dma-mapping.h      |    1 -
 arch/sparc/Kconfig                       |    2 +
 arch/sparc/include/asm/dma-mapping.h     |  145 ++++-------------------
 arch/sparc/include/asm/pci.h             |    3 +
 arch/sparc/include/asm/pci_32.h          |  105 ----------------
 arch/sparc/include/asm/pci_64.h          |   88 --------------
 arch/sparc/kernel/Makefile               |    2 +-
 arch/sparc/kernel/dma.c                  |  175 +--------------------------
 arch/sparc/kernel/dma.h                  |   14 --
 arch/sparc/kernel/iommu.c                |   20 ++-
 arch/sparc/kernel/ioport.c               |  190 ++++++++++++++++-------------
 arch/sparc/kernel/pci.c                  |    2 +-
 arch/sparc/kernel/pci_sun4v.c            |   30 ++----
 arch/x86/kernel/pci-nommu.c              |   27 ++++-
 include/asm-generic/dma-mapping-common.h |    6 -
 15 files changed, 183 insertions(+), 627 deletions(-)



