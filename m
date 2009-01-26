From: David Miller <davem@davemloft.net>
Date: Mon, 26 Jan 2009 22:57:06 +0000
Subject: [GIT]: Sparc
Message-Id: <20090126.145706.154913313.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these Sparc bug fixes, thanks!

The following changes since commit f3b8436ad9a8ad36b3c9fa1fe030c7f38e5d3d0b:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../roland/infiniband

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Christian Borntraeger (1):
      [CVE-2009-0029] sparc: Enable syscall wrappers for 64-bit

David S. Miller (3):
      sparc64: Initialize FHC/CLOCK LED platform_device 'id' field correctly.
      sparc64: Annotate sparc64 specific syscalls with SYSCALL_DEFINEx()
      sparc64: Fix DAX handling via userspace access from kernel.

Sam Ravnborg (2):
      sparc64: fix readout of cpu/fpu type
      sparc64: fix modpost failure

 arch/sparc/Kconfig               |    1 +
 arch/sparc/kernel/central.c      |    2 +
 arch/sparc/kernel/cpu.c          |   18 ++++++++++++--
 arch/sparc/kernel/sys_sparc_64.c |   48 ++++++++++++++++++-------------------
 arch/sparc/kernel/syscalls.S     |    2 +-
 arch/sparc/kernel/systbls.h      |    3 --
 arch/sparc/kernel/systbls_64.S   |   16 ++++++------
 arch/sparc/kernel/traps_64.c     |   17 ++++++++++++-
 arch/sparc/lib/Makefile          |    3 +-
 9 files changed, 68 insertions(+), 42 deletions(-)
