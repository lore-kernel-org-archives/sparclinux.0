From: David Miller <davem@davemloft.net>
Date: Tue, 01 Mar 2016 05:47:22 +0000
Subject: [GIT] Sparc
Message-Id: <20160301.004722.1997314855091172440.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) System call tracing doesn't handle register contents properly
   across the trace.  From Mike Frysinger.

2) Hook up copy_file_range

3) Build fix for 32-bit with newer tools.

4) New sun4v watchdog driver, from Wim Coekaerts.

5) Set context system call has to allow for servicable
   faults when we flush the register windows to memory.

Please pull, thanks a lot!

The following changes since commit 404a47410c26a115123885977053e9a1a4460929:

  Merge branch 'uaccess' (batched user access infrastructure) (2016-01-21 13:02:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 397d1533b6cce0ccb5379542e2e6d079f6936c46:

  sparc64: Fix sparc64_set_context stack handling. (2016-03-01 00:25:32 -0500)

----------------------------------------------------------------
David S. Miller (3):
      sparc: Hook up copy_file_range syscall.
      sparc32: Add -Wa,-Av8 to KBUILD_CFLAGS.
      sparc64: Fix sparc64_set_context stack handling.

Mike Frysinger (1):
      sparc: Fix system call tracing register handling.

wim.coekaerts@oracle.com (1):
      Add sun4v_wdt watchdog driver

 Documentation/watchdog/watchdog-parameters.txt |   4 ++
 arch/sparc/Makefile                            |   6 ++
 arch/sparc/include/uapi/asm/unistd.h           |   3 +-
 arch/sparc/kernel/entry.S                      |  17 +++++
 arch/sparc/kernel/hvcalls.S                    |   3 +-
 arch/sparc/kernel/signal_64.c                  |   2 +-
 arch/sparc/kernel/sparc_ksyms_64.c             |   1 +
 arch/sparc/kernel/syscalls.S                   |  36 +++++++++++
 arch/sparc/kernel/systbls_32.S                 |   2 +-
 arch/sparc/kernel/systbls_64.S                 |   4 +-
 drivers/watchdog/Kconfig                       |  11 ++++
 drivers/watchdog/Makefile                      |   1 +
 drivers/watchdog/sun4v_wdt.c                   | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 275 insertions(+), 6 deletions(-)
 create mode 100644 drivers/watchdog/sun4v_wdt.c
