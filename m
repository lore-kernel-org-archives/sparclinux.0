From: David Miller <davem@davemloft.net>
Date: Tue, 03 Apr 2018 15:31:29 +0000
Subject: [GIT] Sparc
Message-Id: <20180403.113129.1922264570950091622.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Add support for ADI (Application Data Integrity) found in more recent
   sparc64 cpus.  Essentially this is keyed based access to virtual memory,
   and if the key encoded in the virual address is wrong you get a trap.

   The mm changes were reviewed by Andrew Morton and others.

   Work by Khalid Aziz.

2) Validate DAX completion index range properly, from Rob Gardner.

3) Add proper Kconfig deps for DAX driver.  From Guenter Roeck.

Please pull, thanks a lot.

The following changes since commit 8f5fd927c3a7576d57248a2d7a0861c3f2795973:

  Merge tag 'for-4.16-rc5-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2018-03-16 13:37:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git 

for you to fetch changes up to d13864b68e41c11e4231de90cf358658f6ecea45:

  sparc64: Make atomic_xchg() an inline function rather than a macro. (2018-04-03 08:24:35 -0700)

----------------------------------------------------------------
David S. Miller (3):
      Merge branch 'sparc64-ADI'
      Merge git://git.kernel.org/.../davem/sparc
      sparc64: Make atomic_xchg() an inline function rather than a macro.

Guenter Roeck (1):
      sparc64: Oracle DAX driver depends on SPARC64

Khalid Aziz (12):
      signals, sparc: Add signal codes for ADI violations
      mm, swap: Add infrastructure for saving page metadata on swap
      sparc64: Add support for ADI register fields, ASIs and traps
      sparc64: Add HV fault type handlers for ADI related faults
      sparc64: Add handler for "Memory Corruption Detected" trap
      sparc64: Add auxiliary vectors to report platform ADI properties
      mm: Add address parameter to arch_validate_prot()
      mm: Clear arch specific VM flags on protection change
      mm: Allow arch code to override copy_highpage()
      sparc64: Add support for ADI (Application Data Integrity)
      sparc64: Update signal delivery to use new helper functions
      sparc: Make auxiliary vectors for ADI available on 32-bit as well

Rob Gardner (1):
      sparc64: Properly range check DAX completion index

 Documentation/sparc/adi.txt             | 278 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/mman.h         |   4 +-
 arch/powerpc/kernel/syscalls.c          |   2 +-
 arch/sparc/include/asm/adi.h            |   6 ++
 arch/sparc/include/asm/adi_64.h         |  47 +++++++++++++
 arch/sparc/include/asm/atomic_64.h      |   6 +-
 arch/sparc/include/asm/elf_64.h         |   5 ++
 arch/sparc/include/asm/hypervisor.h     |   2 +
 arch/sparc/include/asm/mman.h           |  84 ++++++++++++++++++++++-
 arch/sparc/include/asm/mmu_64.h         |  17 +++++
 arch/sparc/include/asm/mmu_context_64.h |  51 ++++++++++++++
 arch/sparc/include/asm/page_64.h        |   6 ++
 arch/sparc/include/asm/pgtable_64.h     |  48 ++++++++++++++
 arch/sparc/include/asm/thread_info_64.h |   2 +-
 arch/sparc/include/asm/trap_block.h     |   2 +
 arch/sparc/include/asm/ttable.h         |  10 +++
 arch/sparc/include/uapi/asm/asi.h       |   5 ++
 arch/sparc/include/uapi/asm/auxvec.h    |   9 ++-
 arch/sparc/include/uapi/asm/mman.h      |   2 +
 arch/sparc/include/uapi/asm/pstate.h    |  10 +++
 arch/sparc/kernel/Makefile              |   1 +
 arch/sparc/kernel/adi_64.c              | 397 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/entry.h               |   3 +
 arch/sparc/kernel/etrap_64.S            |  27 +++++++-
 arch/sparc/kernel/head_64.S             |   1 +
 arch/sparc/kernel/mdesc.c               |   2 +
 arch/sparc/kernel/process_64.c          |  25 +++++++
 arch/sparc/kernel/rtrap_64.S            |  33 ++++++++-
 arch/sparc/kernel/setup_64.c            |   2 +
 arch/sparc/kernel/sun4v_mcd.S           |  18 +++++
 arch/sparc/kernel/traps_64.c            | 130 ++++++++++++++++++++++++++++++++++--
 arch/sparc/kernel/ttable_64.S           |   6 +-
 arch/sparc/kernel/urtt_fill.S           |   7 +-
 arch/sparc/kernel/vmlinux.lds.S         |   5 ++
 arch/sparc/mm/gup.c                     |  37 +++++++++++
 arch/sparc/mm/hugetlbpage.c             |  14 +++-
 arch/sparc/mm/init_64.c                 |  69 +++++++++++++++++++
 arch/sparc/mm/tsb.c                     |  21 ++++++
 arch/x86/kernel/signal_compat.c         |   2 +-
 drivers/sbus/char/Kconfig               |   3 +-
 drivers/sbus/char/oradax.c              |   2 +-
 include/asm-generic/pgtable.h           |  36 ++++++++++
 include/linux/highmem.h                 |   4 ++
 include/linux/mm.h                      |   9 +++
 include/linux/mman.h                    |   2 +-
 include/uapi/asm-generic/siginfo.h      |   5 +-
 mm/ksm.c                                |   4 ++
 mm/memory.c                             |   1 +
 mm/mprotect.c                           |   4 +-
 mm/rmap.c                               |  14 ++++
 50 files changed, 1451 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/sparc/adi.txt
 create mode 100644 arch/sparc/include/asm/adi.h
 create mode 100644 arch/sparc/include/asm/adi_64.h
 create mode 100644 arch/sparc/kernel/adi_64.c
 create mode 100644 arch/sparc/kernel/sun4v_mcd.S
