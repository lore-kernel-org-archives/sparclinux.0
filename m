From: David Miller <davem@davemloft.net>
Date: Tue, 15 Dec 2009 06:04:43 +0000
Subject: [GIT]: Sparc
Message-Id: <20091214.220443.109333463.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Match some minor bug fixes and feature additions done on
x86 and powerpc during this merge window.

Fix 64-bit PCI BAR handling when device is underneath 32-bit
PCI bridge.

Fix mcount based stack overflow detection wrt. IRQ stacks.

Use new free_bootmem_late() and clock*_calc_mult_shift() helpers.

Please pull, thanks a lot!

The following changes since commit 053fe57ac249a9531c396175778160d9e9509399:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (14):
      sparc64: Fix overly strict range type matching for PCI devices.
      sparc64: Fix stack debugging IRQ stack regression.
      sparc64: Don't specify IRQF_SHARED for LDC interrupts.
      sparc: Validate that kprobe address is 4-byte aligned.
      sparc64: Use kprobes_built_in() to avoid ifdefs in fault_64.c
      sparc64: Add some missing __kprobes annotations to kernel fault paths.
      sparc: Use __builtin_object_size() to validate the buffer size for copy_from_user()
      sparc: Stop trying to be so fancy and use __builtin_{memcpy,memset}()
      sparc64: Add syscall tracepoint support.
      sparc: Add alignment and emulation fault perf events.
      sparc64: Use free_bootmem_late() in mdesc_lmb_free().
      Merge branch 'master' of /home/davem/src/GIT/linux-2.6/
      sparc64: Use clock{source,events}_calc_mult_shift().
      sparc64: Fix clock event multiplier printf format.

 arch/sparc/Kconfig                      |    1 +
 arch/sparc/Kconfig.debug                |   14 ++++++
 arch/sparc/include/asm/string_32.h      |   78 +------------------------------
 arch/sparc/include/asm/string_64.h      |   25 +---------
 arch/sparc/include/asm/thread_info_64.h |    2 +
 arch/sparc/include/asm/uaccess_32.h     |   15 ++++++
 arch/sparc/include/asm/uaccess_64.h     |   23 ++++++++--
 arch/sparc/include/asm/unistd.h         |    2 +-
 arch/sparc/kernel/entry.S               |    2 +-
 arch/sparc/kernel/ftrace.c              |   11 ++++
 arch/sparc/kernel/kprobes.c             |    3 +
 arch/sparc/kernel/ldc.c                 |    4 +-
 arch/sparc/kernel/mdesc.c               |   21 ++------
 arch/sparc/kernel/of_device_64.c        |   14 +++++-
 arch/sparc/kernel/ptrace_64.c           |   10 ++++
 arch/sparc/kernel/syscalls.S            |   14 +++---
 arch/sparc/kernel/time_64.c             |   26 +---------
 arch/sparc/kernel/unaligned_32.c        |   15 +-----
 arch/sparc/kernel/unaligned_64.c        |   23 ++++------
 arch/sparc/kernel/visemul.c             |    3 +
 arch/sparc/lib/Makefile                 |    1 +
 arch/sparc/lib/bzero.S                  |    5 --
 arch/sparc/lib/checksum_32.S            |    2 +-
 arch/sparc/lib/ksyms.c                  |    2 -
 arch/sparc/lib/mcount.S                 |    5 +-
 arch/sparc/lib/memcpy.S                 |    3 -
 arch/sparc/lib/memset.S                 |    3 +-
 arch/sparc/lib/usercopy.c               |    8 +++
 arch/sparc/math-emu/math_32.c           |    3 +
 arch/sparc/math-emu/math_64.c           |    2 +
 arch/sparc/mm/fault_64.c                |   24 ++++------
 31 files changed, 154 insertions(+), 210 deletions(-)
 create mode 100644 arch/sparc/lib/usercopy.c
