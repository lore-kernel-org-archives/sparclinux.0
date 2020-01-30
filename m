From: David Miller <davem@davemloft.net>
Date: Thu, 30 Jan 2020 10:19:27 +0000
Subject: [GIT] Sparc
Message-Id: <20200130.111927.1184332737812002632.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Add a proper .exit.data section.

2) Fix ipc64_perm type definition, from Arnd Bergmann.

3) Support folded p4d page tables on sparc64, from Mike Rapport.

4) Remove uses of struct timex, also from Arnd Bergmann.

Please pull, thanks a lot!

The following changes since commit 7b5cf701ea9c395c792e2a7e3b7caf4c68b87721:

  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-07-22 09:30:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to d68712ee35069455ea4043d443c8d4fb9a1ee956:

  y2038: sparc: remove use of struct timex (2020-01-30 11:14:28 +0100)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32, leon: Stop adding vendor and device id to prom ambapp path components

Arnd Bergmann (2):
      sparc32: fix struct ipc64_perm type definition
      y2038: sparc: remove use of struct timex

Arvind Sankar (1):
      sparc/console: kill off obsolete declarations

David S. Miller (1):
      sparc: Add .exit.data section.

Masahiro Yamada (1):
      sparc: remove unneeded uapi/asm/statfs.h

Mike Rapoport (1):
      sparc64: add support for folded p4d page tables

 arch/sparc/include/asm/pgalloc_64.h  |  6 +++---
 arch/sparc/include/asm/pgtable_64.h  | 24 ++++++++++++------------
 arch/sparc/include/uapi/asm/ipcbuf.h | 22 +++++++++++-----------
 arch/sparc/include/uapi/asm/statfs.h |  7 -------
 arch/sparc/kernel/prom_32.c          | 18 ++++--------------
 arch/sparc/kernel/signal32.c         |  6 +++++-
 arch/sparc/kernel/smp_64.c           | 13 ++++++++++++-
 arch/sparc/kernel/sys_sparc_64.c     | 33 +++++++++++++++++----------------
 arch/sparc/kernel/vmlinux.lds.S      |  6 ++++--
 arch/sparc/mm/fault_64.c             |  6 +++++-
 arch/sparc/mm/hugetlbpage.c          | 28 ++++++++++++++++++----------
 arch/sparc/mm/init_64.c              | 33 +++++++++++++++++++++++++++++----
 include/linux/console.h              |  2 --
 include/uapi/linux/timex.h           |  2 ++
 14 files changed, 122 insertions(+), 84 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/statfs.h
