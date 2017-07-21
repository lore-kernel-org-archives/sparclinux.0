From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 21 Jul 2017 01:50:57 +0000
Subject: [PATCH v1 0/4] Context domains
Message-Id: <1500601861-203232-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Most of this work was done by: bob.picco@oracle.com

Currently, there is only one context domain per-system. This means
when wrap occurs we must go through a cpu-count proportional loop
in order to invalidate context ids. It also means, that context wraps
can occur more frequently. This patchset solves this problem by
introducing multiple context domains. By default one context domain
per physical core (on most sun4v it is actually one per two cores,
because the defined max strands per core is set to 16 to match
match T3.).

Pavel Tatashin (4):
  sparc64: interface to get random tick
  sparc64: tlb mondo replacement with smp_call_function_many
  sparc64: context domains
  sparc64: add boot line core to context domain parameter

 arch/sparc/include/asm/mmu_64.h         |   13 +-
 arch/sparc/include/asm/mmu_context_64.h |   52 ++++-
 arch/sparc/include/asm/timer_64.h       |   15 ++
 arch/sparc/include/asm/tlb_64.h         |    3 +-
 arch/sparc/include/asm/tlbflush_64.h    |    2 +-
 arch/sparc/kernel/smp_64.c              |   54 ++++--
 arch/sparc/kernel/unaligned_64.c        |    4 +-
 arch/sparc/mm/fault_64.c                |    4 +-
 arch/sparc/mm/init_64.c                 |  336 +++++++++++++++++++++++++++----
 arch/sparc/mm/tlb.c                     |    4 +-
 arch/sparc/mm/tsb.c                     |   20 +-
 arch/sparc/mm/ultra.S                   |  131 ------------
 12 files changed, 420 insertions(+), 218 deletions(-)

