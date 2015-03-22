From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 22 Mar 2015 19:22:51 +0000
Subject: [PATCH v5 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <cover.1426986386.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, davem@davemloft.net

Follows up on the feedback in the thread at
  http://www.spinics.net/lists/sparclinux/msg13493.html

- removed ->cookie_to_index and ->demap indirection from the iommu_tbl_ops
  The caller needs to call these functions as needed, before invoking
  the generic arena allocator functions.

- added the "skip_span_boundary" argument to iommu_tbl_pool_init() for
  those callers like LDC which do no care about span boundary checks.


Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

Sowmini Varadhan (1):
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  187 +++++++++++---------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  172 ++++++++++++++---------------
 arch/sparc/kernel/pci_sun4v.c     |  194 ++++++++++++++++-----------------
 include/linux/iommu-common.h      |   55 +++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  219 +++++++++++++++++++++++++++++++++++++
 8 files changed, 519 insertions(+), 325 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

