From: David Miller <davem@davemloft.net>
Date: Sat, 02 Aug 2008 05:12:52 +0000
Subject: [GIT]: Sparc
Message-Id: <20080801.221252.61981911.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc bug fixes and updates.

Thanks a lot!

The following changes since commit 04d91cb8163f7f946e348b2362a6e5dfa5f06b13:
  David S. Miller (1):
        sparc: Set CONFIG_HAVE_ARCH_TRACEHOOK

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (9):
      sparc64: Fix global reg snapshotting on self-cpu.
      sparc64: Kill isa_bus_type.
      sparc64: Make global reg dumping even more useful.
      sparc64: Hook up trigger_all_cpu_backtrace().
      sparc64: Kill VERBOSE_SHOWREGS code.
      sparc64: Kill smp_report_regs().
      sparc: Add __KERNEL__ ifdef protection to pt_regs helpers.
      sparc64: Kill __show_regs().
      sparc64: Do not clobber %g7 in setcontext() trap.

Florian Fainelli (1):
      sparc: Ignore drivers/video/console/promcon_tbl.c conmakehash generated file

Mikael Pettersson (1):
      sparc64: FUTEX_OP_ANDN fix

Stephen Rothwell (1):
      sparc: merge of_platform_{32,64}.h

 arch/sparc/include/asm/futex_64.h       |    2 +-
 arch/sparc/include/asm/irq_64.h         |    3 +
 arch/sparc/include/asm/of_platform.h    |   26 ++++++--
 arch/sparc/include/asm/of_platform_32.h |   24 -------
 arch/sparc/include/asm/of_platform_64.h |   25 -------
 arch/sparc/include/asm/ptrace_32.h      |   20 +++---
 arch/sparc/include/asm/ptrace_64.h      |   39 +++++------
 arch/sparc64/kernel/of_device.c         |    5 --
 arch/sparc64/kernel/process.c           |  110 ++++++++++---------------------
 arch/sparc64/kernel/signal.c            |    6 +-
 arch/sparc64/kernel/smp.c               |    6 --
 arch/sparc64/kernel/sparc64_ksyms.c     |    1 -
 arch/sparc64/kernel/traps.c             |   10 +--
 arch/sparc64/mm/ultra.S                 |   42 ++----------
 drivers/video/console/.gitignore        |    2 +
 15 files changed, 104 insertions(+), 217 deletions(-)
 delete mode 100644 arch/sparc/include/asm/of_platform_32.h
 delete mode 100644 arch/sparc/include/asm/of_platform_64.h
 create mode 100644 drivers/video/console/.gitignore
