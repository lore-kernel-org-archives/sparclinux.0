From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 03 Mar 2015 14:22:02 +0000
Subject: [PATCH v2 0/2] sparc: IOMMU pools for better scalability
Message-Id: <20150303142202.GA7696@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


V2 version ofthis patch-set incorporates the feedback from
  http://marc.info/?l=linux-sparc&m2527471211108&w=2
The sparc specific fields have been moved  off into iommu_64.h, 
into struct iommu_sparc, leaving a minimalist struct iommu_table
in the common functions..

In addition to those changes, there are some additional enhancements to
improve the generality of this library that were based on inspection of other 
iommu use-case such as LDC, which have a much smaller map size 
(8k, vs 256k for pci_sun4v.c), and some other variations. These 
change are:

  (a) When the number of map entries is small, it may not be desirable
      to have too many pools: make npools an input parameter to the library
  (b) the cookie-to-index mapping function could be more complex,
      depending on the device. So added a ->cookie_to_index() indirection
      in the iommu_tbl_ops
  (c) Depending on the device, the span-boundary check may not be needed. 
      Allow for optimizations of this check.


Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

 arch/sparc/include/asm/iommu_64.h |   19 ++++
 arch/sparc/kernel/pci_impl.h      |    7 +-
 arch/sparc/kernel/pci_sun4v.c     |  217 +++++++++++++++++--------------------
 include/linux/iommu-common.h      |   57 ++++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  217 +++++++++++++++++++++++++++++++++++++
 6 files changed, 402 insertions(+), 117 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

