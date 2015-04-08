From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 08 Apr 2015 13:25:29 +0000
Subject: [PATCH v9 0/3] Generic IOMMU pooled allocator
Message-Id: <cover.1428181553.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net


Resubmitting V9 version without RFC tag.

Addresses latest BenH comments: need_flush checks, add support
for dma mask and align_order. 

Sowmini Varadhan (3):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  172 ++++++------------------
 arch/sparc/kernel/iommu_common.h  |    8 -
 arch/sparc/kernel/ldc.c           |  153 +++++++++------------
 arch/sparc/kernel/pci_sun4v.c     |  183 ++++++++++++--------------
 include/linux/iommu-common.h      |   51 +++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  266 +++++++++++++++++++++++++++++++++++++
 8 files changed, 511 insertions(+), 331 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

