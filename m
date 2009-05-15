From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Fri, 15 May 2009 02:23:07 +0000
Subject: [PATCH 0/4] sparc: unify dma-mapping_32.h and dma-mapping_64.h
Message-Id: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp

This patchset unifies dma-mapping_32.h and dma-mapping_64.h, that is,
it uses dma-mapping.h instead and removes dma-mapping_32.h and
dma-mapping_64.h.

In short, this patchset modifies SPARC32 to use struct dma_map
ops.

I like to see architectures implement the dma API in the similar way.

Thanks,

 arch/sparc/include/asm/dma-mapping.h    |  168 ++++++++++++++++++++++++++++++-
 arch/sparc/include/asm/dma-mapping_32.h |   60 -----------
 arch/sparc/include/asm/dma-mapping_64.h |  154 ----------------------------
 arch/sparc/kernel/dma.c                 |  127 +++++++----------------
 arch/sparc/kernel/iommu.c               |   15 ++--
 arch/sparc/kernel/pci_sun4v.c           |   15 ++--
 6 files changed, 218 insertions(+), 321 deletions(-)



