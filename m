From: David Miller <davem@davemloft.net>
Date: Wed, 26 Aug 2009 03:38:28 +0000
Subject: [GIT]: Sparc
Message-Id: <20090825.203828.211231142.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc bug fixes.

Thanks!

The following changes since commit 4075ea8c54a7506844a69f674990241e7766357b:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../bp/bp

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (7):
      sparc: Fix cleanup crash in bbc_envctrl_cleanup()
      sparc64: Sign extend length arg to truncate syscalls when compat.
      sparc: Use page_fault_out_of_memory() for VM_FAULT_OOM.
      sparc32: Kill trap table freeing code.
      sparc32: Update defconfig.
      sparc64: Update defconfig.
      sparc64: Validate linear D-TLB misses.

Mathieu Desnoyers (1):
      sparc: sys32.S incorrect compat-layer splice() system call

 arch/sparc/configs/sparc32_defconfig |   74 ++++++++++++++++++++--------------
 arch/sparc/configs/sparc64_defconfig |   59 +++++++++++++++-----------
 arch/sparc/include/asm/pgtable_64.h  |   12 ++++-
 arch/sparc/kernel/ktlb.S             |   42 +++++++++++++++++--
 arch/sparc/kernel/sun4d_smp.c        |   22 ----------
 arch/sparc/kernel/sun4m_smp.c        |   26 ------------
 arch/sparc/kernel/sys32.S            |    4 +-
 arch/sparc/kernel/systbls_64.S       |    4 +-
 arch/sparc/mm/fault_32.c             |    7 ++-
 arch/sparc/mm/fault_64.c             |    7 ++-
 arch/sparc/mm/init_64.c              |   43 +++++++++++---------
 arch/sparc/mm/init_64.h              |    7 ++-
 drivers/sbus/char/bbc_envctrl.c      |   11 ++++-
 13 files changed, 175 insertions(+), 143 deletions(-)
