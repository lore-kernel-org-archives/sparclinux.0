From: David Miller <davem@davemloft.net>
Date: Mon, 06 Apr 2020 18:25:28 +0000
Subject: [GIT] Sparc
Message-Id: <20200406.112528.895031681027517472.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


A per-device DMA ops conversion for sparc32 by Chrstioph Hellwig.

Please pull, thanks a lot!

The following changes since commit bef7b2a7be28638770972ab2709adf11d601c11a:

  Merge tag 'devicetree-for-5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2020-04-02 17:32:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 255a69a94b8cbbcfef142137b5e7f99b5d168771:

  sparc32: use per-device dma_ops (2020-04-02 18:11:55 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      sparc32: use per-device dma_ops

 arch/sparc/include/asm/dma-mapping.h | 15 ++-------------
 arch/sparc/kernel/ioport.c           |  3 ---
 arch/sparc/kernel/of_device_common.c |  1 +
 arch/sparc/mm/io-unit.c              |  9 ++++-----
 arch/sparc/mm/iommu.c                | 15 ++++++++-------
 arch/sparc/mm/mm_32.h                |  3 ---
 arch/sparc/mm/srmmu.c                |  4 +---
 7 files changed, 16 insertions(+), 34 deletions(-)
