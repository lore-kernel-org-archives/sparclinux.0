From: David Miller <davem@davemloft.net>
Date: Wed, 30 May 2012 22:38:25 +0000
Subject: [GIT] Sparc
Message-Id: <20120530.183825.2036705800447162589.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Remove the idiotic situation wherein Leon was a special
   case in all of the TLB/cache handling code.

   The worst side effect of this bogosity is that you couldn't build a
   kernel with Leon support enabled (to get better build coverage),
   and test boot it on a non-LEON cpu.

   Leon is, in all core respects, programatically identical to the
   32-bit SRMMU.  Except that they put the TLB registers in a
   different alternate address space location.

   Through code patching (for fast paths) and run time checks, this
   issue is now a thing of the past.

   From Sam Ravnborg.

2) There was a mis-merge of arch/sparc/Kconfig for one of the
   clockevents changes that went in, causing 32-bit sparc to
   start failing to build.

   I merged in your tree to get those clockevents changes (and
   added a note to the merge commit) then added Stephen Rothwell's
   fix for the merge error.

3) Software quad floating point emulation was not working properly
   on more recent Niagara chips, because the way the situation is
   reported by the cpu has changed.

   Nobody noticed because gcc emits calls to software emulation
   routines in glibc.

Please pull, thanks a lot!

The following changes since commit af56e0aa35f3ae2a4c1a6d1000702df1dd78cb76:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client (2012-05-30 11:17:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (3):
      sparc64: Fix several bugs in quad floating point emulation.
      Merge git://git.kernel.org/.../torvalds/linux
      sparc32: Export leon_dma_ops to modules.

Sam Ravnborg (22):
      sparc32: string and whitespace cleanup in head_32.S
      sparc32: implement proper LEON support in head_32 (before highmem)
      sparc32: implement proper LEON support in head_32 (after highmem)
      sparc32: introduce sparc32_start_kernel called from head_32.S
      sparc32: add support for run-time patching of leon/sun single instructions
      sparc32: handle leon in irq_32.c
      sparc32: handle leon in cpu.c
      sparc32,leon: clean up leon.h
      sparc32,leon: always include leon_kernel in build
      sparc32,leon: always include leon_smp + leon_mm in build
      sparc32,leon: fix section mismatch warning
      sparc32: introduce support for run-time patching for all shared assembler code
      sparc32: introduce run-time patching of srmmu access functions
      sparc32: drop LEON hack for ASI_M_MMUREGS
      sparc32: srmmu_probe now knows about leon too
      sparc32: refactor cpu_idle()
      sparc32,leon: always include leon_pmc in build
      sparc32,leon: always support leon in ioport
      sparc32: support leon + sun in dma_make_coherent()
      sparc32,leon: fix leon bootup
      sparc32: remove unused variable in head_32.S
      sparc: fix sparc64 build due to leon.h inclusion

Stephen Rothwell (1):
      sparc: fix bad merge of sparc Kconfig

 arch/sparc/Kconfig                   |    1 -
 arch/sparc/include/asm/asi.h         |    4 -
 arch/sparc/include/asm/asmmacro.h    |   22 +++++
 arch/sparc/include/asm/dma-mapping.h |    9 ++-
 arch/sparc/include/asm/leon.h        |   82 +----------------
 arch/sparc/include/asm/leon_amba.h   |    4 -
 arch/sparc/include/asm/pgtsrmmu.h    |   86 ++----------------
 arch/sparc/include/asm/psr.h         |    8 ++
 arch/sparc/include/asm/sections.h    |    3 +
 arch/sparc/kernel/Makefile           |    4 +-
 arch/sparc/kernel/cpu.c              |   18 ++--
 arch/sparc/kernel/entry.S            |   10 +-
 arch/sparc/kernel/etrap_32.S         |   18 +++-
 arch/sparc/kernel/head_32.S          |  168 ++++++++++++++++++++-------------
 arch/sparc/kernel/ioport.c           |   24 ++----
 arch/sparc/kernel/irq_32.c           |   22 +++--
 arch/sparc/kernel/kernel.h           |    3 +
 arch/sparc/kernel/leon_kernel.c      |    1 +
 arch/sparc/kernel/leon_pmc.c         |   15 ++-
 arch/sparc/kernel/leon_smp.c         |    8 +-
 arch/sparc/kernel/process_32.c       |   35 +------
 arch/sparc/kernel/prom_common.c      |    1 -
 arch/sparc/kernel/rtrap_32.S         |   18 +++-
 arch/sparc/kernel/setup_32.c         |   62 ++++++++++---
 arch/sparc/kernel/trampoline_32.S    |    6 +-
 arch/sparc/kernel/traps_64.c         |   12 ++-
 arch/sparc/kernel/vmlinux.lds.S      |    5 +
 arch/sparc/kernel/wof.S              |   18 +++-
 arch/sparc/kernel/wuf.S              |   27 ++++--
 arch/sparc/math-emu/math_64.c        |   20 +++-
 arch/sparc/mm/Makefile               |    3 +-
 arch/sparc/mm/leon_mm.c              |    2 +-
 arch/sparc/mm/srmmu.c                |   25 ++++-
 arch/sparc/mm/srmmu_access.S         |   82 +++++++++++++++++
 34 files changed, 444 insertions(+), 382 deletions(-)
 create mode 100644 arch/sparc/mm/srmmu_access.S
