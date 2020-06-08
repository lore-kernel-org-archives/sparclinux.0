From: David Miller <davem@davemloft.net>
Date: Mon, 08 Jun 2020 00:16:18 +0000
Subject: [GIT] Sparc
Message-Id: <20200607.171618.569910731236239182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Rework the sparc32 page tables so that READ_ONCE(*pmd), as done by
   generic code, operates on a word sized element.  From Will Deacon.

2) Some scnprintf() conversions, from Chen Zhou.

3) A pin_user_pages() conversion from John Hubbard.

4) Several 32-bit ptrace register handling fixes and such from Al Viro.

Please pull, thanks a lot!

The following changes since commit 24085f70a6e1b0cb647ec92623284641d8270637:

  Merge tag 'trace-v5.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2020-05-12 11:06:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next 

for you to fetch changes up to 4f8ad73898171cea2dce9ecf5bd4337c9dfcddc1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2020-06-07 17:11:41 -0700)

----------------------------------------------------------------
Al Viro (3):
      sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
      sparc32: fix register window handling in genregs32_[gs]et()
      fix a braino in "sparc32: fix register window handling in genregs32_[gs]et()"

Anupam Aggarwal (1):
      sparc: remove unused header file nfs_fs.h

Chen Zhou (2):
      sparc: use scnprintf() in show_pciobppath_attr() in pci.c
      sparc: use scnprintf() in show_pciobppath_attr() in vio.c

David S. Miller (6):
      Merge branch 'Rework-sparc32-page-table-layout'
      Merge branch 'sparc-scnprintf'
      Merge branch 'sparc32-SRMMU-fixes-for-SMP'
      Merge branch 'for-davem' of git://git.kernel.org/.../viro/vfs
      Merge branch 'for-davem' of git://git.kernel.org/.../viro/vfs
      Merge git://git.kernel.org/.../davem/sparc

Gustavo A. R. Silva (1):
      sparc64: Replace zero-length array with flexible-array

Jason Yan (1):
      sparc: mm: return true,false in kern_addr_valid()

John Hubbard (1):
      oradax: convert get_user_pages() --> pin_user_pages()

Mike Rapoport (1):
      sparc32: register memory occupied by kernel as memblock.memory

Wei Yongjun (1):
      tty: vcc: Fix error return code in vcc_probe()

Will Deacon (7):
      sparc32: mm: Fix argument checking in __srmmu_get_nocache()
      sparc32: mm: Restructure sparc32 MMU page-table layout
      sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
      sparc32: mm: Reduce allocation size for PMD and PTE tables
      sparc32: mm: Don't try to free page-table pages if ctor() fails
      sparc32: mm: Disable SPLIT_PTLOCK_CPUS
      sparc32: mm: Only call ctor()/dtor() functions for first and last user

 arch/sparc/include/asm/page_32.h    |  12 ++---
 arch/sparc/include/asm/pgalloc_32.h |  11 +++--
 arch/sparc/include/asm/pgtable_32.h |  40 ++++++++++------
 arch/sparc/include/asm/pgtsrmmu.h   |  36 ++-------------
 arch/sparc/include/asm/viking.h     |   5 +-
 arch/sparc/kernel/cpumap.c          |   2 +-
 arch/sparc/kernel/ds.c              |   8 ++--
 arch/sparc/kernel/head_32.S         |   8 ++--
 arch/sparc/kernel/pci.c             |   2 +-
 arch/sparc/kernel/ptrace_32.c       | 233 ++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------
 arch/sparc/kernel/ptrace_64.c       |  17 ++-----
 arch/sparc/kernel/sys_sparc32.c     |   1 -
 arch/sparc/kernel/vio.c             |   2 +-
 arch/sparc/mm/hypersparc.S          |   3 +-
 arch/sparc/mm/init_32.c             |   1 +
 arch/sparc/mm/init_64.c             |  10 ++--
 arch/sparc/mm/srmmu.c               | 106 +++++++++++++++++--------------------------
 arch/sparc/mm/viking.S              |   5 +-
 drivers/sbus/char/oradax.c          |   8 ++--
 drivers/tty/vcc.c                   |   1 +
 mm/Kconfig                          |   4 ++
 21 files changed, 221 insertions(+), 294 deletions(-)
