From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 13 Mar 2015 00:02:34 +0000
Subject: [PATCH v4 RFC 0/3] sparc: IOMMU pools for better scalability
Message-Id: <cover.1426194368.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Follows up on feedback to v3  patch-set from 
  http://www.spinics.net/lists/sparclinux/msg13462.html

specifically,
- pci_impl.h has no changes, now that all sparc iommu usage is converted
  to the common library.
- Remove IOMMU_ERROR_CODE. use DMA_ERROR_CODE
- page_table_map_base and page_table_shift are unsigned long.



Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

Sowmini Varadhan (1):
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  188 +++++++++++---------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  185 ++++++++++++++++---------------
 arch/sparc/kernel/pci_sun4v.c     |  193 ++++++++++++++++-----------------
 include/linux/iommu-common.h      |   55 +++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  220 +++++++++++++++++++++++++++++++++++++
 8 files changed, 533 insertions(+), 325 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

