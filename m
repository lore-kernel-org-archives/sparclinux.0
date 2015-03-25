From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 25 Mar 2015 17:34:45 +0000
Subject: [PATCH v7 0/3] Generic IOMMU pooled allocator
Message-Id: <cover.1427295804.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net


Changes from patchv6: moved pool_hash initialization to
lib/iommu-common.c and cleaned up code duplication from 
sun4v/sun4u/ldc. 

Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

Sowmini Varadhan (1):
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  174 +++++++--------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  152 ++++++++++--------------
 arch/sparc/kernel/pci_sun4v.c     |  179 +++++++++++++----------------
 include/linux/iommu-common.h      |   48 ++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  235 +++++++++++++++++++++++++++++++++++++
 8 files changed, 475 insertions(+), 330 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

