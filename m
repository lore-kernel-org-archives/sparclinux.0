From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 31 Mar 2015 14:40:43 +0000
Subject: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <cover.1427761300.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Addresses BenH comments with one exception: I've left the
IOMMU_POOL_HASH as is, so that powerpc can tailor it to their
convenience. 

I've not heard back from the IB folks, but I'm going to make
a judgement call here and go with the spin_lock. *If* they
report some significant benefit from the trylock, probably 
need to revisit this (and then probably start by re-exmaining
the hash function to avoid collisions, before resorting to 
trylock).

Sowmini Varadhan (3):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  171 +++++++--------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  153 ++++++++++--------------
 arch/sparc/kernel/pci_sun4v.c     |  181 +++++++++++++----------------
 include/linux/iommu-common.h      |   48 ++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  233 +++++++++++++++++++++++++++++++++++++
 8 files changed, 472 insertions(+), 331 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

