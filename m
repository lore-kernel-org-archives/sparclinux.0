From: David Miller <davem@davemloft.net>
Date: Fri, 01 Apr 2011 06:33:30 +0000
Subject: [GIT] Sparc
Message-Id: <20110331.233330.226762625.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix section mismatch errors on sparc64.  These were all legitimate
   and were resulting in freed memory being referenced after boot.

2) Hook up sys_syncfs

3) apbuart LEON driver fixes from Daniel Hellstrom.

Please pull, thanks a lot!

The following changes since commit ecb78ab6f30106ab72a575a25b1cdfd1633b7ca2:

  Merge branch 'release' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6 (2011-03-30 12:22:15 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Daniel Hellstrom (2):
      sparc32, leon: APBUART driver must use archdata to get IRQ number
      sparc32,leon: Fixed APBUART frequency detection

David S. Miller (3):
      sparc: Hook up syncfs system call.
      sparc64: Fix section mis-match errors.
      apbuart: Depend upon sparc.

Tkhai Kirill (1):
      sparc32: Pass task_struct to schedule_tail() in ret_from_fork

 arch/sparc/include/asm/unistd.h |    3 ++-
 arch/sparc/kernel/auxio_64.c    |    2 +-
 arch/sparc/kernel/central.c     |    4 ++--
 arch/sparc/kernel/ds.c          |    2 +-
 arch/sparc/kernel/entry.S       |    2 +-
 arch/sparc/kernel/mdesc.c       |    2 +-
 arch/sparc/kernel/pci_fire.c    |    2 +-
 arch/sparc/kernel/pci_psycho.c  |    2 +-
 arch/sparc/kernel/pci_sabre.c   |    2 +-
 arch/sparc/kernel/pci_schizo.c  |    2 +-
 arch/sparc/kernel/pci_sun4v.c   |    2 +-
 arch/sparc/kernel/power.c       |    2 +-
 arch/sparc/kernel/systbls_32.S  |    2 +-
 arch/sparc/kernel/systbls_64.S  |    2 ++
 arch/sparc/kernel/time_64.c     |    6 +++---
 drivers/tty/serial/Kconfig      |    2 +-
 drivers/tty/serial/apbuart.c    |   34 +++++++++++-----------------------
 17 files changed, 32 insertions(+), 41 deletions(-)
