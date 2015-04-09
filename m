From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 09 Apr 2015 19:33:29 +0000
Subject: [PATCH v10 0/3] Generic IOMMU pooled allocator
Message-Id: <cover.1428605063.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net


Investigation of network performance on Sparc shows a high
degree of locking contention in the IOMMU allocator, and it
was noticed that the PowerPC code has a better locking model.

This patch series tries to extract the generic parts of the 
PowerPC code so that it can be shared across multiple PCI
devices and architectures.

v10: resend patchv9 without RFC tag, and a new mail Message-Id,
(previous non-RFC attempt did not show up on the patchwork queue?)

Full revision history below:
v2 changes:
  - incorporate David Miller editorial comments: sparc specific
    fields moved from iommu-common into sparc's iommu_64.h
  - make the npools value an input parameter, for the case when
    the iommu map size is not very large
  - cookie_to_index mapping, and optimizations for span-boundary
    check, for use case such as LDC.

v3: eliminate iommu_sparc, rearrange the ->demap indirection to
    be invoked under the pool lock.

v4: David Miller review changes:
  - s/IOMMU_ERROR_CODE/DMA_ERROR_CODE
  - page_table_map_base and page_table_shift are unsigned long, not u32.

v5: removed ->cookie_to_index and ->demap indirection from the
    iommu_tbl_ops The caller needs to call these functions as needed,
    before invoking the generic arena allocator functions.
    Added the "skip_span_boundary" argument to iommu_tbl_pool_init() for
    those callers like LDC which do no care about span boundary checks.

v6: removed iommu_tbl_ops, and instead pass the ->flush_all as
    an indirection to iommu_tbl_pool_init(); only invoke ->flush_all
    when there is no large_pool, based on the assumption that large-pool
    usage is infrequently encountered

v7: moved pool_hash initialization to lib/iommu-common.c and cleaned up
    code duplication from sun4v/sun4u/ldc. 

v8: Addresses BenH comments with one exception: I've left the
    IOMMU_POOL_HASH as is, so that powerpc can tailor it to their
    convenience.  Discard trylock for simple spin_lock to acquire pool

v9: Addresses latest BenH comments: need_flush checks, add support
    for dma mask and align_order. 

v10: resend without RFC tag, and new mail Message-Id.

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

