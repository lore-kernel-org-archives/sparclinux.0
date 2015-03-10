From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 10 Mar 2015 22:27:02 +0000
Subject: [PATCH v3 RFC 0/3] sparc: IOMMU pools for better scalability
Message-Id: <cover.1426021520.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a follow-up to 
  http://www.spinics.net/lists/sparclinux/msg13443.html

All sparc iommu usage (LDC, sun4u, sun4v) has now been converted to the
new library.  The one and only struct iommu for sparc uses the iommu_table
defined in iommu-common.c. 

I tested this on a sunfire (V440) and an ultra-45, in addition to a T5,
and LDOMS, but I could use more testing help for the legacy platforms.
Also, I'll be on the road a bit for the rest of the week, so will be
a bit slow to handle review feedback (hence derailing this to RFC status) 

Patches division is as follows.

Patch 1: Common library functions in
             lib/Makefile 
             include/linux/iommu-common.h
             lib/iommu-common.c
Patch 2: Converts  sun4u, sun4v, PCI in sparc to use common library. Impacts
             arch/sparc/include/asm/iommu_64.h
             arch/sparc/kernel/iommu.c
             arch/sparc/kernel/iommu_common.h
             arch/sparc/kernel/pci_sun4v.c
Patch 3: Converts LDC to use Patch 1. Impacts
             arch/sparc/kernel/ldc.c


Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

Sowmini Varadhan (1):
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  194 +++++++++++---------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  185 ++++++++++++++++---------------
 arch/sparc/kernel/pci_impl.h      |    7 +-
 arch/sparc/kernel/pci_sun4v.c     |  207 +++++++++++++++++------------------
 include/linux/iommu-common.h      |   56 ++++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  220 +++++++++++++++++++++++++++++++++++++
 9 files changed, 550 insertions(+), 336 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

