From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 22 Dec 2014 22:43:08 +0000
Subject: [PATCH 0/2] IOMMU pools for better scalability
Message-Id: <20141222224308.GH29674@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This patch series follows up on the suggestion in
  http://www.spinics.net/lists/sparclinux/msg13230.html

Patch 1 of the series adds the infra-structure functions
for range alloc/free into (new file) lib/iomm-common.c

Patch 2 of the series makes sparc64 use this via changes
to pci_sun4v.c

Sowmini Varadhan (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

 arch/sparc/kernel/pci_impl.h  |    7 ++-
 arch/sparc/kernel/pci_sun4v.c |  201 +++++++++++++++++++----------------------
 include/linux/iommu-common.h  |   70 ++++++++++++++
 lib/Makefile                  |    2 +-
 lib/iommu-common.c            |  200 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 370 insertions(+), 110 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

