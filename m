From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 14 Sep 2020 04:52:15 +0000
Subject: [PATCH v2 0/4] more mm switching vs TLB shootdown and lazy tlb fixes
Message-Id: <20200914045219.3736466-1-npiggin@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-mm @ kvack . org" <linux-mm@kvack.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, "David S . Miller" <davem@davemloft.net>

This is an attempt to fix a few different related issues around
switching mm, TLB flushing, and lazy tlb mm handling.

This will require all architectures to eventually move to disabling
irqs over activate_mm, but it's possible we could add another arch
call after irqs are re-enabled for those few which can't do their
entire activation with irqs disabled.

Testing so far indicates this has fixed a mm refcounting bug that
powerpc was running into (via distro report and backport). I haven't
had any real feedback on this series outside powerpc (and it doesn't
really affect other archs), so I propose patches 1,2,4 go via the
powerpc tree.

There is no dependency between them and patch 3, I put it there only
because it follows the history of the code (powerpc code was written
using the sparc64 logic), but I guess they have to go via different arch
trees. Dave, I'll leave patch 3 with you.

Thanks,
Nick

Since v1:
- Updates from Michael Ellerman's review comments.

Nicholas Piggin (4):
  mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
  powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
  sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
  powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm

 arch/Kconfig                           |  7 +++
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/mmu_context.h |  2 +-
 arch/powerpc/include/asm/tlb.h         | 13 ------
 arch/powerpc/mm/book3s64/radix_tlb.c   | 23 ++++++---
 arch/sparc/kernel/smp_64.c             | 65 ++++++--------------------
 fs/exec.c                              | 17 ++++++-
 7 files changed, 54 insertions(+), 74 deletions(-)

-- 
2.23.0
