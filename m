From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jun 2017 20:57:03 +0000
Subject: [GIT] Sparc
Message-Id: <20170606.165703.760397530839376527.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix TLB context wrap races, from Pavel Tatashin.

2) Cure some gcc-7 build issues.

3) Handle invalid setup_hugepagesz command line values properly,
   from Liam R. Howlett.

4) Copy TSB using the correct address shift for the huge TSB,
   from Mike Kravetz.

Please pull, thanks a lot!

The following changes since commit be941bf2e6a32605935865972df7abf74087944f:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2017-05-24 20:29:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to b3aefc2fbdff2576d0c5aca09b963c40f0299664:

  Merge branch 'sparc64-context-wrap-fixes' (2017-06-06 13:45:48 -0700)

----------------------------------------------------------------
David S. Miller (3):
      sparc64: Fix build warnings with gcc 7.
      sparc64: Add __multi3 for gcc 7.x and later.
      Merge branch 'sparc64-context-wrap-fixes'

James Clarke (1):
      sparc: Machine description indices can vary

Jane Chu (2):
      arch/sparc: increase CONFIG_NODES_SHIFT on SPARC64 to 5
      arch/sparc: support NR_CPUS = 4096

Liam R. Howlett (1):
      sparc/mm/hugepages: Fix setup_hugepagesz for invalid values.

Mike Kravetz (1):
      sparc64: mm: fix copy_tsb to correctly copy huge page TSBs

Pavel Tatashin (6):
      sparc64: reset mm cpumask after wrap
      sparc64: combine activate_mm and switch_mm
      sparc64: redefine first version
      sparc64: add per-cpu mm of secondary contexts
      sparc64: new context wrap
      sparc64: delete old wrap code

 arch/sparc/Kconfig                      | 12 ++++++++----
 arch/sparc/include/asm/mmu_64.h         |  2 +-
 arch/sparc/include/asm/mmu_context_64.h | 32 ++++----------------------------
 arch/sparc/include/asm/pil.h            |  1 -
 arch/sparc/include/asm/vio.h            |  1 +
 arch/sparc/kernel/ds.c                  |  2 +-
 arch/sparc/kernel/irq_64.c              | 17 +++++++++++++----
 arch/sparc/kernel/kernel.h              |  1 -
 arch/sparc/kernel/smp_64.c              | 31 -------------------------------
 arch/sparc/kernel/tsb.S                 | 11 +++++++----
 arch/sparc/kernel/ttable_64.S           |  2 +-
 arch/sparc/kernel/vio.c                 | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 arch/sparc/lib/Makefile                 |  1 +
 arch/sparc/lib/multi3.S                 | 35 +++++++++++++++++++++++++++++++++++
 arch/sparc/mm/init_64.c                 | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 arch/sparc/mm/tsb.c                     |  7 +++++--
 arch/sparc/mm/ultra.S                   |  5 -----
 17 files changed, 201 insertions(+), 116 deletions(-)
 create mode 100644 arch/sparc/lib/multi3.S
