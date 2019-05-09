From: David Miller <davem@davemloft.net>
Date: Thu, 09 May 2019 21:35:31 +0000
Subject: [GIT] Sparc
Message-Id: <20190509.143531.499657137828123463.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Here we go:

1) Fix various long standing issues in the sparc 32-bit IOMMU support
   code, from Christoph Hellwig.

2) Various other code cleanups and simplifications all over.  From
   Gustavo A. R. Silva, Jagadeesh Pagadala, Masahiro Yamada, Mauro
   Carvalho Chehab, Mike Rapoport.

Please pull, thanks a lot!

The following changes since commit 92fab77b6b309dc219b02da4a69ad5dc76f7ec74:

  Merge tag 'mips_5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux (2019-05-08 16:41:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to f4d9a23d3dad0252f375901bf4ff6523a2c97241:

  sparc64: simplify reduce_memory() function (2019-05-09 14:26:17 -0700)

----------------------------------------------------------------
Christoph Hellwig (9):
      sparc/iommu: use !PageHighMem to check if a page has a kernel mapping
      sparc/iommu: use sbus_iommu_unmap_page in sbus_iommu_unmap_sg
      sparc/iommu: merge iommu_release_one and sbus_iommu_unmap_page
      sparc/iommu: create a common helper for map_sg
      sparc/iommu: pass a physical address to iommu_get_one
      sparc/iommu: move per-page flushing into __sbus_iommu_map_page
      sparc/iommu: fix __sbus_iommu_map_page for highmem pages
      sparc/iommu: use __sbus_iommu_map_page to implement the map_sg path
      sparc/iommu: merge iommu_get_one and __sbus_iommu_map_page

David S. Miller (1):
      Merge branch 'sparc32-iommu-SG-list'

Gustavo A. R. Silva (1):
      sparc: use struct_size() in kzalloc()

Jagadeesh Pagadala (1):
      arch:sparc:kernel/uprobes.c : Remove duplicate header

Masahiro Yamada (1):
      sparc: vdso: add FORCE to the build rule of %.so

Mauro Carvalho Chehab (1):
      docs: sparc: convert to ReST

Mike Rapoport (1):
      sparc64: simplify reduce_memory() function

 Documentation/sparc/{adi.txt => adi.rst}                      | 188 ++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------
 Documentation/sparc/{console.txt => console.rst}              |   4 +-
 Documentation/sparc/index.rst                                 |  13 +++++++
 Documentation/sparc/oradax/{oracle-dax.txt => oracle-dax.rst} |  58 +++++++++++++++++----------
 arch/sparc/kernel/cpumap.c                                    |   3 +-
 arch/sparc/kernel/uprobes.c                                   |   1 -
 arch/sparc/mm/init_64.c                                       |  42 +-------------------
 arch/sparc/mm/iommu.c                                         | 142 +++++++++++++++++++++++++++---------------------------------------
 arch/sparc/vdso/Makefile                                      |   2 +-
 drivers/sbus/char/oradax.c                                    |   2 +-
 10 files changed, 213 insertions(+), 242 deletions(-)
 rename Documentation/sparc/{adi.txt => adi.rst} (70%)
 rename Documentation/sparc/{console.txt => console.rst} (53%)
 create mode 100644 Documentation/sparc/index.rst
 rename Documentation/sparc/oradax/{oracle-dax.txt => oracle-dax.rst} (95%)
